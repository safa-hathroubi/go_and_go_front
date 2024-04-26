import 'dart:convert';
import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;
import 'package:shared_preferences/shared_preferences.dart';
import '../../models/request/car_model.dart';
import '../Config.dart';
import 'package:go_and_go/models/response/Car_Modelresp.dart';

class CarHelper extends ChangeNotifier {
  static var client = http.Client();

  static Future<List<dynamic>> addCar(CarModelReq model) async {
    final SharedPreferences prefs = await SharedPreferences.getInstance();

    String? token = prefs.getString('token');
    print(token);
    Map<String, String> requestHeaders = {
      'Content-Type': 'application/json',
      'Authorization': 'Bearer $token',
    };

    var url = Uri.http(Config.apiUrl, Config.addCar);
    var response = await client.post(url,
        headers: requestHeaders, body: jsonEncode(model.toJson()));

    if (response.statusCode == 200) {
      return [true];
    } else {
      return [false];
    }
  }


  static Future<CarModelResp> getCars() async {
    final SharedPreferences prefs = await SharedPreferences.getInstance();
    String? token = prefs.getString('token');
    Map<String, String> requestHeaders = {
      'Content-Type': 'application/json',
      'token': 'Bearer $token'
    };

    var url = Uri.http(Config.apiUrl, Config.getCar);
    var response = await client.get(
      url,
      headers: requestHeaders,
    );

    if (response.statusCode == 200) {
      var car = carModelRespFromJson(response.body);
      return car;
    } else {
      throw Exception("Failed to get the jobs");
    }
  }


}

