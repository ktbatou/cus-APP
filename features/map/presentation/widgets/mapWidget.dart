import 'package:sensors/sensors.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:location/location.dart';
import 'package:my_app/features/map/domain/usecases/LocationProvider.dart';
import 'package:provider/provider.dart';
import 'package:google_maps_flutter/google_maps_flutter.dart';
import 'dart:async';

class MapWidget extends StatefulWidget {
  double width;
  double height;
  double heightMap;
  String id;
  MapWidget(this.height, this.width, this.heightMap, this.id);

  @override
  _MapWidgetState createState() =>
      _MapWidgetState(height, width, heightMap, id);
}

class _MapWidgetState extends State<MapWidget> {
  double widSize;
  double heiSize;
  double heightMap;
  String id;
  _MapWidgetState(this.heiSize, this.widSize, this.heightMap, this.id);

  GoogleMapController? _controller;
  Marker? _markers;
  var i = 0;
  @override
  void initState() {
    //TODO: implement initState
    super.initState();
    Map collector = {};
    Map acceleration = {};
    Provider.of<LocationProvider>(context, listen: false).initialization();
    Location location =
        Provider.of<LocationProvider>(context, listen: false).location;
    location.onLocationChanged.listen((LocationData currentLocation) async {
      collector.addAll({
        '${DateTime.now().hour}:${DateTime.now().minute}:${DateTime.now().second}':
            {
          'longitude': currentLocation.longitude,
          'latitude': currentLocation.latitude,
          'altitude': currentLocation.altitude,
          'speed': currentLocation.speed,
          'HDOP': currentLocation.accuracy,
          'NSAT': currentLocation.satelliteNumber,
        }
      });
    });

    accelerometerEvents.listen((AccelerometerEvent event) async {
      acceleration.addAll({
        '${DateTime.now().hour}:${DateTime.now().minute}:${DateTime.now().second}':
            {'x': event.x, 'y': event.y, 'z': event.z}
      });
    });

    Timer.periodic(Duration(minutes: 3), (Timer t) {
      FirebaseFirestore.instance.collection('trips').doc(id).set({
        'Acceleration': {
          '${DateTime(DateTime.now().year, DateTime.now().month, DateTime.now().day)}':
              {
            '${DateTime.now().hour}:${DateTime.now().minute}': acceleration,
          },
        }
      }, SetOptions(merge: true));
      tracker(collector);
      collector.clear();
      acceleration.clear();
    });
  }

  void tracker(Map collector) async {
    //  print(collector);
    FirebaseFirestore.instance.collection('trips').doc(id).set({
      'GPS-DATA': {
        '${DateTime(DateTime.now().year, DateTime.now().month, DateTime.now().day)}':
            {
          '${DateTime.now().hour}:${DateTime.now().minute}': collector,
        },
      }
    }, SetOptions(merge: true));
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
