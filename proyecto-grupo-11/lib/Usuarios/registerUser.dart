import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';

import '../Tiendas/ShopRegister.dart';


class registerUser extends StatefulWidget{

  @override
  registerUserApp createState() => registerUserApp();
}

class registerUserApp extends State<registerUser> {
  @override
  TextEditingController nombreuser =TextEditingController();
  TextEditingController correo= TextEditingController();
  TextEditingController telefono= TextEditingController();
  TextEditingController password = TextEditingController();
  TextEditingController direccion = TextEditingController();
  final firebase=FirebaseFirestore.instance;

  registerUser()async{
    try{
      await firebase
          .collection("Usuarios")
          .doc()
          .set({
        "nombreusuario":nombreuser.text,
        "correo":correo.text,
        "telefono":telefono.text,
        "password":password.text,
        "direccion":direccion.text,
        "Estado":true
      });
    }
    catch(e){
      print(e);
    }
  }
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text("Registro de Usuario"),
      ),
      body: SingleChildScrollView(
        padding: const EdgeInsets.all(20),
        child: Column(
          children: [
            Padding(
              padding: EdgeInsets.only(left: 15, top: 15, right: 15, bottom: 0),
              //nombreusuario
              child: TextField(
                controller: nombreuser,
                decoration: InputDecoration(
                  labelText: "Nombre de usuario",
                  hintText: "Digite nombre de usuario",
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
                controller: correo,
                decoration: InputDecoration(
                  labelText: "Correo",
                  hintText: "Digite correo de la tienda",

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
                    controller: telefono,
                    decoration: InputDecoration(
                        labelText: "Telefono",
                        hintText: "Digite telefono de la tienda",
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
                    controller: password,
                    decoration: InputDecoration(
                        labelText: "Password",
                        hintText: "Digite contraseña",
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
                    registerUser();
                    nombreuser.clear();
                    correo.clear;
                    telefono.clear();
                    password.clear();
                    direccion.clear();
                  },
                  child: Text("Registrar"),
                )
            ),
          ],
        ),
      ),
    );
  }
}