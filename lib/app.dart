import 'dart:async';
import 'package:aerstore/core/routes/router_confiq.dart';
import 'package:aerstore/core/theme/app_colors.dart';
import 'package:flutter/material.dart';
import 'package:supabase_flutter/supabase_flutter.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:aerstore/features/cart/bloc/cart_bloc.dart';
import 'package:aerstore/features/cart/bloc/cart_event.dart';
import 'package:aerstore/features/orders/bloc/order_bloc.dart';
import 'package:aerstore/features/orders/bloc/order_event.dart';

class MyApp extends StatefulWidget {
  const MyApp({super.key});

  static final GlobalKey<NavigatorState> navigatorKey =
      GlobalKey<NavigatorState>();

  @override
  State<MyApp> createState() => _MyAppState();
}

class _MyAppState extends State<MyApp> {
  late final StreamSubscription<AuthState> _authSubscription;

  @override
  void initState() {
    super.initState();
    _authSubscription = Supabase.instance.client.auth.onAuthStateChange.listen((data) {
      final AuthChangeEvent event = data.event;
      if (event == AuthChangeEvent.signedIn || event == AuthChangeEvent.initialSession) {
        final cartRepo = context.read<CartBloc>().cartRepository;
        context.read<CartBloc>().add(SetCartLoadingEvent()); // Show loading immediately
        cartRepo.syncGuestCart().then((_) {
          if (mounted) context.read<CartBloc>().add(GetCartItemsEvent(forceLoading: true));
        });
        final user = data.session?.user;
        if (user != null && mounted) {
          context.read<OrderBloc>().add(LoadOrdersEvent(userid: user.id));
        }
      } else if (event == AuthChangeEvent.signedOut) {
        if (mounted) {
          context.read<CartBloc>().add(ClearCartEvent());
          context.read<OrderBloc>().add(ClearOrdersEvent());
        }
      }
    });
  }

  @override
  void dispose() {
    _authSubscription.cancel();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return MaterialApp.router(
      routerConfig: goRouter,
      theme: ThemeData(
        fontFamily: "Manrope",
        scaffoldBackgroundColor: AppColors.pureWhite,
        appBarTheme: AppBarTheme(backgroundColor: AppColors.pureWhite),
      ),
      debugShowCheckedModeBanner: false,
    );
  }
}
