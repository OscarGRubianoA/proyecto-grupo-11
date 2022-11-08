import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';

class modificarUsuario extends StatefulWidget{
  @override
  modificarUsuarioApp createState() => modificarUsuarioApp();
}

class modificarUsuarioApp extends State<modificarUsuario>{
  TextEditingController correo=TextEditingController();
  TextEditingController nombre=TextEditingController();
  TextEditingController telefono=TextEditingController();
  TextEditingController direccion=TextEditingController();
  TextEditingController pass = TextEditingController();
  final firebase=FirebaseFirestore.instance;
  String correo1="";
  String idDoc="";
  String password="";
  bool estado=false;

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
            if (cursor.get("Password" == pass.text)) {
              flag=1;
              nombre.text = cursor.get("nombreusuario");
              telefono.text = cursor.get("telefono");
              direccion.text = cursor.get("direccion");
              this.idDoc = cursor.id;
              this.correo1 = cursor.get("correo");
              this.password = cursor.get("password");
              this.estado = cursor.get("Estado");
            }
          }
        }
        if (flag == 0) {
          mensaje("Login", "Usuario NO encontrado");
          //mensaje("Correcto","Usuario correcto");

        } else {
          print("no hay elementos en la coleccion");
        }
      }
    } catch (e) {
      print(e);
    }
  }

    modificarDatos()async{
      try{
    await firebase
        .collection("Usuarios")
        .doc(idDoc)
        .set({
    "nombreusuario":nombre.text,
    "correo":this.correo1,
    "telefono":telefono.text,
    "password":this.pass,
    "Direccion":direccion.text,
    "Estado":this.estado
    });
    mensaje("Correcto","Registro correto");
    }
    catch(e){
    print(e);
    mensaje("Error...",""+e.toString());
    }
    }

  @override
  Widget build(BuildContext context){
    return Scaffold(
        appBar: AppBar(
        title: Text ("Modificar usuario"),
        ),body: SingleChildScrollView(
  padding: const EdgeInsets.all(20),
  child: Column(
  children: [
  Padding(
  padding: EdgeInsets.only(left: 15, top: 15, right: 15, bottom: 0),
  //nombreusuario
  child: TextField(
  controller: correo,
  decoration: InputDecoration(
  labelText: "correo",
  hintText: "Digite correo",
  border: OutlineInputBorder(
  borderRadius: BorderRadius.circular(20))),
  ),
  ),
    Padding(
    padding: EdgeInsets.only(left: 15, top: 15, right: 15, bottom: 0),
    //nombreusuario
    child: TextField(
    controller: pass,
    obscureText: true,
    decoration: InputDecoration(
    labelText: "Contraseña",
    hintText: "Digite contraseña",
    border: OutlineInputBorder(
    borderRadius: BorderRadius.circular(20))),
    ),
    ),
    Padding(
    padding:
    EdgeInsets.only(left: 15, top: 15, right: 15, bottom: 0),
    child: ElevatedButton(
    style: ElevatedButton.styleFrom(minimumSize: Size(500, 45)),
    onPressed: () {
    validarDatos();
    },
    child: Text("Buscar"),
    ),
    ),
    Padding(
  padding: EdgeInsets.only(left: 15, top: 15, right: 15, bottom: 0),
  //rutaimagen
  child: TextField(
    controller: nombre,
  decoration: InputDecoration(
  labelText: "Nombre",
  hintText: "Digite el nombre del usuario",
    border: OutlineInputBorder(
  borderRadius: BorderRadius.circular(20))),
  ),
  ),
    Padding(
    padding: EdgeInsets.only(left: 15, top: 15, right: 15, bottom: 0),
    child: TextField(
    controller: direccion,
    decoration: InputDecoration(
    labelText: "Direccion",
    hintText: "Digite la direccion del usuario",
    border: OutlineInputBorder(
    borderRadius: BorderRadius.circular(15))),
    ),
    ),
  Padding(
  padding: EdgeInsets.only(left: 15, top: 15, right: 15, bottom: 0),
  child: TextField(
  controller: telefono,
  decoration: InputDecoration(
  labelText: "Teléfono",
  hintText: "Digite teléfono",
  border: OutlineInputBorder(
  borderRadius: BorderRadius.circular(15))),
  ),
  ),
  Padding(
  padding: EdgeInsets.only(
  left: 15, top: 15, right: 15, bottom: 0),
  child: ElevatedButton(
    style: ElevatedButton.styleFrom(minimumSize: Size(200, 45)),
  onPressed: (){
  modificarDatos();
  nombre.clear();
  direccion.clear();
  correo.clear;
  telefono.clear();
  pass.clear();
  },
  child: Text("Modificar"),
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
