import 'package:firebase_database/firebase_database.dart';
import 'package:flutter/material.dart';
import 'package:geolocator/geolocator.dart';
import 'package:google_maps_flutter/google_maps_flutter.dart';
import 'package:http/http.dart' as http;
import 'dart:convert';
import 'package:flutter_polyline_points/flutter_polyline_points.dart';
import 'package:permission_handler/permission_handler.dart';
import 'package:logger/logger.dart';

final logger = Logger();

class MapWithMarkers extends StatefulWidget {
  const MapWithMarkers({Key? key}) : super(key: key);

  @override
  State<MapWithMarkers> createState() => _MapWithMarkersState();
}

class _MapWithMarkersState extends State<MapWithMarkers> {
  late GoogleMapController mapController;
  Set<Marker> markers = {};
  Set<Polyline> polylines = {};
  bool isLoading = false;
  String errorMessage = '';

  @override
  void initState() {
    super.initState();
    requestLocationPermission();
    fetchCoordinates();
    trackUserLocation();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text("Map with Markers"),
        centerTitle: true,
      ),
      body: Stack(
        children: [
          GoogleMap(
            initialCameraPosition: CameraPosition(
              target: const LatLng(51.5, -0.09),
              zoom: 10.0,
            ),
            markers: markers,
            polylines: polylines,
            onMapCreated: (GoogleMapController controller) {
              mapController = controller;
            },
            zoomControlsEnabled: true,
            myLocationButtonEnabled: true,
            myLocationEnabled: true,
            compassEnabled: true,
          ),
          if (isLoading)
            Center(
              child: CircularProgressIndicator(),
            ),
        ],
      ),
    );
  }

  void fetchCoordinates() async {
    final databaseReference = FirebaseDatabase.instance.reference();

    setState(() {
      isLoading = true;
    });

    try {
      databaseReference.child("Global Messages").onValue.listen((event) {
        handleDatabaseEvent(event);
      });
    } catch (error) {
      handleError(error, 'Error fetching data');
    } finally {
      setState(() {
        isLoading = false;
      });
    }
  }

  void handleDatabaseEvent(DatabaseEvent event) async {
    try {
      markers.clear();
      polylines.clear();

      // ignore: unnecessary_null_comparison
      if (event.snapshot == null || event.snapshot.value == null) {
        // Handle the case where snapshot is null or empty
        return;
      }

      LatLng userLocation = await getUserLocation();

      DataSnapshot snapshot = event.snapshot;

      if (snapshot.value is Map) {
        Map<dynamic, dynamic> data = snapshot.value as Map<dynamic, dynamic>;
        data.forEach((key, value) {
          if (value is Map &&
              value.containsKey("latitude") &&
              value.containsKey("longitude")) {
            double? latitude = value["latitude"] as double?;
            double? longitude = value["longitude"] as double?;

            if (latitude != null && longitude != null) {
              fetchRoute(userLocation, LatLng(latitude, longitude));

              markers.add(
                Marker(
                  markerId: MarkerId(key.toString()),
                  position: LatLng(latitude, longitude),
                  infoWindow: InfoWindow(
                    title: 'Marker Title',
                    snippet: 'Marker Snippet',
                  ),
                ),
              );
            }
          }
        });
      }
    } catch (error) {
      handleError(error, 'Error handling database event');
    }
  }

  void handleError(dynamic error, String message) {
    setState(() {
      errorMessage = '$message: $error';
    });
    _showErrorSnackBar(errorMessage);
  }

  void trackUserLocation() {
    Geolocator.getPositionStream(
      locationSettings: AndroidSettings(
      accuracy: LocationAccuracy.best,
      distanceFilter: 10,
      )
    )..listen(
      (Position position) {
        markers.add(
          Marker(
            markerId: MarkerId('user'),
            position: LatLng(position.latitude, position.longitude),
            icon: BitmapDescriptor.defaultMarkerWithHue(
              BitmapDescriptor.hueBlue,
            ),
            infoWindow: InfoWindow(
              title: 'Your Location',
              snippet: 'You are here!',
            ),
          ),
        );
        setState(() {});
      },
      onError: (error) {
        handleError(error, 'Error obtaining user location');
      },
    );
  }

  Future<void> fetchRoute(LatLng origin, LatLng destination) async {
    try {
      String apiKey = 'AIzaSyDMj8FA_vNUmIkyrBJADZDEBiLLy8NTnn4'; // Replace with your API key
      String url = 'https://maps.googleapis.com/maps/api/directions/json?'
          'origin=${origin.latitude},${origin.longitude}&'
          'destination=${destination.latitude},${destination.longitude}&'
          'key=$apiKey';

      final response = await http.get(Uri.parse(url));

      if (response.statusCode == 200) {
        final data = json.decode(response.body);
        List<LatLng> points = _decodePoly(data['routes'][0]['overview_polyline']
            ['points']); // Decode polyline points
        setState(() {
          polylines.add(
            Polyline(
              polylineId: PolylineId(
                  'route_${origin.toString()}_${destination.toString()}'),
              points: points,
              color: Colors.blue,
              width: 3,
            ),
          );
        });
      } else {
        throw Exception('Failed to fetch route: ${response.statusCode}');
      }
    } catch (e) {
      handleError(e, 'Error fetching route');
    }
  }

  Future<LatLng> getUserLocation() async {
    try {
      Position position = await Geolocator.getCurrentPosition(
        desiredAccuracy: LocationAccuracy.high,
      );
      return LatLng(position.latitude, position.longitude);
    } catch (e) {
      handleError(e, 'Error obtaining user location');
      return LatLng(0, 0);
    }
  }

  List<LatLng> _decodePoly(String encoded) {
    List<PointLatLng> points = PolylinePoints().decodePolyline(encoded);
    List<LatLng> result = <LatLng>[];
    for (PointLatLng point in points) {
      result.add(LatLng(point.latitude, point.longitude));
    }
    return result;
  }

  void _showErrorSnackBar(String message) {
    ScaffoldMessenger.of(context).showSnackBar(
      SnackBar(
        content: Text(message),
        duration: Duration(seconds: 5),
        action: SnackBarAction(
          label: 'Dismiss',
          onPressed: () {
            ScaffoldMessenger.of(context).hideCurrentSnackBar();
          },
        ),
      ),
    );
  }

  void requestLocationPermission() async {
    var status = await Permission.location.request();
    if (status.isDenied) {
      print('User denied location permission');
    }
  }
}


