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
  String _searchQuery = '';

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
    final theme = Theme.of(context);

    final filteredLanguages = _languages.where((language) {
      final query = _searchQuery.toLowerCase();

      return language.name.toLowerCase().contains(query) ||
          language.nativeName.toLowerCase().contains(query);
    }).toList();

    return Scaffold(
      appBar: const CustomAppBar(title: 'Language'),
      body: ListView(
        padding: const EdgeInsets.only(bottom: 24),
        children: [
          /// Search
          Padding(
            padding: const EdgeInsets.symmetric(horizontal: 16),
            child: TextField(
              onChanged: (value) {
                setState(() {
                  _searchQuery = value;
                });
              },
              decoration: const InputDecoration(
                hintText: 'Search language',
                prefixIcon: Icon(Icons.search),
              ),
            ),
          ),

          const SizedBox(height: 8),

          Card(
            margin: const EdgeInsets.symmetric(horizontal: 16),
            elevation: 0,
            child: ListView.separated(
              shrinkWrap: true,
              physics: const NeverScrollableScrollPhysics(),
              itemCount: filteredLanguages.length,
              separatorBuilder: (_, _) => const Divider(height: 1),
              itemBuilder: (context, index) {
                final language = filteredLanguages[index];

                final selected = language.name == _selectedLanguage;

                return ListTile(
                  leading: CircleAvatar(
                    child: Text(
                      language.code.toUpperCase(),
                      style: const TextStyle(
                        fontSize: 12,
                        fontWeight: FontWeight.bold,
                      ),
                    ),
                  ),

                  title: Text(language.name),

                  subtitle: Text(language.nativeName),

                  trailing: selected
                      ? Icon(
                          Icons.check_circle_rounded,
                          color: theme.colorScheme.primary,
                        )
                      : null,

                  onTap: () {
                    setState(() {
                      _selectedLanguage = language.name;
                    });

                    ScaffoldMessenger.of(context).showSnackBar(
                      SnackBar(
                        content: Text('Language changed to ${language.name}'),
                      ),
                    );
                  },
                );
              },
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
