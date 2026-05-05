import 'package:ad_e_commerce/core/widgets/primary_button.dart';
import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';

class AssuranceDetailPage extends StatelessWidget {
  final String title;
  final String subtitle;
  final List<String> points;

  const AssuranceDetailPage({
    super.key,
    required this.title,
    required this.subtitle,
    required this.points,
  });

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: Text(title)),
      body: Padding(
        padding: const EdgeInsets.all(16),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Text(subtitle, style: TextStyle(fontSize: 16)),
            SizedBox(height: 20),

            ...points.map(
              (e) => Padding(
                padding: const EdgeInsets.symmetric(vertical: 6),
                child: Row(
                  children: [
                    Icon(Icons.check, color: Colors.green),
                    SizedBox(width: 10),
                    Expanded(child: Text(e)),
                  ],
                ),
              ),
            ),

            Spacer(),

            SizedBox(
              width: double.infinity,
              child: PrimaryButton(
                text: "Got it",
                onPressed: () => context.pop(),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
