import 'package:flutter/material.dart';
import 'package:state_mangement/models/client.dart';

class Clients extends ChangeNotifier {
  List<Client> clients;

  Clients({
    required this.clients,
  });
}