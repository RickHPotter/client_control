import 'package:flutter/material.dart';
import 'package:state_mangement/models/client.dart';

class Clients extends ChangeNotifier {
  List<Client> list;

  Clients({
    required this.list,
  });

  void add(Client client) {
    list.add(client);
    notifyListeners();
  }

  void remove(int index) {
    list.removeAt(index);
    notifyListeners();
  }
}