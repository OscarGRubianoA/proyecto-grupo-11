import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';


class ShopRegister extends StatefulWidget{

  @override
  ShopRegisterApp createState() => ShopRegisterApp();
}

class ShopRegisterApp extends State<ShopRegister> {
  @override
  TextEditingController nombreTienda =TextEditingController();
  TextEditingController rutaImagen= TextEditingController();
  TextEditingController descripcionTienda= TextEditingController();
  TextEditingController website = TextEditingController();
  final firebase=FirebaseFirestore.instance;

  registrar()async{
    try{
      await firebase
          .collection("Tiendas")
          .doc()
          .set({
        "nombreTienda":nombreTienda.text,
        "ruta":rutaImagen.text,
        "descripcion":descripcionTienda.text,
        "website":website.text
      });
    }
    catch(e){
      print(e);
    }
  }
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text("Registro de tiendas"),
      ),
      body: SingleChildScrollView(
        padding: const EdgeInsets.all(20),
        child: Column(
          children: [
            Padding(
              padding: EdgeInsets.only(left: 15, top: 15, right: 15, bottom: 0),
              //nombretienda
              child: TextField(
                controller: nombreTienda,
                decoration: InputDecoration(
                  labelText: "Nombre de la tienda",
                  hintText: "Digite nombre de la tienda",
                  border: OutlineInputBorder(
                      borderRadius: BorderRadius.circular(20)
                  ),
                ),
              ),
            ),


            Padding(
              padding: EdgeInsets.only(left: 15, top: 15, right: 15, bottom: 0),
              //rutaimagen
              child: TextField(
                controller: rutaImagen,
                decoration: InputDecoration(
                  labelText: "Ruta de la imagen",
                  hintText: "Digite descripcion de la tienda",
                  border: OutlineInputBorder(
                      borderRadius: BorderRadius.circular(20)
                  ),
                ),
              ),
            ),
            Padding(
                padding: EdgeInsets.only(
                    left: 15, top: 15, right: 15, bottom: 0),
                //descripcion tienda
                child: TextField(
                  controller: descripcionTienda,
                    decoration: InputDecoration(
                        labelText: "Descripcion de la tienda",
                        hintText: "Digite nombre de la tienda",
                        border: OutlineInputBorder(
                            borderRadius: BorderRadius.circular(20)

                        )
                    )
                )
            ),
            Padding(
                padding: EdgeInsets.only(
                    left: 15, top: 15, right: 15, bottom: 0),
                //Pgina web
                child: TextField(
                  controller: website,
                    decoration: InputDecoration(
                        labelText: "Pagina Web",
                        hintText: "Digite pagina web de la tienda",
                        border: OutlineInputBorder(
                            borderRadius: BorderRadius.circular(20)

                        )
                    )
                )
            ),
            Padding(
                padding: EdgeInsets.only(
                    left: 15, top: 15, right: 15, bottom: 0),
                child: ElevatedButton(
                  onPressed: (){
                    registrar();
                    nombreTienda.clear();
                    rutaImagen.clear;
                    descripcionTienda.clear();
                    website.clear();
                    },
                  child: Text("Registrar"),
                )
            )
          ],
        ),
      ),
    );
  }
}