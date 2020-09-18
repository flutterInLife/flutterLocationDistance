// import 'package:LocationSuggestor/location.dart';
import 'package:LocationSuggestor/locatingProcess/locationList.dart';
import 'package:flutter/material.dart';
import 'package:geolocator/geolocator.dart';

//Hello Branch

LocationList loc = LocationList();

class LocatingPage extends StatefulWidget {
  @override
  _LocatingPageState createState() => _LocatingPageState();
}

class _LocatingPageState extends State<LocatingPage> {
  double latitudes,
      longitudes,
      distanceInMeter,
      endLatitude,
      endLongitude,
      shortestDistance;

  List<double> distanceList = [];

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

  void updateEndLocation() {
    try {
      setState(() {
        endLatitude = loc.getNextLatitude();
        endLongitude = loc.getNextLongitude();
        print('endLatitude $endLatitude and endLongitude $endLongitude');
        loc.nextLocation();
      });
    } catch (e) {
      print(e);
    }
  }

  void sortingDistance() {
    distanceList.sort();
    print(distanceList);
    setState(() {
      shortestDistance = distanceList[0];
    });
    print('shortest distance is $shortestDistance');
  }

  void measureDistance() {
    // startLatitude	double	Latitude of the start position
    // startLongitude	double	Longitude of the start position
    // endLatitude	double	Latitude of the destination position
    // endLongitude	double	Longitude of the destination position
    try {
      double distanceInMeters =
          distanceBetween(latitudes, longitudes, endLatitude, endLongitude);
      print('distance $distanceInMeters');
      setState(() {
        distanceList.add(distanceInMeters);
      });
      if (distanceInMeters != null) {
        setState(() {
          distanceInMeter = distanceInMeters;
        });
        print('distance list is $distanceList');
      }
    } catch (e) {
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
        body: ListView(
          scrollDirection: Axis.horizontal,
          padding: EdgeInsets.all(10.0),
          children: <Widget>[
            Center(
              child: Column(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  Padding(
                    padding: const EdgeInsets.all(8.0),
                    child: Container(
                      margin: EdgeInsets.all(1),
                      decoration: BoxDecoration(
                        color: Colors.lightGreen,
                        borderRadius: BorderRadius.circular(15.0),
                      ),
                      height: 50,
                      // color: Colors.lightGreen,
                      child: Padding(
                        padding: const EdgeInsets.all(8.0),
                        child:
                            Text('longitude: $longitudes latitude:$latitudes'),
                      ),
                    ),
                  ),
                  Padding(
                    padding: const EdgeInsets.all(8.0),
                    child: Container(
                      margin: EdgeInsets.all(1),
                      decoration: BoxDecoration(
                        color: Colors.amber,
                        borderRadius: BorderRadius.circular(15.0),
                      ),
                      height: 50,
                      // color: Colors.amber,
                      child: Padding(
                        padding: const EdgeInsets.all(8.0),
                        child: Text('distace: $distanceInMeter'),
                      ),
                    ),
                  ),
                  Padding(
                    padding: const EdgeInsets.all(8.0),
                    child: Text('nearest location is $shortestDistance'),
                  ),
                  Row(
                    children: [Text(distanceList.toString())],
                  )
                ],
              ),
            ),
          ],
        ),
        floatingActionButton: Stack(
          children: <Widget>[
            Padding(
              padding: EdgeInsets.only(left: 31),
              child: Align(
                alignment: Alignment.bottomLeft,
                child: FloatingActionButton.extended(
                  heroTag: 'one',
                  onPressed: () {
                    sortingDistance();
                  },
                  label: Text('search nearest'),
                  icon: Icon(Icons.search),
                ),
              ),
            ),
            Align(
              alignment: Alignment.bottomRight,
              child: FloatingActionButton.extended(
                heroTag: 'two',
                onPressed: () {
                  updateEndLocation();

                  measureDistance();
                },
                label: Text('add location'),
                icon: Icon(Icons.add_circle),
                backgroundColor: Colors.green,
              ),
            ),
          ],
        ));
  }
}
