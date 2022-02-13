import 'package:pipgesp/services/models/result.dart';

class PeripheralServices {
  static Future<Result> getGadgetsList({required String endpoint}) async {
    Result result = Result(status: false);
    await Future.delayed(Duration(seconds: 1));
    result.status = true;
    return result;
  }
  
}