import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:gibsonify/sync/bloc/sync_bloc.dart';

class SyncScreen extends StatelessWidget {
  SyncScreen({Key? key}) : super(key: key);

  final TextEditingController messageController = TextEditingController();

  @override
  Widget build(BuildContext context) {
    return BlocConsumer<SyncBloc, SyncState>(
      listener: (context, state) {
        if (state.error != null) {
          ScaffoldMessenger.of(context).showSnackBar(
            SnackBar(
              backgroundColor: Colors.red,
              content: Text('${state.error}', style: TextStyle(color: Colors.white)),
            )
          );
        }
      },
      builder: (context, state) {
        return Column(
          children: [
            const SizedBox(height: 50,),
            const Text('Devices', style: TextStyle(fontSize: 16),),
            SizedBox(
              height: 300,
              width: MediaQuery.of(context).size.width,
              child: ListView.builder(
                scrollDirection: Axis.vertical,
                itemCount: state.peers.length,
                itemBuilder: (context, index) => Padding(
                  padding: const EdgeInsets.only(left: 16.0, right: 16, bottom: 8),
                  child: Row(
                    children: [
                      Text(
                        state.peers[index].deviceName.toString(),
                        style: const TextStyle(
                          fontSize: 24,
                        ),
                      ),
                      const Spacer(),
                      TextButton(
                        onPressed: () {
                          context.read<SyncBloc>().add(Connect(deviceAddress: state.peers[index].deviceAddress));
                        },
                        child: const Text('Connect'),
                      )
                    ],
                  ),
                ),
                ),
            ),
            TextButton(
              onPressed: () {
                print('requested location permissions');
                context.read<SyncBloc>().add(AskLocationPermissions());
              },
              child: const Text('Request location Permissions'),
            ),
            TextButton(
              onPressed: () {
                context.read<SyncBloc>().add(DiscoverDevices());
              },
              child: const Text('Start Discovering'),
            ),
            TextButton(
              onPressed: () {
                final wifiP2pInfo = state.wifiP2pInfo;
                print(wifiP2pInfo);
                if (wifiP2pInfo != null) {
                  context.read<SyncBloc>().add(StartSocket(groupOwnerAddress: wifiP2pInfo.groupOwnerAddress));
                }
              },
              child: const Text('Start Socket'),
            ),
            TextButton(
              onPressed: () {
                final wifiP2pInfo = state.wifiP2pInfo;
                print(wifiP2pInfo);
                if (wifiP2pInfo != null) {
                  context.read<SyncBloc>().add(ConnectToSocket(groupOwnerAddress: wifiP2pInfo.groupOwnerAddress));
                }
              },
              child: const Text('Connect to Socket'),
            ),
            TextField(
              controller: messageController,
            ),
            TextButton(
              onPressed: () {
                if (messageController.text != '') {
                  context.read<SyncBloc>().add(SendStringToSocket(message: messageController.text));
                }
              },
              child: const Text('Send message'),
            ),
            TextButton(
              onPressed: () {
                // close
              },
              child: const Text('Close'),
            ),
          ],
        );
      },
    );
  }
}
