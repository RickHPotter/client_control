import 'package:flutter/material.dart';
import 'package:state_mangement/components/hamburguer_menu.dart';
import 'package:state_mangement/models/client.dart';
import 'package:state_mangement/models/client_type.dart';

class ClientScreen extends StatefulWidget {
  const ClientScreen({required this.title, super.key});
  final String title;

  @override
  State<ClientScreen> createState() => _ClientScreenState();
}

class _ClientScreenState extends State<ClientScreen> {
  List<Client> clients = [
    Client(
        name: "Geralt",
        email: "geralt@gmail.com",
        type: ClientType(name: "Platinum", icon: Icons.credit_card)),
    Client(
        name: "Paul",
        email: "paul@gmail.com",
        type: ClientType(name: "Golden", icon: Icons.card_membership)),
    Client(
        name: "Cain",
        email: "cain@gmail.com",
        type: ClientType(name: "Titanium", icon: Icons.credit_score)),
    Client(
        name: "Juan",
        email: "juan@gmail.com",
        type: ClientType(name: "Diamond", icon: Icons.diamond)),
  ];

  List<ClientType> types = [
    ClientType(name: "Platinum", icon: Icons.credit_card),
    ClientType(name: "Golden", icon: Icons.card_membership_rounded),
    ClientType(name: "Titanium", icon: Icons.credit_score),
    ClientType(name: "Diamond", icon: Icons.diamond),
  ];

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text(widget.title),
      ),
      drawer: const HamburguerMenu(),
      body: ListView.builder(
          itemCount: clients.length,
          itemBuilder: (context, index) {
            return Dismissible(
              key: UniqueKey(),
              background: Container(color: Colors.red),
              child: ListTile(
                leading: Icon(clients[index].type.icon),
                title: Text(clients[index].name),
                iconColor: Colors.indigo,
              ),
              onDismissed: (direct) {
                setState(() {
                  clients.removeAt(index);
                });
              },
            );
          }),
      floatingActionButton: FloatingActionButton(
        backgroundColor: Colors.indigo,
        onPressed: () {
          createType(context);
        },
        tooltip: "Add Type",
        child: const Icon(Icons.add),
      ),
    );
  }

  void createType(BuildContext context) {
    TextEditingController nameInput = TextEditingController();
    TextEditingController emailInput = TextEditingController();
    ClientType dropDownValue = types[0];

    showDialog(
        context: context,
        builder: (BuildContext context) {
          return AlertDialog(
            scrollable: true,
            title: const Text("Register Client"),
            content: Padding(
              padding: const EdgeInsets.all(8),
              child: Form(
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    TextFormField(
                      controller: nameInput,
                      decoration: const InputDecoration(
                        labelText: "Name",
                        icon: Icon(Icons.account_box),
                      ),
                    ),
                    Padding(
                      padding: const EdgeInsets.all(5),
                      child: TextFormField(
                        controller: nameInput,
                        decoration: const InputDecoration(
                          labelText: "Email",
                          icon: Icon(Icons.email),
                        ),
                      ),
                    ),
                    const Padding(padding: EdgeInsets.all(5)),
                    StatefulBuilder(
                        builder: (BuildContext context, StateSetter setState) {
                      return DropdownButton(
                          isExpanded: true,
                          icon: const Icon(Icons.arrow_downward),
                          style: const TextStyle(color: Colors.deepPurple),
                          underline: Container(
                            height: 2,
                            color: Colors.indigo,
                          ),
                          value: dropDownValue,
                          items: types.map((ClientType type) {
                            return DropdownMenuItem<ClientType>(
                              value: type,
                              child: Text(type.name),
                            );
                          }).toList(),
                          onChanged: (newValue) {
                            setState(() {
                              dropDownValue = newValue as ClientType;
                            });
                          });
                    })
                  ],
                ),
              ),
            ),
            actions: [
              TextButton(
                child: const Text("Save"),
                onPressed: () async {
                  setState(() {
                    clients.add(Client(name: nameInput.text, email: emailInput.text, type: dropDownValue));
                  });
                  Navigator.pop(context);
                },
              ),
              TextButton(
                child: const Text("Cancel"),
                onPressed: () {
                  Navigator.pop(context);
                },
              )
            ],
          );
        });
  }
}