import 'package:LocationSuggestor/screen/locationScreen.dart';
import 'package:flutter/material.dart';
import 'package:flutter_spinkit/flutter_spinkit.dart';
import 'package:geolocator/geolocator.dart';

class LoadingScreen extends StatefulWidget {
  @override
  _LoadingScreenState createState() => _LoadingScreenState();
}

class _LoadingScreenState extends State<LoadingScreen> {
  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    getLocationPermission();

  }

  getLocationPermission() async {
    LocationPermission permission = await requestPermission();
    Navigator.pushReplacement(
      context,
      MaterialPageRoute(
        builder: (context) => LocatingPage(),
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SpinKitDoubleBounce(
        color: Colors.white,
        size: 100.0,
        // duration: const Duration(seconds: 3),
      ),
    );
  }
}
