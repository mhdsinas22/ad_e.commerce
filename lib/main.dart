import 'package:ad_e_commerce/app.dart';
import 'package:ad_e_commerce/core/routes/route_names.dart';
import 'package:ad_e_commerce/features/bottom_navigation/bloc/bottom_nav_bloc.dart';
import 'package:ad_e_commerce/features/cart/bloc/cart_bloc.dart';
import 'package:ad_e_commerce/features/cart/bloc/cart_event.dart';
import 'package:ad_e_commerce/features/cart/data/datasources/cart_remote_datasourceimpl.dart';
import 'package:ad_e_commerce/features/cart/data/repositories/cart_repository_impl.dart';
import 'package:ad_e_commerce/features/cart/domain/usecases/add_to_cart_usecase.dart';
import 'package:ad_e_commerce/features/checkout/bloc/address/address_bloc.dart';
import 'package:ad_e_commerce/features/checkout/bloc/address/address_event.dart';
import 'package:ad_e_commerce/features/checkout/data/datasource/address_remote_datasoureimpl.dart';
import 'package:ad_e_commerce/features/checkout/data/repositories/address_repository_impl.dart';
import 'package:ad_e_commerce/features/product/bloc/proudctbloc/product_bloc.dart';
import 'package:ad_e_commerce/features/product/bloc/proudctbloc/product_event.dart';
import 'package:ad_e_commerce/features/product/data/datasources/product_remote_datasourcimpl.dart';
import 'package:ad_e_commerce/features/product/data/repositories/product_repository_impl.dart';
import 'package:ad_e_commerce/features/product/domain/usecases/get_flashsale_product_usecase.dart';
import 'package:ad_e_commerce/features/product/domain/usecases/get_product_usecase.dart';
import 'package:ad_e_commerce/features/profile/data/datasource/wallet_remote_datasource_impl.dart';
import 'package:ad_e_commerce/features/profile/data/repositories/wallet_repo_impl.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_dotenv/flutter_dotenv.dart';
import 'package:supabase_flutter/supabase_flutter.dart';

const supabaseUrl = String.fromEnvironment('SUPABASE_URL');
const supabaseAnonKey = String.fromEnvironment('SUPABASE_ANON_KEY');

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await dotenv.load(fileName: ".env");
  await Supabase.initialize(
    url: dotenv.env["SUPABASE_URL"]!,
    anonKey: dotenv.env["SUPABASE_ANON_KEY"]!,
  );

  Supabase.instance.client.auth.onAuthStateChange.listen((data) {
    final AuthChangeEvent event = data.event;
    if (event == AuthChangeEvent.passwordRecovery) {
      MyApp.navigatorKey.currentState?.pushNamed(RouteNames.restPassword);
    }
    if (event == AuthChangeEvent.signedIn) {
      MyApp.navigatorKey.currentState?.pushNamed(RouteNames.home);
    }
  });
  final supabase = Supabase.instance.client;
  final cartRepository = CartRepositoryImpl(CartRemoteDatasourceimpl(supabase));
  final addtoCartusecase = AddToCartUsecase(cartRepository);
  final walletrepo = WalletRepoImpl(WalletRemoteDatasourceImpl(supabase));
  final addressRepository = AddressRepositoryimpl(
    AddressRemoteDatasoureimpl(supabase),
  );
  final productRepository = ProductRepositoryImpl(
    ProductRemoteDatasourceImpl(supabase),
  );
  final getProductUsecase = GetProductUsecase(productRepository);
  final getflashsaleproductusecase = GetFlashsaleProductUsecase(
    productRepository,
  );
  runApp(
    MultiBlocProvider(
      providers: [
        BlocProvider(
          create:
              (context) =>
                  ProductBloc(getProductUsecase, getflashsaleproductusecase)
                    ..add(LoadProductsEvent())
                    ..add(LoadFlashSaleProductsEvent()),
        ),
        BlocProvider(
          create:
              (context) =>
                  CartBloc(addtoCartusecase, cartRepository, walletrepo)
                    ..add(GetCartItemsEvent()),
        ),
        BlocProvider(
          create:
              (context) =>
                  AddressBloc(addressRepository)..add(FetchAddressEvent()),
        ),
        BlocProvider(create: (context) => BottomNavBloc()),
      ],
      child: MyApp(),
    ),
  );
}
