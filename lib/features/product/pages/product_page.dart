import 'package:ad_e_commerce/core/constants/app_icons.dart';
import 'package:ad_e_commerce/core/constants/asset_constants.dart';
import 'package:ad_e_commerce/core/routes/route_names.dart';
import 'package:ad_e_commerce/core/theme/app_colors.dart';
import 'package:ad_e_commerce/core/utils/helpers.dart';
import 'package:ad_e_commerce/core/utils/navigator.dart';
import 'package:ad_e_commerce/core/widgets/app_text.dart';
import 'package:ad_e_commerce/core/widgets/circular_arrow_button.dart';
import 'package:ad_e_commerce/features/cart/bloc/cart_bloc.dart';
import 'package:ad_e_commerce/features/cart/bloc/cart_event.dart';
import 'package:ad_e_commerce/features/cart/bloc/cart_state.dart';
import 'package:ad_e_commerce/features/home/widgets/CategoryListSection/widgets/airdrop_assurcance/airdrop_assurance.dart';
import 'package:ad_e_commerce/features/product/bloc/proudctbloc/product_bloc.dart';
import 'package:ad_e_commerce/features/product/bloc/proudctbloc/product_event.dart';
import 'package:ad_e_commerce/features/product/bloc/proudctbloc/product_state.dart';
import 'package:ad_e_commerce/features/product/domain/entites/product.dart';
import 'package:ad_e_commerce/features/product/widgets/product_image_carousel.dart';
import 'package:ad_e_commerce/features/product/widgets/product_shimmer.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:share_plus/share_plus.dart';
import 'package:supabase_flutter/supabase_flutter.dart';

class ProductPage extends StatelessWidget {
  final Product? product;
  final String? productId;
  const ProductPage({super.key, required this.product, this.productId});

  @override
  Widget build(BuildContext context) {
    return _ProductPage(
      product:
          product ??
          Product(
            id: productId ?? "",
            title: "",
            category: "",
            condition: "",
            color: "",
            price: 0,
            conditionType: "",
            isActive: true,
            modelNumber: "",
            storageid: "",
            ramid: "",
            ram: "",
            tag: "",
            imageUrls: [],
            stocks: [],
            storage: "",
            colorid: "",
            categoryid: "",
            conditiontypeid: "",
            rating: 0,
            noofreviews: 0,
            subCategory: "",
          ),
      productId: productId,
    );
  }
}

class _ProductPage extends StatefulWidget {
  final Product product;
  final String? productId;
  const _ProductPage({required this.product, required this.productId});

  @override
  State<_ProductPage> createState() => _ProductPageState();
}

