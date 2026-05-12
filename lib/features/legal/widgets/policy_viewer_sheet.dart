import 'package:aerstore/core/widgets/app_text.dart';
import 'package:aerstore/features/legal/models/policy_model.dart';
import 'package:flutter/material.dart';
import 'package:flutter_markdown_plus/flutter_markdown_plus.dart';
import 'package:url_launcher/url_launcher.dart';

class PolicyViewer extends StatelessWidget {
  final PolicyModel policy;

  const PolicyViewer({super.key, required this.policy});

  @override
  Widget build(BuildContext context) {
    return Container(
      height: MediaQuery.of(context).size.height * .85,
      decoration: const BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.vertical(top: Radius.circular(24)),
      ),
      child: Column(
        children: [
          const SizedBox(height: 10),

          // grab handle
          Container(
            width: 40,
            height: 4,
            decoration: BoxDecoration(
              color: Colors.grey[300],
              borderRadius: BorderRadius.circular(10),
            ),
          ),

          const SizedBox(height: 20),

          AppTexts.bold(policy.title, fontSize: 22),

          const SizedBox(height: 4),

          AppTexts.regular(policy.effectiveDate, fontSize: 13),

          const Divider(),

          Expanded(
            child: SingleChildScrollView(
              padding: const EdgeInsets.all(20),
              child: MarkdownBody(
                styleSheet: MarkdownStyleSheet(
                  horizontalRuleDecoration: BoxDecoration(
                    border: Border(
                      top: BorderSide(
                        color: const Color.fromARGB(
                          255,
                          71,
                          70,
                          70,
                        ).withOpacity(0.2),
                        width: 1,
                      ),
                    ),
                  ),
                  p: TextStyle(fontSize: 14, color: Colors.black, height: 1.5),

                  h1: TextStyle(fontSize: 22, fontWeight: FontWeight.bold),

                  h2: TextStyle(fontSize: 18, fontWeight: FontWeight.bold),

                  h3: TextStyle(fontSize: 16, fontWeight: FontWeight.w600),

                  strong: TextStyle(fontWeight: FontWeight.bold),
                  blockSpacing: 25, // 🔥 important (section gap)
                  listIndent: 20,
                  a: TextStyle(
                    color: Colors.blue,
                    decoration: TextDecoration.underline,
                  ),

                  listBullet: TextStyle(fontSize: 14),
                ),
                data: policy.content,
                selectable: true,
                onTapLink: (text, href, title) async {
                  if (href != null) {
                    final Uri url = Uri.parse(href);
                    if (await canLaunchUrl(url)) {
                      await launchUrl(url);
                    }
                  }
                },
              ),
            ),
          ),
        ],
      ),
    );
  }
}

void showPolicySheet(BuildContext context, PolicyModel policy) {
  showModalBottomSheet(
    context: context,
    isScrollControlled: true,
    backgroundColor: Colors.transparent,
    builder: (_) {
      return PolicyViewer(policy: policy);
    },
  );
}
