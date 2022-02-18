import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/foundation.dart';

class FirestoreHandler {
  ///Retorna documento [QuerySnapshot] da coleção selecionada
  static Future<DocumentSnapshot> getDocument({
    required String identifier,
    required String collection,
  }) async {
    debugPrint("state: services");
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
    debugPrint("state: services");
    await FirebaseFirestore.instance
        .collection(collection)
        .doc(identifier)
        .set(params);
  }

  ///Adiciona item a um array de documento do banco de dados
  static Future<void> addOnArray({
    required String identifier,
    required String collection,
    required String field,
    required dynamic param,
  }) async {
    debugPrint("state: services");
    await FirebaseFirestore.instance
        .collection(collection)
        .doc(identifier)
        .update({
      field: FieldValue.arrayUnion([param])
    });
  }

  ///Remove item de um array de documento do banco de dados
  static Future<void> deleteFromArray({
    required String identifier,
    required String collection,
    required String field,
    required dynamic param,
  }) async {
    debugPrint("state: services");
    await FirebaseFirestore.instance
        .collection(collection)
        .doc(identifier)
        .update({
      field: FieldValue.arrayRemove([param])
    });
  }
}
