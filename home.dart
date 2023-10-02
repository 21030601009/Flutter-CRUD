import 'package:flutter/material.dart';
import 'package:list/Namenumber.dart';

class Home extends StatefulWidget {
  const Home({super.key});

  @override
  State<Home> createState() => _HomeState();
}

class _HomeState extends State<Home> {
  int selectedIndex = -1;
  TextEditingController nameController = TextEditingController();
  TextEditingController numberController = TextEditingController();
  List<Namenumber> contacts = List.empty(growable: true);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('CRUD using LIST'),
        centerTitle: true,
      ),
      body: Column(
        children: [
          Padding(
            padding: const EdgeInsets.all(8.0),
            child: TextField(
              controller: nameController,
              decoration: InputDecoration(
                hintText: 'Enter Name',
                border: OutlineInputBorder(
                  borderRadius: BorderRadius.circular(15),
                ),
              ),
            ),
          ),
          Padding(
            padding: const EdgeInsets.all(8.0),
            child: TextField(
              controller: numberController,
              keyboardType: TextInputType.number,
              maxLength: 10,
              decoration: InputDecoration(
                hintText: 'Enter Contact Number',
                border: OutlineInputBorder(
                  borderRadius: BorderRadius.circular(15),
                ),
              ),
            ),
          ),
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceEvenly,
            children: [
              ElevatedButton(
                onPressed: () {
                  String name = nameController.text.trim();
                  String number = numberController.text.trim();

                  if (name.isNotEmpty && number.isNotEmpty) {
                    setState(() {
                      nameController.text = '';
                      numberController.text = '';
                      contacts.add(Namenumber(name: name, number: number));
                    });
                  }
                },
                child: Text('Save'),
              ),
              ElevatedButton(
                onPressed: () {
                  String name = nameController.text.trim();
                  String number = numberController.text.trim();
                  if (name.isNotEmpty && number.isNotEmpty) {
                    setState(() {
                      nameController.text = '';
                      numberController.text = '';
                      contacts[selectedIndex].name = name;
                      contacts[selectedIndex].number = number;
                    });
                  }
                },
                child: Text('Update'),
              ),
            ],
          ),
          SizedBox(
            height: 20,
          ),
          contacts.isEmpty
              ? Text('No Contact Yet..')
              : Expanded(
                  child: ListView.builder(
                    itemCount: contacts.length,
                    itemBuilder: (context, index) => getRow(index),
                  ),
                )
        ],
      ),
    );
  }

  Widget getRow(index) {
    return Card(
      child: ListTile(
        leading: CircleAvatar(
          child: Text(
            contacts[index].name[0].toUpperCase(),
            style: TextStyle(fontWeight: FontWeight.bold),
          ),
          backgroundColor:
              index % 2 == 0 ? Colors.deepPurpleAccent : Colors.blueAccent,
        ),
        title: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Text(
              contacts[index].name,
              style: TextStyle(fontSize: 20),
            ),
            Text(
              contacts[index].number,
              style: TextStyle(color: Colors.grey),
            ),
          ],
        ),
        trailing: SizedBox(
          width: 75,
          child: Row(
            children: [
              InkWell(
                child: Icon(
                  Icons.edit_rounded,
                  color: Colors.lightBlueAccent,
                ),
                onTap: () {
                  nameController.text = contacts[index].name;
                  numberController.text = contacts[index].number;
                  setState(() {
                    selectedIndex = index;
                  });
                },
              ),
              SizedBox(
                width: 10,
              ),
              InkWell(
                child: Icon(
                  Icons.delete_rounded,
                  color: Colors.red,
                ),
                onTap: () {
                  setState(() {
                    contacts.removeAt(index);
                  });
                },
              ),
            ],
          ),
        ),
      ),
    );
  }
}
