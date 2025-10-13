import 'dart:developer';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter_easyloading/flutter_easyloading.dart';
import '../../services/snack_bar_service.dart';

class AuthFirebase {
  static final _auth = FirebaseAuth.instance;
  static final _firestore = FirebaseFirestore.instance;

  // إنشاء حساب جديد
  static Future<bool> createAccount({
    required String email,
    required String password,
  }) async {
    EasyLoading.show();
    try {
      // إنشاء الحساب في Firebase Auth
      UserCredential userCredential = await _auth.createUserWithEmailAndPassword(
        email: email,
        password: password,
      );

      User? user = userCredential.user;

      // حفظ بيانات المستخدم في Firestore
      if (user != null) {
        await _firestore.collection('users').doc(user.uid).set({
          'uid': user.uid,
          'email': user.email,
          'createdAt': FieldValue.serverTimestamp(),
        });
      }

      EasyLoading.dismiss();
      SnackBarService.showSuccessMessage('Account created successfully');
      return true;
    } on FirebaseAuthException catch (e) {
      EasyLoading.dismiss();

      if (e.code == 'weak-password') {
        log('The password provided is too weak.');
        SnackBarService.showErrorMessage(
            e.message ?? 'The password provided is too weak.');
      } else if (e.code == 'email-already-in-use') {
        log('The account already exists for that email.');
        SnackBarService.showErrorMessage(
            e.message ?? 'The account already exists for that email.');
      } else {
        SnackBarService.showErrorMessage(e.message ?? 'Error creating account');
      }

      return false;
    } catch (e) {
      EasyLoading.dismiss();
      log(e.toString());
      SnackBarService.showErrorMessage('Unexpected error occurred');
      return false;
    }
  }

  // تسجيل الدخول
  static Future<bool> login({
    required String email,
    required String password,
  }) async {
    EasyLoading.show();
    try {
      await _auth.signInWithEmailAndPassword(
        email: email,
        password: password,
      );

      EasyLoading.dismiss();
      SnackBarService.showSuccessMessage('Login successfully');
      return true;
    } on FirebaseAuthException catch (e) {
      EasyLoading.dismiss();
      SnackBarService.showErrorMessage(e.message ?? 'Login failed');
      return false;
    } catch (e) {
      EasyLoading.dismiss();
      log(e.toString());
      SnackBarService.showErrorMessage('Unexpected error occurred');
      return false;
    }
  }
}
