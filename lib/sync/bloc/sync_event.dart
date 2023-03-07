part of 'sync_bloc.dart';

abstract class SyncEvent extends Equatable {
  const SyncEvent();

  @override
  List<Object> get props => [];
}

class CheckLocationPermissions extends SyncEvent {}

class CheckLocationEnabled extends SyncEvent {}

class CheckWifiEnabled extends SyncEvent {}

class AskLocationPermissions extends SyncEvent {}

class EnableLocationServices extends SyncEvent {}

class EnableWifiServices extends SyncEvent {}

class Initialise extends SyncEvent {}

class Register extends SyncEvent {}

class Unregister extends SyncEvent {}

class DiscoverDevices extends SyncEvent {}

class PeersUpdated extends SyncEvent {
  const PeersUpdated({required this.peers});
  final List<DiscoveredPeers> peers;
}

class Connect extends SyncEvent {
  const Connect({required this.deviceAddress});
  final String deviceAddress;
}

class StartSocket extends SyncEvent {
  const StartSocket({required this.groupOwnerAddress});
  final String groupOwnerAddress;
}

class ConnectToSocket extends SyncEvent {
  const ConnectToSocket({required this.groupOwnerAddress});
  final String groupOwnerAddress;
}

class SendStringToSocket extends SyncEvent {
  const SendStringToSocket({required this.message});
  final String message;
}

class GetWiFiP2pInfo extends SyncEvent {}

class UpdateWiFiP2pInfo extends SyncEvent {
  const UpdateWiFiP2pInfo({required this.wifiP2PInfo});
  final WifiP2PInfo wifiP2PInfo;
}

class Init extends SyncEvent {}

class Close extends SyncEvent {}
