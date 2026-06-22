import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:messenger/shared/widgets/custom_appbar.dart';

class ReportScreen extends ConsumerStatefulWidget {
  const ReportScreen({super.key});

  @override
  ConsumerState<ReportScreen> createState() => _ReportScreenState();
}

class _ReportScreenState extends ConsumerState<ReportScreen> {
  String? _selectedReason;
  final TextEditingController _detailsController = TextEditingController();

  final List<ReportReason> _reasons = const [
    ReportReason(
      title: 'Spam',
      description: 'Unwanted advertisements or repetitive messages',
      icon: Icons.campaign_outlined,
    ),
    ReportReason(
      title: 'Fake Account',
      description: 'Impersonation or misleading identity',
      icon: Icons.person_off_outlined,
    ),
    ReportReason(
      title: 'Violence',
      description: 'Threats, violence, or harmful content',
      icon: Icons.gpp_bad_outlined,
    ),
    ReportReason(
      title: 'Harassment',
      description: 'Bullying, abuse, or targeted harassment',
      icon: Icons.report_problem_outlined,
    ),
    ReportReason(
      title: 'Adult Content',
      description: 'Sexually explicit or inappropriate material',
      icon: Icons.no_adult_content_outlined,
    ),
    ReportReason(
      title: 'Scam or Fraud',
      description: 'Financial scams or deceptive activities',
      icon: Icons.warning_amber_outlined,
    ),
    ReportReason(
      title: 'Copyright Violation',
      description: 'Unauthorized use of copyrighted material',
      icon: Icons.copyright_outlined,
    ),
    ReportReason(
      title: 'Other',
      description: 'Describe the issue in your own words',
      icon: Icons.more_horiz,
    ),
  ];

  @override
  void dispose() {
    _detailsController.dispose();
    super.dispose();
  }

  void _submitReport() {
    if (_selectedReason == null) {
      ScaffoldMessenger.of(
        context,
      ).showSnackBar(const SnackBar(content: Text('Please select a reason')));
      return;
    }

    ScaffoldMessenger.of(context).showSnackBar(
      const SnackBar(content: Text('Report submitted successfully')),
    );

    Navigator.pop(context);
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: const CustomAppBar(title: 'Report'),
      body: Column(
        children: [
          Container(
            width: double.infinity,
            padding: const EdgeInsets.all(16),
            color: Theme.of(context).colorScheme.surfaceContainerHighest,
            child: const Text(
              'Help keep the community safe. Select the reason that best describes the issue.',
            ),
          ),

          Expanded(
            child: ListView(
              children: [
                const SizedBox(height: 8),

                ..._reasons.map(
                  (reason) => RadioListTile<String>(
                    value: reason.title,
                    groupValue: _selectedReason,
                    title: Text(reason.title),
                    subtitle: Text(reason.description),
                    secondary: Icon(reason.icon),
                    onChanged: (value) {
                      setState(() {
                        _selectedReason = value;
                      });
                    },
                  ),
                ),

                const Divider(),

                Padding(
                  padding: const EdgeInsets.all(16),
                  child: TextField(
                    controller: _detailsController,
                    maxLines: 5,
                    decoration: const InputDecoration(
                      labelText: 'Additional Details',
                      hintText: 'Provide more information (optional)',
                      border: OutlineInputBorder(),
                      alignLabelWithHint: true,
                    ),
                  ),
                ),

                Padding(
                  padding: const EdgeInsets.symmetric(horizontal: 16),
                  child: FilledButton.icon(
                    onPressed: _submitReport,
                    icon: const Icon(Icons.flag_outlined),
                    label: const Text('Submit Report'),
                  ),
                ),

                const SizedBox(height: 24),
              ],
            ),
          ),
        ],
      ),
    );
  }
}

class ReportReason {
  final String title;
  final String description;
  final IconData icon;

  const ReportReason({
    required this.title,
    required this.description,
    required this.icon,
  });
}
