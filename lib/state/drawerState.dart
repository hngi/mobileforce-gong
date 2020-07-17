import 'dart:async';
class DrawerService {
  StreamController<bool> _statusController = StreamController.broadcast();
  Stream<bool> get status => _statusController.stream;

  setIsOpenStatus(bool openStatus) {
    _statusController.add(openStatus);
  }
}