import 'package:ad_e_commerce/core/widgets/app_text.dart';
import 'package:ad_e_commerce/features/legal/models/policy_model.dart';
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

          AppTexts.regular(policy.subtitle, fontSize: 16),

          const SizedBox(height: 4),

          AppTexts.regular(policy.effectiveDate, fontSize: 13),

          const Divider(),

          Expanded(
            child: SingleChildScrollView(
              padding: const EdgeInsets.all(20),
              child: MarkdownBody(
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
