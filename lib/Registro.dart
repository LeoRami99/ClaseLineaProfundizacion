import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';

class Registro extends StatefulWidget {
  @override
  RegistroApp createState() => RegistroApp();
}

class RegistroApp extends State<Registro> {
  TextEditingController correo = TextEditingController();
  TextEditingController pass = TextEditingController();
  TextEditingController nombre = TextEditingController();
  TextEditingController documento = TextEditingController();
  final firebase = FirebaseFirestore.instance;
  create() async {
    try {
      await firebase.collection("Usuarios").doc().set({
        "nombre": nombre.text,
        "Documento": documento.text,
        "Correo": correo.text,
        "Password": pass.text
      });
    } catch (e) {
      print(e);
    }
  }

  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text("Registro de usuarios"),
      ),
      body: Padding(
        padding: const EdgeInsets.all(20.0),
        child: Column(children: [
          Padding(
            padding: EdgeInsets.only(left: 15.0, top: 0, right: 15, bottom: 10),
            child: TextField(
              controller: nombre,
              decoration: InputDecoration(
                  labelText: "Nombre",
                  border: OutlineInputBorder(
                    borderRadius: BorderRadius.circular(20),
                  )),
            ),
          ),
          Padding(
            padding: EdgeInsets.only(left: 15.0, top: 0, right: 15, bottom: 10),
            child: TextField(
              controller: documento,
              decoration: InputDecoration(
                  labelText: "Documento",
                  border: OutlineInputBorder(
                    borderRadius: BorderRadius.circular(20),
                  )),
            ),
          ),
          Padding(
            padding: EdgeInsets.only(left: 15.0, top: 0, right: 15, bottom: 10),
            child: TextField(
              controller: correo,
              decoration: InputDecoration(
                  labelText: "Correo",
                  border: OutlineInputBorder(
                    borderRadius: BorderRadius.circular(20),
                  )),
            ),
          ),
          Padding(
            padding: EdgeInsets.only(left: 15.0, top: 0, right: 15, bottom: 10),
            child: TextField(
              controller: pass,
              obscureText: true,
              decoration: InputDecoration(
                  labelText: "Password",
                  border: OutlineInputBorder(
                    borderRadius: BorderRadius.circular(20),
                  )),
            ),
          ),
          Row(
            children: [
              ElevatedButton(
                  style: TextButton.styleFrom(backgroundColor: Colors.blueGrey),
                  onPressed: () {
                    create();
                    nombre.clear();
                    documento.clear();
                    correo.clear();
                    pass.clear();
                  },
                  child: Text("Enviar"))
            ],
          )
        ]),
      ),
    );
  }
}
