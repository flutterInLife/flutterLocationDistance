import 'dart:async';

import 'package:flutter/material.dart';
import 'package:geolocator/geolocator.dart';
import 'package:google_maps_flutter/google_maps_flutter.dart';

class LocatingPage extends StatefulWidget {
  @override
  _LocatingPageState createState() => _LocatingPageState();
}

class _LocatingPageState extends State<LocatingPage> {
  Completer<GoogleMapController> _controller = Completer();

  final Set<Marker> _markers = {};

  Future getCurrentLocation() async {
    final GoogleMapController mapController = await _controller.future;
    Position position =
    await getCurrentPosition(desiredAccuracy: LocationAccuracy.high);
    mapController.animateCamera(CameraUpdate.newCameraPosition(
      CameraPosition(
        target: LatLng(position.latitude, position.longitude),
        zoom: 11,
      ),
    ));
    setState(() {
      _markers.add(Marker(
          markerId: MarkerId('Your Location'),
          position: LatLng(position.latitude, position.longitude),
          icon: BitmapDescriptor.defaultMarkerWithHue(100),
          infoWindow: InfoWindow(
            title: 'Your Location',
          ),
          onTap: () {
            mapController
                .animateCamera(CameraUpdate.newCameraPosition(CameraPosition(
              target: LatLng(position.latitude, position.longitude),
              zoom: 13,
            )));
          }),);
    });
  }

  Future getLocations() async {
    await getCurrentLocation();
    final GoogleMapController mapController = await _controller.future;
    setState(() {
      _markers.addAll({
        Marker(
            markerId: MarkerId('Bhaktapur'),
            position: LatLng(27.671022, 85.429817),
            icon: BitmapDescriptor.defaultMarker,
            infoWindow: InfoWindow(
              title: 'Bhaktapur',
            ),
            onTap: () {
              mapController
                  .animateCamera(CameraUpdate.newCameraPosition(CameraPosition(
                target: LatLng(27.671022, 85.429817),
                zoom: 13,
              )));
            }),
        Marker(
            markerId: MarkerId('Lalitpur'),
            position: LatLng(27.6588, 85.3247),
            icon: BitmapDescriptor.defaultMarker,
            infoWindow: InfoWindow(
              title: 'Lalitpur',
            ),
            onTap: () {
              mapController
                  .animateCamera(CameraUpdate.newCameraPosition(CameraPosition(
                target: LatLng(27.6588, 85.3247),
                zoom: 13,
              )));
            }),
      });
    });
  }

  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    getCurrentLocation();
    getLocations();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Geo Location'),
        elevation: 0,
        centerTitle: true,
      ),
      body: Stack(
        children: [
          GoogleMap(
            mapType: MapType.normal,
            initialCameraPosition: CameraPosition(
              target: LatLng(28.3949, 84.1240),
              zoom: 6,
            ),
            onMapCreated: (GoogleMapController controller) {
              _controller.complete(controller);
            },
            zoomControlsEnabled: false,
            markers: _markers,
          ),
          Align(
            alignment: Alignment.topRight,
            child: Padding(
              padding: const EdgeInsets.all(20),
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
