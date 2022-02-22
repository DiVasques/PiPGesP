import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/foundation.dart';
import 'package:pipgesp/services/firestore_handler.dart';
import 'package:pipgesp/services/models/result.dart';
import 'package:pipgesp/services/utils/database_collections.dart';

class ChangeRaspberryRepository {
  Future<Result> changeRaspberry({
    required String raspberryIP,
    required String email,
  }) async {
    debugPrint("state: repository");
    Result result = Result(status: false);

    try {
      await FirestoreHandler.updateDocument(
        collection: DatabaseCollections.users,
        identifier: email,
        params: {'raspberryIP': raspberryIP},
      );

      DocumentSnapshot raspDoc = await FirestoreHandler.getDocument(
        collection: DatabaseCollections.raspberries,
        identifier: raspberryIP,
      );

      if (!raspDoc.exists) {
        await FirestoreHandler.addDocument(
          collection: DatabaseCollections.raspberries,
          identifier: raspberryIP,
          params: {'gadgets': []},
        );
      }

      result.status = true;
    } on FirebaseException catch (error) {
      result.errorCode = error.code;
      result.errorMessage = error.message;
      result.status = false;
      return result;
    } catch (error) {
      result.errorCode = "999";
      result.errorMessage = error.toString();
      result.status = false;
      return result;
    }

    return result;
  }
}
