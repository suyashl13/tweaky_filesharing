import 'package:flutter/material.dart';

class BottomSender extends StatefulWidget {
  const BottomSender({Key? key}) : super(key: key);

  @override
  State<BottomSender> createState() => _BottomSenderState();
}

class _BottomSenderState extends State<BottomSender> {
  GlobalKey<FormState> _fKey = GlobalKey<FormState>();

  @override
  Widget build(BuildContext context) {
    return Container(
      height: 500,
      child: Form(
        key: _fKey,
        child: Column(
          children: [
            TextFormField(),
            TextFormField(),
            
          ],
        ),
      ),
    );
  }
}
