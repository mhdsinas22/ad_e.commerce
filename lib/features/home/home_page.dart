import 'package:ad_e_commerce/features/auth/pages/login_page.dart';
import 'package:flutter/material.dart';
import 'package:supabase_flutter/supabase_flutter.dart';

class HomePage extends StatelessWidget {
  const HomePage({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text("HOME SCREEN"),
        leading: IconButton(
          onPressed: () async {
            await Supabase.instance.client.auth.signOut();
            Navigator.pushReplacement(
              context,
              MaterialPageRoute(
                builder: (context) {
                  return LoginPage();
                },
              ),
            );
          },
          icon: Icon(Icons.logout),
        ),
      ),
      body: Center(child: Text("HOE SCRREn")),
    );
  }
}
