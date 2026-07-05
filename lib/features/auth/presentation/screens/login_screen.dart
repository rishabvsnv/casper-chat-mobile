import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:go_router/go_router.dart';
import 'package:messenger/routes/named_routes.dart';

class LoginScreen extends ConsumerStatefulWidget {
  const LoginScreen({super.key});

  @override
  ConsumerState<LoginScreen> createState() => _LoginScreenState();
}

class _LoginScreenState extends ConsumerState<LoginScreen> {
  final FocusNode _phoneFocusNode = FocusNode();
  final FocusNode _countryCodeFocusNode = FocusNode();

  final TextEditingController _phoneController = TextEditingController();

  final TextEditingController _countryCodeController = TextEditingController(
    text: '+91',
  );

  String _selectedCountry = 'in';

  bool sendMessages = false;

  final Map<String, Map<String, String>> countries = {
    'in': {'name': 'India', 'code': '+91', 'flag': '🇮🇳'},
    'us': {'name': 'United States', 'code': '+1', 'flag': '🇺🇸'},
    'uk': {'name': 'United Kingdom', 'code': '+44', 'flag': '🇬🇧'},
    'ca': {'name': 'Canada', 'code': '+1', 'flag': '🇨🇦'},
    'au': {'name': 'Australia', 'code': '+61', 'flag': '🇦🇺'},
    'nz': {'name': 'New Zealand', 'code': '+64', 'flag': '🇳🇿'},
    'de': {'name': 'Germany', 'code': '+49', 'flag': '🇩🇪'},
    'fr': {'name': 'France', 'code': '+33', 'flag': '🇫🇷'},
    'it': {'name': 'Italy', 'code': '+39', 'flag': '🇮🇹'},
    'es': {'name': 'Spain', 'code': '+34', 'flag': '🇪🇸'},
    'ru': {'name': 'Russia', 'code': '+7', 'flag': '🇷🇺'},
    'cn': {'name': 'China', 'code': '+86', 'flag': '🇨🇳'},
    'jp': {'name': 'Japan', 'code': '+81', 'flag': '🇯🇵'},
    'kr': {'name': 'South Korea', 'code': '+82', 'flag': '🇰🇷'},
    'sg': {'name': 'Singapore', 'code': '+65', 'flag': '🇸🇬'},
    'my': {'name': 'Malaysia', 'code': '+60', 'flag': '🇲🇾'},
    'th': {'name': 'Thailand', 'code': '+66', 'flag': '🇹🇭'},
    'id': {'name': 'Indonesia', 'code': '+62', 'flag': '🇮🇩'},
    'ae': {'name': 'United Arab Emirates', 'code': '+971', 'flag': '🇦🇪'},
    'sa': {'name': 'Saudi Arabia', 'code': '+966', 'flag': '🇸🇦'},
    'qa': {'name': 'Qatar', 'code': '+974', 'flag': '🇶🇦'},
    'kw': {'name': 'Kuwait', 'code': '+965', 'flag': '🇰🇼'},
    'om': {'name': 'Oman', 'code': '+968', 'flag': '🇴🇲'},
    'bh': {'name': 'Bahrain', 'code': '+973', 'flag': '🇧🇭'},
    'pk': {'name': 'Pakistan', 'code': '+92', 'flag': '🇵🇰'},
    'bd': {'name': 'Bangladesh', 'code': '+880', 'flag': '🇧🇩'},
    'lk': {'name': 'Sri Lanka', 'code': '+94', 'flag': '🇱🇰'},
    'np': {'name': 'Nepal', 'code': '+977', 'flag': '🇳🇵'},
  };

  final countries2 = [
    {'code': 'jp', 'name': 'Japan', 'flag': '🇯🇵'},
    {'code': 'sg', 'name': 'Singapore', 'flag': '🇸🇬'},
    {'code': 'pk', 'name': 'Pakistan', 'flag': '🇵🇰'},
    {'code': 'bd', 'name': 'Bangladesh', 'flag': '🇧🇩'},
    {'code': 'lk', 'name': 'Sri Lanka', 'flag': '🇱🇰'},
    {'code': 'np', 'name': 'Nepal', 'flag': '🇳🇵'},
  ];

  final List<Map<String, String?>> keypadKeys = [
    {'title': '1', 'subtitle': null},
    {'title': '2', 'subtitle': 'ABC'},
    {'title': '3', 'subtitle': 'DEF'},
    {'title': '4', 'subtitle': 'GHI'},
    {'title': '5', 'subtitle': 'JKL'},
    {'title': '6', 'subtitle': 'MNO'},
    {'title': '7', 'subtitle': 'PQRS'},
    {'title': '8', 'subtitle': 'TUV'},
    {'title': '9', 'subtitle': 'WXYZ'},
    {'title': '', 'subtitle': null},
    {'title': '0', 'subtitle': '+'},
    {'title': 'BACKSPACE', 'subtitle': null},
  ];

