import 'dart:io';

import 'package:dio/dio.dart';

class RoomConnectHelper {
  static String BASE_URL = 'http://10.0.2.2:3000/api/v1/';

  static Future createRoomAndConnect(
      String roomName, onSuccess, onError) async {
    try {
      var response =
          await Dio().post(BASE_URL + 'room', data: {'name': roomName});
      if (response.statusCode == 200) {
        onSuccess(response.data);
      } else {
        onError(response.data);
      }
    } catch (e) {
      onError({'err': 'Unable to create room with name : $roomName'});
    }
  }

  static Future joinRoom(String roomName, onSuccess, onError) async {
    try {
      var response = await Dio().get(BASE_URL + 'room/$roomName');
      if (response.statusCode == 200) {
        onSuccess(response.data);
      } else {
        onError(response.data);
      }
    } catch (e) {
      onError({'err': 'Unable to join room with name : $roomName'});
    }
  }

  static Future getRoomFileMessages(String roomName, onSuccess, onError) async {
    try {
      var response = await Dio().get(BASE_URL + 'room/$roomName');
      if (response.statusCode == 200) {
        onSuccess(response.data);
      } else {
        onError(response.data);
      }
    } catch (e) {
      onError({'err': 'Unable to join room with name : $roomName'});
    }
  }

  static Future sendFileMessage(Map fileMessage, String roomName,
      File messageFile, onSuccess, onError) async {
    final FormData _fileMessageDetails = FormData.fromMap({
      ...fileMessage,
      'file_message': await MultipartFile.fromFile(
        messageFile.path,
      ),
    });
    try {
      var res = await Dio().post(BASE_URL + 'room/$roomName/file-message',
          data: _fileMessageDetails);
      if (res.statusCode == 200) {
        onSuccess(res.data);
      }
    } catch (e) {
      onError("Unable to upload file!");
    }
  }
}
