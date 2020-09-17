// import 'package:LocationSuggestor/location.dart';
import 'package:flutter/material.dart';
import 'package:geolocator/geolocator.dart';

//Hello Branch

class LocatingPage extends StatefulWidget {
  @override
  _LocatingPageState createState() => _LocatingPageState();
}

class _LocatingPageState extends State<LocatingPage> {
  double latitudes, longitudes, distanceInMeter, endLatitude, endLongitude;

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

  Container measureDistance() {
    // startLatitude	double	Latitude of the start position
    // startLongitude	double	Longitude of the start position
    // endLatitude	double	Latitude of the destination position
    // endLongitude	double	Longitude of the destination position
    try {
      double distanceInMeters =
          distanceBetween(latitudes, longitudes, 52.3546274, 4.8285838);
      print('distance $distanceInMeters');
      if (distanceInMeters != null) {
        setState(() {
          distanceInMeter = distanceInMeters;
          distanceList.add(distanceInMeters);
        });
        print('distance list is $distanceList');
      }
    } catch (e) {
      print(e);
    }
    return Container(
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
    );
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
                    child: measureDistance(),
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
                  onPressed: null,
                  label: Text('search nearest'),
                  icon: Icon(Icons.search),
                ),
              ),
            ),
            Align(
              alignment: Alignment.bottomRight,
              child: FloatingActionButton.extended(
                heroTag: 'two',
                onPressed: null,
                label: Text('add location'),
                icon: Icon(Icons.add_circle),
                backgroundColor: Colors.green,
              ),
            ),
          ],
        )

        // FloatingActionButton.extended(
        //   heroTag: 'button1',
        //   onPressed: null,
        //   label: Text('add location'),
        //   icon: Icon(Icons.add_circle),
        //   backgroundColor: Colors.green,
        // ),
        //   FloatingActionButton(
        //   heroTag: 'button2',
        //   onPressed: null,
        //   child: Icon(Icons.add_circle),
        //   backgroundColor: Colors.green,
        // ),
        );
  }
}
