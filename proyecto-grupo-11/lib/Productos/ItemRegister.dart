import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';

import '../Tiendas/ShopRegister.dart';


class ItemRegister extends StatefulWidget{

  final String idTienda;
  ItemRegister(this.idTienda);


  @override
  ItemRegisterApp createState() => ItemRegisterApp();
}

class ItemRegisterApp extends State<ItemRegister> {
  @override
  TextEditingController nombre =TextEditingController();
  TextEditingController precio= TextEditingController();
  TextEditingController descripcion= TextEditingController();
  TextEditingController imagen= TextEditingController();
  final firebase=FirebaseFirestore.instance;

  registerProducto()async{
    try{
      await firebase
          .collection("Productos")
          .doc()
          .set({
        "Nombre":nombre.text,
        "Precio":precio.text,
        "Descripcion":descripcion.text,
      "Imagen":imagen.text,
        "idTienda":widget.idTienda,
        "Estado":true
      });
    }
    catch(e){
      print(e);
      mensaje("Error...",""+e.toString());
    }
  }
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text("Registro de Productos"),
      ),
      body: SingleChildScrollView(
        padding: const EdgeInsets.all(20),
        child: Column(
          children: [
            Padding(
              padding: EdgeInsets.only(left: 15, top: 15, right: 15, bottom: 0),
              //nombreusuario
              child: TextField(
                controller: nombre,
                decoration: InputDecoration(
                  labelText: "Nombre de producto",
                  hintText: "Digite nombre de producto",
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
                obscureText:true,
                controller: precio,
                decoration: InputDecoration(
                  labelText: "Precio final",
                  hintText: "Digite precio del producto",

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
                    controller: descripcion,
                    decoration: InputDecoration(
                        labelText: "Descripcion",
                        hintText: "Digite descripcion del producto",
                        border: OutlineInputBorder(
                            borderRadius: BorderRadius.circular(20)

                        )
                    )
                )
            ),Padding(
                padding: EdgeInsets.only(
                    left: 15, top: 15, right: 15, bottom: 0),
                //descripcion tienda
                child: TextField(
                    controller: imagen,
                    decoration: InputDecoration(
                        labelText: "Nombre de la Imagen",
                        hintText: "Digite ruta de la imagen",
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
                    registerProducto();
                    nombre.clear();
                    descripcion.clear;
                    precio.clear;
                    imagen.clear;
                  },
                  child: Text("Registrar"),
                )
            ),
          ],
        ),
      ),
    );
  }
  void mensaje(String titulo,String mess ){
    showDialog(
        context:context,
        builder: (builcontext){
          return AlertDialog(
            title: Text(titulo),
            content: Text(mess),
            actions: [
              RaisedButton(
                onPressed: (){
                  Navigator.of(context).pop();
                },
                child:Text("Aceptar",
                    style:TextStyle(color:Colors.blueGrey)),
              ),
            ],
          ) ;
        }
    );
  }
}