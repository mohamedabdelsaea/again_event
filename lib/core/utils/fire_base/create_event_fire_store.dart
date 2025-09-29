import 'package:cloud_firestore/cloud_firestore.dart';
import '../../../modules/widget/even_date_model.dart';

class CreateEventFireStore {
  // إضافة event جديد
  static Future<bool> createNewEvent(EvenDateModel data) async {
    try {
      var collectionRef = getCollectionReference();
      var docRef = collectionRef.doc();
      data.Id = docRef.id;
      await docRef.set(data);
      return true;
    } catch (error) {
      return false;
    }
  }

  // المرجع الأساسي
  static CollectionReference<EvenDateModel> getCollectionReference() {
    return FirebaseFirestore.instance
        .collection('events')
        .withConverter<EvenDateModel>(
          fromFirestore: (snapshot, _) =>
              EvenDateModel.fromFireStore(snapshot.data()!),
          toFirestore: (model, _) => model.toJson(),
        );
  }

  // جلب كل البيانات مرة واحدة
  static Future<List<EvenDateModel>> getDataFromFirestore() async {
    var collectionRef = getCollectionReference();

    QuerySnapshot<EvenDateModel> data = await collectionRef.get();

    List<EvenDateModel> eventDataList =
        data.docs.map((element) => element.data()).toList();

    return eventDataList;
  }

  // Stream للحصول على أي تحديث مباشر
  static Stream<List<EvenDateModel>> getEventsStream() {
    var collectionRef = getCollectionReference();

    return collectionRef.snapshots().map((snapshot) {
      return snapshot.docs.map((doc) => doc.data()).toList();
    });
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
