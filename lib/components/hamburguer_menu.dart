import 'package:flutter/material.dart';
import 'dart:io';

class HamburguerMenu extends StatelessWidget {
  const HamburguerMenu({super.key});

  @override
  Widget build(BuildContext context) {
    return Drawer(
      child: ListView(
        padding: EdgeInsets.zero,
        children: [
          const DrawerHeader(
            decoration: BoxDecoration(
              color: Colors.indigo,
            ),
            child: Text( 
              "Menu",
              style: TextStyle(
                fontWeight: FontWeight.bold,
                color: Colors.white,
                fontSize: 20,
              ),
            ),
          ),
          ListTile(
            title: const Text("Manage Clients"),
            onTap: () {
              Navigator.pushNamed(context, "/");
            },
          ),
          const Divider(),
          ListTile(
            title: const Text("Client Types"),
            onTap: () {
              Navigator.pushNamed(context, "/types");
            },
          ),
          const Divider(),
          ListTile(
            title: const Text("Exit"),
            onTap: () => exit(0),
          )
        ],
      ),
    );
  }
}