import 'dart:ffi';

import 'package:flutter/material.dart';
import 'package:parkingapp/models/place.dart';
import 'dart:convert' as convert;
import 'package:http/http.dart' as http;
class placeservices{
  final key='AIzaSyBB798cGlaZTVGqUzLsOHE33cLB6mGTSv0';
  Future<List<place>> getplaces(double lat,double lng) async{
    var response=await http.get('https://maps.googleapis.com/maps/api/place/nearbysearch/json?location=$lat,$lng&type=parking&rankby=distance&key=$key');
    var json=convert.jsonDecode(response.body);
    var jsonResult= json['results'] as List;
    return jsonResult.map((e) => place.fromJson(e)).toList();
  }
}