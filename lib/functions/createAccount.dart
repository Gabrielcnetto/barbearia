import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/material.dart';

class CreateAccount with ChangeNotifier {
  final authSettings = FirebaseAuth.instance;
  final dataBaseFirestore = FirebaseFirestore.instance;

  //

  //

  Future<void> CreateAccountProvider({
    required String email,
    required String password,
    required String userName,
  }) async {
    await authSettings.createUserWithEmailAndPassword(
      email: email,
      password: password,
    );

    String userIdCreate = await authSettings.currentUser!.uid;
    print("userid:${userIdCreate}");
    await dataBaseFirestore.collection("usuarios").doc(userIdCreate).set({
      'userName': userName,
      'userEmail': email,
      'PhoneNumber': "",
    });
    notifyListeners();
  }
}