/*import 'package:firebase_database/firebase_database.dart';
import 'package:flutter/material.dart';
import 'package:geolocator/geolocator.dart';
import 'package:google_maps_flutter/google_maps_flutter.dart';
import 'package:http/http.dart' as http;
import 'dart:convert';
import 'package:flutter_polyline_points/flutter_polyline_points.dart';
import 'package:permission_handler/permission_handler.dart';

class MapWithMarkers extends StatefulWidget {
  const MapWithMarkers({Key? key}) : super(key: key);

  @override
  State<MapWithMarkers> createState() => _MapWithMarkersState();
}

class _MapWithMarkersState extends State<MapWithMarkers> {
  late GoogleMapController mapController;
  Set<Marker> markers = {};
  Set<Polyline> polylines = {};
  bool isLoading = false;
  String errorMessage = '';

  @override
  void initState() {
    super.initState();
    requestLocationPermission();
    fetchCoordinates();
    trackUserLocation();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text("Map with Markers"),
        centerTitle: true,
      ),
      body: Stack(
        children: [
          GoogleMap(
            initialCameraPosition: const CameraPosition(
              target: LatLng(51.5, -0.09),
              zoom: 10.0,
            ),
            markers: markers,
            polylines: polylines,
            onMapCreated: (GoogleMapController controller) {
              mapController = controller;
            },
            zoomControlsEnabled: true,
            myLocationButtonEnabled: true,
            myLocationEnabled: true,
            compassEnabled: true,
          ),
          if (isLoading)
            const Center(
              child: CircularProgressIndicator(),
            ),
        ],
      ),
    );
  }

  void fetchCoordinates() {
    // Your Firebase Realtime Database reference
    final databaseReference = FirebaseDatabase.instance.ref();

    setState(() {
      isLoading = true;
    });

    // Listening for changes in the "Global Messages" node
    databaseReference.child("Global Messages").onValue.listen((event) async {
      markers.clear();
      polylines.clear();

      LatLng userLocation = await getUserLocation();

      // Extracting data from the event snapshot
      Map<dynamic, dynamic>? data = event.snapshot.value as Map?;

      if (data != null) {
        data.forEach((key, value) {
          if (value is Map &&
              value.containsKey("latitude") &&
              value.containsKey("longitude")) {
            double latitude = value["latitude"] ?? 0.0;
            double longitude = value["longitude"] ?? 0.0;

            fetchRoute(userLocation, LatLng(latitude, longitude));

            markers.add(
              Marker(
                markerId: MarkerId(key.toString()),
                position: LatLng(latitude, longitude),
                infoWindow: const InfoWindow(
                  title: 'Marker Title',
                  snippet: 'Marker Snippet',
                ),
              ),
            );
          }
        });
      }

      setState(() {
        isLoading = false;
      });
    }, onError: (error) {
      setState(() {
        isLoading = false;
        errorMessage = 'Error fetching data: $error';
      });
      _showErrorSnackBar(errorMessage);
    });
  }

  // Tracks user location using Geolocator
  void trackUserLocation() {
    Geolocator.getPositionStream(
      locationSettings: AndroidSettings(
      accuracy: LocationAccuracy.best,
      distanceFilter: 10,
      )
    ).listen(
      (Position position) {
        markers.add(
          Marker(
            markerId: const MarkerId('user'),
            position: LatLng(position.latitude, position.longitude),
            icon: BitmapDescriptor.defaultMarkerWithHue(
              BitmapDescriptor.hueBlue,
            ),
            infoWindow: const InfoWindow(
              title: 'Your Location',
              snippet: 'You are here!',
            ),
          ),
        );
        setState(() {});
      },
      onError: (error) {
        setState(() {
          errorMessage = 'Error obtaining user location: $error';
        });
        _showErrorSnackBar(errorMessage);
      },
    );
  }

  // Fetches route using Google Directions API
  Future<void> fetchRoute(LatLng origin, LatLng destination) async {
    try {
      String apiKey =
          'AIzaSyDMj8FA_vNUmIkyrBJADZDEBiLLy8NTnn4'; // Replace with your API key
      String url = 'https://maps.googleapis.com/maps/api/directions/json?'
          'origin=${origin.latitude},${origin.longitude}&'
          'destination=${destination.latitude},${destination.longitude}&'
          'key=$apiKey';

      final response = await http.get(Uri.parse(url));

      if (response.statusCode == 200) {
        final data = json.decode(response.body);
        List<LatLng> points = _decodePoly(data['routes'][0]['overview_polyline']
            ['points']); // Decode polyline points
        setState(() {
          polylines.add(
            Polyline(
              polylineId: PolylineId(
                  'route_${origin.toString()}_${destination.toString()}'),
              points: points,
              color: Colors.blue,
              width: 3,
            ),
          );
        });
      } else {
        throw Exception('Failed to fetch route: ${response.statusCode}');
      }
    } catch (e) {
      setState(() {
        errorMessage = 'Error fetching route: $e';
      });
      _showErrorSnackBar(errorMessage);
    }
  }

  // Obtains user location using Geolocator
  Future<LatLng> getUserLocation() async {
    try {
      Position position = await Geolocator.getCurrentPosition(
        desiredAccuracy: LocationAccuracy.high,
      );
      return LatLng(position.latitude, position.longitude);
    } catch (e) {
      setState(() {
        errorMessage = 'Error obtaining user location: $e';
      });
      _showErrorSnackBar(errorMessage);
      return const LatLng(0, 0);
    }
  }

  // Decodes polyline points received from Google Directions API
  List<LatLng> _decodePoly(String encoded) {
    List<PointLatLng> points = PolylinePoints().decodePolyline(encoded);
    List<LatLng> result = <LatLng>[];
    for (PointLatLng point in points) {
      result.add(LatLng(point.latitude, point.longitude));
    }
    return result;
  }

  // Displays error messages using SnackBar
  void _showErrorSnackBar(String message) {
    ScaffoldMessenger.of(context).showSnackBar(
      SnackBar(
        content: Text(message),
        duration: const Duration(seconds: 5),
        action: SnackBarAction(
          label: 'Dismiss',
          onPressed: () {
            ScaffoldMessenger.of(context).hideCurrentSnackBar();
          },
        ),
      ),
    );
  }

  void requestLocationPermission() async {
    var status = await Permission.location.request();
    if (status.isDenied) {
      // Handle case when user denied permission
      print('User denied location permission');
    }
  }
}
*/