import 'dart:convert';

import 'package:flutter/foundation.dart';
import 'package:flutter/services.dart';
import 'package:http/http.dart' as http;
import 'package:pipgesp/services/utils/app_urls.dart';

class GadgetServices {
  static Future<Map<String, dynamic>> getGadgetData(
      {required String raspberryIP, required String physicalPort}) async {
    debugPrint("state: services");
    Uri url = Uri.http(
      raspberryIP + AppUrls.raspberryPort,
      '/sensor',
      {'id': physicalPort},
    );
    debugPrint(url.toString());

    Map<String, String> headers = <String, String>{};
    headers["Content-type"] = "application/json";

    http.Response response = await http.get(
      url,
      headers: headers,
    );
    if (response.statusCode == 200) {
      final Map<String, dynamic> data = await json.decode(response.body);
      debugPrint(data.toString());
      return data;
    } else {
      // If that response was not OK, throw an error.
      throw Exception('Code ${response.statusCode}. ${response.toString()}');
    }
  }

  static Future<void> setGadgetOutput(
      {required String raspberryIP, required String physicalPort, required String value}) async {
    debugPrint("state: services");
    Uri url = Uri.http(
        raspberryIP + AppUrls.raspberryPort, '/sensor/set', {
      'id': physicalPort,
      'value': value,
    });
    debugPrint(url.toString());

    Map<String, String> headers = <String, String>{};
    headers["Content-type"] = "application/json";

    http.Response response = await http.get(
      url,
      headers: headers,
    );
    if (response.statusCode != 200) {
      // If that response was not OK, throw an error.
      throw Exception('Code ${response.statusCode}. ${response.toString()}');
    }
  }

  ///Param [iotype] must be 'output', 'input' or 'spi'
  ///Param [datatype] must be 'bool' or 'int'
  static Future<void> addGadget({
    required String raspberryIP, 
    required String physicalPort,
    required String id,
    required String iotype,
    required String datatype,
  }) async {
    debugPrint("state: services");
    Uri url = Uri.http(
        raspberryIP + AppUrls.raspberryPort, '/include', {
      'id': physicalPort,
      'string': id,
      'iotype': iotype,
      'datatype': datatype
    });
    debugPrint(url.toString());

    Map<String, String> headers = <String, String>{};
    headers["Content-type"] = "application/json";

    http.Response response = await http.get(
      url,
      headers: headers,
    );
    if (response.statusCode != 200) {
      // If that response was not OK, throw an error.
      throw Exception('Code ${response.statusCode}. ${response.toString()}');
    }
  }
}
