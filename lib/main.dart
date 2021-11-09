import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/material.dart';

// import 'Inicio.dart';
// import 'General.dart';
//Prueba de github
//rama app2
void main() {
  WidgetsFlutterBinding.ensureInitialized();
  Firebase.initializeApp();
  runApp(MyApp());
}

class MyApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      home: Login(),
    );
  }
}

class Login extends StatefulWidget {
  @override
  LoginStart createState() => LoginStart();
}

class LoginStart extends State<Login> {
  TextEditingController correo = TextEditingController();
  TextEditingController pass = TextEditingController();
  verificarPass() async {
    try {
      CollectionReference cllreference =
          FirebaseFirestore.instance.collection("Users");
      QuerySnapshot user = await cllreference.get();
      if (user.docs.length != 0) {
        for (var doc in user.docs) {
          print(doc.get("Pass"));

          print(doc.get("Correo"));
          print(correo.text + "  prueba correo");
          if (doc.get("Correo") == correo.text) {
            print("correo correcto");
            if (doc.get("Pass") == pass.text) {
              Navigator.push(
                  context, MaterialPageRoute(builder: (_) => General()));
            }
          }
        }
      }
    } catch (e) {
      print(e);
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white,
      appBar: AppBar(
        title: Text("Formulario Login"),
      ),
      body: SingleChildScrollView(
        child: Column(
          children: <Widget>[
            Padding(
              padding: const EdgeInsets.only(top: 60.0),
              child: Center(
                child: Container(
                  width: 200,
                  height: 200,
                  child: Image.asset('assets/login_1.png'),
                ),
              ),
            ),
            Padding(
              padding:
                  EdgeInsets.only(left: 15.0, top: 0, right: 15, bottom: 10),
              child: TextField(
                controller: correo,
                decoration: InputDecoration(
                  border: OutlineInputBorder(),
                  labelText: 'User',
                  hintText: 'Digite Usuario',
                ),
              ),
            ),
            Padding(
              padding:
                  EdgeInsets.only(left: 15, top: 15, right: 15, bottom: 10),
              child: TextField(
                controller: pass,
                obscureText: true,
                decoration: InputDecoration(
                  border: OutlineInputBorder(),
                  labelText: 'Password',
                  hintText: 'Digite su contraseña',
                ),
              ),
            ),
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceEvenly,
              children: [
                Container(
                  height: 50,
                  width: 120,
                  decoration: BoxDecoration(
                      color: Colors.blue,
                      borderRadius: BorderRadius.circular(20)),
                  child: FlatButton(
                      onPressed: () {
                        verificarPass();
                      },
                      child: Text(
                        'Enviar',
                        style: TextStyle(color: Colors.white, fontSize: 20),
                      )),
                ),
                Container(
                  height: 50,
                  width: 120,
                  decoration: BoxDecoration(
                      color: Colors.blueGrey,
                      borderRadius: BorderRadius.circular(20)),
                  child: FlatButton(
                      onPressed: () {
                        Navigator.push(context,
                            MaterialPageRoute(builder: (_) => Inicio()));
                      },
                      child: Text(
                        'Registro',
                        style: TextStyle(color: Colors.white, fontSize: 20),
                      )),
                ),
              ],
            )
          ],
        ),
      ),
    );
  }
}
