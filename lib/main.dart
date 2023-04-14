import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:state_mangement/models/clients.dart';
import 'package:state_mangement/screens/client_screen.dart';
import 'package:state_mangement/screens/client_type_screen.dart';

void main() {
  runApp(
    ChangeNotifierProvider(
      create: (context) => Clients(clients: []),
      child: const MyApp()
    )
  );
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

