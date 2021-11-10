import 'package:flutter_polyline_points/flutter_polyline_points.dart';
import 'package:google_maps_flutter/google_maps_flutter.dart';
import 'package:location/location.dart';
import 'package:flutter/material.dart';
import 'package:my_app/features/map/domain/usecases/LocationProvider.dart';
import 'dart:async';

import 'package:provider/provider.dart';

const double CAMERA_ZOOM = 16;
const double CAMERA_TILT = 10;
const double CAMERA_BEARING = 30;
const LatLng SOURCE_LOCATION = LatLng(34.020882, -6.841650);

class MapPage extends StatefulWidget {
  double width;
  double height;
  MapPage(this.height, this.width);
  @override
  State<StatefulWidget> createState() => MapPageState(height, width);
}

class MapPageState extends State<MapPage> {
  double widSize;
  double heiSize;
  MapPageState(this.heiSize, this.widSize);
  GoogleMapController? mapController;

  LocationData? currentLocation;
  Completer<GoogleMapController> _controller = Completer();
  Marker? _markers;
  BitmapDescriptor? sourceIcon;
  var pinPosition;
  @override
  void initState() {
    super.initState();

    // Provider.of<LocationProvider>(context, listen: false).initialization();
  }

  /*location.onLocationChanged.listen((LocationData cLoc) {
      currentLocation = cLoc;
      /* print(
          "this is longitude ============================> ${currentLocation!.longitude}");
      print(
          "this is latitude ============================> ${currentLocation!.latitude}");
      print(
          "this is altitude ============================> ${currentLocation!.altitude}");
      print(
          "this is speed ============================> ${currentLocation!.speed}");ù*/
    });*/

  /* void showPinsOnMap() {
    // get a LatLng for the source location
    // from the LocationData currentLocation object
    setState(() {
      var pinPosition =
          LatLng(currentLocation!.latitude!, currentLocation!.longitude!);
      // get a LatLng out of the LocationData object
      // add the initial source location pin
      _markers = Marker(
        markerId: MarkerId('sourcePin'),
        position: pinPosition,
        icon: BitmapDescriptor.defaultMarkerWithHue(BitmapDescriptor.hueRed),
      );
    });

    // destination pin
  }*/

  @override
  Widget build(BuildContext context) {
    /*  CameraPosition initialCameraPosition = CameraPosition(
        zoom: CAMERA_ZOOM,
        tilt: CAMERA_TILT,
        bearing: CAMERA_BEARING,
        target: SOURCE_LOCATION);

    if (currentLocation != null) {
      initialCameraPosition = CameraPosition(
          target:
              LatLng(currentLocation!.latitude!, currentLocation!.longitude!),
          zoom: CAMERA_ZOOM,
          tilt: CAMERA_TILT,
          bearing: CAMERA_BEARING);
    }*/

    return Consumer<LocationProvider>(
      builder: (context, loc, _) {
        if (loc.location != null) {
          return Align(
            alignment: Alignment.topCenter,
            child: Container(
              decoration: BoxDecoration(
                boxShadow: [
                  BoxShadow(
                      color: Colors.blueGrey,
                      offset: Offset(1.5, 2),
                      // spreadRadius: 3.0,
                      blurRadius: 5.5)
                ],
                borderRadius: BorderRadius.all(Radius.circular(10.0)),
              ),
              margin: EdgeInsets.only(bottom: 10),
              width: widSize * 0.90,
              height: heiSize * 0.70,
              child: ClipRRect(
                borderRadius: BorderRadius.all(Radius.circular(10.0)),
                child: GoogleMap(
                  zoomControlsEnabled: true,
                  zoomGesturesEnabled: true,
                  scrollGesturesEnabled: true,
                  myLocationButtonEnabled: true,
                  myLocationEnabled: true,
                  tiltGesturesEnabled: true,
                  markers: Set.of((_markers != null) ? [_markers!] : []),
                  mapType: MapType.normal,
                  initialCameraPosition: CameraPosition(
                      target: loc.locationPosition,
                      //LatLng(currentLocation!.latitude!, currentLocation!.longitude!),
                      zoom: CAMERA_ZOOM,
                      tilt: CAMERA_TILT,
                      bearing: CAMERA_BEARING),
                  onMapCreated: (GoogleMapController controller) {
                    _controller.complete(controller);

                    /*  void showPinsOnMap() {
                      // get a LatLng for the source location
                      // from the LocationData currentLocation object
                      setState(() {
                        var pinPosition = loc.locationPosition;
                        // get a LatLng out of the LocationData object
                        // add the initial source location pin
                        _markers = Marker(
                          markerId: MarkerId('sourcePin'),
                          position: pinPosition,
                          icon: BitmapDescriptor.defaultMarkerWithHue(
                              BitmapDescriptor.hueRed),
                        );
                      });
                    }

                    showPinsOnMap();*/
                  },
                ),
              ),
            ),
          );
        }

        return Center(
          child: Container(
              padding: EdgeInsets.only(top: 30),
              child: CircularProgressIndicator(
                valueColor:
                    new AlwaysStoppedAnimation<Color>(Color(0xff52B69A)),
              )),
        );
      },
    );
  }
}
