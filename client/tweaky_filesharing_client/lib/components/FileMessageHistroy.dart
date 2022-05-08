// ignore_for_file: no_logic_in_create_state

import 'package:flutter/material.dart';
import 'package:url_launcher/url_launcher.dart';

class FileMessageHistory extends StatefulWidget {
  final List fileHistory;
  const FileMessageHistory({Key? key, required this.fileHistory})
      : super(key: key);

  @override
  State<FileMessageHistory> createState() =>
      _FileMessageHistoryState(fileHistory);
}

class _FileMessageHistoryState extends State<FileMessageHistory> {
  final List fileHistory;

  _FileMessageHistoryState(this.fileHistory) {
    print(fileHistory);
  }

  @override
  Widget build(BuildContext context) {
    return ListView.builder(
        itemCount: fileHistory.length,
        itemBuilder: ((context, index) => ListTile(
              title: Text("${fileHistory[index]['title']}"),
              subtitle: Text(
                  fileHistory[index]['description']),
              trailing: TextButton(
                  onPressed: fileHistory[index]['is_expired'] ? null : () async {
                      await launch('http://10.0.2.2:3000/' + fileHistory[index]['display_url']);
                  },
                  child: Text(fileHistory[index]['is_expired'] ? "Expired" : "Open")),
            )));
  }
}
