import 'package:geolocator/geolocator.dart';

class geolocatorservice{
  var geolocator=Geolocator();
  Future<Position> geolocation() async{

    return (await geolocator.getCurrentPosition(desiredAccuracy: LocationAccuracy.high,locationPermissionLevel: GeolocationPermission.location));
  }
  Future<double>getdistance(double startLatitude,double startLongitude,double endLatitude,double endLongitude)async{
    return (await geolocator.distanceBetween(startLatitude, startLongitude, endLatitude, endLongitude));
  }
}