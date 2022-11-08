import 'package:flutter/material.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import '../busqueda.dart';
import 'Token.dart';
class Login extends StatefulWidget{

  @override
  LoginApp createState() => LoginApp();
}

class LoginApp extends State<Login>{
  TextEditingController correo= TextEditingController();
  TextEditingController pass= TextEditingController();
  //final firebase=FirebaseFirestore.instance;


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
            Token tk=new Token();
            String idToken=await tk.validarToken("Login");
            if(idToken!=""){
              final Firebase=FirebaseFirestore.instance;
              try{
                Firebase.collection("Tokens").doc(idToken).delete();
              }catch(e){
                print(e);
              }
            }
            tk.guardarToken(cursor.id);
            Navigator.of(context).pop();
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
      print(e);
    }
    }
  @override
  Widget build(BuildContext context){
    return Scaffold(
      appBar: AppBar(
        title: Text ("Login de clientes"),
      ),
      body: SingleChildScrollView(
        child: Column(
        children: [
          Padding(padding:
          EdgeInsets.all(20),
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
              border: OutlineInputBorder(
                borderRadius: BorderRadius.circular(10)
              ),
              labelText: 'Correo',
              hintText: 'Digite el correo'
              ),
          ),
          ),
      Padding(padding: EdgeInsets.only(left:40, top:30,right:5,bottom:5),
        child:TextField(
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

              Padding
              (padding: EdgeInsets.only(left:40, top:30,right:5,bottom:5),
    child:ElevatedButton(
    style: ElevatedButton.styleFrom(

    minimumSize: Size(500,50)
    ),
    onPressed:(){
      validarDatos();
      //correo.text="Hola mundo";
      //correo.clear();
      //pass.clear();

    },
    child: Text('Enviar'),
    ),
    
          )

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
            RaisedButton(onPressed:(){
              Navigator.of(context).pop();
        },
            child:Text("Aceptar",
            style:TextStyle(color:Colors.blueGrey),
        ),
            ),
        ],
        );
      }
    );
  }
}