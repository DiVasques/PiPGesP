import 'package:cloud_firestore/cloud_firestore.dart';

class FirestoreHandler {
  ///Retorna documento [QuerySnapshot] do usuário selecionado
  static Future<DocumentSnapshot> getUser(
      {required String email}) async {
    DocumentSnapshot document =
        await FirebaseFirestore.instance.collection('users').doc(email).get();
    return document;
  }

  ///Adiciona usuário ao banco de dados
  static Future<void> addUser({
    required String uid,
    required String name,
    required String email,
    required String registration,
  }) async {
    await FirebaseFirestore.instance.collection('users').doc(email).set(
      {
        'uid': uid,
        'name': name,
        'email': email,
        'registration': registration
      },
    );
  }
}
