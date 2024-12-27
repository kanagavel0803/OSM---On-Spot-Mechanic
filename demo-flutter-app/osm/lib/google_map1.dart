import 'dart:async'; // Add this import for StreamSubscription
import 'package:flutter/material.dart';
import 'package:google_maps_flutter/google_maps_flutter.dart';
import 'package:geocoding/geocoding.dart';
import 'package:geolocator/geolocator.dart';
import 'user_navbar1.dart';
import 'user_vehicle.dart';

class GoogleMapPage extends StatefulWidget {
  @override
  GoogleMapPageState createState() => GoogleMapPageState();
}

class GoogleMapPageState extends State<GoogleMapPage> {
  GoogleMapController? mapController;
  final LatLng _center = const LatLng(11.1271, 78.6569);
  Marker? _selectedMarker;
  String cityName = "Unknown";
  LatLng? _markerPosition;
  bool _showCustomInfoWindow = false;
  TextEditingController _searchController = TextEditingController();
  Marker? _userLocationMarker;
  StreamSubscription<Position>? _positionStreamSubscription;

  @override
  void initState() {
    super.initState();
    _getUserLocation();
    _startListeningToLocation();
  }

  @override
  void dispose() {
    _searchController.dispose();
    _positionStreamSubscription?.cancel();
    mapController?.dispose(); // Dispose of the map controller
    super.dispose();
  }

  void _onMapCreated(GoogleMapController controller) {
    mapController = controller;
  }

  Future<void> _getUserLocation() async {
    bool serviceEnabled;
    LocationPermission permission;

    serviceEnabled = await Geolocator.isLocationServiceEnabled();
    if (!serviceEnabled) {
      // Location services are not enabled, handle this case.
      return;
    }

    permission = await Geolocator.checkPermission();
    if (permission == LocationPermission.denied) {
      permission = await Geolocator.requestPermission();
      if (permission == LocationPermission.denied) {
        // Permissions are denied, handle this case.
        return;
      }
    }

    if (permission == LocationPermission.deniedForever) {
      // Permissions are permanently denied, handle appropriately.
      return;
    }

    Position position = await Geolocator.getCurrentPosition(
      desiredAccuracy: LocationAccuracy.high,
    );

    _addUserMarker(LatLng(position.latitude, position.longitude));
  }

  Future<void> _getCityName(LatLng position) async {
    try {
      List<Placemark> placemarks = await placemarkFromCoordinates(
        position.latitude,
        position.longitude,
      );

      setState(() {
        cityName = placemarks[0].locality ?? "Unknown";
      });
    } catch (e) {
      print(e);
      setState(() {
        cityName = "Error getting city name";
      });
    }
  }

  void _addMarker(LatLng position) async {
    await _getCityName(position);
    setState(() {
      _markerPosition = position;
      _selectedMarker = Marker(
        markerId: MarkerId('selected_marker'),
        position: position,
        infoWindow: InfoWindow(
          title: cityName,
          snippet: 'Confirm Location',
          onTap: () {
            setState(() {
              _showCustomInfoWindow = true;
            });
          },
        ),
      );
    });
  }

  void _addUserMarker(LatLng position) {
    setState(() {
      _userLocationMarker = Marker(
        markerId: MarkerId('user_location'),
        position: position,
        infoWindow: InfoWindow(title: 'Your Location'),
        icon: BitmapDescriptor.defaultMarkerWithHue(BitmapDescriptor.hueAzure),
      );

      mapController?.animateCamera(
        CameraUpdate.newLatLngZoom(position, 14.0),
      );
    });
  }

  void _onDoubleTap(LatLng position) {
    _addMarker(position);
  }

  void _searchAndNavigate(String searchText) async {
    try {
      List<Location> locations = await locationFromAddress(searchText);
      if (locations.isNotEmpty) {
        mapController?.animateCamera(CameraUpdate.newLatLng(
          LatLng(locations[0].latitude, locations[0].longitude),
        ));
      }
    } catch (e) {
      print("Error searching: $e");
    }
  }

  void _navigateToUserVehicle() {
    if (_markerPosition != null) {
      Navigator.push(
        context,
        MaterialPageRoute(
          builder: (context) => UserVehicle(
            confirmedLocation: '${_markerPosition!.latitude}, ${_markerPosition!.longitude}',
          ),
        ),
      );
    }
  }

  void _startListeningToLocation() {
    _positionStreamSubscription = Geolocator.getPositionStream().listen((Position position) {
      _addUserMarker(LatLng(position.latitude, position.longitude));
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      drawer: Navbar1(),
      appBar: AppBar(
        title: Text('Google Map'),
        backgroundColor: Color.fromARGB(255, 31, 157, 161),
      ),
      body: Stack(
        children: [
          GoogleMap(
            onMapCreated: _onMapCreated,
            initialCameraPosition: CameraPosition(
              target: _center,
              zoom: 11.0,
            ),
            markers: {
              if (_selectedMarker != null) _selectedMarker!,
              if (_userLocationMarker != null) _userLocationMarker!,
            },
            onTap: _onDoubleTap,
          ),
          if (_showCustomInfoWindow && _markerPosition != null)
            Positioned(
              top: MediaQuery.of(context).size.height / 2 - 50,
              left: MediaQuery.of(context).size.width / 2 - 75,
              child: CustomInfoWindow(
                cityName: cityName,
                onConfirm: () {
                  _navigateToUserVehicle();
                },
              ),
            ),
          Positioned(
            top: 16.0,
            left: 16.0,
            right: 16.0,
            child: Container(
              decoration: BoxDecoration(
                color: Colors.white,
                borderRadius: BorderRadius.circular(20.0),
              ),
              padding: EdgeInsets.symmetric(horizontal: 16.0),
              child: Row(
                children: [
                  Icon(Icons.search, color: Colors.grey),
                  SizedBox(width: 12.0),
                  Expanded(
                    child: TextField(
                      controller: _searchController,
                      decoration: InputDecoration(
                        hintText: 'Search...',
                        border: InputBorder.none,
                        hintStyle: TextStyle(color: Colors.grey),
                      ),
                      style: TextStyle(color: Colors.black),
                      onChanged: (value) {
                        _searchAndNavigate(value);
                      },
                    ),
                  ),
                ],
              ),
            ),
          ),
          Align(
            alignment: Alignment.bottomCenter,
            child: Padding(
              padding: const EdgeInsets.all(20.0),
              child: FloatingActionButton(
                onPressed: _navigateToUserVehicle,
                child: Text('Go'),
                backgroundColor: Color.fromARGB(255, 31, 157, 161),
              ),
            ),
          ),
        ],
      ),
    );
  }

  // Dummy CustomInfoWindow widget
  Widget CustomInfoWindow({required String cityName, required VoidCallback onConfirm}) {
    return Container(
      color: Colors.white,
      padding: EdgeInsets.all(16.0),
      child: Column(
        mainAxisSize: MainAxisSize.min,
        children: [
          Text(cityName, style: TextStyle(fontSize: 18.0)),
          SizedBox(height: 10.0),
          ElevatedButton(
            onPressed: onConfirm,
            child: Text('Confirm'),
          ),
        ],
      ),
    );
  }
}
