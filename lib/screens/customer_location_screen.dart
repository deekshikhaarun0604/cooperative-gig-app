import 'dart:convert';
import 'package:flutter_map/flutter_map.dart';
import 'package:flutter/material.dart';
import 'dart:async';
import 'package:latlong2/latlong.dart';
import 'package:url_launcher/url_launcher.dart';
import 'package:geolocator/geolocator.dart';
import 'package:http/http.dart' as http;

class CustomerLocationScreen extends StatefulWidget {
const CustomerLocationScreen({super.key});

@override
State<CustomerLocationScreen> createState() =>
_CustomerLocationScreenState();
}

class _CustomerLocationScreenState
extends State<CustomerLocationScreen> {

// Dummy customer location for prototype.
static const LatLng customerLocation =
LatLng(11.0276, 76.9661);

// Temporary worker location.
LatLng workerLocation =
const LatLng(11.0168, 76.9558);

// Road route returned by OSRM.
List<LatLng> routePoints = [];

double? distanceKm;
double? durationMinutes;

bool locationLoading = true;
bool routeLoading = false;

final MapController mapController = MapController();

// Live GPS subscription.
StreamSubscription<Position>? positionSubscription;

@override
void initState() {
super.initState();
getWorkerLocation();
}

// --------------------------------------------------
// GET WORKER GPS LOCATION
// --------------------------------------------------

Future<void> getWorkerLocation() async {
try {
bool serviceEnabled =
await Geolocator.isLocationServiceEnabled();

if (!serviceEnabled) {
setState(() {
locationLoading = false;
});

await getRoute();
return;
}

LocationPermission permission =
await Geolocator.checkPermission();

if (permission == LocationPermission.denied) {
permission =
await Geolocator.requestPermission();
}

if (permission == LocationPermission.denied ||
permission == LocationPermission.deniedForever) {
setState(() {
locationLoading = false;
});

await getRoute();
return;
}

Position position =
await Geolocator.getCurrentPosition();

setState(() {
workerLocation = LatLng(
position.latitude,
position.longitude,
);

locationLoading = false;
});

// Get initial route.
await getRoute();

// Start live location tracking.
startLocationTracking();

} catch (e) {
setState(() {
locationLoading = false;
});

await getRoute();
}
}

// --------------------------------------------------
// LIVE WORKER LOCATION TRACKING
// --------------------------------------------------

void startLocationTracking() {
const locationSettings = LocationSettings(
accuracy: LocationAccuracy.high,
distanceFilter: 20,
);

positionSubscription =
Geolocator.getPositionStream(
locationSettings: locationSettings,
).listen((Position position) async {
if (!mounted) return;

setState(() {
workerLocation = LatLng(
position.latitude,
position.longitude,
);
});

// Recalculate route using updated worker location.
await getRoute();
});
}

// --------------------------------------------------
// GET REAL ROAD ROUTE FROM OSRM
// --------------------------------------------------

Future<void> getRoute() async {
setState(() {
routeLoading = true;
});

try {
final url = Uri.parse(
'https://router.project-osrm.org/route/v1/driving/'
'${workerLocation.longitude},'
'${workerLocation.latitude};'
'${customerLocation.longitude},'
'${customerLocation.latitude}'
'?overview=full&geometries=geojson',
);

final response = await http.get(url);

if (response.statusCode == 200) {
final data = jsonDecode(response.body);

final routes = data['routes'];

if (routes != null && routes.isNotEmpty) {
final route = routes[0];

final coordinates =
route['geometry']['coordinates'];

final List<LatLng> points = coordinates
    .map<LatLng>(
(coordinate) => LatLng(
coordinate[1].toDouble(),
coordinate[0].toDouble(),
),
)
    .toList();

setState(() {
routePoints = points;

distanceKm =
route['distance'] / 1000;

durationMinutes =
route['duration'] / 60;

routeLoading = false;
});

// Automatically fit the map to the route.
if (points.isNotEmpty) {
final bounds =
LatLngBounds.fromPoints(points);

mapController.fitCamera(
CameraFit.bounds(
bounds: bounds,
padding: const EdgeInsets.all(50),
),
);
}

return;
}
}

setState(() {
routeLoading = false;
});

} catch (e) {
setState(() {
routeLoading = false;
});
}
}

// --------------------------------------------------
// GOOGLE MAPS NAVIGATION
// --------------------------------------------------

Future<void> startNavigation() async {
final Uri navigationUrl = Uri.parse(
'https://www.google.com/maps/dir/?api=1'
'&destination=${customerLocation.latitude},'
'${customerLocation.longitude}'
'&travelmode=driving',
);

if (await canLaunchUrl(navigationUrl)) {
await launchUrl(
navigationUrl,
mode: LaunchMode.externalApplication,
);
}
}

// --------------------------------------------------
// CLEAN UP GPS STREAM
// --------------------------------------------------

@override
void dispose() {
positionSubscription?.cancel();
super.dispose();
}

// --------------------------------------------------
// UI
// --------------------------------------------------

@override
Widget build(BuildContext context) {
return Scaffold(
appBar: AppBar(
title: const Text('Customer Location'),
centerTitle: true,
),

body: Column(
children: [

// ---------------- MAP ----------------

Expanded(
child: FlutterMap(
mapController: mapController,

options: MapOptions(
initialCenter: workerLocation,
initialZoom: 14,
),

children: [

// ---------------- MAP TILES ----------------

TileLayer(
urlTemplate:
'https://tile.openstreetmap.org/{z}/{x}/{y}.png',

userAgentPackageName:
'com.example.cooperative_gig_app',
),

// ---------------- REAL ROAD ROUTE ----------------

if (routePoints.isNotEmpty)
PolylineLayer(
polylines: [
Polyline(
points: routePoints,
strokeWidth: 5,
),
],
),

// ---------------- MARKERS ----------------

MarkerLayer(
markers: [

// WORKER
Marker(
point: workerLocation,
width: 80,
height: 80,

child: const Column(
children: [

Icon(
Icons.person_pin_circle,
color: Colors.deepPurple,
size: 40,
),

Text(
'You',
style: TextStyle(
fontWeight: FontWeight.bold,
fontSize: 12,
),
),
],
),
),

// CUSTOMER
Marker(
point: customerLocation,
width: 100,
height: 80,

child: const Column(
children: [

Icon(
Icons.location_on,
color: Colors.red,
size: 40,
),

Text(
'Customer',
style: TextStyle(
fontWeight: FontWeight.bold,
fontSize: 12,
),
),
],
),
),
],
),
],
),
),

// ---------------- BOTTOM PANEL ----------------

Container(
padding: const EdgeInsets.all(18),

decoration: const BoxDecoration(
color: Colors.white,

borderRadius: BorderRadius.vertical(
top: Radius.circular(20),
),
),

child: Column(
crossAxisAlignment:
CrossAxisAlignment.start,

children: [

const Text(
'Customer Location',

style: TextStyle(
fontSize: 19,
fontWeight: FontWeight.bold,
),
),

const SizedBox(height: 12),

// ---------------- DISTANCE + ETA ----------------

Row(
children: [

Expanded(
child: _infoCard(
Icons.route,
'Distance',

routeLoading
? 'Calculating...'
    : distanceKm != null
? '${distanceKm!.toStringAsFixed(1)} km'
    : 'Unavailable',
),
),

const SizedBox(width: 12),

Expanded(
child: _infoCard(
Icons.access_time,
'Estimated Time',

routeLoading
? 'Calculating...'
    : durationMinutes != null
? '${durationMinutes!.round()} min'
    : 'Unavailable',
),
),
],
),

const SizedBox(height: 12),

// ---------------- ADDRESS ----------------

Row(
children: [

const Icon(
Icons.location_on_outlined,
color: Colors.red,
),

const SizedBox(width: 8),

Expanded(
child: Text(
locationLoading
? 'Getting your current location...'
    : 'Customer address will appear here',

style: const TextStyle(
color: Colors.grey,
),
),
),
],
),

const SizedBox(height: 15),

// ---------------- NAVIGATION BUTTON ----------------

SizedBox(
width: double.infinity,
height: 52,

child: ElevatedButton.icon(
onPressed: startNavigation,

icon: const Icon(
Icons.navigation_outlined,
),

label: const Text(
'Start Navigation',

style: TextStyle(
fontSize: 16,
fontWeight: FontWeight.bold,
),
),

style: ElevatedButton.styleFrom(
backgroundColor:
Colors.deepPurple,

foregroundColor:
Colors.white,

shape:
RoundedRectangleBorder(
borderRadius:
BorderRadius.circular(14),
),
),
),
),
],
),
),
],
),
);
}

// --------------------------------------------------
// DISTANCE / ETA CARD
// --------------------------------------------------

Widget _infoCard(
IconData icon,
String title,
String value,
) {
return Container(
padding: const EdgeInsets.all(12),

decoration: BoxDecoration(
color: Colors.grey.shade100,
borderRadius: BorderRadius.circular(12),
),

child: Row(
children: [

Icon(
icon,
color: Colors.deepPurple,
),

const SizedBox(width: 8),

Expanded(
child: Column(
crossAxisAlignment:
CrossAxisAlignment.start,

children: [

Text(
title,

style: const TextStyle(
fontSize: 12,
color: Colors.grey,
),
),

const SizedBox(height: 3),

Text(
value,

style: const TextStyle(
fontWeight: FontWeight.bold,
),
),
],
),
),
],
),
);
}
}

