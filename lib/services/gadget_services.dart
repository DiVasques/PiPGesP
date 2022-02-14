import 'dart:convert';

import 'package:flutter/foundation.dart';
import 'package:flutter/services.dart';

class GadgetServices {
  static Future<Map<String, dynamic>> getGadgetData(
      {required int physicalPort}) async {
    String response;
    await Future.delayed(Duration(seconds: 1));
    switch (physicalPort) {
      case 999:
        response = await rootBundle.loadString('assets/json/input_gadget.json');

        break;
      case 5:
        response =
            await rootBundle.loadString('assets/json/output_gadget.json');
        break;
      default:
        throw (Exception('No Data!'));
    }
    final Map<String, dynamic> data = await json.decode(response);
    debugPrint(data.toString());
    return data;
  }
}
