import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:tweaky_filesharing_client/contexts/RoomHistory.dart';
import 'package:tweaky_filesharing_client/helpers/RoomHelper.dart';
import 'package:tweaky_filesharing_client/screens/FileShareRoomPage.dart';

class JoinOrCreateCard extends StatefulWidget {
  const JoinOrCreateCard({Key? key}) : super(key: key);

  @override
  State<JoinOrCreateCard> createState() => _JoinOrCreateCardState();
}

class _JoinOrCreateCardState extends State<JoinOrCreateCard> {
  String _roomName = '';

  @override
  Widget build(BuildContext context) {
    return Card(
      child: Padding(
        padding: const EdgeInsets.all(8.0),
        child: Column(mainAxisSize: MainAxisSize.min, children: [
          TextFormField(
            initialValue: _roomName,
            onChanged: (e) => {
              setState(() {
                _roomName = e;
              })
            },
            decoration: const InputDecoration(
              label: Text(
                "Room Name",
                style: TextStyle(fontSize: 14),
              ),
            ),
          ),
          Container(
            margin: const EdgeInsets.only(top: 12),
            width: double.maxFinite,
            color: Colors.green,
            height: 38,
            child: MaterialButton(
              textColor: Colors.white,
              onPressed: () async {
                await RoomConnectHelper.createRoomAndConnect(_roomName,
                    (res) {
                  Navigator.of(context).push(MaterialPageRoute(
                      builder: (_) =>
                          FileShareRoomPage(roomName: res['name'])));
                }, (err) {
                  ScaffoldMessenger.of(context)
                      .showSnackBar(SnackBar(content: Text(err['err'])));
                });
              },
              child: const Text("Create Room"),
            ),
          ),
          Container(
            margin: const EdgeInsets.only(top: 6),
            width: double.maxFinite,
            color: Colors.green,
            height: 38,
            child: MaterialButton(
              textColor: Colors.white,
              onPressed: () async {
                await RoomConnectHelper.joinRoom(_roomName, (res) {
                  Provider.of<RoomHistory>(context, listen: false)
                      .setRoomHistory(res);
                  Navigator.of(context).push(MaterialPageRoute(
                      builder: (_) => FileShareRoomPage(
                            roomName: _roomName,
                          )));
                }, (err) {
                  ScaffoldMessenger.of(context)
                      .showSnackBar(SnackBar(content: Text(err['err'])));
                });
              },
              child: const Text("Join Room"),
            ),
          )
        ]),
      ),
    );
  }
}
