class DeviceModel {
  final String deviceName;
  final String platform;
  final String location;
  final String lastActive;
  final bool isCurrent;

  const DeviceModel({
    required this.deviceName,
    required this.platform,
    required this.location,
    required this.lastActive,
    this.isCurrent = false,
  });
}
