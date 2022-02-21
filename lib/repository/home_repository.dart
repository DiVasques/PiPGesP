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
      DocumentSnapshot userSnapshot = await FirestoreHandler.getDocument(
        identifier: email,
        collection: DatabaseCollections.users,
      );
      debugPrint(userSnapshot.data().toString());
      user = User(
        uid: userSnapshot.get('uid'),
        name: userSnapshot.get('name'),
        email: userSnapshot.get('email'),
        registration: userSnapshot.get('registration'),
        raspberryIP: userSnapshot.get('raspberryIP'),
      );
      DocumentSnapshot gadgetsSnapshot = await FirestoreHandler.getDocument(
        identifier: user.raspberryIP,
        collection: DatabaseCollections.raspberries,
      );
      debugPrint(gadgetsSnapshot.data().toString());
      for (Map<String, dynamic> gadgetMap in gadgetsSnapshot.get('gadgets')) {
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
      debugPrint(userSnapshot.get('uid'));
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

  Future<Result> deleteGadget(
      {required String identifier, required Gadget gadget}) async {
    debugPrint("state: repository");
    Result result = Result(status: false);

    try {
      Map<String, dynamic> param = {
        "device": gadget.device.name,
        "id": gadget.id,
        "iotype": gadget.iotype.name,
        "name": gadget.name,
        "physicalPort": gadget.physicalPort,
      };
      await FirestoreHandler.deleteFromArray(
          identifier: identifier,
          collection: DatabaseCollections.raspberries,
          field: "gadgets",
          param: param);
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
