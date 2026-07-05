import 'package:flutter_contacts/flutter_contacts.dart';

class DeviceContactsService {
  Future<List<Contact>> getContacts() async {
    final status = await FlutterContacts.permissions.request(
      PermissionType.read,
    );

    if (status != PermissionStatus.granted &&
        status != PermissionStatus.limited) {
      return [];
    }

    return FlutterContacts.getAll(
      properties: {
        ContactProperty.name,
        ContactProperty.phone,
        ContactProperty.photoThumbnail,
      },
    );
  }
}
