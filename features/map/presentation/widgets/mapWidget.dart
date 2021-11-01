import 'package:flutter/material.dart';
import 'package:my_app/features/map/domain/usecases/LocationProvider.dart';
import 'package:provider/provider.dart';
import 'package:google_maps_flutter/google_maps_flutter.dart';
import 'dart:async';

class MapWidget extends StatefulWidget {
  double width;
  double height;
  double heightMap;
  MapWidget(this.height, this.width, this.heightMap);

  @override
  _MapWidgetState createState() => _MapWidgetState(height, width, heightMap);
}

class _MapWidgetState extends State<MapWidget> {
  double widSize;
  double heiSize;
  double heightMap;

  _MapWidgetState(this.heiSize, this.widSize, this.heightMap);
  // GoogleMapController? _controller;

  Completer<GoogleMapController> _controller = Completer();
  Marker? _markers;

  @override
  Widget build(BuildContext context) {
    heiSize = widget.height;
    widSize = widget.width;
    heightMap = widget.heightMap;

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
              margin: EdgeInsets.only(bottom: 15),
              width: widSize * 0.90,
              height: heiSize * heightMap,
              child: ClipRRect(
                borderRadius: BorderRadius.all(Radius.circular(10.0)),
                child: GoogleMap(
                  myLocationButtonEnabled: true,
                  myLocationEnabled: true,
                  tiltGesturesEnabled: true,
                  markers: Set.of((_markers != null) ? [_markers!] : []),
                  mapType: MapType.normal,
                  initialCameraPosition: CameraPosition(
                    target: LatLng(34.020882, -6.841650),
                    zoom: 16,
                    //   tilt: CAMERA_TILT,
                    //   bearing: CAMERA_BEARING
                  ),
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
