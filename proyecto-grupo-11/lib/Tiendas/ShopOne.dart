import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:proyecto_grupo6/Carrito/Carrito.dart';
import 'package:proyecto_grupo6/Carrito/ShoppingCart.dart';
import 'package:proyecto_grupo6/Productos/ItemRegister.dart';
import 'package:proyecto_grupo6/Usuarios/Login.dart';
import 'package:proyecto_grupo6/Usuarios/Token.dart';

import 'ObjetoTienda.dart';

class ShopOne extends StatefulWidget {
  final ObjetoTienda tiendaObj;
  ShopOne(this.tiendaObj);
  @override
  ShopOneApp createState() => ShopOneApp();
}

class ShopOneApp extends State<ShopOne> {
  final firebase = FirebaseFirestore.instance;
  String nombre = "";
  //String logo="";
  //String titulo="";
  //String descripcionCorta="";
  String descripcionLarga = "";
  int cont = 0;
  String idUser = "";

  //ShoponeApp(){//buscarDoc();
  //}
  /*buscarDoc()async{
    try{
      CollectionReference ref =FirebaseFirestore.instance.collection("Tiendas");
      QuerySnapshot tienda= await ref.get();
      if(tienda.docs.length!=0){
        for(var cursor in tienda.docs){
          if (cursor.id==widget.tiendaObj.idTienda){
            this.logo=cursor.get("ruta");
            this.titulo=cursor.get("nombreTienda");
            this.descripcionCorta=cursor.get("descripcionCorta");
            this.descripcionLarga=cursor.get("descripcionLarga");
            this.cont=cursor.get("conteo");
            //print(widget.docId +"id importado");
          }
        }
      }
    }catch(e){
      print(e);
    }
  }*/
  registerCarrito(Carrito cartShopping) async {
    try {
      await firebase.collection("Carrito").doc("docid").set({
        "Userid": cartShopping.idUser,
        "Shopid": cartShopping.nombreTienda,
        "Itemid": cartShopping.idItem,
        "PrecioItem":cartShopping.precioItem,
        "NombreItem":cartShopping.nombreItem,
        "Descripcion":cartShopping.descripcion,
        "Cantidad":cartShopping.cantidad,
        "Total":cartShopping.total,
        //"conteo": cont + 1,
        //"Estado": true

      });
    } catch (e) {
      print(e);
    }
  }

  Future<String> buscarNombre (String idUser)async{
    String nombreUsuario="";
    try{
      CollectionReference ref=FirebaseFirestore.instance.collection("Usuarios");
      QuerySnapshot cart= await ref.get();

      if(cart.docs.length !=0){
        for(var cursor in cart.docs){
          if(cursor.id==idUser){
            nombreUsuario=cursor.get("Nombre");
          }
        }
      }
    }catch(e){print(e);}
    return nombreUsuario;
  }

