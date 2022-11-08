import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'Tiendas/ShopOne.dart';

class busqueda extends StatefulWidget {
  final String searchWord;
  busqueda(this.searchWord);

  @override
  BuscarApp createState() => BuscarApp();
}

class BuscarApp extends State<busqueda> {
  String idDoc = "";
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text("Registro de busqueda"),
      ),
      body: Container(
        child: Center(
          child: StreamBuilder(
            stream:
                FirebaseFirestore.instance.collection("Tiendas").snapshots(),
            builder:
                (BuildContext context, AsyncSnapshot<QuerySnapshot> snapshot) {
              if (!snapshot.hasData) return CircularProgressIndicator();
              //print(widget.searchWord);
              return ListView.builder(
                itemCount: snapshot.data!.docs.length,
                itemBuilder: (BuildContext context, int index) {
                  if (snapshot.data!.docs[index]
                      .get("nombreTienda")
                      .toString()
                      .toUpperCase()
                      .contains(widget.searchWord.toUpperCase())) {
                    print(snapshot.data!.docs[index].id);

                    return Card(
                      child: new Column(
                        children: <Widget>[
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
                                          padding:
                                              const EdgeInsets.only(bottom: 10),
                                          child: Text(
                                            snapshot.data!.docs[index]
                                                .get("nombreTienda"),
                                          ),
                                        ),
                                        Text(
                                          "Perros Calientes,Hamburguersas y mas",
                                          style: TextStyle(
                                            color: Colors.green[500],
                                          ),
                                        ),
                                        Text(
                                          snapshot.data!.docs[index]
                                              .get("descripcionTienda"),
                                          style: TextStyle(
                                            color: Colors.green[500],
                                          ),
                                        ),
                                      ],
                                    ),
                                  ),
                                  Container(
                                    width: 80,
                                    height: 80,
                                    child: Image.asset(
                                        snapshot.data!.docs[index].get("ruta")),
                                  ),
                                  ElevatedButton(
                                      onPressed: () {
                                        this.idDoc =
                                            snapshot.data!.docs[index].id;
                                        //Navigator.push(
                                            //context,
                                           // MaterialPageRoute(
                                                //builder: (_) =>
                                                   // ShopOne(this.idDoc)));
                                      },
                                      child: Text('Entrar'))
                                ],
                              )),
                          Container(
                            width: 80,
                            height: 80,
                            child: Image.asset('images/' +
                                snapshot.data!.docs[index].get("ruta")),
                          ),
                          ElevatedButton(
                              onPressed: () {
                                this.idDoc=snapshot.data!.docs[index].id;
                                //Navigator.push(context, MaterialPageRoute(
                                        //builder: (_) => ShopOne(snapshot.data!.docs[index].id)));
                              },
                              child: Text('Entrar'))
                        ],
                      ),
                    );
                  } else {
                    return new Card();
                  }
                  //  new Text(snapshot.data!.docs[index].content)
                },
              );
            },
          ),
        ),
      ),
    );
  }
}