class _ProductPageState extends State<_ProductPage>
    with TickerProviderStateMixin {
  bool isExpanded = false;
  @override
  void initState() {
    super.initState();
    // productId undennum, pakshe product data empty aanennum urappu varuthunnu
    if (widget.productId != null && widget.productId!.isNotEmpty) {
      if (widget.product.id == null || widget.product.id!.isEmpty) {
        context.read<ProductBloc>().add(
          GetProductByIdEvent(productid: widget.productId!),
        );
      }
    }
  }

  @override
  Widget build(BuildContext context) {
    return BlocBuilder<ProductBloc, ProductState>(
      builder: (context, state) {
        if (state.productStatus == ProductStatus.loading) {
          return const ProductShimmer();
        }
        Product? foundProduct;
        if (state.products.isNotEmpty) {
          // Safe way to find product
          final results = state.products.where((p) => p.id == widget.productId);
          if (results.isNotEmpty) {
            foundProduct = results.first;
          }
        }
        final bool hasInitialData = widget.product.title.isNotEmpty;
        // 2. Error handle cheyyunnu (Ithanu ippo sambhavikkunnath ennu thonnunnu)
        if (!hasInitialData &&
            foundProduct == null &&
            widget.productId != null &&
            state.productStatus != ProductStatus.failure) {
          return const ProductShimmer();
        }
        // 4. Failure status aayalum foundProduct null aayalum maathram error kaanikkanam
        if (state.productStatus == ProductStatus.failure &&
            foundProduct == null) {
          return Scaffold(
            body: Center(
              child: Text(state.errorMessage ?? "Error loading product"),
            ),
          );
        }
        final currentProduct = foundProduct ?? widget.product;
        if (currentProduct.id == null ||
            currentProduct.id!.isEmpty ||
            currentProduct.title.isEmpty) {
          return Scaffold(
            body: Center(
              child: Column(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  const Icon(Icons.error_outline, size: 40, color: Colors.grey),
                  const SizedBox(height: 10),
                  Text("Product details fetch aayilla."),
                  Text("ID: ${widget.productId}"), // Debugging-nu sahayikkum
                  ElevatedButton(
                    onPressed: () {
                      context.read<ProductBloc>().add(
                        GetProductByIdEvent(productid: widget.productId!),
                      );
                    },
                    child: const Text("Retry"),
                  ),
                ],
              ),
            ),
          );
        }
        final isLongText = currentProduct.description!.length > 100;
        final isSoldOut =
            currentProduct.stocks.isEmpty ||
            currentProduct.stocks.every((stock) => stock.quantity == 0) ||
            currentProduct.isActive == false;
        return LayoutBuilder(
          builder: (context, constraints) {
            final isDesktop = constraints.maxWidth > 1024;
            return PopScope(
              canPop: false,
              onPopInvokedWithResult: (didPop, result) {
                if (didPop) return;
                _handleBackAction();
              },
              child: Scaffold(
                body:
                    isDesktop
                        ? _buildDesktopLayout(
                          isSoldOut,
                          isLongText,
                          currentProduct,
                        )
                        : _buildMobileLayout(
                          isSoldOut,
                          isLongText,
                          currentProduct,
                        ),
                bottomNavigationBar:
                    isDesktop ? null : _buildBottomBar(isSoldOut, context),
              ),
            );
          },
        );
      },
    );
  }

  // ──────────────────────────────────────────────
  // MOBILE LAYOUT (unchanged)
  // ──────────────────────────────────────────────
  Widget _buildMobileLayout(bool isSoldOut, bool isLongText, Product product) {
    return SafeArea(
      child: SingleChildScrollView(
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Stack(
              children: [
                ProductImageCarousel(images: product.imageUrls),
                if (isSoldOut)
                  Positioned.fill(
                    child: Container(
                      color: Colors.black.withOpacity(0.7),
                      child: Center(
                        child: Container(
                          padding: const EdgeInsets.symmetric(
                            horizontal: 24,
                            vertical: 12,
                          ),
                          decoration: BoxDecoration(
                            color: Colors.red.shade600,
                            borderRadius: BorderRadius.circular(8),
                          ),
                          child: AppTexts.bold(
                            "SOLD OUT",
                            fontSize: 22,
                            color: AppColors.pureWhite,
                          ),
                        ),
                      ),
                    ),
                  ),
                Positioned(
                  top: 0,
                  left: 0,
                  right: 0,
                  child: SafeArea(
                    child: Padding(
                      padding: const EdgeInsets.symmetric(horizontal: 16),
                      child: _topNavRow(context),
                    ),
                  ),
                ),
              ],
            ),
            Padding(
              padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 20),
              child: _productInfoColumn(isSoldOut, isLongText, product),
            ),
            Padding(
              padding: const EdgeInsets.symmetric(horizontal: 16.0),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [AirdropAssurance(isProductPage: true)],
              ),
            ),
          ],
        ),
      ),
    );
  }

  // ──────────────────────────────────────────────
  // DESKTOP LAYOUT — two-column: image left, info right
  // ──────────────────────────────────────────────
  Widget _buildDesktopLayout(bool isSoldOut, bool isLongText, Product product) {
    return SingleChildScrollView(
      child: Center(
        child: ConstrainedBox(
          constraints: const BoxConstraints(maxWidth: 1200),
          child: Column(
            children: [
              // Desktop AppBar replacement
              Padding(
                padding: const EdgeInsets.symmetric(
                  horizontal: 24,
                  vertical: 16,
                ),
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    CircularArrowButton(
                      iconSize: 22,
                      size: 44,
                      needCircle: true,
                      iconColor: AppColors.pureBlack,
                      icon: Icons.arrow_back,
                      backgroundColor: Colors.grey.shade100,
                      onTap: _handleBackAction,
                    ),
                    Row(
                      children: [
                        CircularArrowButton(
                          iconSize: 20,
                          iconColor: AppColors.pureBlack,
                          backgroundColor: AppColors.pureWhite,
                          onTap: () {
                            final String shareLink =
                                "https://www.aerstore.in/productpage/${widget.product.id}";
                            Share.share(
                              "Check out this ${widget.product.title} for ₹${widget.product.price.toStringAsFixed(0)}!\n$shareLink",
                              subject: widget.product.title,
                            );
                          },
                          icon: Icons.share_outlined,
                          size: 50,
                        ),
                        const SizedBox(width: 10),
                        GestureDetector(
                          onTap:
                              () => Appnavigotor.pushnamed(
                                context,
                                RouteNames.search,
                                {},
                              ),
                          child: Container(
                            width: 44,
                            height: 44,
                            decoration: BoxDecoration(
                              shape: BoxShape.circle,
                              color: Colors.grey.shade100,
                            ),
                            padding: const EdgeInsets.all(10),
                            child: SvgPicture.asset(AppIcons.serachucon),
                          ),
                        ),
                        const SizedBox(width: 10),
                        GestureDetector(
                          onTap:
                              () => Appnavigotor.pushnamed(
                                context,
                                RouteNames.cart,
                                {},
                              ),
                          child: Container(
                            width: 44,
                            height: 44,
                            decoration: BoxDecoration(
                              shape: BoxShape.circle,
                              color: Colors.grey.shade100,
                            ),
                            padding: const EdgeInsets.all(10),
                            child: SvgPicture.asset(AssetConstants.carticonpng),
                          ),
                        ),
                      ],
                    ),
                  ],
                ),
              ),
              // Two-column body
              Padding(
                padding: const EdgeInsets.symmetric(
                  horizontal: 24,
                  vertical: 8,
                ),
                child: Row(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    // LEFT: Product image carousel
                    Expanded(
                      flex: 5,
                      child: ClipRRect(
                        borderRadius: BorderRadius.circular(20),
                        child: Stack(
                          children: [
                            ProductImageCarousel(images: product.imageUrls),
                            if (isSoldOut)
                              Positioned.fill(
                                child: Container(
                                  color: Colors.black.withOpacity(0.7),
                                  child: Center(
                                    child: Container(
                                      padding: const EdgeInsets.symmetric(
                                        horizontal: 24,
                                        vertical: 12,
                                      ),
                                      decoration: BoxDecoration(
                                        color: Colors.red.shade600,
                                        borderRadius: BorderRadius.circular(8),
                                      ),
                                      child: AppTexts.bold(
                                        "SOLD OUT",
                                        fontSize: 22,
                                        color: AppColors.pureWhite,
                                      ),
                                    ),
                                  ),
                                ),
                              ),
                          ],
                        ),
                      ),
                    ),
                    const SizedBox(width: 40),
                    // RIGHT: Product info + action buttons
                    Expanded(
                      flex: 5,
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          _productInfoColumn(isSoldOut, isLongText, product),
                          const SizedBox(height: 24),
                          // Inline action buttons (desktop only)
                          Row(
                            children: [
                              Expanded(
                                child: SizedBox(
                                  height: 52,
                                  child: _addToCartButton(isSoldOut, context),
                                ),
                              ),
                              const SizedBox(width: 16),
                              Expanded(
                                child: SizedBox(
                                  height: 52,
                                  child: _buyNowButton(isSoldOut, context),
                                ),
                              ),
                            ],
                          ),
                          const SizedBox(height: 32),
                          AirdropAssurance(isProductPage: true),
                        ],
                      ),
                    ),
                  ],
                ),
              ),
              const SizedBox(height: 40),
            ],
          ),
        ),
      ),
    );
  }

  // ──────────────────────────────────────────────
  // SHARED WIDGETS
  // ──────────────────────────────────────────────

  Widget _topNavRow(BuildContext context) {
    return Row(
      mainAxisAlignment: MainAxisAlignment.spaceBetween,
      children: [
        CircularArrowButton(
          iconSize: 25,
          size: 50,
          needCircle: true,
          iconColor: AppColors.pureBlack,
          icon: Icons.arrow_back,
          backgroundColor: Colors.white,
          onTap: _handleBackAction,
        ),
        Row(
          children: [
            CircularArrowButton(
              iconSize: 20,
              iconColor: AppColors.pureBlack,
              backgroundColor: AppColors.pureWhite,
              onTap: () {
                final String shareLink =
                    "https://www.aerstore.in/productpage/${widget.product.id}";
                Share.share(
                  "Check out this ${widget.product.title} for ₹${widget.product.price.toStringAsFixed(0)}!\n$shareLink",
                  subject: widget.product.title,
                );
              },
              icon: Icons.share_outlined,
              size: 50,
            ),
            const SizedBox(width: 10),
            GestureDetector(
              onTap:
                  () => Appnavigotor.pushnamed(context, RouteNames.search, {}),
              child: Container(
                width: 50,
                height: 50,
                decoration: const BoxDecoration(
                  shape: BoxShape.circle,
                  color: Colors.white,
                ),
                padding: const EdgeInsets.all(12),
                child: SvgPicture.asset(AppIcons.searchicononly),
              ),
            ),
            const SizedBox(width: 10),
            GestureDetector(
              onTap: () => Appnavigotor.pushnamed(context, RouteNames.cart, {}),
              child: Container(
                width: 50,
                height: 50,
                decoration: const BoxDecoration(
                  shape: BoxShape.circle,
                  color: Colors.white,
                ),
                padding: const EdgeInsets.all(12),
                child: SvgPicture.asset(AppIcons.bagIcon),
              ),
            ),
          ],
        ),
      ],
    );
  }

  Widget _productInfoColumn(bool isSoldOut, bool isLongText, Product product) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        // Rating Row
        Row(
          children: [
            const Icon(Icons.star, color: Colors.amber, size: 20),
            const SizedBox(width: 4),
            Text(
              "${product.rating}",
              style: const TextStyle(fontSize: 16, fontWeight: FontWeight.bold),
            ),
            const SizedBox(width: 4),
            Text(
              "(${product.noofreviews}) Reviews",
              style: TextStyle(fontSize: 16, color: Colors.grey[600]),
            ),
          ],
        ),
        const SizedBox(height: 12),
        // Title
        product.storage.isEmpty || product.ram.isEmpty
            ? Text(
              product.title,
              style: const TextStyle(
                fontSize: 22,
                fontWeight: FontWeight.w500,
                color: Colors.black,
              ),
            )
            : Text(
              "${product.title}  (${product.storage})-${product.ram}",
              style: const TextStyle(
                fontSize: 22,
                fontWeight: FontWeight.w500,
                color: Colors.black,
              ),
            ),
        const SizedBox(height: 4),
        // Model
        Text(
          "Model: ${product.modelNumber}",
          style: const TextStyle(fontSize: 14, color: Colors.black54),
        ),
        const SizedBox(height: 16),
        // Price
        Row(
          children: [
            Text(
              "₹ ${product.price.toStringAsFixed(0)}",
              style: const TextStyle(
                fontSize: 20,
                fontWeight: FontWeight.bold,
                color: Colors.black,
              ),
            ),
            const SizedBox(width: 10),
            AppTexts.bold(
              "₹ ${product.originalPrice?.toStringAsFixed(0)}",
              fontSize: 20,
              color: AppColors.grayColor,
              isOffer: true,
            ),
          ],
        ),
        const SizedBox(height: 24),
        // Key Features
        Column(
          children: [
            const Align(
              alignment: Alignment.topLeft,
              child: Text(
                "Key Features",
                style: TextStyle(fontSize: 18, fontWeight: FontWeight.w500),
              ),
            ),
            const SizedBox(height: 8),
            AnimatedSize(
              duration: const Duration(milliseconds: 300),
              curve: Curves.easeInOut,
              child: AppTexts.medium(
                product.description ?? "",
                maxLines: isExpanded ? null : 3,
                overflow:
                    isExpanded ? TextOverflow.visible : TextOverflow.ellipsis,
                softWrap: true,
                fontSize: 15,
                height: 1.7,
                color: Colors.black87,
                letterSpacing: 0.2,
              ),
            ),
          ],
        ),
        if (isLongText)
          Row(
            mainAxisAlignment: MainAxisAlignment.end,
            children: [
              TextButton(
                onPressed: () {
                  setState(() {
                    isExpanded = !isExpanded;
                  });
                },
                child: Text(
                  isExpanded ? "Show Less" : "View All",
                  style: TextStyle(
                    color: AppColors.primaryBlack,
                    fontWeight: FontWeight.w600,
                  ),
                ),
              ),
            ],
          ),
      ],
    );
  }

  // ──────────────────────────────────────────────
  // BOTTOM BAR (mobile only)
  // ──────────────────────────────────────────────
  Widget _buildBottomBar(bool isSoldOut, BuildContext context) {
    return Container(
      padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 16),
      decoration: BoxDecoration(
        color: Colors.white,
        border: Border(top: BorderSide(color: Colors.grey.shade200)),
      ),
      child: SafeArea(
        child: Row(
          children: [
            Expanded(
              child: SizedBox(
                height: 48,
                child: _addToCartButton(isSoldOut, context),
              ),
            ),
            const SizedBox(width: 16),
            Expanded(
              child: SizedBox(
                height: 48,
                child: _buyNowButton(isSoldOut, context),
              ),
            ),
          ],
        ),
      ),
    );
  }

  Widget _addToCartButton(bool isSoldOut, BuildContext context) {
    return BlocListener<CartBloc, CartState>(
      listenWhen: (previous, current) {
        return previous.isAdding &&
            !current.isAdding &&
            previous.cartitems.length < current.cartitems.length;
      },
      listener: (context, state) {
        if (state.status == CartStatus.loaded) {
          ScaffoldMessenger.of(context).showSnackBar(
            const SnackBar(
              content: Text("Item Added To Cart"),
              backgroundColor: AppColors.pureBlack,
              duration: Duration(seconds: 2),
            ),
          );
        }
        if (state.status == CartStatus.error) {
          ScaffoldMessenger.of(context).showSnackBar(
            SnackBar(
              content: Text(state.error ?? "Something went wrong"),
              backgroundColor: Colors.red,
              duration: const Duration(seconds: 2),
            ),
          );
        }
      },
      child: BlocBuilder<CartBloc, CartState>(
        builder: (context, state) {
          final isInCart = state.cartitems.any(
            (element) => element.productId == widget.product.id,
          );
          if (state.status == CartStatus.loading) {
            return const Center(child: CircularProgressIndicator());
          }
          if (isInCart) {
            return OutlinedButton(
              onPressed: () async {
                await Appnavigotor.pushnamed(context, RouteNames.cart, {});
              },
              style: OutlinedButton.styleFrom(
                side: const BorderSide(color: Colors.black),
                shape: RoundedRectangleBorder(
                  borderRadius: BorderRadius.circular(24),
                ),
              ),
              child: const Text(
                "View Cart",
                style: TextStyle(
                  color: Colors.black,
                  fontWeight: FontWeight.w600,
                  fontSize: 16,
                ),
              ),
            );
          }
          return OutlinedButton(
            onPressed:
                isSoldOut
                    ? null
                    : () {
                      context.read<CartBloc>().add(
                        AddToCartEvent(
                          imageUrl: widget.product.imageUrls[0],
                          productid: widget.product.id!,
                          storename: "",
                          price: widget.product.price,
                          noOfRating: widget.product.noofreviews.toString(),
                          rating: widget.product.rating.toString(),
                          modelNumber: widget.product.modelNumber.toString(),
                          title: widget.product.title.toString(),
                          color: widget.product.color,
                          storage: widget.product.storage,
                        ),
                      );
                    },
            style: OutlinedButton.styleFrom(
              side: BorderSide(color: isSoldOut ? Colors.grey : Colors.black),
              shape: RoundedRectangleBorder(
                borderRadius: BorderRadius.circular(24),
              ),
            ),
            child: AppTexts.semiBold(
              isSoldOut ? "Unavailable" : "Add to cart",
              color: Colors.black,
              fontSize: 16,
            ),
          );
        },
      ),
    );
  }

  Widget _buyNowButton(bool isSoldOut, BuildContext context) {
    return ElevatedButton(
      onPressed:
          isSoldOut
              ? null
              : () {
                final user = Supabase.instance.client.auth.currentUser;
                user == null
                    ? Helpers.showAuthBottomSheet(
                      context,
                      redirectRoute: RouteNames.checkout,
                      redirectArgs: {
                        "isMyaddressScreen": false,
                        "isDirectBuy": true,
                        "directProduct": widget.product,
                      },
                    )
                    : Appnavigotor.pushnamed(context, RouteNames.checkout, {
                      "isMyaddressScreen": false,
                      "isDirectBuy": true,
                      "directProduct": widget.product,
                    });
              },
      style: ElevatedButton.styleFrom(
        backgroundColor:
            isSoldOut ? AppColors.grayColor : AppColors.primaryBlack,
        shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(24)),
        elevation: 0,
      ),
      child: AppTexts.semiBold(
        isSoldOut ? "Sold Out" : "Buy Now",
        color: Colors.white,
        fontSize: 16,
      ),
    );
  }

  void _handleBackAction() {
    // Navigator.canPop() check cheyyunnathil oru kuzhappamundu.
    // Direct Product Page-ilaanu app thurakkunnath-enkil stack empty aayirikkum.
    // So, direct MainShell-ilekk push cheyyunnathaanu nallathu.

    if (Navigator.of(context).canPop()) {
      Navigator.of(context).pop();
    } else {
      // Stack empty aanel (Direct Deep Link)
      // pushAndRemoveUntil upayogikkunnathu Home root aayi maarikan sahayikkum
      Navigator.pushNamedAndRemoveUntil(
        context,
        RouteNames.mainShell,
        (route) => false,
      );
    }
  }
}
