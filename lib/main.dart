import 'package:ad_e_commerce/app.dart';
import 'package:ad_e_commerce/core/routes/route_names.dart';
import 'package:ad_e_commerce/features/cart/bloc/cart_bloc.dart';
import 'package:ad_e_commerce/features/cart/bloc/cart_event.dart';
import 'package:ad_e_commerce/features/cart/data/datasources/cart_remote_datasourceimpl.dart';
import 'package:ad_e_commerce/features/cart/data/repositories/cart_repository_impl.dart';
import 'package:ad_e_commerce/features/cart/domain/usecases/add_to_cart_usecase.dart';
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
  runApp(
    MultiBlocProvider(
      providers: [
        BlocProvider(
          create:
              (context) =>
                  CartBloc(addtoCartusecase, cartRepository)
                    ..add(GetCartItemsEvent()),
        ),
      ],
      child: MyApp(),
    ),
  );
}
