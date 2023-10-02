import 'package:crud/AddEdit.dart';
import 'package:crud/FetchApi.dart';
import 'package:flutter/material.dart';

class Home extends StatefulWidget {
  const Home({Key? key}) : super(key: key);

  @override
  State<Home> createState() => _HomeState();
}

class _HomeState extends State<Home> {
  FetchApi api = FetchApi();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar:
          AppBar(backgroundColor: Colors.teal, title: Text("Users"), actions: [
        IconButton(
            onPressed: () {
              Navigator.of(context).push(
                MaterialPageRoute(
                  builder: (context) {
                    return AddEdit();
                  },
                ),
              ).then(
                (value) {
                  api.insertData(value);
                  setState(() {});
                },
              );
            },
            icon: Icon(
              Icons.add,
              color: Colors.black,
            ))
      ]),
      body: FutureBuilder(
        builder: (context, snapshot) {
          if (snapshot.hasData) {
            return ListView.builder(
              itemCount: snapshot.data!.length,
              itemBuilder: (context, index) {
                return Card(
                  margin: EdgeInsets.all(10),
                  color: Colors.tealAccent,
                  child: Padding(
                    padding: const EdgeInsets.only(
                        top: 25, bottom: 25, left: 15, right: 15),
                    child: Row(
                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                        children: [
                          Column(
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: [
                              Text(
                                snapshot.data![index]['name'],
                                style: TextStyle(fontSize: 25),
                              ),
                              Text(
                                snapshot.data![index]['city'],
                                style: TextStyle(
                                    fontSize: 15, color: Colors.black54),
                              ),
                            ],
                          ),
                          Row(
                            children: [
                              IconButton(
                                  onPressed: () {
                                    Navigator.of(context)
                                        .push(MaterialPageRoute(
                                      builder: (context) {
                                        return AddEdit(
                                          employee: snapshot.data![index],
                                        );
                                      },
                                    )).then(
                                      (value) {
                                        api.updateData(
                                            value,
                                            int.parse(snapshot.data![index]
                                                    ["id"]
                                                .toString()));
                                        setState(() {});
                                      },
                                    );
                                  },
                                  icon: Icon(
                                    Icons.edit,
                                    color: Colors.blue,
                                  )),
                              IconButton(
                                  onPressed: () {
                                    setState(() {
                                      api.deleteData(int.parse(snapshot
                                          .data![index]['id']
                                          .toString()));
                                    });
                                  },
                                  icon: Icon(
                                    Icons.delete,
                                    color: Colors.red,
                                  ))
                            ],
                          )
                        ]),
                  ),
                );
              },
            );
          } else {
            return const Center(
              child: CircularProgressIndicator(),
            );
          }
        },
        future: api.getData(),
      ),
    );
  }
}
