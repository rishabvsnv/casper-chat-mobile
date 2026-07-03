import 'dart:ui';

class AppColors {
  // Casper Chat Brand
  static const Color primary = Color(0xFF0A84FF);
  static const Color secondary = Color(0xFF36CFFF);

  // App Icon Gradient
  static const Color iconGradientStart = Color(0xFF36CFFF);
  static const Color iconGradientEnd = Color(0xFF0A84FF);

  // Ghost Logo
  static const Color ghost = Color(0xFFFFFFFF);
  static const Color ghostEyes = Color(0xFF0B1F44);
  static const Color ghostSmile = Color(0xFF0B1F44);

  // Backgrounds
  static const Color background = Color(0xFFF7F9FC);
  static const Color surface = Color(0xFFFFFFFF);
  static const Color surfaceVariant = Color(0xFFF1F5F9);

  // Text
  static const Color textPrimary = Color(0xFF111827);
  static const Color textSecondary = Color(0xFF6B7280);
  static const Color textHint = Color(0xFF9CA3AF);

  // Status
  static const Color online = Color(0xFF22C55E);
  static const Color unread = primary;
  static const Color archived = Color(0xFF9CA3AF);

  // Feedback
  static const Color success = Color(0xFF22C55E);
  static const Color warning = Color(0xFFF59E0B);
  static const Color error = Color(0xFFEF4444);
  static const Color info = primary;

  // Borders
  static const Color border = Color(0xFFE5E7EB);
  static const Color divider = Color(0xFFF1F5F9);

  // Disabled
  static const Color disabled = Color(0xFFD1D5DB);
  static const Color disabledBackground = Color(0xFFF3F4F6);

  // Shadows
  static const Color shadow = Color(0x14000000);

  // Chat
  static const Color outgoingBubble = Color(0xFFE8F6FF);
  static const Color incomingBubble = Color(0xFFFFFFFF);

  // Dark Theme
  static const Color darkScaffold = Color(0xFF0B1220);
  static const Color darkSurface = Color(0xFF111827);
  static const Color darkSurfaceVariant = Color(0xFF1F2937);

  static const Color darkTextPrimary = Color(0xFFF9FAFB);
  static const Color darkTextSecondary = Color(0xFF9CA3AF);

  static const Color darkBorder = Color(0xFF374151);
  static const Color darkDivider = Color(0xFF1F2937);

  // Stories
  static const Color storyBorder = primary;

  // Chat States
  static const Color readTick = primary;
  static const Color unreadTick = Color(0xFF9CA3AF);

  // Folder Tabs
  static const Color tabSelected = primary;
  static const Color tabUnselected = Color(0xFF6B7280);
}
