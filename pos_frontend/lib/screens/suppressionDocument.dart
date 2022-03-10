import 'package:flutter/material.dart';
import 'dart:convert';
import 'package:http/http.dart' as http;

class suppressionDocument extends StatefulWidget {
  int documentId;
  suppressionDocument(this.documentId);

  @override
  State<suppressionDocument> createState() => _suppressionDocumentState();
}

class _suppressionDocumentState extends State<suppressionDocument> {
  suppressionDocument(id) async {
    final response = await http.delete(
      Uri.parse('http://127.0.0.1:8000/api/document/$id'),
      headers: <String, String>{
        'Content-Type': 'application/json; charset=UTF-8',
      },
    );
  }

  Future<dynamic> future;

  @override
  Widget build(BuildContext context) {
    return Card(
        elevation: 0,
        child: Column(
          children: [
            Text('Voulez vous vraiment supprimer ce Document ?'),
            SizedBox(
              height: 30,
            ),
            Row(mainAxisAlignment: MainAxisAlignment.spaceAround, children: [
              ElevatedButton(
                onPressed: (() {
                  setState(() {
                    future = suppressionDocument(widget.documentId);
                  });
                  Navigator.of(context).pop();
                }),
                child: Text(
                  "Supprimer",
                  style: TextStyle(
                    fontWeight: FontWeight.w800,
                    fontFamily: 'Montserrat',
                    color: Colors.white,
                  ),
                ),
                style: ElevatedButton.styleFrom(
                    elevation: 0,
                    primary: Colors.red,
                    minimumSize: Size(150, 50),
                    shape: RoundedRectangleBorder(
                        borderRadius: BorderRadius.circular(5))),
              ),
              ElevatedButton(
                onPressed: (() {
                  Navigator.of(context).pop();
                }),
                child: Text(
                  "Annuler",
                  style: TextStyle(
                    fontWeight: FontWeight.w800,
                    fontFamily: 'Montserrat',
                    color: Colors.grey.shade600,
                  ),
                ),
                style: ElevatedButton.styleFrom(
                    elevation: 0,
                    primary: Colors.white,
                    minimumSize: Size(150, 50),
                    shape: RoundedRectangleBorder(
                        borderRadius: BorderRadius.circular(5))),
              ),
            ])
          ],
        ));
  }
}