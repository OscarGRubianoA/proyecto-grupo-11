import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:proyecto_grupo6/Usuarios/modificarUsuario.dart';
import 'registerUser.dart';
import 'Login.dart';
import 'changePass.dart';
class gestionUsuarios extends StatefulWidget{

  @override
  gestionUsuariosApp createState() => gestionUsuariosApp();
}

class gestionUsuariosApp extends State<gestionUsuarios>{
  TextEditingController correo= TextEditingController();
  TextEditingController pass= TextEditingController();

  final firebase=FirebaseFirestore.instance;
  validarDatos() async {
    try{
      CollectionReference ref=FirebaseFirestore.instance.collection("Usuarios");
      QuerySnapshot usuario= await ref.get();

      if (usuario.docs.length !=0) {
        //print("flag");
        print(usuario.docs.length);
        int flag=0;
        for (var cursor in usuario.docs) {
          print(cursor.get("Correo")+"||"+correo.text);
          if (cursor.get("Correo") == correo.text) {
            print(cursor.get("Password"));
            if (cursor.get("Password" == pass.text)) {
              mensaje("Correcto","Usuario correcto");
              print(cursor.get("nombre usuario"));
              flag=1;
              print(cursor.id);
              try{
                await firebase
                    .collection("Usuarios")
                    .doc()
                    .set({
                  "nombreusuario":cursor.get("nombre"),
                  "Direccion":cursor.get("Direccion"),
                  "telefono":cursor.get("telefono"),
                  "Correo":cursor.get("correo"),
                  "password":cursor.get("contraseña"),
                  "Estado":false
                });
              }catch(e){}
              //Navigator.push(
                 // context, MaterialPageRoute(builder: (_) =>busqueda()));

            }
          }

        }
        print(flag);
        if (flag==0){
          mensaje("Login","No se encontro el usuario");
        }

      }else{
        print("no hay elementos en la coleccion");
      }

    }catch(e){
      mensaje("Error...",e.toString());
      print(e);
    }
  }
  @override
  Widget build(BuildContext context){
    return Scaffold(
      appBar: AppBar(
        title: Text ("Gestion de usuarios"),
      ),
      body: SingleChildScrollView(
        padding: EdgeInsets.all(20),
        child: Column(
          children: [
            Padding(
              padding:
                EdgeInsets.only(top:20),
              child: ElevatedButton(
                style: ElevatedButton.styleFrom(

                    minimumSize: Size(500,50)
                ),
                onPressed: (){
                  Navigator.push(context, MaterialPageRoute(builder: (_)=>registerUser()));
                },
                child:Text("Registrar Usuario"),
              ),
      ),

            Padding(
            padding:
            EdgeInsets.only(top:20),
            child: ElevatedButton(
              style: ElevatedButton.styleFrom(

                  minimumSize: Size(500,50)
              ),
              onPressed: (){
                Navigator.push(
                    context, MaterialPageRoute(builder: (_) => changePass()));
              },
              child:Text("Cambio de password"),
            )

        ),

            Padding(
            padding:
            EdgeInsets.only(top:20),
            child: ElevatedButton(
              style: ElevatedButton.styleFrom(

                  minimumSize: Size(500,50)
              ),
            onPressed: (){

                mensaje("Inactivar usuario","Desea inactivar el usuario?");
            },
            child:Text("Dar de baja"),
            )

            ),
            Padding(
            padding:
            EdgeInsets.only(top: 20),
    child: Center(
   child:ElevatedButton(
    onPressed: (){
      Navigator.push(
    context, MaterialPageRoute(builder: (_) => modificarUsuario()));
    },
    style: ElevatedButton.styleFrom(

    minimumSize: Size(500,50)),

    child:Text("Modificar usuario"),
    ),
            ),
  ),

    Padding(
    padding:
    EdgeInsets.only(top:20),
    child: Center(
        child:ElevatedButton(
          onPressed: (){
      Navigator.push(context, MaterialPageRoute(builder: (_)=>Login()));
    },style: ElevatedButton.styleFrom(

            minimumSize: Size(500,50)
        ),
    child:Text("Login"),
    ),
    ),
    ),
    ],
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
            actions:<Widget>[
              Padding(
                  padding:
                  EdgeInsets.only(top:20),
                  child: ElevatedButton(
                    style: ElevatedButton.styleFrom(

                        minimumSize: Size(500,50)
                    ),
                    onPressed: (){},
                    child:Text("Modificar usuario"),
                  )
              ),
              RaisedButton(onPressed:(){
                validarDatos();
                Navigator.of(context).pop();
              },
                child:Text("cancelar",
                  style:TextStyle(color:Colors.blueGrey),
                ),
              ), RaisedButton(onPressed:(){
                Navigator.of(context).pop();
              },
                child:Text("Aceptar",
                  style:TextStyle(color:Colors.blueGrey),
                ),
              ),Padding(
                  padding:
                  EdgeInsets.only(top:20),
                  child: ElevatedButton(
                    style: ElevatedButton.styleFrom(

                        minimumSize: Size(500,50)
                    ),
                    onPressed: (){},
                    child:Text("Modificar usuario"),
                  )
              ),
            ],
          );
        }
    );

}void inactivar(String titulo,String mensaje) {
  showDialog(
      context: context,
      builder: (buildcontext) {
        return AlertDialog(
          title: Text(titulo),
          content: Text(mensaje),
          actions: <Widget>[
            Padding(
              padding: EdgeInsets.only(left: 40, top: 30, right: 5, bottom: 5),
              child: TextField(
                controller: pass,
                decoration: InputDecoration(
                    border: OutlineInputBorder(
                        borderRadius: BorderRadius.circular(10)
                    ),
                    labelText: 'Contraseña',
                    hintText: 'Digite la contraseña'
                ),
              ),
            ),
            RaisedButton(onPressed: () {
              Navigator.of(context).pop();
            },
              child: Text("Aceptar",
                style: TextStyle(color: Colors.blueGrey),
              ),
            ),
            RaisedButton(onPressed: () {
              Navigator.of(context).pop();
            },
              child: Text("Cancelar",
                style: TextStyle(color: Colors.blueGrey),
              ),
            ),

          ],
        );
      }
  );
}
}