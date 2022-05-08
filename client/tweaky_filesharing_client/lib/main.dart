import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:tweaky_filesharing_client/components/JoinOrCreateCard.dart';
import 'package:tweaky_filesharing_client/contexts/RoomHistory.dart';
import 'package:tweaky_filesharing_client/screens/FileShareRoomPage.dart';
import 'package:tweaky_filesharing_client/screens/HomePage.dart';

void main() {
  runApp(MultiProvider(
    providers: [
      ChangeNotifierProvider(create: (_) => RoomHistory()),
      Provider(create: (_) => FileShareRoomPage(roomName: "")),
      Provider(create: (_) => const JoinOrCreateCard())
    ],
    child: const MyApp(),
  ));
}

class MyApp extends StatelessWidget {
  const MyApp({Key? key}) : super(key: key);

  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Tweaky Fileshare',
      theme: ThemeData(primarySwatch: Colors.green),
      home: HomePage(),
    );
  }
}
