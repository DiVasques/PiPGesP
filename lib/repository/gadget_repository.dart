import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:pipgesp/services/models/result.dart';

class GadgetRepository {

  Future<Result> getGadgetData({required String id}) async {
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
