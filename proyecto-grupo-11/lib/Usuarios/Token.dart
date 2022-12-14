import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:firebase_messaging/firebase_messaging.dart';

class Token {
  FirebaseMessaging messaging = FirebaseMessaging.instance;
  String isToken = "";
  FirebaseFirestore firestore = FirebaseFirestore.instance;

  guardarToken(String idUser) async {
    await Firebase.initializeApp();
    isToken = (await FirebaseMessaging.instance.getToken())!;
    print(isToken);
    try {
      await firestore.collection("Tokens").doc().set({
        "Tokenid": isToken,
        "Userid": idUser,
      });
    } catch (e) {
      print(e);
    }
  }

  validarToken(String x) async {
    String isSession = "";
    String idToken="";
    try {
      await Firebase.initializeApp();
      isToken = (await FirebaseMessaging.instance.getToken())!;

      CollectionReference ref = FirebaseFirestore.instance.collection("Tokens");
      QuerySnapshot sesion = await ref.get();

      if (sesion.docs.length != 0) {
        for (var cursor in sesion.docs) {
          if (cursor.get("Tokenid") == isToken) {
            print("Token encontrado");
            isSession=cursor.get("Userid");
            idToken=cursor.id;
          }
        }
      } else {
        print("no hay elementos en la coleccion");
      }
    } catch (e) {
      print(e);
    }
    if(x=="Login"){
      return idToken;
    }else{

    }
    return isSession;
  }
}
