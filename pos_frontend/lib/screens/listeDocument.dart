// ignore_for_file: prefer_const_constructors, sized_box_for_whitespace, dead_code, avoid_unnecessary_containers, unnecessary_new

import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;
import 'package:pos_frontend/screens/suppressionProduit.dart';
import 'dart:convert';
import '../screens/modificationDocument.dart';
import '../screens/suppressionDocument.dart';
import 'package:flutter_animated_dialog/flutter_animated_dialog.dart';
import 'package:pos_frontend/HomeScreen.dart';

class listeDocument extends StatefulWidget {
  @override
  _listeDocumentState createState() => _listeDocumentState();
}

class _listeDocumentState extends State<listeDocument> {
  int documentId;

  List documents = [];
  @override
  void initState() {
    super.initState();
    this.fetchDocuments();
  }

  fetchDocuments() async {
    final response =
        await http.get(Uri.parse('http://127.0.0.1:8000/api/document'));
    if (response.statusCode == 200) {
      var items = jsonDecode(response.body);
      setState(() {
        documents = items;
        print(documents);
      });
    } else {
      throw Exception('Error!');
    }
  }

  @override
  Widget build(BuildContext context) {
    return Card(
      shape: RoundedRectangleBorder(
        borderRadius: BorderRadius.circular(15),
      ),
      clipBehavior: Clip.antiAliasWithSaveLayer,
      color: Colors.white,
      elevation: 10,
      child: SingleChildScrollView(
        child: Column(children: <Widget>[
          Padding(
            padding: const EdgeInsets.all(15),
            child: Center(
                child: Container(
                  height: 20,
                  child: Center(
                    child: Text(
                      'La Liste Des Documents :',
                      style: TextStyle(
                          fontFamily: 'Montserrat',
                          color: Colors.black,
                          fontSize: 20,
                          fontWeight: FontWeight.bold),
                    ),
                  ),
                )),
          ),
          Divider(
            thickness: 3,
          ),
          SizedBox(
            height: 30,
          ),
          for (var i = 0; i < documents.length; i++)
            Card(
              child: Column(mainAxisSize: MainAxisSize.min, children: <Widget>[
                ListTile(
                  title: Text(documents[i]['raisonSociale']),
                  trailing: Row(
                    mainAxisSize: MainAxisSize.min,
                    children: <Widget>[
                      Container(
                        child: IconButton(
                            icon: Icon(Icons.edit),
                            onPressed: () {
                              documentId = documents[i]['id'];
                              print(documentId);
                              showAnimatedDialog(
                                context: context,
                                barrierDismissible: true,
                                builder: (BuildContext context) {
                                  return AlertDialog(
                                    insetPadding:
                                    EdgeInsets.symmetric(vertical: 10),
                                    backgroundColor: Colors.white,
                                    shape: RoundedRectangleBorder(
                                      borderRadius: BorderRadius.circular(10),
                                    ),
                                    content: Container(
                                        width: 800,
                                        child: modificationDocument(
                                            documentId)),
                                  );
                                },
                                animationType: DialogTransitionType.fadeScale,
                                curve: Curves.fastOutSlowIn,
                                duration: Duration(seconds: 1),
                              );
                            }),
                      ),
                      Container(
                        child: IconButton(
                          icon: Icon(Icons.delete),
                          onPressed: () {
                            documentId = documents[i]['id'];
                            showAnimatedDialog(
                              context: context,
                              barrierDismissible: true,
                              builder: (BuildContext context) {
                                return AlertDialog(
                                  insetPadding:
                                  EdgeInsets.symmetric(vertical: 10),
                                  backgroundColor: Colors.white,
                                  shape: RoundedRectangleBorder(
                                    borderRadius: BorderRadius.circular(10),
                                  ),
                                  content: Container(
                                      width: 400,
                                      height: 100,
                                      child: suppressionProduit(
                                          documentId)),
                                );
                              },
                              animationType: DialogTransitionType.fadeScale,
                              curve: Curves.fastOutSlowIn,
                              duration: Duration(seconds: 1),
                            );
                          },
                        ),
                      ),
                    ],
                  ),
                ),
              ]),
            ),
          Column(children: [
            SizedBox(
              height: 40,
            ),
            Container(
              height: 50,
              width: 250,
              decoration: BoxDecoration(
                  color: Color.fromARGB(255, 216, 216, 216),
                  borderRadius: BorderRadius.circular(10)),
              child: MaterialButton(
                onPressed: () {
                  Navigator.push(
                      context,
                      MaterialPageRoute(
                          builder: (context) => HomeScreen(Text("HOME"))));
                },
                child: Text(
                  'Retour au Menu',
                  style: TextStyle(
                      color: Color.fromARGB(255, 0, 0, 0),
                      fontSize: 18,
                      fontWeight: FontWeight.bold),
                ),
              ),
            ),
            SizedBox(
              height: 50,
            )
          ]),
        ]),
      ),
    );
  }
}
