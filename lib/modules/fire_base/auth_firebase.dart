import 'dart:developer';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:flutter_easyloading/flutter_easyloading.dart';

import '../../core/services/snack_bar_service.dart';

class AuthFirebase {
  static Future<bool> signUp({
    required String email,
    required String password,
  }) async {
    EasyLoading.show();
    try {
      await FirebaseAuth.instance.createUserWithEmailAndPassword(
        email: email,
        password: password,
      );
      User? user = FirebaseAuth.instance.currentUser;

      EasyLoading.dismiss();
      return Future.value(true);
    } on FirebaseAuthException catch (e) {
      if (e.code == 'weak-password') {
        SnackBarService.showErrorMessage(
            e.message ?? 'The password provided is too weak.');

        print('The password provided is too weak.');
        return Future.value(false);
      } else if (e.code == 'email-already-in-use') {
        SnackBarService.showErrorMessage(
            e.message ?? 'The account already exists for that email.');
        print('The account already exists for that email.');
        return Future.value(false);
      }
      return Future.value(false);
    } catch (e) {
      return Future.value(false);
    }
  }

  Future<void> signIn(String name, String email, String password) async {
    try {
      UserCredential userCredential =
          await FirebaseAuth.instance.createUserWithEmailAndPassword(
        email: email,
        password: password,
      );
      User? user = FirebaseAuth.instance.currentUser;
      if (user != null) {
        log('${user.uid}');
      }
    } catch (e) {}
  }
}
