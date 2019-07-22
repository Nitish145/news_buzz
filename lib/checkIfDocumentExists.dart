import 'package:cloud_firestore/cloud_firestore.dart';

Future<bool> isDocumentExisting(
    String documentName, String firebaseUserId) async {
  final QuerySnapshot result = await Firestore.instance
      .collection(firebaseUserId)
      .where('title', isEqualTo: documentName)
      .limit(1)
      .getDocuments();
  final List<DocumentSnapshot> documents = result.documents;
  return documents.length == 1;
}
