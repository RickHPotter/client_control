import 'package:flutter/material.dart';
import 'package:state_mangement/models/client_type.dart';

class ClientTypes extends ChangeNotifier {
  List<ClientType> list;

  ClientTypes({
    required this.list,
  });

  void add(ClientType type) {
    list.add(type);
    notifyListeners();
  }

  void remove(int index) {
    list.removeAt(index);
    notifyListeners();
  }
}