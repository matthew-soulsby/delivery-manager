import 'package:delivery_manager_app/assets/loading_spinner.dart';
import 'package:delivery_manager_app/classes/delivery.dart';
import 'package:flutter/material.dart';
import 'package:google_maps_flutter/google_maps_flutter.dart';
import 'package:isar/isar.dart';
import 'package:location/location.dart';

class RouteVisualiser extends StatefulWidget {
  const RouteVisualiser(
      {super.key, required this.isar, required this.deliveries});

  final Isar isar;

  final List<Delivery> deliveries;

  @override
  State<RouteVisualiser> createState() => _RouteVisualiserState();
}

class _RouteVisualiserState extends State<RouteVisualiser> {
  late GoogleMapController mapController;
  LocationData? _currentLocation;

  final LatLng _center = const LatLng(45.521563, -122.677433);

  void _onMapCreated(GoogleMapController controller) {
    mapController = controller;
  }

  void refreshLocation() async {
    Location location = new Location();

    bool _serviceEnabled;
    PermissionStatus _permissionGranted;
    LocationData _locationData;

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

    location.getLocation().then((location) {
      setState(() {
        _currentLocation = location;
      });
    });
  }

  @override
  void initState() {
    super.initState();

    refreshLocation();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Route'),
      ),
      body: (_currentLocation == null)
          ? Center(
              child: loadingSpinner(
                alignment: MainAxisAlignment.center,
              ),
            )
          : GoogleMap(
              onMapCreated: _onMapCreated,
              initialCameraPosition: CameraPosition(
                target: LatLng(_currentLocation!.latitude ?? 0,
                    _currentLocation!.longitude ?? 0),
                zoom: 13.0,
              ),
            ),
      bottomSheet: Container(
        child: Text('Bottom Sheet'),
      ),
    );
  }
}
