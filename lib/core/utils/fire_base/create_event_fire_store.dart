import 'package:cloud_firestore/cloud_firestore.dart';
import '../../../modules/widget/even_date_model.dart';

class CreateEventFireStore {
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

  static CollectionReference<EvenDateModel> getCollectionReference() {
    return FirebaseFirestore.instance
        .collection('events')
        .withConverter<EvenDateModel>(
          fromFirestore: (snapshot, _) =>
              EvenDateModel.fromFireStore(snapshot.data()!),
          toFirestore: (model, _) => model.toJson(),
        );
  }

  static Future<List<EvenDateModel>> getDataFromFirestore() async {
    var collectionRef = getCollectionReference();

    QuerySnapshot<EvenDateModel> data = await collectionRef.get();

    List<EvenDateModel> eventDataList =
        data.docs.map((element) => element.data()).toList();

    return eventDataList;
  }

  static Stream<List<EvenDateModel>> getEventsStream() {
    var collectionRef = getCollectionReference();

    return collectionRef.snapshots().map((snapshot) {
      return snapshot.docs.map((doc) => doc.data()).toList();
    });
  }
}
