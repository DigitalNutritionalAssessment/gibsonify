part of 'sync_bloc.dart';

enum FoundDevices { found, loading, notFound }

class SyncState extends Equatable {
  const SyncState({
    this.locationPermissionsGranted = false,
    this.locationEnabled = false,
    this.wifiEnabled = false,
    this.error,
    this.initialised = false,
    this.registered = false,
    this.wifiP2pInfo,
    this.streamPeers,
    this.peers = const [],
    this.status = '',
  });

  final bool locationPermissionsGranted;
  final bool locationEnabled;
  final bool wifiEnabled;
  final String? error;
  final String status;

  final bool initialised;
  final bool registered;

  final WifiP2PInfo? wifiP2pInfo;
  final StreamSubscription<List<DiscoveredPeers>>? streamPeers;

  final List<DiscoveredPeers> peers;

  SyncState copyWith({
    bool? locationPermissionsGranted,
    bool? locationEnabled,
    bool? wifiEnabled,
    String? error,
    bool? initialised,
    bool? registered,
    WifiP2PInfo? wifiP2PInfo,
    StreamSubscription<List<DiscoveredPeers>>? streamPeers,
    List<DiscoveredPeers>? peers,
    String? status,
  }) {
    return SyncState(
      locationPermissionsGranted:
          locationPermissionsGranted ?? this.locationPermissionsGranted,
      locationEnabled: locationEnabled ?? this.locationEnabled,
      wifiEnabled: wifiEnabled ?? this.wifiEnabled,
      error: error ?? this.error,
      initialised: initialised ?? this.initialised,
      registered: registered ?? this.registered,
      wifiP2pInfo: wifiP2PInfo ?? wifiP2pInfo,
      streamPeers: streamPeers ?? this.streamPeers,
      peers: peers ?? this.peers,
      status: status ?? this.status,
    );
  }

  @override
  List<Object?> get props => [
        locationPermissionsGranted,
        locationEnabled,
        wifiEnabled,
        error,
        initialised,
        registered,
        wifiP2pInfo,
        streamPeers,
        peers,
        status
      ];
}
