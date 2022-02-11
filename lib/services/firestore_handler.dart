import 'package:cloud_firestore/cloud_firestore.dart';

class FirestoreHandler {
  ///Retorna documento [QuerySnapshot] da coleção selecionada
  static Future<DocumentSnapshot> getDocument({
    required String identifier,
    required String collection,
  }) async {
    DocumentSnapshot document = await FirebaseFirestore.instance
        .collection(collection)
        .doc(identifier)
        .get();
    return document;
  }

  ///Adiciona documento ao banco de dados
  static Future<void> addDocument({
    required String identifier,
    required String collection,
    required Map<String, dynamic> params,
  }) async {
    await FirebaseFirestore.instance
        .collection(collection)
        .doc(identifier)
        .set(params);
  }
}
