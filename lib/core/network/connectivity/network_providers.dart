/* import 'package:connectivity_plus/connectivity_plus.dart';
import 'package:dio/dio.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:myschoolio/core/network/dio_client.dart';
import 'connectivity_service.dart';
import 'internet_reachability.dart';
import 'network_status.dart';

final connectivityProvider = Provider((_) => Connectivity());

final dioProvider = Provider<Dio>((_) => DioClient.dio);

final connectivityServiceProvider = Provider<ConnectivityService>(
  (ref) => ConnectivityService(ref.read(connectivityProvider)),
);

final internetReachabilityProvider = Provider<InternetReachability>(
  (ref) => InternetReachability(ref.read(dioProvider)),
);

final networkStatusProvider = StreamProvider<NetworkStatus>((ref) async* {
  final connectivityService = ref.read(connectivityServiceProvider);
  final reachability = ref.read(internetReachabilityProvider);

  yield await reachability.check();

  await for (final _ in connectivityService.observeChanges()) {
    yield await reachability.check();
  }
});
 */
