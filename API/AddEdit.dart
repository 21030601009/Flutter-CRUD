import 'package:flutter/material.dart';

class AddEdit extends StatefulWidget {
  AddEdit({Key? key, this.employee}) : super(key: key);
  Map<String, dynamic>? employee;

  @override
  State<AddEdit> createState() => _AddEditState();
}

class _AddEditState extends State<AddEdit> {
  TextEditingController nameController = TextEditingController();

  @override
  void initState() {
    super.initState();
    nameController = TextEditingController(
        text:
            widget.employee != null ? widget.employee!["name"].toString() : "");
  }

  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: Text("New User")),
      body: Column(children: [
        TextFormField(
          controller: nameController,
          decoration: InputDecoration(
              border: OutlineInputBorder(
                  borderRadius: BorderRadius.all(Radius.circular(50))),
              hintText: "Enter Username"),
        ),
        SizedBox(height: 10),
        ElevatedButton(
          onPressed: () {
            Map<String, dynamic> user = {"name": nameController.text};
            Navigator.of(context).pop(user);
          },
          child: Text(
            "Submit",
            style: TextStyle(color: Colors.black87, fontSize: 20),
          ),
          style: ButtonStyle(
              backgroundColor: MaterialStatePropertyAll(Colors.teal)),
        )
      ]),
    );
  }
}
