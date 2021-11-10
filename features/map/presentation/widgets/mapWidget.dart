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

  GoogleMapController? _controller;
  Marker? _markers;

  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    Provider.of<LocationProvider>(context, listen: false).initialization();
  }

  void _onMapCreated(GoogleMapController controller) {
    _controller = controller;
  }

  @override
  Widget build(BuildContext context) {
    heiSize = widget.height;
    widSize = widget.width;
    heightMap = widget.heightMap;

    return Consumer<LocationProvider>(builder: (context, model, _) {
      return Align(
        alignment: Alignment.topCenter,
        child: Container(
          decoration: BoxDecoration(
            boxShadow: [
              BoxShadow(
                  color: Colors.blueGrey,
                  offset: Offset(1.5, 2),
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
              zoomControlsEnabled: true,
              scrollGesturesEnabled: true,
              zoomGesturesEnabled: true,
              indoorViewEnabled: true,
              myLocationButtonEnabled: true,
              myLocationEnabled: true,
              tiltGesturesEnabled: true,
              markers: Set<Marker>.of(model.markers
                  .values), //Set.of((_markers != null) ? [_markers!] : []),
              mapType: MapType.normal,
              initialCameraPosition: CameraPosition(
                target: model.locationPosition,
                zoom: 16,
              ),
              onMapCreated: (GoogleMapController controller) async {
                Provider.of<LocationProvider>(context, listen: false)
                    .setMapController(controller);
              },
            ),
          ),
        ),
      );
    }

        /* return Center(
          child: Container(
              padding: EdgeInsets.only(top: 30),
              child: CircularProgressIndicator(
                valueColor:
                    new AlwaysStoppedAnimation<Color>(Color(0xff52B69A)),
              )),
        );*/

        );
  }
}
