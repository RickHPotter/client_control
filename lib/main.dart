import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:state_mangement/models/client.dart';
import 'package:state_mangement/models/client_type.dart';
import 'package:state_mangement/models/client_types.dart';
import 'package:state_mangement/models/clients.dart';
import 'package:state_mangement/screens/client_screen.dart';
import 'package:state_mangement/screens/client_type_screen.dart';

void main() {
  List<Client> list = [
    Client(
        name: "Cain",
        email: "cain@gmail.com",
        type: ClientType(name: "Titanium", icon: Icons.credit_score)),
  ];

  List<ClientType> types = [
    ClientType(name: "Platinum", icon: Icons.credit_card),
    ClientType(name: "Golden", icon: Icons.card_membership),
    ClientType(name: "Titanium", icon: Icons.credit_score),
    ClientType(name: "Diamond", icon: Icons.diamond),
  ];

  runApp(MultiProvider(
    providers: [
      ChangeNotifierProvider(create: (context) => Clients(list: list)),
      ChangeNotifierProvider(create: (context) => ClientTypes(list: types)),
    ],
    child: const MyApp(),
  ));
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Client Control',
      debugShowCheckedModeBanner: false,
      theme: ThemeData(
        primarySwatch: Colors.blue,
      ),
      initialRoute: "/",
      routes: {
        "/": (context) => const ClientScreen(title: "Clients"),
        "/types": (context) => const ClientTypeScreen(title: "Client Types"),
      },
    );
  }
}
