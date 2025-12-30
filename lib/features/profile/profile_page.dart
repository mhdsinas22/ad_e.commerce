import 'package:ad_e_commerce/data/repositories/auth_repository.dart';
import 'package:flutter/material.dart';
import 'package:supabase_flutter/supabase_flutter.dart';

class ProfilePage extends StatelessWidget {
  const ProfilePage({super.key});

  @override
  Widget build(BuildContext context) {
    final supabase = Supabase.instance.client;
    final authrepository = AuthRepository(supabase);
    return Scaffold(
      body: Center(
        child: TextButton(
          onPressed: () {
            authrepository.signOut();
          },
          child: Text("Logout"),
        ),
      ),
    );
  }
}
