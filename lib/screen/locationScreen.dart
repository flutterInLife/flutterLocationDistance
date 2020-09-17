import 'package:flutter/material.dart';
import 'package:geolocator/geolocator.dart';
import 'package:google_maps_flutter/google_maps_flutter.dart';

class LocatingPage extends StatefulWidget {
  @override
  _LocatingPageState createState() => _LocatingPageState();
}

class _LocatingPageState extends State<LocatingPage> {

  GoogleMapController mapController;

  getCurrentLocation() async {
    Position position = await getCurrentPosition(desiredAccuracy: LocationAccuracy.high);
    mapController.animateCamera(CameraUpdate.newCameraPosition(CameraPosition(
      target: LatLng(position.latitude, position.longitude),
      zoom: 17,
    ),));
  }

  _onMapCreated(GoogleMapController controller) {
    setState(() {
      mapController = controller;
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Geo Location'),
        elevation: 0,
      ),
      body: Stack(
        children: [
          GoogleMap(
            mapType: MapType.normal,
            initialCameraPosition: CameraPosition(
              target: LatLng(37.42796133580664, -122.085749655962),
              zoom: 14.4746,
            ),
            onMapCreated: _onMapCreated,
            zoomControlsEnabled: false,
          ),
          Align(
            alignment: Alignment.bottomRight,
            child: Padding(
              padding: const EdgeInsets.all(10),
              child: FloatingActionButton(
                elevation: 0,
                child: Icon(Icons.location_on),
                onPressed: getCurrentLocation,
              ),
            ),
          )
        ],
      ),
    );
  }
}
