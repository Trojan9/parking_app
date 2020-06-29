import 'package:flutter/material.dart';
import 'package:geolocator/geolocator.dart';
import 'package:parkingapp/models/place.dart';
import 'package:parkingapp/screnns/search.dart';
import 'package:parkingapp/services/geolocator.dart';
import 'package:parkingapp/services/places_services.dart';
import 'package:provider/provider.dart';

void main() {
  runApp(MyApp());
}

class MyApp extends StatelessWidget {
  // create instance of geoocatorservice class
  final locationservice=geolocatorservice();
  final placeservice=placeservices();
  @override
  Widget build(BuildContext context) {
    return MultiProvider(
      providers:[
        FutureProvider(
        create: (context)=>locationservice.geolocation(),),


        ProxyProvider<Position,Future<List<place>>>(
          update:(context,position,places){
            return((position!=null)?placeservice.getplaces(position.latitude,position.longitude):null);
          },
        ),
      ],
      child: MaterialApp(
        title: 'Flutter Demo',
        theme: ThemeData(
          visualDensity: VisualDensity.adaptivePlatformDensity,
        ),
        home:search(),
      ),
    );
  }
}

