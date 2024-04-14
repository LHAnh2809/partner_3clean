import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:partner_3clean/app/data/firebase/collection_reference.dart';

class FirestoreServiceGet {
  Future<DocumentSnapshot?> getAPI() async {
    try {
      DocumentSnapshot snapshot = await FirestoreCollections.firestore
          .collection('API')
          .doc('uUKOwRAIHWvAW6yRUWdA')
          .get();

      return snapshot;
    } catch (e) {
      print('Error getting document: $e');
      return null;
    }
  }
}
