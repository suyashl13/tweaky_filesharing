// ignore_for_file: no_logic_in_create_state

import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:socket_io_client/socket_io_client.dart';
import 'package:tweaky_filesharing_client/components/BottomPostFileMessage.dart';
import 'package:tweaky_filesharing_client/components/FileMessageHistroy.dart';
import 'package:tweaky_filesharing_client/contexts/RoomHistory.dart';

class FileShareRoomPage extends StatefulWidget {
  FileShareRoomPage({Key? key, required this.roomName}) : super(key: key);

  final String roomName;
  @override
  State<FileShareRoomPage> createState() => _FileShareRoomPageState(roomName);
}

class _FileShareRoomPageState extends State<FileShareRoomPage> {
  final String roomName;
  Socket? socket;

  _FileShareRoomPageState(this.roomName);

  _initializeSocketIO() {
    socket = io(
        'http://10.0.2.2:3000',
        OptionBuilder()
            .setQuery({'roomName': roomName})
            .setTransports(['websocket'])
            .disableAutoConnect()
            .build());
    socket!.connect();

    socket!.on('file_message', (data) {
      setState(() {
        Provider.of<RoomHistory>(context, listen: false).addItem(data);
      });
    });
  }

  @override
  void initState() {
    super.initState();
    _initializeSocketIO();
  }

  @override
  void dispose() {
    super.dispose();
    socket!.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        appBar: AppBar(
          elevation: 0,
          toolbarHeight: 50,
          title: Center(
              child: Text(
            "Room : " + roomName,
            style: TextStyle(fontSize: 18),
          )),
        ),
        body: Column(
          children: [
            Expanded(
              child: FileMessageHistory(
                  fileHistory: Provider.of<RoomHistory>(context, listen: false)
                      .roomHistory),
            ),
            Container(
              margin: const EdgeInsets.symmetric(horizontal: 4),
              width: double.maxFinite,
              child: MaterialButton(
                onPressed: () {
                  showModalBottomSheet(
                      context: context,
                      builder: (context) => BottomSender(
                            roomName: roomName,
                          ));
                },
                textColor: Colors.white,
                color: Colors.green,
                child: const Text("Send File"),
              ),
            )
          ],
        ));
  }
}
