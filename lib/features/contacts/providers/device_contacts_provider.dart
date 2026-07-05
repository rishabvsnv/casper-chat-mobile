import 'package:flutter_contacts/flutter_contacts.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

import '../data/services/device_contacts_service.dart';

final deviceContactsProvider = FutureProvider<List<Contact>>((ref) async {
  return DeviceContactsService().getContacts();
});
