import 'package:flutter/foundation.dart';

class RoomHistory with ChangeNotifier, DiagnosticableTreeMixin {
  List roomHistory = [];

  setRoomHistory(roomHistory) {
    this.roomHistory = roomHistory;
    notifyListeners();
  }

  getRoomHistory() {
    return roomHistory;
  }

  clearRoomHistory() {
    roomHistory = [];
    notifyListeners();
  }

  addItem(Map item) {
    roomHistory.add(item);
    notifyListeners();
  }
}
