import 'package:LocationSuggestor/location.dart';
import 'package:flutter/material.dart';
import 'package:geolocator/geolocator.dart';

//Hello Branch

class LocatingPage extends StatefulWidget {
  @override
  _LocatingPageState createState() => _LocatingPageState();
}

class _LocatingPageState extends State<LocatingPage> {
  double latitude;
  double longitude;
  double distanceInMeter;

  Future<void> getCurrentLocation() async {
    try {
      Position position =
          await getCurrentPosition(desiredAccuracy: LocationAccuracy.high);

      latitude = position.latitude;
      longitude = position.longitude;

      print(latitude);
    } catch (e) {
      print(e);
    }
  }

  Future<void> measureDistance() async{
    // startLatitude	double	Latitude of the start position
    // startLongitude	double	Longitude of the start position
    // endLatitude	double	Latitude of the destination position
    // endLongitude	double	Longitude of the destination position
    try{
      double distanceInMeters = distanceBetween(latitude, longitude, 52.3546274, 4.8285838);
      print('distance $distanceInMeters');
      if(distanceInMeters!=null){
        setState(() {
          distanceInMeter = distanceInMeters;
        });
        return Container(child: Text('$distanceInMeters'),);

      }
    }catch(e){
      print(e);
    }
  }



  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    // methodnone();
    getCurrentLocation();
    measureDistance();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Distance between two location'),
      ),
      body: Center(
        child: Column(
          children: [
            Container(
              color: Colors.lightGreen,
              child: Text('longitude: $longitude latitude:$latitude'),
            ),
            Container(color: Colors.amber,
            child: Text('distace: $distanceInMeter'),),
          ],
        ),
      ),
    );
  }
}
