import 'package:flutter/material.dart';

class downUser extends StatefulWidget{

  @override
 downUserApp createState() => downUserApp();
}

class downUserApp extends State<downUser>{
  @override
  Widget build(BuildContext context){
    return Scaffold(
      appBar: AppBar(
        title: Text ("Usuario dado de Baja"),
      ),
    );
  }
}