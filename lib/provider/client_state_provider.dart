import 'package:flutter/cupertino.dart';
import 'package:typeracer_project/model/client_state.dart';

class ClientStateProvider extends ChangeNotifier {
  ClientState _clientState = ClientState(
    timer: {
      'countDown': '',
      'msg': '',
    },
  );

  Map<String, dynamic> get clientState => _clientState.toJson();

  setClientState(timer) {
    _clientState = ClientState(timer: timer);
    notifyListeners();
  }
}
