import 'package:parkingapp/models/location.dart';

class Geometry{
  final location Location;
  Geometry(this.Location);
  Geometry.fromJson(Map<dynamic,dynamic>parsedJson)
    :Location=location.fromJson(parsedJson['location']);
}