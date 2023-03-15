import 'dart:async';
import 'package:flutter/foundation.dart';
import 'package:flutter/gestures.dart';
import 'package:flutter/material.dart';
import 'package:google_maps_flutter/google_maps_flutter.dart';
import 'package:geolocator/geolocator.dart';
import 'package:soil_app/utils/location.dart';

class GetMap extends StatefulWidget {
  const GetMap({Key? key}) : super(key: key);

  @override
  State<GetMap> createState() => GetMapState();
}

class GetMapState extends State<GetMap> {
  Completer<GoogleMapController> _controller = Completer();

  static final CameraPosition _initialLoc = CameraPosition(
    target: LatLng(43.53279948175861, -80.22643789240361),
    zoom: 14.00,
  );

  var _locationStatus = 0;
  Set<Marker> _markers = Set<Marker>();

  void _setMarker(LatLng point) {
    setState(() {
      _markers.add(Marker(
        markerId: MarkerId('marker'),
        position: point,
        icon: BitmapDescriptor.defaultMarker,
      ));
    });
  }

  void get_location() async {
    setState(() async {
      List location = await LocationServices().getLocation();
      LatLng currentLocation = LatLng(location[0], location[1]);
      _locationStatus = 1;
      _setMarker(currentLocation);
      _goLocation(currentLocation);
    });
  }

  @override
  void initState() {
    super.initState();
    get_location();
  }

  @override
  Widget build(BuildContext context) {
    return new SizedBox(
      height: MediaQuery.of(context).size.height * 0.4,
      child: Stack(
        children: [
          GoogleMap(
            gestureRecognizers: <Factory<OneSequenceGestureRecognizer>>[
              new Factory<OneSequenceGestureRecognizer>(
                () => new EagerGestureRecognizer(),
              ),
            ].toSet(),
            mapType: MapType.hybrid,
            initialCameraPosition: _initialLoc,
            onMapCreated: (GoogleMapController controller) {
              _controller.complete(controller);
            },
            markers: _markers,
          ),

          // Display latitude and longitude of the location
          (_locationStatus == 1)
              ? Container(
                  alignment: Alignment.bottomCenter,
                  child: Text(
                    '"Current Location: "+${_markers.elementAt(0).position.latitude}, ${_markers.elementAt(0).position.longitude}',
                    style: TextStyle(
                        color: Colors.black, fontWeight: FontWeight.bold),
                  ),
                )
              : Container(),
        ],
      ),
    );
  }

  Future<void> _goLocation(LatLng point) async {
    final GoogleMapController controller = await _controller.future;
    controller.animateCamera(CameraUpdate.newCameraPosition(CameraPosition(
      target: point,
      zoom: 17.00,
    )));
  }
}
