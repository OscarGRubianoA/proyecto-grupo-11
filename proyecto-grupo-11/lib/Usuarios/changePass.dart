import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';

class changePass extends StatefulWidget{

  @override
  changePassApp createState() => changePassApp();
}

class changePassApp extends State<changePass> {
  TextEditingController correo = TextEditingController();
  TextEditingController passA = TextEditingController();
  TextEditingController passN = TextEditingController();
  final firebase = FirebaseFirestore.instance;

  validarDatos() async {
    try {
      CollectionReference ref = FirebaseFirestore.instance.collection(
          "Usuarios");
      QuerySnapshot usuario = await ref.get();

      if (usuario.docs.length != 0) {
        //print("flag");
        //print(usuario.docs.length);
        int flag = 0;
        for (var cursor in usuario.docs) {
          //print(cursor.get("Correo")+"||"+correo.text);
          if (cursor.get("Correo") == correo.text) {
            //print(cursor.get("Password"));
            //print(cursor.id);
            if (cursor.get("Password" == passA.text)) {
              //mensaje("Correcto","Usuario correcto");
              print("usuario encontrado");
              flag = 1;
              print(cursor.id);
              try {
                await firebase
                    .collection("Usuarios")
                    .doc(cursor.id)
                    .set({
                  "nombreusuario": cursor.get("nombre"),
                  "Direccion": cursor.get("Direccion"),
                  "telefono": cursor.get("telefono"),
                  "Correo": correo.text,
                  "password": passN.text,
                  "Estado": true
                });
                mensaje("Correcto", "Registro correcto");
              }
              catch (e) {
                print(e);
                mensaje("Error...", "" + e.toString());
              }
            }
            //print(cursor.id);

            // Navigator.push(
            //context, MaterialPageRoute(builder: (_) =>busqueda()));
          }
        }
        // print(flag);
        if (flag == 0) {
          mensaje("Login", "No se encontro el usuario");
        }
      } else {
        print("no hay elementos en la coleccion");
      }
    } catch (e) {
      //print(e);
    }
  }

    @override
    Widget build(BuildContext context){

    return Scaffold(
    appBar: AppBar(
    title: Text ("Cambio de contraseña"),
    ),
    body: SingleChildScrollView(
    child: Column(
    children: [
    Padding(padding:
    EdgeInsets.all(10),
    child: Center(
    child: Container(
    width: 100,
    height: 100,
    child: Image.asset('images/128px-Crystal_Clear_app_Login_Manager.svg.png'),

    ),

    ),
    ),
    Padding(padding: EdgeInsets.only(left:40, top:30,right:5,bottom:5),
    child:TextField(
    controller: correo,
    decoration: InputDecoration(
    labelText: 'Correo',
    hintText: 'Digite el correo',
    border: OutlineInputBorder(
    borderRadius: BorderRadius.circular(10))),
    ),
    ),


    Padding(padding: EdgeInsets.only(left:40, top:30,right:5,bottom:5),
    child:TextField(
    controller: passA,
    obscureText: true,
    decoration: InputDecoration(
    labelText: 'Contraseña actual',
    hintText: 'Digite la contraseña actual',
    border: OutlineInputBorder(
    borderRadius: BorderRadius.circular(10),
    ),


    ),
    )
    ), Padding(padding: EdgeInsets.only(left:40, top:30,right:5,bottom:5),
    child:TextField(
    controller: passN,
    obscureText: true,
    decoration: InputDecoration(
    labelText: 'Contraseña nueva',
    hintText: 'Digite la contraseña nueva',
    border: OutlineInputBorder(
    borderRadius: BorderRadius.circular(10)
    ),
    ),
    ),
    ),Padding
    (padding: EdgeInsets.only(left:40, top:30,right:5,bottom:5),
    child:ElevatedButton(
    style: ElevatedButton.styleFrom(

    minimumSize: Size(500,50)
    ),
    onPressed:(){
    validarDatos();
    //correo.clear();
    //pass.clear();

    },
    child: Text('Cambiar'),
    ),

    ),
    ] ,
    ),
    ),
    );
    }
    void mensaje(String titulo,String mensaje){
    showDialog(
    context:context,
    builder:(buildcontext){
    return AlertDialog(
    title: Text(titulo),
    content: Text(mensaje),
    actions:[
    RaisedButton(onPressed:(){
    Navigator.of(context).pop();
    },
    child:Text("Aceptar",
    style:TextStyle(color:Colors.blueGrey),),
    ),
    ],
    );
    });
    }
  }
