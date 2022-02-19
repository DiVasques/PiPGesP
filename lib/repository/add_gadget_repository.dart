import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/foundation.dart';
import 'package:pipgesp/repository/models/gadget.dart';
import 'package:pipgesp/services/firestore_handler.dart';
import 'package:pipgesp/services/gadget_services.dart';
import 'package:pipgesp/services/models/result.dart';
import 'package:pipgesp/services/utils/database_collections.dart';
import 'package:pipgesp/ui/utils/gadget_types.dart';

class AddGadgetRepository {
  Future<Result> addGadget(
      {required String identifier, required Gadget gadget}) async {
    debugPrint("state: repository");
    Result result = Result(status: false);

    try {
      await GadgetServices.addGadget(
        physicalPort: gadget.physicalPort.toString(),
        id: gadget.id,
        datatype: gadget.iotype == GadgetType.spi ? 'int' : 'bool',
        iotype: gadget.iotype.name,
      );

      Map<String, dynamic> param = {
        "device": gadget.device.name,
        "id": gadget.id,
        "iotype": gadget.iotype.name,
        "name": gadget.name,
        "physicalPort": gadget.physicalPort,
      };
      await FirestoreHandler.addOnArray(
          identifier: identifier,
          collection: DatabaseCollections.users,
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
