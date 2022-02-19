import 'dart:convert';

import 'package:flutter/foundation.dart';
import 'package:flutter/services.dart';
import 'package:http/http.dart' as http;
import 'package:pipgesp/services/utils/app_urls.dart';

class GadgetServices {
  static Future<Map<String, dynamic>> getGadgetDataMock(
      {required String physicalPort}) async {
    debugPrint("state: services");
    String response;
    await Future.delayed(Duration(seconds: 1));
    Uri url =
        Uri.http(AppUrls.raspberryEndpoint, '/sensor', {'id': physicalPort});
    debugPrint(url.toString());
    switch (physicalPort) {
      case '999':
        response = await rootBundle.loadString('assets/json/spi_gadget.json');
        break;
      case '5':
        response =
            await rootBundle.loadString('assets/json/output_gadget.json');
        break;
      case '6':
        response = await rootBundle.loadString('assets/json/input_gadget.json');
        break;
      default:
        throw (Exception('No Data!'));
    }
    final Map<String, dynamic> data = await json.decode(response);
    debugPrint(data.toString());
    return data;
  }

  static Future<void> getGadgetData(
      {required String physicalPort,
      required Map<String, dynamic> params}) async {
    debugPrint("state: services");
    await Future.delayed(Duration(seconds: 1));
    Uri url = Uri.http(
      AppUrls.raspberryEndpoint,
      '/sensor',
      {'id': physicalPort},
    );
    debugPrint(url.toString());

    Map<String, String> headers = <String, String>{};
    headers["Content-type"] = "application/json";

    http.Response response = await http.post(
      url,
      headers: headers,
      body: params,
    );
    if (response.statusCode != 200) {
      // If that response was not OK, throw an error.
      throw Exception('Code ${response.statusCode}. ${response.toString()}');
    }
  }

  static Future<void> setGadgetOutput(
      {required String physicalPort, required String value}) async {
    debugPrint("state: services");
    await Future.delayed(Duration(seconds: 1));
    Uri url = Uri.http(AppUrls.raspberryEndpoint, '/sensor/set', {
      'id': physicalPort,
      'value': value,
    });
    debugPrint(url.toString());

    Map<String, String> headers = <String, String>{};
    headers["Content-type"] = "application/json";

    // http.Response response = await http.get(
    //   url,
    //   headers: headers,
    // );
    // if (response.statusCode != 200) {
    //   // If that response was not OK, throw an error.
    //   throw Exception('Code ${response.statusCode}. ${response.toString()}');
    // }
  }

  ///Param [iotype] must be 'output', 'input' or 'spi'
  ///Param [datatype] must be 'bool' or 'int'
  static Future<void> addGadget({
    required String physicalPort,
    required String id,
    required String iotype,
    required String datatype,
  }) async {
    debugPrint("state: services");
    await Future.delayed(Duration(seconds: 1));
    Uri url = Uri.http(AppUrls.raspberryEndpoint, '/include', {
      'id': physicalPort,
      'string': id,
      'iotype': iotype,
      'datatype': datatype
    });
    debugPrint(url.toString());

    Map<String, String> headers = <String, String>{};
    headers["Content-type"] = "application/json";

    // http.Response response = await http.get(
    //   url,
    //   headers: headers,
    // );
    // if (response.statusCode != 200) {
    //   // If that response was not OK, throw an error.
    //   throw Exception('Code ${response.statusCode}. ${response.toString()}');
    // }
  }
}
