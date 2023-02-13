import 'dart:async';

import 'package:bloc/bloc.dart';
import 'package:equatable/equatable.dart';
import 'package:flutter/foundation.dart';
import 'package:flutter_p2p_connection/flutter_p2p_connection.dart';

part 'sync_event.dart';
part 'sync_state.dart';

// This class extends the Bloc class and manages the state and events for synchronizing devices over a peer-to-peer connection

class SyncBloc extends Bloc<SyncEvent, SyncState> {

  // constructor initializes the state and sets up event handlers
  SyncBloc() : super(const SyncState()) {
    on<CheckLocationPermissions>(_checkLocationPermissions);
    on<CheckLocationEnabled>(_checkLocationEnabled);
    on<CheckWifiEnabled>(_checkWifiEnabled);
    on<AskLocationPermissions>(_askLocationPermissions);
    on<EnableLocationServices>(_enableLocationServices);
    on<EnableWifiServices>(_enableWifiServices);
    on<DiscoverDevices>(_discoverDevices);
    on<PeersUpdated>(_peersUpdated);
    on<Connect>(_connect);
    on<StartSocket>(_startSocket);
    on<ConnectToSocket>(_connectToSocket);
    on<SendStringToSocket>(_sendStringToSocket);
    on<GetWiFiP2pInfo>(_getWifiP2pInfo);
    on<UpdateWiFiP2pInfo>(_updateWiFiP2pInfo);
    on<Init>(_initP2p);
    on<Close>(_closeP2p);
  }

  final _flutterP2pConnectionPlugin = FlutterP2pConnection();

  // stream of discovered peers
  final _streamPeers = FlutterP2pConnection().streamPeers();
  final _streamWiFiP2pInfo = FlutterP2pConnection().streamWifiP2PInfo();

  @override
  Future<void> close() async {
    print('closed');
    await _flutterP2pConnectionPlugin.removeGroup();
    await _flutterP2pConnectionPlugin.stopDiscovery();
    await _flutterP2pConnectionPlugin.unregister();
    return super.close();
  }

  // event handler for checking location permissions
  void _checkLocationPermissions(CheckLocationPermissions event, Emitter<SyncState> emit) async {
    var result = await _flutterP2pConnectionPlugin.checkLocationPermission();
    if (result) {
      emit(state.copyWith(locationPermissionsGranted: true));
    } else {
      emit(state.copyWith(locationPermissionsGranted: false));
    }
  }

  // event handler for checking if location services are enabled
  void _checkLocationEnabled(CheckLocationEnabled event, Emitter<SyncState> emit) async {
    var result = await _flutterP2pConnectionPlugin.checkLocationEnabled();
    if (result) {
      emit(state.copyWith(locationEnabled: true));
    } else {
      emit(state.copyWith(locationEnabled: false));
      }
  }

  // event handler for checking if wifi is enabled
  void _checkWifiEnabled(CheckWifiEnabled event, Emitter<SyncState> emit) async {
    var result = await _flutterP2pConnectionPlugin.checkWifiEnabled();
    if (result) {
      emit(state.copyWith(wifiEnabled: true));
    } else {
      emit(state.copyWith(wifiEnabled: false));
      }
  }

  // event handler for asking for location permissions
  void _askLocationPermissions(AskLocationPermissions event, Emitter<SyncState> emit) async {
    try {
      await _flutterP2pConnectionPlugin.askLocationPermission();
      bool? enabled =  await _flutterP2pConnectionPlugin.checkLocationEnabled();
      print('location enabled: $enabled');
    } catch (e) {
      print('ask location perms: $e');
      emit(state.copyWith(error: '$e'));
    }
  }

  // event handler for enabling location services
  void _enableLocationServices(EnableLocationServices event, Emitter<SyncState> emit) async {
    try {
      await _flutterP2pConnectionPlugin.enableLocationServices();
    } catch (e) {
      print('enable location: $e');
      emit(state.copyWith(error: '$e'));
    }
  }

  // event handler for enabling wifi services
  void _enableWifiServices(EnableWifiServices event, Emitter<SyncState> emit) async {
    try {
      await _flutterP2pConnectionPlugin.enableWifiServices();
    } catch (e) {
      print('enable wifi: $e');
      emit(state.copyWith(error: '$e'));
    }
  }

