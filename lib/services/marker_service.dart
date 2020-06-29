import 'package:google_maps_flutter/google_maps_flutter.dart';
import 'package:parkingapp/models/place.dart';

class MarkerServices{
  List<Marker>getmarker(List<place> places){
    var markers=List<Marker>();//a list for markers
    places.forEach((place) {
      Marker marker=Marker(
        visible: true,
          markerId: MarkerId(place.name),
          draggable: false,
        position: LatLng(place.geometry.Location.lat,place.geometry.Location.lng),
        infoWindow: InfoWindow(title: place.name,snippet: place.vicinity)
      );
      markers.add(marker);
    });
    return markers;
  }
}