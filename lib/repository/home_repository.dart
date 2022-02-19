import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/foundation.dart';
import 'package:pipgesp/repository/models/gadget.dart';
import 'package:pipgesp/repository/models/user.dart';
import 'package:pipgesp/repository/utils/utils.dart';
import 'package:pipgesp/services/firestore_handler.dart';
import 'package:pipgesp/services/models/result.dart';
import 'package:pipgesp/services/utils/database_collections.dart';

class HomeRepository {
  late User user;

  Future<Result> getUser({required String email}) async {
    debugPrint("state: repository");
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
        raspPort: snapshot.get('raspPort'),
      );
      for (Map<String, dynamic> gadgetMap in snapshot.get('gadgets')) {
        Gadget gadget = Gadget(
          device: Utils.processDevice(gadgetMap['device'] as String),
          iotype: Utils.processIOType(gadgetMap['iotype'] as String),
          name: gadgetMap['name'] as String,
          physicalPort: gadgetMap['physicalPort'] as int,
          id: gadgetMap['id'] as String,
        );
        user.gadgets.add(gadget);
      }
      debugPrint(user.uid);
      debugPrint(snapshot.get('uid'));
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
