class location{
  final double lat;
  final double lng;
  location({this.lat,this.lng});
  location.fromJson(Map<dynamic,dynamic>parsedJson)
      :lat=parsedJson['lat'],
        lng=parsedJson['lng'];
}