import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/foundation.dart';
import 'package:pipgesp/repository/models/gadget.dart';
import 'package:pipgesp/repository/models/gadget_data.dart';
import 'package:pipgesp/repository/utils/utils.dart';
import 'package:pipgesp/services/firestore_handler.dart';
import 'package:pipgesp/services/gadget_services.dart';
import 'package:pipgesp/services/models/result.dart';
import 'package:pipgesp/services/utils/database_collections.dart';
import 'package:pipgesp/ui/utils/gadget_devices.dart';
import 'package:pipgesp/ui/utils/gadget_types.dart';

class GadgetRepository {
  late GadgetData gadgetData;

  Future<Result> getGadgetData({required int physicalPort}) async {
    debugPrint("state: repository");
    Result result = Result(status: false);

    try {
      Map<String, dynamic> json =
          await GadgetServices.getGadgetDataMock(physicalPort: physicalPort.toString());
      gadgetData = GadgetData(
        iotype: Utils.processIOType(json['iotype']),
        name: json['string'],
        dataType: Utils.processDataType(json['datatype']),
        lastChange: DateTime.fromMillisecondsSinceEpoch(json['last']),
        data: json['data']!,
      );

      result.status = true;
    } catch (error) {
      result.errorCode = "999";
      result.errorMessage = error.toString();
      result.status = false;
      return result;
    }

    return result;
  }

  Future<Result> setGadgetOutput(
      {required int physicalPort, required bool output}) async {
    debugPrint("state: repository");
    Result result = Result(status: false);

    try {
      await GadgetServices.setGadgetOutput(physicalPort: physicalPort.toString(), value: output.toString());
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

  Future<Result> deleteGadget({required String identifier, required Gadget gadget}) async {
    debugPrint("state: repository");
    Result result = Result(status: false);

    try {
      Map<String, dynamic> param = {
        "device": gadget.device.toValueString(),
        "id": gadget.id,
        "iotype": gadget.iotype.toValue(),
        "name": gadget.name,
        "physicalPort": gadget.physicalPort,
      };
      await FirestoreHandler.deleteFromArray(
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
