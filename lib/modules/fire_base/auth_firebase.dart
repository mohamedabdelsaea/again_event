import 'dart:developer';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter_easyloading/flutter_easyloading.dart';
import '../../core/services/snack_bar_service.dart';

class AuthFirebase {
  static Future<bool> createAccount({
    required String email,
    required String password,
  }) async {
    EasyLoading.show();
    try {
      await FirebaseAuth.instance.createUserWithEmailAndPassword(
        email: email,
        password: password,
      );

      EasyLoading.dismiss();
      return true;
    } on FirebaseAuthException catch (e) {
      EasyLoading.dismiss();
      if (e.code == 'weak-password') {
        SnackBarService.showErrorMessage(
            e.message ?? 'The password provided is too weak.');
        return false;
      } else if (e.code == 'email-already-in-use') {
        SnackBarService.showErrorMessage(
            e.message ?? 'The account already exists for that email.');
        return false;
      }
      return false;
    } catch (e) {
      EasyLoading.dismiss();
      return false;
    }
  }

  Future<bool> signIn({
    required String email,
    required String password,
  }) async {
    EasyLoading.show();
    try {
      UserCredential userCredential =
          await FirebaseAuth.instance.signInWithEmailAndPassword(
        email: email,
        password: password,
      );

      User? user = userCredential.user;
      EasyLoading.dismiss();

      if (user != null) {
        log('Signed in: ${user.uid}');
        return true;
      }
      return false;
    } on FirebaseAuthException catch (e) {
      EasyLoading.dismiss();
      SnackBarService.showErrorMessage(e.message ?? 'Login failed');
      return false;
    } catch (e) {
      EasyLoading.dismiss();
      return false;
    }
  }
}