  @override
  void initState() {
    super.initState();

    _countryCodeController.text = '+91';

    _countryCodeController.addListener(_onCountryCodeChanged);

    WidgetsBinding.instance.addPostFrameCallback((_) {
      _phoneFocusNode.requestFocus();
    });
  }

  @override
  void dispose() {
    _phoneFocusNode.dispose();
    _phoneController.dispose();
    super.dispose();
  }

  void _onCountryCodeChanged() {
    final code = _countryCodeController.text.trim();

    for (final entry in countries.entries) {
      if (entry.value['code'] == code) {
        if (_selectedCountry != entry.key) {
          setState(() {
            _selectedCountry = entry.key;
          });
        }
        break;
      }
    }
  }

  void _onKeyPressed(String key) {
    setState(() {
      final controller = _countryCodeFocusNode.hasFocus
          ? _countryCodeController
          : _phoneController;

      if (key == 'BACKSPACE') {
        if (controller.text.isNotEmpty) {
          controller.text = controller.text.substring(
            0,
            controller.text.length - 1,
          );
        }
      } else if (key == 'LongPress') {
        controller.clear();
      } else {
        controller.text += key;
      }

      controller.selection = TextSelection.collapsed(
        offset: controller.text.length,
      );
    });
  }

  void _showCountryPicker() {
    final countryList = countries.entries.toList();

    showModalBottomSheet(
      context: context,
      isScrollControlled: true,
      showDragHandle: true,
      builder: (context) {
        String search = '';

        return StatefulBuilder(
          builder: (context, setModalState) {
            final filteredCountries = countryList.where((entry) {
              return entry.value['name']!.toLowerCase().contains(
                    search.toLowerCase(),
                  ) ||
                  entry.key.toLowerCase().contains(search.toLowerCase());
            }).toList();

            return SafeArea(
              child: SizedBox(
                height: MediaQuery.of(context).size.height * 0.75,
                child: Column(
                  children: [
                    Padding(
                      padding: const EdgeInsets.all(16),
                      child: TextField(
                        // autofocus: true,
                        decoration: InputDecoration(
                          hintText: 'Search country',
                          prefixIcon: const Icon(Icons.search),
                          border: OutlineInputBorder(
                            borderRadius: BorderRadius.circular(16),
                          ),
                        ),
                        onChanged: (value) {
                          setModalState(() {
                            search = value;
                          });
                        },
                      ),
                    ),

                    Expanded(
                      child: ListView.builder(
                        itemCount: filteredCountries.length,
                        itemBuilder: (context, index) {
                          final entry = filteredCountries[index];

                          return ListTile(
                            leading: Text(
                              entry.value['flag']!,
                              style: const TextStyle(fontSize: 24),
                            ),
                            title: Text(entry.value['name']!),
                            subtitle: Text(entry.value['code']!),
                            onTap: () {
                              setState(() {
                                _selectedCountry = entry.key;
                                _countryCodeController.text =
                                    entry.value['code']!;
                              });

                              context.pop();
                            },
                          );
                        },
                      ),
                    ),
                  ],
                ),
              ),
            );
          },
        );
      },
    );
  }

