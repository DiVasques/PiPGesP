import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/cupertino.dart';
import 'package:pipgesp/repository/models/user.dart';
import 'package:pipgesp/services/firestore_handler.dart';
import 'package:pipgesp/services/models/result.dart';
import 'package:pipgesp/services/utils/database_collections.dart';

class HomeRepository {
  late User user;

  Future<Result> getUser({required String email}) async {
    Result result = Result(status: false);

    try {
      DocumentSnapshot snapshot = await FirestoreHandler.getDocument(
        identifier: email,
        collection: DatabaseCollections.users,
      );
      debugPrint(snapshot.data().toString());
      user = User(
        uid: snapshot.get('uid'),
        name: snapshot.get('name'),
        email: snapshot.get('email'),
        registration: snapshot.get('registration'),
      );
      debugPrint(user.uid);
      debugPrint(snapshot.get('uid'));
      result.status = true;
    } on FirebaseException catch (error) {
      result.errorCode = error.code;
      result.errorMessage = error.message;
      result.status = false;
      return result;
    } catch (error) {
      result.errorCode = "error.code";
      result.errorMessage = "error.message";
      result.status = false;
      return result;
    }

    return result;
  }
}
