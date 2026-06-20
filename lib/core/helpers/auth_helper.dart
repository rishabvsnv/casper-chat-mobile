/* import 'dart:convert';

import 'package:myschoolio/core/constants/image.dart';
import 'package:shared_preferences/shared_preferences.dart';

class AuthHelper {
  static SharedPreferences? _prefs;

  static Future<void> init() async {
    _prefs ??= await SharedPreferences.getInstance();
  }

  static bool hasStdPermision() {
    return _prefs?.getBool('has_permissions') ?? false;
  }

  static String? getToken() => _prefs?.getString('jwt');
  static String? getUserId() => _prefs?.getString('id');
  static String? getSchoolId() => _prefs?.getString('school_id');
  static String? getSchoolUpiId() => _prefs?.getString('school_upi_id');
  static String? getSchoolName() => _prefs?.getString('school_name');
  static String? getSchoolWPNo() => _prefs?.getString('school_whatsapp_no');
  static String? getSchoolBoard() => _prefs?.getString('school_board');
  static String? getUserName() => _prefs?.getString('username');
  static String? getUserRole() => _prefs?.getString('user_role');
  static String? getPhotoUrl() => _prefs?.getString('photo_url');
  static String? getSelectedChild() => _prefs?.getString('selected_child_name');

  static String? getSelectedChildId() => _prefs?.getString('selected_child_id');

  /// ✅ NEW: Fetch student_id from flutter.child_detail
  static String? getStudentId() {
    final userJson = _prefs?.getString('user_detail'); // ✅ correct key
    if (userJson == null) return null;

    try {
      final List<dynamic> list = jsonDecode(userJson);
      if (list.isEmpty) return null;

      return list.first["student_id"]?.toString(); // ✅ correct field
    } catch (_) {
      return null;
    }
  }

  static String? getUserImage() {
    final role = getUserRole();

    // PARENT → load selected child image
    if (role == "parent") {
      final childJson = _prefs?.getString('child_detail');
      final selectedId = _prefs?.getString('selected_child_id');

      if (childJson != null && selectedId != null) {
        try {
          final List data = jsonDecode(childJson);

          final selectedChild = data.firstWhere(
            (item) => item["student_id"].toString() == selectedId,
            orElse: () => null,
          );

          if (selectedChild != null) {
            final img = selectedChild["image"]?.toString();
            if (img != null && img.isNotEmpty) return img;
          }
        } catch (_) {}
      }
    }

    // STUDENT → load from user_detail
    if (role == "student") {
      final userJson = _prefs?.getString('user_detail');
      if (userJson != null) {
        try {
          final List data = jsonDecode(userJson);

          if (data.isNotEmpty) {
            final img = data.first["image"]?.toString();
            if (img != null && img.isNotEmpty) return img;
          }
        } catch (_) {}
      }
    }

    // Fallback
    return _prefs?.getString('photo_url') ?? Images.stdAvatar;
  }

  static String? getUserDetailId() {
    final jsonString = _prefs?.getString('user_detail');
    if (jsonString == null) return null;

    try {
      final List<dynamic> list = jsonDecode(jsonString);
      if (list.isEmpty) return null;

      return list.first["id"].toString();
    } catch (_) {
      return null;
    }
  }

  static String? getDisplayName() {
    final role = getUserRole();

    // Parent → show father_name from user_detail
    if (role == "parent") {
      final userJson = _prefs?.getString('user_detail');
      if (userJson != null) {
        try {
          final List data = jsonDecode(userJson);
          if (data.isNotEmpty) {
            final fatherName = data.first["father_name"]?.toString().trim();
            if (fatherName != null && fatherName.isNotEmpty) {
              return fatherName; // primary for parent
            }
          }
        } catch (_) {}
      }

      // fallback → selected child name
      final childName = _prefs?.getString('selected_child_name');
      if (childName != null && childName.isNotEmpty) {
        return childName;
      }
    }

    // Student → name from user_detail
    if (role == "student") {
      final userJson = _prefs?.getString('user_detail');
      if (userJson != null) {
        try {
          final List data = jsonDecode(userJson);
          if (data.isNotEmpty) {
            final firstname = data.first["firstname"]?.toString() ?? "";
            final lastname = data.first["lastname"]?.toString() ?? "";
            return "$firstname $lastname".trim();
          }
        } catch (_) {}
      }
    }

    // Default fallback
    return getUserName();
  }

  static Map<String, dynamic>? getTeacherProfile() {
    final userJson = _prefs?.getString('user_detail');
    if (userJson == null) return null;

    try {
      final List<dynamic> list = jsonDecode(userJson);
      if (list.isEmpty) return null;

      return list.first as Map<String, dynamic>;
    } catch (_) {
      return null;
    }
  }

  static Map<String, dynamic>? fetchParentProfile() {
    final userJson = _prefs?.getString('user_detail');
    if (userJson == null) return null;

    try {
      final List<dynamic> list = jsonDecode(userJson);
      if (list.isEmpty) return null;

      return list.first as Map<String, dynamic>;
    } catch (_) {
      return null;
    }
  }
}
 */