  @override
  Widget build(BuildContext context) {
    final size = MediaQuery.of(context).size;

    final isSmallScreen = size.height < 700;

    final keypadHeight = isSmallScreen ? 260.0 : size.height * 0.38;

    return Scaffold(
      body: SafeArea(
        child: SingleChildScrollView(
          padding: const EdgeInsets.symmetric(horizontal: 24, vertical: 16),
          child: ConstrainedBox(
            constraints: BoxConstraints(minHeight: size.height * 0.40),
            child: Column(
              children: [
                const SizedBox(height: 12),

                Image.asset(
                  'assets/images/casper_logo.png',
                  width: 72,
                  height: 72,
                ),

                const SizedBox(height: 20),

                Text(
                  'Casper Chat',
                  style: Theme.of(context).textTheme.headlineSmall?.copyWith(
                    fontWeight: FontWeight.w800,
                  ),
                ),

                const SizedBox(height: 8),

                Text(
                  'Stay close to every conversation.',
                  textAlign: TextAlign.center,
                  style: Theme.of(context).textTheme.bodyMedium,
                ),

                const SizedBox(height: 40),

                Container(
                  decoration: BoxDecoration(
                    borderRadius: BorderRadius.circular(18),
                    border: Border.all(
                      color: Theme.of(context).colorScheme.outline,
                    ),
                  ),
                  child: ListTile(
                    leading: Text(
                      countries[_selectedCountry]!['flag']!,
                      style: const TextStyle(fontSize: 24),
                    ),
                    title: Text(countries[_selectedCountry]!['name']!),
                    // subtitle: Text(countries[_selectedCountry]!['code']!),
                    trailing: const Icon(Icons.keyboard_arrow_down_rounded),
                    onTap: _showCountryPicker,
                  ),
                ),

                const SizedBox(height: 16),

                AnimatedContainer(
                  duration: const Duration(milliseconds: 200),
                  decoration: BoxDecoration(
                    color: Theme.of(context).inputDecorationTheme.fillColor,
                    borderRadius: BorderRadius.circular(18),
                    border: Border.all(
                      color:
                          _phoneFocusNode.hasFocus ||
                              _countryCodeFocusNode.hasFocus
                          ? Theme.of(context).colorScheme.primary
                          : Colors.transparent,
                      width: 1.5,
                    ),
                  ),
                  child: Row(
                    children: [
                      SizedBox(
                        width: 60,
                        child: Center(
                          child: Text(
                            _countryCodeController.text,
                            style: Theme.of(context).textTheme.titleMedium,
                          ),
                        ),
                      ),

                      Container(
                        width: 1,
                        height: 28,
                        color: Theme.of(context).colorScheme.outline,
                      ),

                      Expanded(
                        child: TextFormField(
                          controller: _phoneController,
                          focusNode: _phoneFocusNode,
                          keyboardType: TextInputType.none,
                          decoration: const InputDecoration(
                            border: InputBorder.none,
                            hintText: 'Phone Number',
                            contentPadding: EdgeInsets.symmetric(
                              horizontal: 16,
                            ),
                          ),
                        ),
                      ),
                    ],
                  ),
                ),

                const SizedBox(height: 24),

                ValueListenableBuilder<TextEditingValue>(
                  valueListenable: _phoneController,
                  builder: (context, value, child) {
                    return SizedBox(
                      width: double.infinity,
                      height: 52,
                      child: FilledButton.icon(
                        onPressed: value.text.length >= 10
                            ? () => context.pushReplacement(NamedRoutes.main)
                            : null,
                        icon: const Icon(Icons.arrow_forward_rounded),
                        label: const Text('Continue'),
                      ),
                    );
                  },
                ),
              ],
            ),
          ),
        ),
      ),

      floatingActionButton: FloatingActionButton.extended(
        label: Text('Skip'),
        onPressed: () {
          context.pushReplacement(NamedRoutes.main);
        },
      ),

      bottomNavigationBar: SafeArea(
        top: false,
        child: SizedBox(
          height: keypadHeight,
          child: Padding(
            padding: const EdgeInsets.all(16),
            child: GridView.builder(
              physics: const NeverScrollableScrollPhysics(),
              itemCount: keypadKeys.length,
              gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
                crossAxisCount: 3,
                childAspectRatio: isSmallScreen ? 1.7 : 2.0,
                crossAxisSpacing: 10,
                mainAxisSpacing: 10,
              ),
              itemBuilder: (context, index) {
                final item = keypadKeys[index];

                if (item['title']!.isEmpty) {
                  return const SizedBox.shrink();
                }

                if (item['title'] == 'BACKSPACE') {
                  return GestureDetector(
                    onTap: () => _onKeyPressed('BACKSPACE'),
                    onLongPress: () => _onKeyPressed('LongPress'),
                    child: const Card(
                      child: Center(child: Icon(Icons.backspace_outlined)),
                    ),
                  );
                }

                return DialPadWidget(
                  title: item['title']!,
                  subtitle: item['subtitle'],
                  onTap: () {
                    _onKeyPressed(item['title']!);
                  },
                );
              },
            ),
          ),
        ),
      ),
    );
  }
}

class DialPadWidget extends StatefulWidget {
  final String title;
  final String? subtitle;
  final VoidCallback onTap;

  const DialPadWidget({
    super.key,
    required this.title,
    this.subtitle,
    required this.onTap,
  });

  @override
  State<DialPadWidget> createState() => _DialPadWidgetState();
}

class _DialPadWidgetState extends State<DialPadWidget> {
  bool _pressed = false;

  @override
  Widget build(BuildContext context) {
    final width = MediaQuery.of(context).size.width;

    return GestureDetector(
      onTapDown: (_) => setState(() => _pressed = true),
      onTapUp: (_) {
        setState(() => _pressed = false);
        widget.onTap();
      },
      onTapCancel: () => setState(() => _pressed = false),
      child: AnimatedScale(
        duration: const Duration(milliseconds: 80),
        scale: _pressed ? 0.95 : 1,
        child: AnimatedContainer(
          duration: const Duration(milliseconds: 120),
          decoration: BoxDecoration(
            borderRadius: BorderRadius.circular(20),
            color: _pressed
                ? Theme.of(context).colorScheme.primaryContainer
                : Theme.of(context).cardColor,
          ),
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              Text(
                widget.title,
                style: TextStyle(
                  fontSize: width < 360 ? 18 : 22,
                  fontWeight: FontWeight.w500,
                ),
              ),

              if (widget.subtitle != null)
                Text(
                  widget.subtitle!,
                  style: TextStyle(
                    fontSize: width < 360 ? 10 : 12,
                    letterSpacing: 1.4,
                    color: Theme.of(
                      context,
                    ).textTheme.bodySmall?.color?.withValues(alpha: .7),
                  ),
                ),
            ],
          ),
        ),
      ),
    );
  }
}
