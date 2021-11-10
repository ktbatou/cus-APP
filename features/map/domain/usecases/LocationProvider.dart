import 'package:flutter/cupertino.dart';
import 'package:provider/provider.dart';
import 'package:location/location.dart';
import 'package:google_maps_flutter/google_maps_flutter.dart';

class LocationProvider with ChangeNotifier {
  Location _location = new Location();
  Location get location => _location;

  final MarkerId markerId = MarkerId("1");
  Map<MarkerId, Marker> _markers = <MarkerId, Marker>{};
  Map<MarkerId, Marker> get markers => _markers;

  LatLng _locationPosition = LatLng(34.020882, -6.841650);
  LatLng get locationPosition => _locationPosition;

  GoogleMapController? _mapController;
  GoogleMapController get mapController => _mapController!;

  initialization() async {
    await userLocation();
  }

  userLocation() async {
    bool _serviceEnabled;
    PermissionStatus _permissionGranted;

    _serviceEnabled = await location.serviceEnabled();
    if (!_serviceEnabled) {
      _serviceEnabled = await location.requestService();
      if (!_serviceEnabled) {
        return;
      }
    }

    _permissionGranted = await location.hasPermission();
    if (_permissionGranted == PermissionStatus.denied) {
      _permissionGranted = await location.requestPermission();
      if (_permissionGranted != PermissionStatus.granted) {
        return;
      }
    }

    location.onLocationChanged.listen((LocationData currentLocation) {
      _locationPosition =
          LatLng(currentLocation.altitude!, currentLocation.altitude!);
      _markers.clear();
      Marker marker = Marker(
        markerId: markerId,
        position: LatLng(
          currentLocation.latitude!,
          currentLocation.longitude!,
        ),
        icon: BitmapDescriptor.defaultMarkerWithHue(BitmapDescriptor.hueRed),
      );

      _markers[markerId] = marker;
      notifyListeners();
    });
  }

  setMapController(GoogleMapController controller) {
    _mapController = controller;
    notifyListeners();
  }
}
