import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:messenger/shared/widgets/custom_appbar.dart';

class LanguageScreen extends ConsumerStatefulWidget {
  const LanguageScreen({super.key});

  @override
  ConsumerState<LanguageScreen> createState() => _LanguageScreenState();
}

class _LanguageScreenState extends ConsumerState<LanguageScreen> {
  String _selectedLanguage = 'English';

  final List<LanguageModel> _languages = const [
    LanguageModel(name: 'English', nativeName: 'English', code: 'en'),
    LanguageModel(name: 'Hindi', nativeName: 'हिन्दी', code: 'hi'),
    LanguageModel(name: 'Arabic', nativeName: 'العربية', code: 'ar'),
    LanguageModel(name: 'Spanish', nativeName: 'Español', code: 'es'),
    LanguageModel(name: 'French', nativeName: 'Français', code: 'fr'),
    LanguageModel(name: 'German', nativeName: 'Deutsch', code: 'de'),
    LanguageModel(name: 'Russian', nativeName: 'Русский', code: 'ru'),
    LanguageModel(name: 'Chinese', nativeName: '中文', code: 'zh'),
    LanguageModel(name: 'Japanese', nativeName: '日本語', code: 'ja'),
    LanguageModel(name: 'Portuguese', nativeName: 'Português', code: 'pt'),
    LanguageModel(name: 'Turkish', nativeName: 'Türkçe', code: 'tr'),
    LanguageModel(name: 'Italian', nativeName: 'Italiano', code: 'it'),
  ];

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: const CustomAppBar(title: 'Language'),
      body: Column(
        children: [
          Container(
            width: double.infinity,
            padding: const EdgeInsets.all(16),
            color: Theme.of(context).colorScheme.surfaceContainerHighest,
            child: const Row(
              children: [
                Icon(Icons.language_outlined),
                SizedBox(width: 12),
                Expanded(
                  child: Text(
                    'Choose the language used throughout the application.',
                  ),
                ),
              ],
            ),
          ),

          Expanded(
            child: RadioGroup<String>(
              groupValue: _selectedLanguage,
              onChanged: (String? value) {
                if (value == null) return;

                setState(() {
                  _selectedLanguage = value;
                });

                ScaffoldMessenger.of(context).showSnackBar(
                  SnackBar(content: Text('Language changed to $value')),
                );
              },
              child: ListView.separated(
                itemCount: _languages.length,
                separatorBuilder: (_, _) => const Divider(height: 1),
                itemBuilder: (context, index) {
                  final language = _languages[index];

                  final isSelected = language.name == _selectedLanguage;

                  return RadioListTile<String>(
                    value: language.name,
                    title: Text(
                      language.name,
                      style: const TextStyle(fontWeight: FontWeight.w600),
                    ),
                    subtitle: Text(language.nativeName),
                    secondary: CircleAvatar(
                      child: Text(
                        language.code.toUpperCase(),
                        style: const TextStyle(
                          fontSize: 12,
                          fontWeight: FontWeight.bold,
                        ),
                      ),
                    ),
                    selected: isSelected,
                  );
                },
              ),
            ),
          ),

          SafeArea(
            top: false,
            child: Padding(
              padding: const EdgeInsets.all(16),
              child: FilledButton.icon(
                onPressed: () {
                  ScaffoldMessenger.of(context).showSnackBar(
                    SnackBar(content: Text('$_selectedLanguage selected')),
                  );
                },
                icon: const Icon(Icons.check),
                label: const Text('Apply Language'),
              ),
            ),
          ),
        ],
      ),
    );
  }
}

class LanguageModel {
  final String name;
  final String nativeName;
  final String code;

  const LanguageModel({
    required this.name,
    required this.nativeName,
    required this.code,
  });
}
