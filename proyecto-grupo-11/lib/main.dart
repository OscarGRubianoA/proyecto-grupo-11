import 'package:flutter/material.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:proyecto_grupo6/Tiendas/GestionTiendas.dart';
import 'package:proyecto_grupo6/Tiendas/Shop.dart';
import 'busqueda.dart';
import 'Tiendas/ShopRegister.dart';
import 'Usuarios/gestionUsuarios.dart';
import 'Tiendas/GestionTiendas.dart';
import 'Tiendas/Shop.dart';

void main() {
  WidgetsFlutterBinding.ensureInitialized();
  Firebase.initializeApp();
  runApp(MyApp());
}

class MyApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(debugShowCheckedModeBanner: false, home: Home());
  }
}

class Home extends StatefulWidget {
  @override
  HomeStart createState() => HomeStart();
}

@override
class HomeStart extends State<Home> {
  TextEditingController buscar = TextEditingController();
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Welcome group 6',
      home: Scaffold(
        appBar: AppBar(title: Text('LO QUE NECESITAS A LA MANO...'), actions: [
          FloatingActionButton(
            onPressed: () {
              //Navigator.push(context,
              //MaterialPageRoute(builder:(_))>=ItemRegister(idTienda)));
            },
            tooltip: 'Agregar producto',
            child: const Icon(Icons.shopping_cart),
            // child: Text("add"),
            backgroundColor: Colors.purpleAccent,
          )
        ]),

        body: SingleChildScrollView(
          child: Column(
            children: <Widget>[
              Padding(
                padding:
                    EdgeInsets.only(left: 20, top: 40, right: 20, bottom: 0),
                child: Center(
                  child: Container(
                    width: 150,
                    height: 150,
                    child: Image.asset("images/night-4694750__340.png"),
                  ),
                ),
              ),
              Padding(
                padding:
                    EdgeInsets.only(left: 20, top: 40, right: 20, bottom: 0),
                child: TextField(
                  controller: buscar,
                  decoration: InputDecoration(
                      border: OutlineInputBorder(),
                      labelText: 'busqueda',
                      hintText: 'Palabra clave de la busqueda'),
                ),
              ),
              Padding(
                padding:
                    EdgeInsets.only(left: 20, top: 20, right: 20, bottom: 0),
                child: ElevatedButton(
                  style: ElevatedButton.styleFrom(minimumSize: Size(500, 50)),
                  onPressed: () {
                    print("Presiono el boton");
                    Navigator.push(
                        context,
                        MaterialPageRoute(
                            builder: (_) => busqueda(buscar.text)));
                  },
                  child: Text('Buscar'),
                ),
              ),
              Padding(
                padding:
                    EdgeInsets.only(left: 20, top: 20, right: 20, bottom: 0),
                child: ElevatedButton(
                  style: ElevatedButton.styleFrom(minimumSize: Size(500, 50)),
                  onPressed: () {
                    print("Presiono el boton");
                    Navigator.push(context,
                        MaterialPageRoute(builder: (_) => GestionTiendas()));
                  },
                  child: Text('Gestion de Tiendas'),
                ),
              ),
              Padding(
                padding:
                    EdgeInsets.only(left: 20, top: 20, right: 20, bottom: 0),
                child: ElevatedButton(
                  style: ElevatedButton.styleFrom(minimumSize: Size(500, 50)),
                  onPressed: () {
                    print("Presiono el boton");
                    Navigator.push(context,
                        MaterialPageRoute(builder: (_) => gestionUsuarios()));
                  },
                  child: Text('Gestion usuario'),
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
