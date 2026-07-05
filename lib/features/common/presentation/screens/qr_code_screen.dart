import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:qr_code_scanner_plus/qr_code_scanner_plus.dart';
import 'package:qr_flutter/qr_flutter.dart';
import 'package:messenger/shared/widgets/custom_appbar.dart';

enum QrMode { myCode, scan }

class QrCodeScreen extends ConsumerStatefulWidget {
  const QrCodeScreen({super.key});

  @override
  ConsumerState<QrCodeScreen> createState() => _QrCodeScreenState();
}

class _QrCodeScreenState extends ConsumerState<QrCodeScreen> {
  QrMode _mode = QrMode.myCode;

  String? _scannedValue;
  bool _handledScan = false;

  QRViewController? _scannerController;
  final GlobalKey qrKey = GlobalKey(debugLabel: 'QR');

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);

    // Todo:
    // Replace with actual user/provider data
    const String fullName = 'Rishabh';
    const String username = 'rishabvsnv';
    const String phoneNumber = '+91 9876543210';

    final qrData = 'https://casperchat.me/$username';

    return Scaffold(
      appBar: const CustomAppBar(title: 'QR Code'),
      body: Column(
        children: [
          const SizedBox(height: 12),

          Padding(
            padding: const EdgeInsets.symmetric(horizontal: 16),
            child: SegmentedButton<QrMode>(
              segments: const [
                ButtonSegment(
                  value: QrMode.myCode,
                  icon: Icon(Icons.qr_code_rounded),
                  label: Text('My Code'),
                ),
                ButtonSegment(
                  value: QrMode.scan,
                  icon: Icon(Icons.qr_code_scanner_rounded),
                  label: Text('Scan'),
                ),
              ],
              selected: {_mode},
              onSelectionChanged: (selection) {
                setState(() {
                  _mode = selection.first;
                  _handledScan = false;
                });
              },
            ),
          ),

          const SizedBox(height: 12),

          Expanded(
            child: _mode == QrMode.myCode
                ? _buildMyCode(
                    context,
                    theme,
                    fullName,
                    username,
                    phoneNumber,
                    qrData,
                  )
                : _buildScanner(context, theme),
          ),
        ],
      ),
    );
  }

  Widget _buildMyCode(
    BuildContext context,
    ThemeData theme,
    String fullName,
    String username,
    String phoneNumber,
    String qrData,
  ) {
    return ListView(
      padding: const EdgeInsets.only(bottom: 24),
      children: [
        /// Profile Card
        Padding(
          padding: const EdgeInsets.symmetric(horizontal: 16),
          child: Card(
            elevation: 0,
            child: Padding(
              padding: const EdgeInsets.all(20),
              child: Row(
                children: [
                  const CircleAvatar(
                    radius: 30,
                    child: Icon(Icons.person, size: 30),
                  ),

                  const SizedBox(width: 16),

                  Expanded(
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Text(
                          fullName,
                          style: const TextStyle(
                            fontSize: 18,
                            fontWeight: FontWeight.w700,
                          ),
                        ),

                        const SizedBox(height: 4),

                        Text('@$username'),

                        Text(
                          phoneNumber,
                          style: TextStyle(
                            color: theme.colorScheme.onSurfaceVariant,
                          ),
                        ),
                      ],
                    ),
                  ),
                ],
              ),
            ),
          ),
        ),

        const SizedBox(height: 16),

        /// QR Card
        Padding(
          padding: const EdgeInsets.symmetric(horizontal: 16),
          child: Card(
            elevation: 0,
            child: Padding(
              padding: const EdgeInsets.all(24),
              child: Column(
                children: [
                  QrImageView(
                    data: qrData,
                    version: QrVersions.auto,
                    size: 260,
                    gapless: true,
                  ),

                  const SizedBox(height: 20),

                  const Text(
                    'Scan this QR code to open my profile',
                    textAlign: TextAlign.center,
                  ),
                ],
              ),
            ),
          ),
        ),

        const SizedBox(height: 16),

        /// Profile Link
        Padding(
          padding: const EdgeInsets.symmetric(horizontal: 16),
          child: Card(
            elevation: 0,
            child: ListTile(
              leading: const Icon(Icons.link_rounded),
              title: const Text('Profile Link'),
              subtitle: SelectableText(qrData),
            ),
          ),
        ),

        const SizedBox(height: 16),

        /// Actions
        Padding(
          padding: const EdgeInsets.symmetric(horizontal: 16),
          child: Card(
            elevation: 0,
            child: Column(
              children: [
                ListTile(
                  leading: const Icon(Icons.share_outlined),
                  title: const Text('Share Profile'),
                  trailing: const Icon(Icons.chevron_right_rounded),
                  onTap: () {
                    // Todo:
                    // Share profile
                  },
                ),

                const Divider(height: 1),

                ListTile(
                  leading: const Icon(Icons.download_rounded),
                  title: const Text('Save QR Code'),
                  trailing: const Icon(Icons.chevron_right_rounded),
                  onTap: () {
                    // Todo:
                    // Save QR Image
                  },
                ),
              ],
            ),
          ),
        ),
      ],
    );
  }

  Widget _buildScanner(BuildContext context, ThemeData theme) {
    return Column(
      children: [
        Expanded(
          child: Padding(
            padding: const EdgeInsets.all(16),
            child: ClipRRect(
              borderRadius: BorderRadius.circular(24),
              child: Stack(
                fit: StackFit.expand,
                children: [
                  QRView(
                    key: qrKey,
                    onQRViewCreated: (controller) {
                      _scannerController = controller;

                      controller.scannedDataStream.listen((scanData) {
                        if (_handledScan) return;

                        final value = scanData.code;

                        if (value == null) return;

                        _handledScan = true;

                        setState(() {
                          _scannedValue = value;
                        });
                        if (context.mounted) {
                          ScaffoldMessenger.of(context).showSnackBar(
                            SnackBar(content: Text('Scanned: $value')),
                          );
                        }

                        controller.pauseCamera();
                      });
                    },
                    overlay: QrScannerOverlayShape(
                      borderColor: Colors.white,
                      borderRadius: 20,
                      borderLength: 32,
                      borderWidth: 6,
                      cutOutSize: 240,
                    ),
                  ),

                  IgnorePointer(
                    child: Center(
                      child: Container(
                        width: 240,
                        height: 240,
                        decoration: BoxDecoration(
                          border: Border.all(color: Colors.white, width: 3),
                          borderRadius: BorderRadius.circular(20),
                        ),
                      ),
                    ),
                  ),
                ],
              ),
            ),
          ),
        ),

        if (_scannedValue != null)
          Padding(
            padding: const EdgeInsets.fromLTRB(16, 0, 16, 16),
            child: Card(
              elevation: 0,
              child: ListTile(
                leading: const Icon(Icons.qr_code_2_rounded),
                title: const Text('Scanned Result'),
                subtitle: Text(_scannedValue!),
                trailing: IconButton(
                  icon: const Icon(Icons.refresh),
                  onPressed: () async {
                    await _scannerController?.resumeCamera();

                    setState(() {
                      _handledScan = false;
                      _scannedValue = null;
                    });
                  },
                ),
              ),
            ),
          )
        else
          Padding(
            padding: const EdgeInsets.all(16),
            child: Text(
              'Point the camera at a QR code to scan.',
              style: TextStyle(color: theme.colorScheme.onSurfaceVariant),
            ),
          ),
      ],
    );
  }
}
