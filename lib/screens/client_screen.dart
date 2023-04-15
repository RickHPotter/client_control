import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:state_mangement/components/hamburguer_menu.dart';
import 'package:state_mangement/models/client.dart';
import 'package:state_mangement/models/client_type.dart';
import 'package:state_mangement/models/client_types.dart';
import 'package:state_mangement/models/clients.dart';

class ClientScreen extends StatefulWidget {
  const ClientScreen({required this.title, super.key});
  final String title;

  @override
  State<ClientScreen> createState() => _ClientScreenState();
}

class _ClientScreenState extends State<ClientScreen> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text(widget.title),
      ),
      drawer: const HamburguerMenu(),
      body: Consumer<Clients>(
          builder: (BuildContext context, Clients clients, Widget? widget) {
        return ListView.builder(
            itemCount: clients.list.length,
            itemBuilder: (context, index) {
              return Dismissible(
                  key: UniqueKey(),
                  background: Container(color: Colors.red),
                  child: ListTile(
                    leading: Icon(clients.list[index].type.icon),
                    title: Text(clients.list[index].name),
                    iconColor: Colors.indigo,
                  ),
                  onDismissed: (direct) => clients.remove(index));
            });
      }),
      floatingActionButton: FloatingActionButton(
        backgroundColor: Colors.indigo,
        onPressed: () {
          createClient(context);
        },
        tooltip: "Add Client",
        child: const Icon(Icons.add),
      ),
    );
  }

  void createClient(BuildContext context) {
    TextEditingController nameInput = TextEditingController();
    TextEditingController emailInput = TextEditingController();

    ClientTypes types = Provider.of<ClientTypes>(context, listen: false);
    ClientType dropDownValue = types.list[0];

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
                          items: types.list.map((ClientType type) {
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
              Consumer<Clients>(
                builder:
                    (BuildContext context, Clients clients, Widget? widget) =>
                        TextButton(
                  child: const Text("Save"),
                  onPressed: () async {
                    clients.add(Client(
                        name: nameInput.text,
                        email: emailInput.text,
                        type: dropDownValue));
                    Navigator.pop(context);
                  },
                ),
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
