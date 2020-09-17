import 'locationFormat.dart';

class LocationList{

  int _nextLocation = 0;

  List<LocationFormat> _locationList = [

    LocationFormat(342.243, 434.24424),
    LocationFormat(342.243, 434.24424),
    LocationFormat(342.243, 434.24424),
    LocationFormat(342.243, 434.24424),
    LocationFormat(342.243, 434.24424),
    LocationFormat(342.243, 434.24424),
    LocationFormat(342.243, 434.24424),
    LocationFormat(342.243, 434.24424),

  ];
  void nextLocation(){
    if(_nextLocation<_locationList.length -1) {
      _nextLocation++;
    }
  }

  double getNextLatitude(){
    return _locationList[_nextLocation].endLatitude;
  }

  double getNextLongitude(){
    return _locationList[_nextLocation].endLongitude;
  }
}