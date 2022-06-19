// ignore_for_file: unused_field

import 'package:projetpfe/constants.dart';
import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;
import 'dart:convert';

class listeUtlisateurs extends StatefulWidget {
  @override
  State<listeUtlisateurs> createState() => _listeUtlisateursState();
}

class _listeUtlisateursState extends State<listeUtlisateurs> {
  String? _chosenValue;
  static const snackBar = SnackBar(
    content: Text('Tâche effectuée avec succès'),
  );
  List? users = [];
  @override
  void initState() {
    super.initState();
    fetchUsers();
  }

  fetchUsers() async {
    final response = await http.get(
      Uri.parse('http://127.0.0.1:8000/api/users'),
      headers: <String, String>{
        'Cache-Control': 'no-cache',
      },
    );

    if (response.statusCode == 200) {
      var items = jsonDecode(response.body);
      setState(() {
        users = items;
        print(users);
      });
    } else {
      throw Exception('Error!');
    }
  }

  attribuerRole(int id, int role) async {
    final reponse = await http.post(
      Uri.parse('http://127.0.0.1:8000/api/role/$id'),
      headers: <String, String>{'Content-Type': 'application/json'},
      body: jsonEncode(<String, dynamic>{
        'role': role,
      }),
    );
    if (reponse.statusCode == 200) {
      print('success');
    } else {
      print('error');
    }
  }

  Text typeAcc(int y) {
    if (users![y]['role'] == 1) {
      return const Text('Administrateur');
    } else if (users![y]['role'] == 2) {
      return const Text("Agent de Bureau");
    } else if (users![y]['role'] == 3) {
      return const Text("Caissier");
    } else {
      return const Text("");
    }
  }

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.all(10.0),
      child: SizedBox(
        width: double.infinity,
        child: Material(
          shape: RoundedRectangleBorder(
            borderRadius: BorderRadius.circular(25),
          ),
          clipBehavior: Clip.antiAliasWithSaveLayer,
          color: const Color(0xFF2A2D3E),
          elevation: 10,
          child: SizedBox(
            width: double.infinity,
            child: Column(children: <Widget>[
              const Padding(
                padding: EdgeInsets.all(20),
                child: Center(
                    child: SizedBox(
                  height: 25,
                  child: Center(
                    child: Text(
                      'La Liste Des Utlisateurs :',
                      style: TextStyle(
                          //
                          color: Colors.white,
                          fontSize: 20,
                          fontWeight: FontWeight.bold),
                    ),
                  ),
                )),
              ),
              const Divider(
                thickness: 3,
              ),
              const SizedBox(
                height: 30,
              ),
              SizedBox(
                height: 600,
                child: SingleChildScrollView(
                    child: DataTable(
                  columns: const <DataColumn>[
                    DataColumn(
                        label: Flexible(
                      child: Text("Identifiant",
                          maxLines: 5,
                          overflow: TextOverflow.ellipsis,
                          style: TextStyle(fontWeight: FontWeight.bold)),
                    )),
                    DataColumn(
                        label: Flexible(
                      child: Text("Nom et prénom",
                          maxLines: 5,
                          overflow: TextOverflow.ellipsis,
                          style: TextStyle(fontWeight: FontWeight.bold)),
                    )),
                    DataColumn(
                        label: Flexible(
                      child: Text("E-mail",
                          maxLines: 5,
                          overflow: TextOverflow.ellipsis,
                          style: TextStyle(fontWeight: FontWeight.bold)),
                    )),
                    DataColumn(
                        label: Flexible(
                            child: Text("Droit d'accès",
                                style:
                                    TextStyle(fontWeight: FontWeight.bold)))),
                  ],
                  rows: <DataRow>[
                    for (var i = 0; i < users!.length; i++)
                      DataRow(
                        cells: <DataCell>[
                          DataCell(Text(users![i]['id'].toString())),
                          DataCell(Text(users![i]['name'])),
                          DataCell(Text(users![i]['email'])),
                          DataCell(
                            PopupMenuButton<int>(
                              onSelected: (dynamic value) {
                                if (value == 1) {
                                  attribuerRole(users![i]['id'], 1);
                                  setState(() {
                                    fetchUsers();
                                  });
                                  ScaffoldMessenger.of(context)
                                      .showSnackBar(snackBar);
                                }
                                if (value == 2) {
                                  attribuerRole(users![i]['id'], 2);
                                  setState(() {
                                    fetchUsers();
                                  });
                                  ScaffoldMessenger.of(context)
                                      .showSnackBar(snackBar);
                                }
                                if (value == 3) {
                                  attribuerRole(users![i]['id'], 3);
                                  setState(() {
                                    fetchUsers();
                                  });
                                  ScaffoldMessenger.of(context)
                                      .showSnackBar(snackBar);
                                }
                              },
                              color: const Color(0xFF247b9c),
                              offset: const Offset(0, 30),
                              elevation: 0,
                              shape: RoundedRectangleBorder(
                                borderRadius: BorderRadius.circular(10.0),
                              ),
                              child: Container(
                                decoration: BoxDecoration(
                                    color: secondaryColor,
                                    borderRadius: BorderRadius.circular(10.0)),
                                width: 150,
                                child: Row(
                                  children: [
                                    typeAcc(i),
                                    const SizedBox(
                                      width: 20,
                                    ),
                                    const Icon(Icons.arrow_drop_down,
                                        color: Colors.white),
                                  ],
                                ),
                              ),
                              itemBuilder: (context) => [
                                const PopupMenuItem(
                                  value: 1,
                                  child: Text('Administrateur'),
                                ),
                                const PopupMenuDivider(
                                  height: 5,
                                ),
                                const PopupMenuItem(
                                  value: 2,
                                  child: Text('Agent de Bureau'),
                                ),
                                const PopupMenuDivider(
                                  height: 5,
                                ),
                                const PopupMenuItem(
                                  value: 3,
                                  child: Text('Caissier'),
                                ),
                              ],
                            ),
                          ),
                        ],
                      ),
                  ],
                )),
              ),
            ]),
          ),
        ),
      ),
    );
  }
}
