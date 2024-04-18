

import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';

class MyProfileScreenFunctions with ChangeNotifier {
    final authSettings = FirebaseAuth.instance;
 // final storageSettings = FirebaseStorage.instance;
  final dataBaseFirestore = FirebaseFirestore.instance;


  Future<String?> getNameUser() async {
    if (authSettings.currentUser != null) {
      String? urlImage;
      await dataBaseFirestore
          .collection("usuarios")
          .doc(authSettings.currentUser!.uid)
          .get()
          .then((getData) {
        if (getData.exists) {
          urlImage = getData.data()?["userName"];
        } else {}
      });
      print("recebi do server: ${urlImage}");
      return urlImage;
    }
    return null;
  }
}


