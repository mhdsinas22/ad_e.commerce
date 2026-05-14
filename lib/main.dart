import 'package:aerstore/app.dart';
import 'package:aerstore/features/bottom_navigation/bloc/bottom_nav_bloc.dart';
import 'package:aerstore/features/cart/bloc/cart_bloc.dart';
import 'package:aerstore/features/cart/bloc/cart_event.dart';
import 'package:aerstore/features/cart/data/datasources/cart_local_datasource.dart';
import 'package:aerstore/features/cart/data/datasources/cart_remote_datasourceimpl.dart';
import 'package:aerstore/features/cart/data/repositories/cart_repository_impl.dart';
import 'package:aerstore/features/cart/domain/usecases/add_to_cart_usecase.dart';
import 'package:aerstore/features/checkout/bloc/address/address_bloc.dart';
import 'package:aerstore/features/checkout/bloc/address/address_event.dart';
import 'package:aerstore/features/checkout/data/datasource/address_remote_datasoureimpl.dart';
import 'package:aerstore/features/checkout/data/repositories/address_repository_impl.dart';
import 'package:aerstore/features/product/bloc/proudctbloc/product_bloc.dart';
import 'package:aerstore/features/product/bloc/proudctbloc/product_event.dart';
import 'package:aerstore/features/product/data/datasources/product_remote_datasourcimpl.dart';
import 'package:aerstore/features/product/data/repositories/product_repository_impl.dart';
import 'package:aerstore/features/product/domain/usecases/get_flashsale_product_usecase.dart';
import 'package:aerstore/features/product/domain/usecases/get_product_usecase.dart';
import 'package:aerstore/features/profile/data/datasource/wallet_remote_datasource_impl.dart';
import 'package:aerstore/features/profile/data/repositories/wallet_repo_impl.dart';
import 'package:aerstore/features/orders/bloc/order_bloc.dart';
import 'package:aerstore/features/orders/bloc/order_event.dart';
import 'package:aerstore/features/orders/data/datasource/order_remote_datasouceimpl.dart';
import 'package:aerstore/features/orders/data/repo/order_repo_impl.dart';
import 'package:aerstore/firebase_options.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_dotenv/flutter_dotenv.dart';
import 'package:go_router/go_router.dart';
import 'package:hive_flutter/hive_flutter.dart';
import 'package:supabase_flutter/supabase_flutter.dart';
// ignore: depend_on_referenced_packages
import 'package:flutter_web_plugins/url_strategy.dart';

const supabaseUrl = String.fromEnvironment('SUPABASE_URL');
const supabaseAnonKey = String.fromEnvironment('SUPABASE_ANON_KEY');

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  usePathUrlStrategy();
  GoRouter.optionURLReflectsImperativeAPIs = true;

  await Firebase.initializeApp(options: DefaultFirebaseOptions.currentPlatform);
  // Dotenv init
  await dotenv.load(fileName: ".env");
  // Supabase init
  await Supabase.initialize(
    url: "https://api.aerstore.in",
    anonKey:
        "eyJhbGciOiJIUzI1NiIsInR5cCI6IkpXVCJ9.eyJpc3MiOiJzdXBhYmFzZSIsInJlZiI6InV1bXFoaXh2eXRka2lpaXV5aG5hIiwicm9sZSI6ImFub24iLCJpYXQiOjE3NjU3NzAxNTgsImV4cCI6MjA4MTM0NjE1OH0.lElvwN7psm2gaWpt2QFuAK6p2QR6-9RY1qWp_t9Y1Gw",
  );
  // Hive init(Guest Cart)
  await Hive.initFlutter();
  await Hive.openBox("guest_cart");
  final supabase = Supabase.instance.client;
  final cartRepository = CartRepositoryImpl(
    CartRemoteDatasourceimpl(supabase),
    CartLocalDatasource(),
  );
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
  final orderRepo = OrderRepoImpl(
    remote: OrderRemoteDatasouceimpl(supabase: supabase),
    walletRemoteDataSource: WalletRemoteDatasourceImpl(supabase),
  );
  runApp(
    MultiBlocProvider(
      providers: [
        BlocProvider(
          create:
              (context) =>
                  ProductBloc(getProductUsecase, getflashsaleproductusecase)
                    ..add(LoadProductsEvent()),
        ),
        BlocProvider(
          create: (context) {
            final bloc = OrderBloc(orderRepo);
            final userid = supabase.auth.currentUser;
            if (userid != null) {
              bloc.add(LoadOrdersEvent(userid: userid.id));
            }
            return bloc;
          },
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
