import 'package:flutter/material.dart';
import 'dart:convert';
import 'package:http/http.dart' as http;

class suppressionProduit extends StatefulWidget {
  int produitId;
  suppressionProduit(this.produitId);

  @override
  State<suppressionProduit> createState() => _suppressionProduitState();
}

class _suppressionProduitState extends State<suppressionProduit> {
  suppressionProduit(id) async {
    final response = await http.delete(
      Uri.parse('http://127.0.0.1:8000/api/produit/$id'),
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
            Text('Voulez vous vraiment supprimer ce produit ?'),
            SizedBox(
              height: 30,
            ),
            Row(mainAxisAlignment: MainAxisAlignment.spaceAround, children: [
              ElevatedButton(
                onPressed: (() {
                  setState(() {
                    future = suppressionProduit(widget.produitId);
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
