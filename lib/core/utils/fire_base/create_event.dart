import 'package:cloud_firestore/cloud_firestore.dart';
import '../../../modules/widget/even_date_model.dart';

class CreateEvent {
  static Future<bool> createNewEvent(EvenDateModel data) async {
    try {
      var collectionRef = getCollectionReference();
      var docRef = collectionRef.doc();
      data.Id = docRef.id;
      await docRef.set(data.toJson());
      return Future.value(true);
    } catch (error) {
      return Future.value(false);
    }
  }

  static CollectionReference<Map<String, dynamic>> getCollectionReference() {
    return FirebaseFirestore.instance.collection('events');
  }
}