  // event handler for discovering nearby devices
  void _discoverDevices(DiscoverDevices event, Emitter<SyncState> emit) async {
    try {
      bool? initialised = await _flutterP2pConnectionPlugin.initialize();
      print('init: $initialised');
      bool? registered = await _flutterP2pConnectionPlugin.register();
      print('registered: $registered');
    } catch (e) {
      print('init: $e');
      emit(state.copyWith(error: '$e'));
    }
    add(GetWiFiP2pInfo());
    try {
      //listen for peer events and call PeersUpdated event
      _streamPeers.listen((peerEvent) {
        add(PeersUpdated(peers: peerEvent));
      });
    } catch (e) {
      //emit an error state if there is an exception
      print('peers listener: $e');
      emit(state.copyWith(error: '$e'));
      //return from the method to stop further execution
      return;
    }
    try {
      bool? discovering = await _flutterP2pConnectionPlugin.discover();
      print('discovering: $discovering');
    } catch (e) {
      //emit an error state if there is an exception
      print('discover: $e');
      emit(state.copyWith(error: '$e'));
    }
  }

  void _peersUpdated(PeersUpdated event, Emitter<SyncState> emit) async {
    emit(state.copyWith(peers: event.peers));
  }

  void _connect(Connect event, Emitter<SyncState> emit) async {
    try {
      await _flutterP2pConnectionPlugin.connect(event.deviceAddress);
      emit(state.copyWith(status: 'Connected to ${event.deviceAddress}'));
      var groupInfo = await _flutterP2pConnectionPlugin.groupInfo();
      print(groupInfo?.clients);
    } catch (e) {
      //emit an error state if there is an exception
      print('connect: $e');
      emit(state.copyWith(error: '$e'));
    }
  }

  Future _startSocket(StartSocket event, Emitter<SyncState> emit) async {
    await _flutterP2pConnectionPlugin.startSocket(
      groupOwnerAddress: event.groupOwnerAddress,
      downloadPath: "/storage/emulated/0/Download/",
      onConnect: (String name, String address) {
          print("$name connected to socket with address: $address");
      },
      transferUpdate: (TransferUpdate transfer) {

      },
      receiveString: (req) async {
        if (kDebugMode) {
          print(req);
        }
      },
    );
  }

  Future _connectToSocket(ConnectToSocket event, Emitter<SyncState> emit) async {
    await _flutterP2pConnectionPlugin.connectToSocket(
      groupOwnerAddress: event.groupOwnerAddress,
      downloadPath: "/storage/emulated/0/Download/",
      onConnect: (String address) {
        print("connected to socket with address: $address");
      },
      transferUpdate: (TransferUpdate transfer) {

      },
      receiveString: (req) async {
        if (kDebugMode) {
          print(req);
        }
      },
    );
  }

  void _sendStringToSocket(SendStringToSocket event, Emitter<SyncState> emit) async {
    _flutterP2pConnectionPlugin.sendStringToSocket(event.message);
  }

  void _getWifiP2pInfo(GetWiFiP2pInfo event, Emitter<SyncState> emit) async {
    print('started listening');
    try {
      _streamWiFiP2pInfo.listen((e) {
        print('e');
        add(UpdateWiFiP2pInfo(wifiP2PInfo: e));
      });
    } catch (e) {
      print(e);
    }

  }

  void _updateWiFiP2pInfo(UpdateWiFiP2pInfo event, Emitter<SyncState> emit) async {
    emit(state.copyWith(wifiP2PInfo: event.wifiP2PInfo));
  }

  void _initP2p(Init event, Emitter<SyncState> emit) async {
    try {
      await _flutterP2pConnectionPlugin.initialize();
      await _flutterP2pConnectionPlugin.register();
    } catch (e) {
      print('init: $e');
      emit(state.copyWith(error: '$e'));
    }
  }

  void _closeP2p(Close event, Emitter<SyncState> emit) async {
      bool? stopped = await _flutterP2pConnectionPlugin.stopDiscovery();
      print('stopped discovery: $stopped');
      bool closed = _flutterP2pConnectionPlugin.closeSocket();
      print('stopped socket: $closed');
      bool? removed = await _flutterP2pConnectionPlugin.removeGroup();
      print("removed group: $removed");
      _flutterP2pConnectionPlugin.unregister();
  }
}