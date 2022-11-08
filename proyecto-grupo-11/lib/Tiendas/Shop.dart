import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:proyecto_grupo6/Tiendas/ShopOne.dart';

import 'ObjetoTienda.dart';

class Shop extends StatefulWidget {
  @override
  ShopApp createState() => ShopApp();
}

class ShopApp extends State<Shop> {
  Widget build(BuildContext context) {
    String texto1 = "Comidas rapidas el gordo";
    ObjetoTienda objTienda = new ObjetoTienda();

    buscarDoc(String idDoc) async {
      try {
        CollectionReference ref =
            FirebaseFirestore.instance.collection("Tiendas");
        QuerySnapshot tienda = await ref.get();
        if (tienda.docs.length != 0) {
          for (var cursor in tienda.docs) {
            if (cursor.id == idDoc) {
              objTienda.nombre = cursor.get("nombreTienda");
              objTienda.descripcionCorta = cursor.get("descripcion");
              objTienda.website = cursor.get("website");
              objTienda.imagen = cursor.get("ruta");
              objTienda.idTienda = cursor.id;

              //this.logo=cursor.get("ruta");
              //this.titulo=cursor.get("nombreTienda");
              //this.descripcionCorta=cursor.get("descripcionCorta");
              //this.descripcionLarga=cursor.get("descripcionLarga");
              //this.cont=cursor.get("conteo");
              //print(widget.docId +"id importado");
            }
          }
        }
      } catch (e) {
        print(e);
      }
    }

    Widget titleSection = Container(
        padding: const EdgeInsets.all(32),
        child: Row(children: [
          Expanded(
            child:
                Column(crossAxisAlignment: CrossAxisAlignment.start, children: [
              Container(
                  padding: const EdgeInsets.only(bottom: 8),
                  child: Text(
                    "Comidas Rapidas el gordo",
                    style: TextStyle(fontWeight: FontWeight.bold),
                  )),
              Text("Perros Calientes,Hamburguersas y mas",
                  style: TextStyle(
                    color: Colors.green[500],
                  )),
            ]),
          ),
          Container(
              width: 80,
              height: 80,
              child: Image.asset(
                  'images/composición-de-comida-rápida-vectores-la-del-vector-sobre-fondo-blanco-197380349.jpg')),
          ElevatedButton(onPressed: () {}, child: Text('Entrar'))
        ]));
    return Scaffold(
      appBar: AppBar(title: Text('Lista de Tiendas')),
      body: Container(
        child: Center(
          child: StreamBuilder(
            stream:
                FirebaseFirestore.instance.collection("Tiendas").snapshots(),
            builder:
                (BuildContext context, AsyncSnapshot<QuerySnapshot> snapshot) {
              if (!snapshot.hasData) return CircularProgressIndicator();
              return ListView.builder(
                  itemCount: snapshot.data!.docs.length,
                  itemBuilder: (BuildContext context, int index) {
                    return new Card(
                      child: new Column(
                        children: <Widget>[
                          Container(
                              padding: const EdgeInsets.all(15),
                              child: Row(
                                children: [
                                  Expanded(
                                    child: Column(
                                      crossAxisAlignment:
                                          CrossAxisAlignment.start,
                                      children: [
                                        Container(
                                          padding:
                                              const EdgeInsets.only(bottom: 10),
                                          child: Text(
                                            snapshot.data!.docs[index]
                                                .get("nombreTienda"),
                                          ),
                                        ),
                                        Text(
                                          "Perros Calientes,Hamburguersas y mas",
                                          style: TextStyle(
                                            color: Colors.green[500],
                                          ),
                                        ),
                                        Text(
                                          snapshot.data!.docs[index]
                                              .get("descripcionTienda"),
                                          style: TextStyle(
                                            color: Colors.green[500],
                                          ),
                                        ),
                                      ],
                                    ),
                                  ),
                                  Container(
                                      width: 80,
                                      height: 80,
                                      child: Image.asset("images/" +
                                          snapshot.data!.docs[index]
                                              .get("ruta"))),
                                  ElevatedButton(
                                      onPressed: () {
                                        String idDoc =
                                            snapshot.data!.docs[index].id;
                                        buscarDoc(idDoc);
                                        Navigator.push(
                                            context,
                                            MaterialPageRoute(
                                                builder: (_) =>
                                                    ShopOne(objTienda)));
                                      },
                                      child: Text('Entrar'))
                                ],
                              )),
                        ],
                      ),
                    );
                    //  new Text(snapshot.data!.docs[index].content)
                  });
            },
          ),
        ),
      ),
    );
  }
}
