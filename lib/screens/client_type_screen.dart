import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:state_mangement/components/hamburguer_menu.dart';
import 'package:state_mangement/components/icon_picker.dart';
import 'package:state_mangement/models/client_type.dart';
import 'package:state_mangement/models/client_types.dart';

class ClientTypeScreen extends StatefulWidget {
  const ClientTypeScreen({required this.title, super.key});
  final String title;

  @override
  State<ClientTypeScreen> createState() => _ClientTypeScreenState();
}

class _ClientTypeScreenState extends State<ClientTypeScreen> {
  IconData? selectedIcon;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: (AppBar(
        title: Text(widget.title),
      )),
      drawer: const HamburguerMenu(),
      body: Consumer<ClientTypes>(
        builder: (BuildContext context, ClientTypes types, Widget? widget) =>
            ListView.builder(
          itemCount: types.list.length,
          itemBuilder: (context, index) => Dismissible(
              key: UniqueKey(),
              background: Container(color: Colors.red),
              child: ListTile(
                leading: Icon(types.list[index].icon),
                title: Text(types.list[index].name),
                iconColor: Colors.deepOrange,
              ),
              onDismissed: (direction) => setState(() => types.remove(index))),
        ),
      ),
      floatingActionButton: FloatingActionButton(
        backgroundColor: Colors.deepOrange,
        onPressed: () => createType(context),
        tooltip: "Add Type",
        child: const Icon(Icons.add),
      ),
    );
  }

  void createType(context) {
    TextEditingController nameInput = TextEditingController();

    showDialog(
        context: context,
        builder: (BuildContext context) {
          return AlertDialog(
            scrollable: true,
            title: const Text("Register Type"),
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
                    const Padding(padding: EdgeInsets.all(5)),
                    StatefulBuilder(
                      builder: (BuildContext context, StateSetter setState) =>
                          Column(
                        children: [
                          const Padding(padding: EdgeInsets.all(5)),
                          selectedIcon != null
                              ? Icon(selectedIcon, color: Colors.deepOrange)
                              : const Text("Select an Icon"),
                          const Padding(padding: EdgeInsets.all(5)),
                          SizedBox(
                            width: double.infinity,
                            child: ElevatedButton(
                              onPressed: () async {
                                final IconData? result = await showIconPicker(
                                    context: context,
                                    defaultIcon: selectedIcon);
                                setState(() => selectedIcon = result);
                              },
                              child: const Text("Select an Icon"),
                            ),
                          )
                        ],
                      ),
                    )
                  ],
                ),
              ),
            ),
            actions: [
              Consumer<ClientTypes>(
                  builder: (BuildContext context, ClientTypes types,
                          Widget? widget) =>
                      TextButton(
                        child: const Text("Save"),
                        onPressed: () {
                          selectedIcon ??= Icons.credit_score;
                          types.add(ClientType(
                              name: nameInput.text, icon: selectedIcon));
                          selectedIcon = null;
                          setState(() => Navigator.pop(context));
                        },
                      )),
            ],
          );
        });
  }
}
