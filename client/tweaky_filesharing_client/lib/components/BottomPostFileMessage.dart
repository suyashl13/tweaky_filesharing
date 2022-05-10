import 'dart:io';

import 'package:file_picker/file_picker.dart';
import 'package:flutter/material.dart';
import 'package:tweaky_filesharing_client/helpers/RoomHelper.dart';

class BottomSender extends StatefulWidget {
  const BottomSender({Key? key, required this.roomName}) : super(key: key);

  final String roomName;
  @override
  State<BottomSender> createState() => _BottomSenderState(roomName);
}

class _BottomSenderState extends State<BottomSender> {
  String roomName;
  GlobalKey<FormState> _fKey = GlobalKey<FormState>();
  Map fileMessageData = {
    'title': '',
    'description': '',
  };
  File? messageFile;

  _BottomSenderState(this.roomName);

  Future _getFile() async {
    FilePickerResult? result = await FilePicker.platform.pickFiles();
    setState(() {
      if (result != null) {
        messageFile = File(result.files.single.path!);
      } else {
        ScaffoldMessenger.of(context)
            .showSnackBar(const SnackBar(content: Text("No File Selected!")));
      }
    });
  }

  Future _uploadFile() async {
    await RoomConnectHelper.sendFileMessage(
        fileMessageData, roomName, messageFile!, (data) {
      ScaffoldMessenger.of(context)
          .showSnackBar(const SnackBar(content: Text("File Sent!")));
    }, (error) {
      ScaffoldMessenger.of(context)
          .showSnackBar(SnackBar(content: Text(error.toString())));
    });

    setState(() {
      fileMessageData = {
        'title': '',
        'description': '',
      };
      messageFile = null;
    });
    Navigator.pop(context);
  }

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: const EdgeInsets.symmetric(vertical: 10, horizontal: 10),
      height: 500,
      child: Form(
        key: _fKey,
        child: Column(
          children: [
            TextFormField(
              initialValue: fileMessageData['title'],
              onChanged: (e) {
                setState(() {
                  fileMessageData['title'] = e;
                });
              },
              validator: (value) {
                if (value!.isEmpty) {
                  return "Field cannot be empty";
                }
              },
              decoration: InputDecoration(label: Text("Title")),
            ),
            TextFormField(
              initialValue: fileMessageData['description'],
              onChanged: (e) {
                setState(() {
                  fileMessageData['description'] = e;
                });
              },
              validator: (value) {
                if (value!.isEmpty) {
                  return "Field cannot be empty";
                }
              },
              decoration: const InputDecoration(label: Text("Description")),
            ),
            TextButton(
                onPressed: _getFile,
                child: Text(messageFile == null
                    ? "Upload File"
                    : "Tap to change file")),
            SizedBox(
              width: double.maxFinite,
              child: MaterialButton(
                elevation: 0,
                onPressed: () {
                  if (_fKey.currentState!.validate()) {
                    _fKey.currentState!.save();
                    _uploadFile();
                  }
                },
                child: const Text("Send File"),
                color: Colors.green,
              ),
            )
          ],
        ),
      ),
    );
  }
}
