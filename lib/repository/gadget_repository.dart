import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/foundation.dart';
import 'package:pipgesp/repository/models/gadget.dart';
import 'package:pipgesp/repository/models/gadget_data.dart';
import 'package:pipgesp/repository/utils/utils.dart';
import 'package:pipgesp/services/firestore_handler.dart';
import 'package:pipgesp/services/gadget_services.dart';
import 'package:pipgesp/services/models/result.dart';
import 'package:pipgesp/services/utils/database_collections.dart';
import 'package:pipgesp/ui/utils/gadget_types.dart';

class GadgetRepository {
  late GadgetData gadgetData;

  Future<Result> getGadgetData(
      {required String raspberryIP, required Gadget gadget}) async {
    debugPrint("state: repository");
    Result result = Result(status: false);
    try {
      await GadgetServices.addGadget(
        raspberryIP: raspberryIP,
        physicalPort: gadget.physicalPort.toString(),
        id: gadget.id,
        datatype: gadget.iotype == GadgetType.spi ? 'int' : 'bool',
        iotype: gadget.iotype.name,
      );
      debugPrint("state: added on server");

      Map<String, dynamic> json = await GadgetServices.getGadgetData(
          raspberryIP: raspberryIP,
          physicalPort: gadget.physicalPort.toString());
      json = json['data']['${gadget.physicalPort.toString()}'];
      gadgetData = GadgetData(
        iotype: Utils.processIOType(json['iotype']),
        name: json['string'],
        dataType: Utils.processDataType(json['datatype']),
        lastChange:
            DateTime.fromMillisecondsSinceEpoch(json['last'] * 1000).toLocal(),
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

  Future<Result> setGadgetOutput({
    required String raspberryIP,
    required int physicalPort,
    required bool output,
  }) async {
    debugPrint("state: repository");
    Result result = Result(status: false);

    try {
      await GadgetServices.setGadgetOutput(
          raspberryIP: raspberryIP,
          physicalPort: physicalPort.toString(),
          value: output.toString());
      result.status = true;
    } catch (error) {
      result.errorCode = "error.code";
      result.errorMessage = "error.message";
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
