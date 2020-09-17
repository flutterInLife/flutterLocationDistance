// import 'package:LocationSuggestor/location.dart';
import 'package:flutter/material.dart';
import 'package:geolocator/geolocator.dart';

//Hello Branch

class LocatingPage extends StatefulWidget {
  @override
  _LocatingPageState createState() => _LocatingPageState();
}

class _LocatingPageState extends State<LocatingPage> {
  double latitudes;
  double longitudes;
  double distanceInMeter;

  Future<void> getCurrentLocation() async {
    try {
      Position position =
          await getCurrentPosition(desiredAccuracy: LocationAccuracy.high);

      latitudes = position.latitude;
      longitudes = position.longitude;

      print(position);
    } catch (e) {
      print(e);
    }
  }

  Container measureDistance() {
    // startLatitude	double	Latitude of the start position
    // startLongitude	double	Longitude of the start position
    // endLatitude	double	Latitude of the destination position
    // endLongitude	double	Longitude of the destination position
    try{
      double distanceInMeters = distanceBetween(latitudes, longitudes, 52.3546274, 4.8285838);
      print('distance $distanceInMeters');
      if(distanceInMeters!=null){
        setState(() {
          distanceInMeter = distanceInMeters;
        });

      }
    }catch(e){
      print(e);
    }
    return Container(color: Colors.amber,
      child: Text('distace: $distanceInMeter'),);
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
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Container(
              color: Colors.lightGreen,
              child: Text('longitude: $longitudes latitude:$latitudes'),
            ),
            measureDistance(),
          ],
        ),
      ),
    );
  }


}
