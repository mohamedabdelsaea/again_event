import 'dart:developer';

import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart'; // ✅ عشان نجيب UID المستخدم
import '../../../modules/widget/even_date_model.dart';

class CreateEventFireStore {
  // ✅ المرجع الأساسي
  static CollectionReference<EvenDateModel> getCollectionReference() {
    return FirebaseFirestore.instance
        .collection('events')
        .withConverter<EvenDateModel>(
      fromFirestore: (snapshot, _) =>
          EvenDateModel.fromFireStore(snapshot.data()!),
      toFirestore: (model, _) => model.toJson(),
    );
  }

  // ✅ إضافة event جديد وربطه بالمستخدم الحالي
  static Future<bool> createNewEvent(EvenDateModel data) async {
    try {
      final user = FirebaseAuth.instance.currentUser; // 🔥 المستخدم الحالي
      if (user == null) return false;

      var collectionRef = getCollectionReference();
      var docRef = collectionRef.doc();

      data.Id = docRef.id;
      data.userId = user.uid; // ✅ نربط الحدث بالمستخدم الحالي

      await docRef.set(data);
      return true;
    } catch (error) {
      log("Error creating event: $error");
      return false;
    }
  }

  // ✅ جلب كل بيانات المستخدم الحالي فقط
  static Future<List<EvenDateModel>> getDataFromFirestore() async {
    final user = FirebaseAuth.instance.currentUser;
    if (user == null) return [];

    var collectionRef = getCollectionReference();

    QuerySnapshot<EvenDateModel> data = await collectionRef
        .where('userId', isEqualTo: user.uid) // 🔥 فلترة بالأحداث الخاصة بالمستخدم
        .get();

    return data.docs.map((element) => element.data()).toList();
  }

  // ✅ Stream للأحداث الخاصة بالمستخدم الحالي فقط
  static Stream<List<EvenDateModel>> getEventsStream() {
    final user = FirebaseAuth.instance.currentUser;
    if (user == null) {
      // لو المستخدم مش داخل، نرجع Stream فاضي
      return const Stream.empty();
    }

    var collectionRef = getCollectionReference();

    return collectionRef
        .where('userId', isEqualTo: user.uid) // 🔥 فلترة حسب المستخدم
        .snapshots()
        .map((snapshot) => snapshot.docs.map((doc) => doc.data()).toList());
  }

  // ✅ تحديث حالة isFavourite
  static Future<void> updateFavouriteStatus(String id, bool isFavourite) async {
    await FirebaseFirestore.instance
        .collection('events')
        .doc(id)
        .update({'isFavourite': isFavourite});
  }

  // ✅ حذف Event من Firestore
  static Future<void> deleteEvent(String id) async {
    await FirebaseFirestore.instance.collection('events').doc(id).delete();
  }
}
