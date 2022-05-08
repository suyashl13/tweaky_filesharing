import 'package:flutter/material.dart';
import 'package:tweaky_filesharing_client/components/JoinOrCreateCard.dart';

class HomePage extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
        appBar: AppBar(
          elevation: 0,
          toolbarHeight: 50,
          title: const Center(
              child: Text(
            "Tweaky Fileshare",
            style: TextStyle(fontSize: 18),
          )),
        ),
        body: Center(
          child: Container(
              width: MediaQuery.of(context).size.width / 2,
              child: const JoinOrCreateCard()),
        ));
  }
}
