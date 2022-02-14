import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:pipgesp/repository/models/gadget_data.dart';
import 'package:pipgesp/repository/utils/utils.dart';
import 'package:pipgesp/services/gadget_services.dart';
import 'package:pipgesp/services/models/result.dart';

class GadgetRepository {
  late GadgetData gadgetData;

  Future<Result> getGadgetData({required int physicalPort}) async {
    Result result = Result(status: false);

    try {
      Map<String, dynamic> json =
          await GadgetServices.getGadgetData(physicalPort: physicalPort);
      gadgetData = GadgetData(
        iotype: Utils.processIOType(json['iotype']),
        name: json['string'],
        dataType: Utils.processDataType(json['datatype']),
        lastChange:
            DateTime.fromMillisecondsSinceEpoch(json['last']),
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
    Result result = Result(status: false);

    try {
      await Future.delayed(Duration(seconds: 1));
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
