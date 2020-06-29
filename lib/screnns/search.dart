import 'package:flutter/material.dart';
import 'package:flutter_rating_bar/flutter_rating_bar.dart';
import 'package:geolocator/geolocator.dart';
import 'package:google_maps_flutter/google_maps_flutter.dart';
import 'package:parkingapp/models/place.dart';
import 'package:parkingapp/services/geolocator.dart';
import 'package:parkingapp/services/places_services.dart';
import 'package:provider/provider.dart';
import 'package:url_launcher/url_launcher.dart';
import '../services/marker_service.dart';
class search extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    final currentposition=Provider.of<Position>(context);
    final placeprovider=Provider.of<Future<List<place>>>(context);
    final geoservice=geolocatorservice();
    final markerServices=MarkerServices();
    return FutureProvider(
      create:(context) => placeprovider,
      child: Scaffold(
        body: (currentposition!=null)?
        Consumer<List<place>>(
        builder:(_, places, __){
          var marker=(places!=null)? markerServices.getmarker(places):List<Marker>();
          return (places!=null)? Column(
          children: [
            Container(
              width: MediaQuery.of(context).size.width,
              height: MediaQuery.of(context).size.height/2.5,
              child: GoogleMap(
                initialCameraPosition: CameraPosition(target: LatLng(currentposition.latitude,currentposition.longitude),
                zoom: 16.0),
                zoomGesturesEnabled: true,
                markers: Set<Marker>.of(marker),
              ),
            ),
            SizedBox(height: 10.0,),
            Expanded(child: ListView.builder(
                itemCount: places.length,
                itemBuilder: (context,index){
                  return FutureProvider(
                    create: (context)=>geoservice.getdistance(
                        currentposition.latitude,
                        currentposition.longitude,
                        places[index].geometry.Location.lat,
                        places[index].geometry.Location.lng),
                    child: Card(
                      child: ListTile(
                        title: Text(places[index].name),
                      subtitle: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          (places[index].rating!=null)? Row(
                            children: [
                              RatingBarIndicator(
                                rating: places[index].rating,
                                itemCount: 5,
                                itemSize: 10.0,
                                itemBuilder: (context,index)=>Icon(Icons.star,color: Colors.amber,),
                              ),
                            ],
                          ):Row(),
                          Consumer<double>
                            (builder: (context,meters,wiget){
                            return (meters!=null)?Text('${places[index].vicinity} \u00b7 ${(meters/1609).round()} mi'):Container();
                          }),
                        ],
                      ),
                        trailing: IconButton(icon: Icon(Icons.directions),
                            color: Theme.of(context).primaryColor,
                            onPressed: (){
                          _lunchurl(places[index].geometry.Location.lat,places[index].geometry.Location.lng);

                            }
                        ),
                      ),
                    ),
                  );
                }
                )
            ),
          ],
        ):Center(child: CircularProgressIndicator());
        },
        ):
    Center(child: CircularProgressIndicator(),)
      ),
    );
  }
  void _lunchurl(double lat,double lng)async{
    final url='http://www.google.com/maps/search/?api=1&query=$lat,$lng';
    if(await canLaunch(url)){
      await(launch(url));
    }else{
      throw "Could not launch $url";
    }
  }
}
