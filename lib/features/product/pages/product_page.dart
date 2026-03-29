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
import 'package:ad_e_commerce/features/product/domain/entites/product.dart';
import 'package:ad_e_commerce/features/product/widgets/product_image_carousel.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:supabase_flutter/supabase_flutter.dart';

class ProductPage extends StatelessWidget {
  final Product product;
  const ProductPage({super.key, required this.product});

  @override
  Widget build(BuildContext context) {
    return _ProductPage(product: product);
  }
}

class _ProductPage extends StatefulWidget {
  final Product product;
  const _ProductPage({required this.product});

  @override
  State<_ProductPage> createState() => _ProductPageState();
}

class _ProductPageState extends State<_ProductPage>
    with TickerProviderStateMixin {
  bool isExpanded = false;

  @override
  Widget build(BuildContext context) {
    final isLongText = widget.product.description!.length > 100;
    final isSoldOut =
        widget.product.stocks.isEmpty ||
        widget.product.stocks.every((stock) => stock.quantity == 0) ||
        widget.product.isActive == false;

    return LayoutBuilder(
      builder: (context, constraints) {
        final isDesktop = constraints.maxWidth > 1024;
        return Scaffold(
          body:
              isDesktop
                  ? _buildDesktopLayout(isSoldOut, isLongText)
                  : _buildMobileLayout(isSoldOut, isLongText),
          bottomNavigationBar:
              isDesktop ? null : _buildBottomBar(isSoldOut, context),
        );
      },
    );
  }

  // ──────────────────────────────────────────────
  // MOBILE LAYOUT (unchanged)
  // ──────────────────────────────────────────────
  Widget _buildMobileLayout(bool isSoldOut, bool isLongText) {
    return SingleChildScrollView(
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Stack(
            children: [
              ProductImageCarousel(images: widget.product.imageUrls),
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
            child: _productInfoColumn(isSoldOut, isLongText),
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
    );
  }

  // ──────────────────────────────────────────────
  // DESKTOP LAYOUT — two-column: image left, info right
  // ──────────────────────────────────────────────
  Widget _buildDesktopLayout(bool isSoldOut, bool isLongText) {
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
                      onTap: () => Navigator.pop(context),
                    ),
                    Row(
                      children: [
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
                            ProductImageCarousel(
                              images: widget.product.imageUrls,
                            ),
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
                          _productInfoColumn(isSoldOut, isLongText),
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
          onTap: () => Navigator.pop(context),
        ),
        Row(
          children: [
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
                child: SvgPicture.asset(AppIcons.serachucon),
              ),
            ),
            const SizedBox(width: 10),
            GestureDetector(
              onTap:
                  () => Appnavigotor.pushnamed(context, RouteNames.cart, {}),
              child: Container(
                width: 50,
                height: 50,
                decoration: const BoxDecoration(
                  shape: BoxShape.circle,
                  color: Colors.white,
                ),
                padding: const EdgeInsets.all(12),
                child: SvgPicture.asset(AssetConstants.carticonpng),
              ),
            ),
          ],
        ),
      ],
    );
  }

  Widget _productInfoColumn(bool isSoldOut, bool isLongText) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        // Rating Row
        Row(
          children: [
            const Icon(Icons.star, color: Colors.amber, size: 20),
            const SizedBox(width: 4),
            Text(
              "${widget.product.rating}",
              style: const TextStyle(
                fontSize: 16,
                fontWeight: FontWeight.bold,
              ),
            ),
            const SizedBox(width: 4),
            Text(
              "(${widget.product.noofreviews}) Reviews",
              style: TextStyle(fontSize: 16, color: Colors.grey[600]),
            ),
          ],
        ),
        const SizedBox(height: 12),
        // Title
        widget.product.storage.isEmpty || widget.product.ram.isEmpty
            ? Text(
              widget.product.title,
              style: const TextStyle(
                fontSize: 22,
                fontWeight: FontWeight.w500,
                color: Colors.black,
              ),
            )
            : Text(
              "${widget.product.title}  (${widget.product.storage})-${widget.product.ram}",
              style: const TextStyle(
                fontSize: 22,
                fontWeight: FontWeight.w500,
                color: Colors.black,
              ),
            ),
        const SizedBox(height: 4),
        // Model
        Text(
          "Model: ${widget.product.modelNumber}",
          style: const TextStyle(fontSize: 14, color: Colors.black54),
        ),
        const SizedBox(height: 16),
        // Price
        Row(
          children: [
            Text(
              "₹ ${widget.product.price.toStringAsFixed(0)}",
              style: const TextStyle(
                fontSize: 20,
                fontWeight: FontWeight.bold,
                color: Colors.black,
              ),
            ),
            const SizedBox(width: 10),
            AppTexts.bold(
              "₹ ${widget.product.originalPrice?.toStringAsFixed(0)}",
              fontSize: 20,
              color: AppColors.purered,
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
              curve: Curves.easeInOut,
              duration: const Duration(milliseconds: 300),
              child: Align(
                alignment: Alignment.centerLeft,
                child: AppTexts.medium(
                  "${widget.product.description}",
                  fontSize: 16,
                  maxLines: isExpanded ? null : 2,
                  overflow:
                      isExpanded
                          ? TextOverflow.visible
                          : TextOverflow.ellipsis,
                  height: 1.6,
                ),
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
              side: BorderSide(
                color: isSoldOut ? Colors.grey : Colors.black,
              ),
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
                    : Appnavigotor.pushnamed(
                      context,
                      RouteNames.checkout,
                      {
                        "isMyaddressScreen": false,
                        "isDirectBuy": true,
                        "directProduct": widget.product,
                      },
                    );
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
}
