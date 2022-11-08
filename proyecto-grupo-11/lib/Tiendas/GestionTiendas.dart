import 'package:flutter/material.dart';
import 'package:proyecto_grupo6/Usuarios/registerUser.dart';
import '../busqueda.dart';
import 'Shop.dart';
import 'ShopRegister.dart';

class GestionTiendas extends StatefulWidget{

  @override
  GestionTiendasApp createState() => GestionTiendasApp();
}

class GestionTiendasApp extends State<GestionTiendas>{
  TextEditingController busqueda=TextEditingController();
  @override
  Widget build(BuildContext context){
    return Scaffold(
      appBar: AppBar(
        title: Text ("Gestion de Tiendas"),
      ),
      body: SingleChildScrollView(
        child: Column(
          children: [
            Padding(
              padding: EdgeInsets.all(20),
              child:
                ElevatedButton(
                  style: ElevatedButton.styleFrom(

                      minimumSize: Size(500,50)
                  ),
                  onPressed: (){
                    Navigator.push(context, MaterialPageRoute(builder: (_)=>ShopRegister()));
                  },
                  child:Text("Registrar Tienda"),
                ),
              ),Padding(
      padding: EdgeInsets.only(top:40,right:20,bottom:20,left:20),
      child:
      ElevatedButton(
        style: ElevatedButton.styleFrom(

            minimumSize: Size(500,50)
        ),
        onPressed: (){
          Navigator.push(context, MaterialPageRoute(builder: (_)=>registerUser()));
        },
        child:Text("Modificar Tienda"),
      ),
    ),Padding(
      padding: EdgeInsets.only(right:20,top:40,bottom:0,left:20),
      child:
      ElevatedButton(
        style: ElevatedButton.styleFrom(

            minimumSize: Size(500,50)
        ),
        onPressed: (){
          Navigator.push(context, MaterialPageRoute(builder: (_)=>Shop()));
        },
        child:Text("Listar Tienda"),
      ),
    ),
         Padding(padding: EdgeInsets.only(left:40, top:30,right:40,bottom:5),
              child:TextField(
                controller: busqueda,
                decoration: InputDecoration(
                    border: OutlineInputBorder(
                        borderRadius: BorderRadius.circular(10)
                    ),
                    labelText: 'Buscar Tienda',
                    hintText: 'Digite palabra clave'
                ),
              ),
            ),

            Padding
              (padding: EdgeInsets.only(left:20, top:30,right:20,bottom:5),
              child: ElevatedButton(
                style: ElevatedButton.styleFrom(

                    minimumSize: Size(500,50)
                ),
                onPressed:(){

    Navigator.push(context, MaterialPageRoute(builder: (_)=>Shop()));
    },
                  //validarDatos();
                  //correo.text="Hola mundo";
                  //correo.clear();
                  //pass.clear();


                child: Text('Buscar'),
              ),

            )
          ],
        ),
      ),
    );
  }
}