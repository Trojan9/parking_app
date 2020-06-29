import 'package:parkingapp/models/geometry.dart';

class place{
  final String name;
  final double rating;
  final int user_ratings_total;
  final Geometry geometry;
  final String vicinity;
  place(this.geometry,this.name,this.rating,this.user_ratings_total,this.vicinity);
  place.fromJson(Map<dynamic,dynamic>parsedJson)
  :name=parsedJson['name'],
    rating=(parsedJson['rating']!=null)?parsedJson['rating'].toDouble():null,
    user_ratings_total=(parsedJson['user_ratings_total']!=null)?parsedJson['user_ratings_total']:null,
    vicinity=parsedJson['vicinity'],
    geometry= Geometry.fromJson(parsedJson['geometry']);
}