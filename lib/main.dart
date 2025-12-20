import 'package:ad_e_commerce/app.dart';
import 'package:ad_e_commerce/core/routes/route_names.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter_dotenv/flutter_dotenv.dart';
import 'package:supabase_flutter/supabase_flutter.dart';

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

  runApp(MyApp());
}
