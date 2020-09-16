import 'package:LocationSuggestor/location.dart';
import 'package:flutter/material.dart';
import 'package:geolocator/geolocator.dart';

class LocatingPage extends StatefulWidget {
  @override
  _LocatingPageState createState() => _LocatingPageState();
}

class _LocatingPageState extends State<LocatingPage> {
  double latitude;
  double longitude;

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

  methodnone() async {
    Location location = Location();
    await location.getCurrentLocation();
    print(location);
  }

  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    // methodnone();
    getCurrentLocation();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Sanjiv Push'),
      ),
      body: Center(
        child: Container(
          color: Colors.white,
          child: Text('longitude: $longitude latitude:$latitude'),
        ),
      ),
    );
  }
}
