import 'package:dio/dio.dart';

class RoomConnectHelper {
  final String BASE_URL = 'http://10.0.2.2:3000/api/v1/';

  Future createRoomAndConnect(String roomName, onSuccess, onError) async {
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

  Future joinRoom(String roomName, onSuccess, onError) async {
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

  Future getRoomFileMessages(String roomName, onSuccess, onError) async {
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
}