  @override
  Widget build(BuildContext context) {
    //print(widget.docId);
    Widget titleSection = Container(
      padding: const EdgeInsets.all(32),
      child: Row(
        children: [
          Expanded(
            /*1*/
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                /*2*/
                Container(
                  padding: const EdgeInsets.only(bottom: 8),
                  child: Text(
                    widget.tiendaObj.nombre,
                    style: TextStyle(
                      fontWeight: FontWeight.bold,
                    ),
                  ),
                ),
                Text(
                  widget.tiendaObj.descripcionCorta,
                  style: TextStyle(
                    color: Colors.grey[500],
                  ),
                ),
              ],
            ),
          ),
          /*3*/
          Icon(
            Icons.star,
            color: Colors.red[500],
          ),
          Text('41'),
        ],
      ),
    );
    Color color = Theme.of(context).primaryColor;

    Widget buttonSection = Container(
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceEvenly,
        children: [
          _buildButtonColumn(color, Icons.call, 'TELEFONO'),
          _buildButtonColumn(color, Icons.near_me, 'MAPS'),
          _buildButtonColumn(color, Icons.share, 'WEBSITE'),
        ],
      ),
    );
    Widget textSection = Container(
      padding: const EdgeInsets.all(32),
      child: Text(
        descripcionLarga,
        softWrap: true,
      ),
    );

    return MaterialApp(
      title: widget.tiendaObj.nombre,
      home: Scaffold(
          appBar: AppBar(
            title: Text(widget.tiendaObj.nombre),
          ),
          body: Column(
            children: [
              Expanded(
                child: ListView(
                  children: [
                    Image.asset(
                      'images/' + widget.tiendaObj.imagen,
                      width: 600,
                      height: 240,
                      fit: BoxFit.cover,
                    ),
                    titleSection,
                    buttonSection,
                    textSection,
                  ],
                ),
              ),
              Center(
                child: Row(
                  children: [
                    Padding(
                      padding: EdgeInsets.all(10),
                      child: Text(
                        "Productos",
                        style: TextStyle(fontSize: 25, color: Colors.blueGrey),
                      ),
                    ),
                    FloatingActionButton(
                      onPressed: () {
                        Navigator.push(
                            context,
                            MaterialPageRoute(
                                builder: (_) =>
                                    ItemRegister(widget.tiendaObj.idTienda)));
                      },
                      //child: const Icon(Icons.add_box),
                      tooltip: 'Agregar producto',
                      child: Text("add"),
                      backgroundColor: Colors.red,
                    ),
                  ],
                ),
              ),
              Expanded(
                child: StreamBuilder(
                  stream: FirebaseFirestore.instance
                      .collection("Productos")
                      .snapshots(),
                  builder: (BuildContext context,
                      AsyncSnapshot<QuerySnapshot> snapshot) {
                    if (!snapshot.hasData) return CircularProgressIndicator();
                    return ListView.builder(
                      itemCount: snapshot.data!.docs.length,
                      itemBuilder: (BuildContext context, int index) {
                        if (snapshot.data!.docs[index].get("idtienda") ==
                            widget.tiendaObj.idTienda) {
                          return new Card(
                            child: new Column(
                              children: [
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
                                              padding: const EdgeInsets.only(
                                                  bottom: 10),
                                              child: Text(
                                                snapshot.data!.docs[index]
                                                    .get("Nombre"),
                                                style: TextStyle(
                                                  fontWeight: FontWeight.bold,
                                                ),
                                              ),
                                            ),
                                            Text(
                                              snapshot.data!.docs[index]
                                                  .get("Descripcion"),
                                              style: TextStyle(
                                                color: Colors.blueGrey[500],
                                              ),
                                            ),
                                          ],
                                        ),
                                      ),
                                      Container(
                                        width: 80,
                                        height: 80,
                                        child: Image.asset(
                                          "images/" +
                                              (snapshot.data!.docs[index]
                                                  .get("imagen")),
                                        ),
                                      ),
                                      FloatingActionButton(
                                        onPressed: () async {
                                          Token tk = new Token();
                                          String idUser =
                                              await tk.validarToken("");
                                          print(idUser);
                                          Carrito cart=new Carrito();
                                          cart.descripcion=snapshot.data!.docs[index].get("Descripcion");
                                          cart.nombreItem=snapshot.data!.docs[index].get("Nombre");
                                          cart.precioItem=snapshot.data!.docs[index].get("Precio");
                                          cart.idItem=snapshot.data!.docs[index].id;
                                          cart.nombreTienda=widget.tiendaObj.nombre;
                                          cart.idUser=idUser;
                                          if (idUser != "") {
                                            mensajeCantidad("Agregar al carrito","¡Desea agregar el articulo al carrito?",cart);
                                            /*Navigator.push(
                                                context,
                                                MaterialPageRoute(
                                                    builder: (_) => ShoppingCart(idUser)));*/
                                          } else {
                                            Navigator.push(
                                                context,
                                                MaterialPageRoute(
                                                    builder: (_) => Login()));
                                          }
                                          //tk.guardarToken("idUser");
                                          //if(this.idUser!="") {
                                          //registerCarrito(
                                          //this.tiendaId,this.idUser,
                                          // (snapshot.data!.docs[index].id));
                                          //}else{
                                          //Navigator.push(context,
                                          // MaterialPageRoute(builder:(_))=>Login()));
                                          //}
                                        },
                                        child:
                                            const Icon(Icons.add_shopping_cart),
                                        heroTag: null,
                                        //child: Text("Ver"),
                                        tooltip: 'Agregar al carrito',
                                        backgroundColor: Colors.blue,
                                      ),
                                      FloatingActionButton(
                                        onPressed: () {
                                          //Navigator.push(context,
                                          //MaterialPageRoute(builder:(_))>=ItemRegister(idTienda)));
                                        },
                                        //child: const Icon(Icons.add_shopping_cart),
                                        child: Text("Ver"),
                                        tooltip: 'Ver producto',
                                        heroTag: null,
                                        backgroundColor: Colors.green,
                                      ),
                                    ],
                                  ),
                                )
                                //  new Text(snapshot.data!.docs[index].content)
                              ],
                            ),
                          );
                        } else {
                          return new Card();
                        }
                      },
                    );
                  },
                ),
              )
            ],
          )),
    );
  }

  Column _buildButtonColumn(Color color, IconData icon, String label) {
    return Column(
      mainAxisSize: MainAxisSize.min,
      mainAxisAlignment: MainAxisAlignment.center,
      children: [
        Icon(icon, color: color),
        Container(
          margin: const EdgeInsets.only(top: 8),
          child: Text(
            label,
            style: TextStyle(
              fontSize: 12,
              fontWeight: FontWeight.w400,
              color: color,
            ),
          ),
        ),
      ],
    );
  }
  void mensajeCantidad(String titulo, String mess, Carrito cart) {
    TextEditingController cant=TextEditingController();

    cant.text="1" ;

    showDialog(
        context: context,
        builder: (builcontext) {
          return AlertDialog(
            title: Text(titulo),
            content: Text(mess),
            actions: [
              Padding(
                padding:
                EdgeInsets.only(left: 15, top: 15, right: 15, bottom: 0),
                child: TextField(
                  controller: cant,

                  decoration: InputDecoration(
                      labelText: "Cantidad ",
                      hintText: "Digite Cantidad",
                      border: OutlineInputBorder(
                          borderRadius: BorderRadius.circular(15))),
                ),
              ),
              RaisedButton(
                onPressed: () {
                  //Navigator.of(context,rootNavigator: true).pop();// pendiente corregir
                  Navigator.of(context).pop();
                },
                child: Text(
                  "Cancelar",
                  style: TextStyle(color: Colors.teal),
                ),
              ),
              RaisedButton(
                onPressed: () async {
                  cart.cantidad=cant.text;
                  cart.total=double.parse(cart.cantidad)*double.parse(cart.precioItem);
                  cart.nombreUsuario=await buscarNombre(cart.idUser);

                  await  registerCarrito(cart);
                  Navigator.of(context).pop();
                  Navigator.push(
                      context,
                      MaterialPageRoute(
                          builder: (_) =>
                              ShoppingCart(
                                  cart)));
                  //  Navigator.of(context).pop();
                },
                child: Text(
                  "Aceptar",
                  style: TextStyle(color: Colors.teal),
                ),
              ),
            ],
          );
        });
  }
}

