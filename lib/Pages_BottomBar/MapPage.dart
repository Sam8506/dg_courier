// ignore: file_names
import 'package:dg_courier/Pages_BottomBar/NewOrder.dart';
import 'package:dg_courier/Utils/Colors.dart';
import 'package:dg_courier/Utils/secrets.dart';
import 'package:dotted_line/dotted_line.dart';
import 'package:flutter/material.dart';
import 'package:flutter_polyline_points/flutter_polyline_points.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:google_maps_flutter/google_maps_flutter.dart';
import 'dart:async';
import 'package:geocoding/geocoding.dart';
import 'package:geolocator/geolocator.dart';
import 'dart:math';

bool showPickupContainer = false;
bool showDistanceContainer = false;
bool hidePickupContainer = false;
bool hideMenuWidget = false;
bool payNow = false;
int? placeDistance=0;
String TotalAmount = '';
String ladu = '';


class MapView extends StatefulWidget {
  @override
  MapViewState createState() => MapViewState();
}

class MapViewState extends State<MapView> {
  CameraPosition _initialLocation =
      CameraPosition(target: LatLng(28.644800, 77.216721), zoom: 5.5);
  late GoogleMapController mapController;

  late Position _currentPosition;
  late Position _currentStartPosition;
  String _currentAddress = '';

  final startAddressController = pickUpController;
  final destinationAddressController = deliveryController;

  final startAddressFocusNode = FocusNode();
  final desrinationAddressFocusNode = FocusNode();

  String _startAddress = '';
  String _destinationAddress = '';
double totalDistance = 0.0;
  

  Set<Marker> markers = {};

  late PolylinePoints polylinePoints;
  Map<PolylineId, Polyline> polylines = {};
  List<LatLng> polylineCoordinates = [];

  final _scaffoldKey = GlobalKey<ScaffoldState>();

  var threshold = 200;

  Widget _textField({
    required TextEditingController controller,
    required FocusNode focusNode,
    required String label,
    required String hint,
    required double width,
    required Icon prefixIcon,
    //Widget? suffixIcon,
    required Function(String) locationCallback,
  }) {
    return SizedBox(
      width: width * 0.8,
      child: TextField(
        onChanged: (value) {
          locationCallback(value);
        },
        controller: controller,
        focusNode: focusNode,
        textCapitalization: TextCapitalization.words,
        style: TextStyle(
            fontFamily: GoogleFonts.montserrat().fontFamily,
            fontSize: 13,
            fontWeight: FontWeight.w500),
        decoration: InputDecoration(
            contentPadding: const EdgeInsets.fromLTRB(25, 1, 0, 1),
            filled: true,
            fillColor: Colors.grey.shade300,
            enabledBorder: OutlineInputBorder(
                borderSide: BorderSide.none,
                borderRadius: BorderRadius.circular(5)),
            focusedBorder: OutlineInputBorder(
                borderSide: BorderSide.none,
                borderRadius: BorderRadius.circular(5)),
            hintText: hint,
            hintStyle: TextStyle(
                fontSize: 13,
                fontFamily: GoogleFonts.montserrat().fontFamily,
                color: Colors.black.withOpacity(0.5))),
      ),
    );
  }

  // Method for retrieving the current location
  _getCurrentLocation() async {
    await Geolocator.getCurrentPosition(desiredAccuracy: LocationAccuracy.high)
        .then((Position position) async {
      setState(() {
        _currentPosition = position;
        print('CURRENT POSITION: $_currentPosition');
        mapController.animateCamera(
          CameraUpdate.newCameraPosition(
            CameraPosition(
              target: LatLng(position.latitude, position.longitude),
              zoom: 18.0,
            ),
          ),
        );
      });
      await _getAddress();
    }).catchError((e) {
      print(e);
    });
  }

  _getStartLocation() async {
    setState(() {
      _currentStartPosition = _startAddress as Position;
      print('CURRENT POSITION: $_currentPosition');
      mapController.animateCamera(
        CameraUpdate.newCameraPosition(
          CameraPosition(
            target: LatLng(_currentStartPosition.latitude,
                _currentStartPosition.longitude),
            zoom: 18.0,
          ),
        ),
      );
    });
    await _getAddress();
  }

  // Method for retrieving the address
  _getAddress() async {
    try {
      List<Placemark> p = await placemarkFromCoordinates(
          _currentPosition.latitude, _currentPosition.longitude);

      Placemark place = p[0];

      setState(() {
        _currentAddress =
            "${place.name}, ${place.locality}, ${place.postalCode}, ${place.country}";
        startAddressController.text = _currentAddress;
        _startAddress = _currentAddress;
      });
    } catch (e) {
      print(e);
    }
  }

  // Method for calculating the distance between two places
  Future<bool> _calculateDistance() async {
    try {
      // Retrieving placemarks from addresses
      List<Location> startPlacemark = await locationFromAddress(_startAddress);
      List<Location> destinationPlacemark =
          await locationFromAddress(_destinationAddress);

      // Use the retrieved coordinates of the current position,
      // instead of the address if the start position is user's
      // current position, as it results in better accuracy.
      double startLatitude = _startAddress == _currentAddress
          ? _currentPosition.latitude
          : startPlacemark[0].latitude;

      double startLongitude = _startAddress == _currentAddress
          ? _currentPosition.longitude
          : startPlacemark[0].longitude;

      double destinationLatitude = destinationPlacemark[0].latitude;
      double destinationLongitude = destinationPlacemark[0].longitude;

      String startCoordinatesString = '($startLatitude, $startLongitude)';
      String destinationCoordinatesString =
          '($destinationLatitude, $destinationLongitude)';

      // Start Location Marker
      Marker startMarker = Marker(
        markerId: MarkerId(startCoordinatesString),
        position: LatLng(startLatitude, startLongitude),
        infoWindow: InfoWindow(
          title: 'Start $startCoordinatesString',
          snippet: _startAddress,
        ),
        icon: BitmapDescriptor.defaultMarkerWithHue(BitmapDescriptor.hueAzure),
      );

      // Destination Location Marker
      Marker destinationMarker = Marker(
        markerId: MarkerId(destinationCoordinatesString),
        position: LatLng(destinationLatitude, destinationLongitude),
        infoWindow: InfoWindow(
          title: 'Destination $destinationCoordinatesString',
          snippet: _destinationAddress,
        ),
        icon: BitmapDescriptor.defaultMarker,
      );

      // Adding the markers to the list
      markers.add(startMarker);
      markers.add(destinationMarker);

      print(
        'START COORDINATES: ($startLatitude, $startLongitude)',
      );
      print(
        'DESTINATION COORDINATES: ($destinationLatitude, $destinationLongitude)',
      );

      // Calculating to check that the position relative
      // to the frame, and pan & zoom the camera accordingly.
      double miny = (startLatitude <= destinationLatitude)
          ? startLatitude
          : destinationLatitude;
      double minx = (startLongitude <= destinationLongitude)
          ? startLongitude
          : destinationLongitude;
      double maxy = (startLatitude <= destinationLatitude)
          ? destinationLatitude
          : startLatitude;
      double maxx = (startLongitude <= destinationLongitude)
          ? destinationLongitude
          : startLongitude;

      double southWestLatitude = miny;
      double southWestLongitude = minx;

      double northEastLatitude = maxy;
      double northEastLongitude = maxx;

      // Accommodate the two locations within the
      // camera view of the map
      mapController.animateCamera(
        CameraUpdate.newLatLngBounds(
          LatLngBounds(
            northeast: LatLng(northEastLatitude, northEastLongitude),
            southwest: LatLng(southWestLatitude, southWestLongitude),
          ),
          100.0,
        ),
      );

      await _createPolylines(startLatitude, startLongitude, destinationLatitude,
          destinationLongitude);

      
  //    double getDistanceFromGPSPointsInRoute(List<LatLng> gpsList) {
  //   //double totalDistance = 0.0;

  //   for (var i = 0; i < gpsList.length; i++) {
  //     var p = 0.017453292519943295;
  //     var c = cos;
  //     var a = 0.5 -
  //         c((gpsList[i + 1].latitude - gpsList[i].latitude) * p) / 2 +
  //         c(gpsList[i].latitude * p) *
  //             c(gpsList[i + 1].latitude * p) *
  //             (1 - c((gpsList[i + 1].longitude - gpsList[i].longitude) * p)) /
  //             2;
  //     double distance = 12742 * asin(sqrt(a));
  //     totalDistance += distance;
  //     print('Distance is ${12742 * asin(sqrt(a))}');
  //   }
  //   print('Total distance is $totalDistance');
  //   return totalDistance;
  // }

      // Calculating the total distance by adding the distance
      // between small segments
      for (int i = 0; i < polylineCoordinates.length - 1; i++) {
        totalDistance += _coordinateDistance(
          polylineCoordinates[i].latitude,
          polylineCoordinates[i].longitude,
          polylineCoordinates[i + 1].latitude,
          polylineCoordinates[i + 1].longitude,
        );
      }

      setState(() {
        placeDistance = totalDistance.toInt();
        // placeDistance = totalDistance.toStringAsFixed(2);
        print('DISTANCE: $placeDistance km');
      });

      return true;
    } catch (e) {
      print(e);
    }
    return false;
  }
  

  // Formula for calculating distance between two coordinates
  double _coordinateDistance(lat1, lon1, lat2, lon2) {
    var p = 0.017453292519943295;
    var c = cos;
    var a = 0.5 -
        c((lat2 - lat1) * p) / 2 +
        c(lat1 * p) * c(lat2 * p) * (1 - c((lon2 - lon1) * p)) / 2;
    return 12742 * asin(sqrt(a));
  }

  // Create the polylines for showing the route between two places
  _createPolylines(
    double startLatitude,
    double startLongitude,
    double destinationLatitude,
    double destinationLongitude,
  ) async {
    polylinePoints = PolylinePoints();
    PolylineResult result = await polylinePoints.getRouteBetweenCoordinates(
      Secrets.API_KEY, // Google Maps API Key
      PointLatLng(startLatitude, startLongitude),
      PointLatLng(destinationLatitude, destinationLongitude),
      travelMode: TravelMode.driving,
    );

    if (result.points.isNotEmpty) {
      result.points.forEach((PointLatLng point) {
        polylineCoordinates.add(LatLng(point.latitude, point.longitude));
      });
    }

    PolylineId id = PolylineId('poly');
    Polyline polyline = Polyline(
      polylineId: id,
      color: Colors.blueAccent,
      points: polylineCoordinates,
      width: 4,
    );
    polylines[id] = polyline;
  }

  @override
  void initState() {
    super.initState();
    _getCurrentLocation();
  }

  @override
  Widget build(BuildContext context) {
    var height = MediaQuery.of(context).size.height;
    var width = MediaQuery.of(context).size.width;
    return SingleChildScrollView(
      child: SizedBox(
        height: height,
        width: width,
        child: Scaffold(
          key: _scaffoldKey,
          body: Stack(
            alignment: Alignment.topCenter,
            children: <Widget>[
              Padding(
                padding: const EdgeInsets.only(bottom: 177),
                child: GoogleMap(
                  markers: Set<Marker>.from(markers),
                  initialCameraPosition: _initialLocation,
                  myLocationEnabled: true,
                  myLocationButtonEnabled: true,
                  mapType: MapType.satellite,
                  zoomGesturesEnabled: true,
                  zoomControlsEnabled: true,
                  polylines: Set<Polyline>.of(polylines.values),
                  onMapCreated: (GoogleMapController controller) {
                    mapController = controller;
                  },
                ),
              ),
              
              showDistanceContainer
                  ? SafeArea(
                      child: Padding(
                        padding: const EdgeInsets.only(top: 15),
                        child: Container(
                          decoration: BoxDecoration(
                            borderRadius: BorderRadius.circular(10),
                            border: Border.all(
                                width: 3, color: Colors.transparent),
                            color: dgdarkpink,
                          ),
                          alignment: Alignment.center,
                          height: 30,
                          width: 150,
                          child: Visibility(
                            visible: placeDistance == null ? false : true,
                            child: Text(
                              '$placeDistance km', 
                              // "KI",
                              style: const TextStyle(
                                color: Colors.white,
                                fontSize: 16,
                                fontWeight: FontWeight.bold,
                              ),
                            ),
                          ),
                        ),
                      ),
                    )
                  : Container(
                      color: Colors.transparent,
                    ),
              Positioned(
                  bottom: 0,
                  left: 0,
                  right: 0,
                  child: SafeArea(
                    child: GestureDetector(
                      onPanEnd: (details) {
                        if (details.velocity.pixelsPerSecond.dy > -threshold) {
                          HidePickupContainer();
                          setState(() {
                                    // payNow=true;
                           });
                        } else if (details.velocity.pixelsPerSecond.dy <
                            -threshold) {
                          setState(() {
                            showPickupContainer = true;
                            hideMenuWidget = true;
                          });
                        }
                      },
                      child: showPickupContainer
                          ? AnimatedContainer(
                              duration: Duration(milliseconds: 800),
                              height: MediaQuery.of(context).size.height,
                              width: MediaQuery.of(context).size.width,
                              decoration: BoxDecoration(
                                borderRadius: BorderRadius.only(
                                    topLeft: Radius.circular(20),
                                    topRight: Radius.circular(20)),
                                color: Colors.white,
                              ),
                              child: Stack(children: [
                                Positioned(
                                  top: 0,
                                  left: 0,
                                  right: 0,
                                  child: Container(
                                    height: MediaQuery.of(context).size.height /
                                        4.3,
                                    decoration: BoxDecoration(
                                        color: Colors.white,
                                        boxShadow: [
                                          BoxShadow(
                                              color:
                                                  Colors.black.withOpacity(0.4),
                                              blurRadius: 20,
                                              spreadRadius: 10)
                                        ]),
                                    child: Container(
                                      color: Colors.transparent,
                                      margin:
                                          EdgeInsets.fromLTRB(15, 30, 15, 0),
                                      child: Column(
                                        crossAxisAlignment:
                                            CrossAxisAlignment.start,
                                        children: [
                                          Row(
                                            children: [
                                              IconButton(
                                                  onPressed: () {
                                                    setState(() {
                                                      showPickupContainer =
                                                          false;
                                                      hideMenuWidget = false;
                                                    });
                                                  },
                                                  icon:
                                                      Icon(Icons.close_sharp)),
                                              SizedBox(
                                                width: 15,
                                              ),
                                              Text(
                                                "Enter Pickup",
                                                style: TextStyle(
                                                  fontFamily:
                                                      GoogleFonts.montserrat()
                                                          .fontFamily,
                                                  fontWeight: FontWeight.bold,
                                                ),
                                              )
                                            ],
                                          ),
                                          Container(
                                            child: Row(
                                              mainAxisAlignment:
                                                  MainAxisAlignment.start,
                                              crossAxisAlignment:
                                                  CrossAxisAlignment.start,
                                              children: [
                                                SizedBox(
                                                  width: 17,
                                                ),
                                                Column(
                                                  children: [
                                                    SizedBox(
                                                      height: 14,
                                                    ),
                                                    Icon(
                                                      Icons.trip_origin,
                                                      size: 15,
                                                      color: Colors
                                                          .yellow.shade700,
                                                    ),
                                                    Container(
                                                      child: buildDashedLine(),
                                                    ),
                                                    Icon(
                                                      Icons.location_on,
                                                      size: 15,
                                                      color:
                                                          Colors.blue.shade700,
                                                    ),
                                                    const SizedBox(
                                                      height: 5,
                                                    ),
                                                  ],
                                                ),
                                                const SizedBox(
                                                  width: 5,
                                                ),
                                                 SizedBox(
                                                  width: MediaQuery.of(context)
                                                          .size
                                                          .width -
                                                      100,
                                                  child: Column(
                                                    children: [
                                                      Container(
                                                        decoration:
                                                            BoxDecoration(
                                                          borderRadius:
                                                              BorderRadius
                                                                  .circular(5),
                                                        ),
                                                        height: 40,
                                                        child: _textField(
                                                          controller:
                                                              pickUpController,
                                                          focusNode:
                                                              startAddressFocusNode,
                                                          width: width,
                                                          locationCallback:
                                                              (String value) {
                                                            setState(() {
                                                              _startAddress =
                                                                  value;
                                                            });
                                                          },
                                                          hint: 'Enter Pickup',
                                                          label: '',
                                                          prefixIcon:
                                                              Icon(Icons.done),
                                                        ),
                                                      ),
                                                      const SizedBox(
                                                        height: 10,
                                                      ),
                                                      Container(
                                                        decoration:
                                                            BoxDecoration(
                                                          borderRadius:
                                                              BorderRadius
                                                                  .circular(5),
                                                        ),
                                                        height: 40,
                                                        child: _textField(
                                                            controller:
                                                                deliveryController,
                                                            focusNode:
                                                                desrinationAddressFocusNode,
                                                            width: width,
                                                            locationCallback:
                                                                (String value) {
                                                              setState(() {
                                                                _destinationAddress =
                                                                    value;
                                                              });
                                                            },
                                                            hint:
                                                                'Enter Destination',
                                                            label: '',
                                                            prefixIcon: const Icon(
                                                                Icons.done)),
                                                      ),
                                                    ],
                                                  ),
                                                )
                                              ],
                                            ),
                                          )
                                        ],
                                      ),
                                    ),
                                  ),
                                ),
                                Positioned(
                                    top: MediaQuery.of(context).size.height /
                                        3.5,
                                    left: 0,
                                    right: 0,
                                    child: Padding(
                                      padding: const EdgeInsets.only(top: 50),
                                      child: Column(children: [
                                       Image.asset("assets/images/MapImage.png")
                                      ]),
                                    )),
                                Positioned(
                                  bottom: 20,
                                  left: 20,
                                  right: 20,
                                  child: ElevatedButton(
                                    onPressed
                                    :
                                        () async {
                                            startAddressFocusNode.unfocus();
                                            desrinationAddressFocusNode
                                                .unfocus();
                                            setState(() {
                                              if (markers.isNotEmpty) {
                                                markers.clear();
                                              }
                                              if (polylines.isNotEmpty) {
                                                polylines.clear();
                                              }
                                              if (polylineCoordinates
                                                  .isNotEmpty) {
                                                polylineCoordinates.clear();
                                              }
                                              placeDistance;
                                            });

                                            _calculateDistance()
                                                .then((isCalculated) {
                                              if (isCalculated) {
                                                ScaffoldMessenger.of(context)
                                                    .showSnackBar(
                                                  const SnackBar(
                                                    content: Text(
                                                        'Distance Calculated Sucessfully'),
                                                  ),
                                                );
                                                setState(() {
                                                  payNow=true;
                                                  showPickupContainer = false;
                                                  showDistanceContainer = true;
                                                  hideMenuWidget = false;
                                                });
                                              } else {
                                                ScaffoldMessenger.of(context)
                                                    .showSnackBar(
                                                  const SnackBar(
                                                    content: Text(
                                                        'Error Calculating Distance'),
                                                  ),
                                                );
                                              }
                                            });
                                          }
                                        ,
                                    style: ElevatedButton.styleFrom(
                                      backgroundColor: Colors.pink,
                                      shape: RoundedRectangleBorder(
                                        borderRadius:
                                            BorderRadius.circular(20.0),
                                      ),
                                    ),
                                    child: Text(
                                      '       Done       ',
                                      style: TextStyle(
                                          fontFamily:
                                              GoogleFonts.pacifico().fontFamily,
                                          fontSize: 20,
                                          letterSpacing: 1.3),
                                    ),
                                  ),
                                )
                              ]),
                            )
                          : AnimatedContainer(
                              decoration: const BoxDecoration(
                                borderRadius: BorderRadius.only(
                                    topLeft: Radius.circular(20),
                                    topRight: Radius.circular(20)),
                                color: Colors.white,
                              ),
                              height: 190,
                              width: MediaQuery.of(context).size.width,
                              duration: const Duration(milliseconds: 800),
                              child: Padding(
                                padding:
                                    const EdgeInsets.fromLTRB(30, 12, 30, 0),
                                child: Column(
                                  children: [
                                    Container(
                                      height: 6,
                                      width: 45,
                                      decoration: BoxDecoration(
                                        borderRadius: BorderRadius.circular(4),
                                        color: Colors.grey.shade200,
                                      ),
                                    ),
                                    Padding(
                                      padding: const EdgeInsets.fromLTRB(
                                          0, 18, 0, 0),
                                      child: Material(
                                        color: Colors.white,
                                        child: InkWell(
                                          borderRadius:
                                              BorderRadius.circular(10),
                                          onTap: (() async {
                                            setState(() {
                                              showPickupContainer = true;
                                              hideMenuWidget = true;
                                            });
                                          }),
                                          child: Column(
                                            children: [
                                              Ink(
                                                height: 40,
                                                width: MediaQuery.of(context)
                                                    .size
                                                    .width,
                                                decoration: BoxDecoration(
                                                  borderRadius:
                                                      BorderRadius.circular(10),
                                                  color: Colors.grey.shade200,
                                                ),
                                                child: Padding(
                                                  padding:
                                                      const EdgeInsets.only(
                                                          left: 12),
                                                  child: Row(
                                                    children: [
                                                      Container(
                                                          height: 30,
                                                          width: 30,
                                                          decoration:
                                                              BoxDecoration(
                                                                  shape: BoxShape
                                                                      .circle,
                                                                  color: Colors
                                                                      .grey
                                                                      .shade300),
                                                          child: const Icon(
                                                            Icons.search,
                                                            size: 20,
                                                          )),
                                                      const SizedBox(
                                                        width: 15,
                                                      ),
                                                      Text("Enter Pickup",
                                                          textAlign:
                                                              TextAlign.left,
                                                          style: TextStyle(
                                                            fontSize: 14,
                                                            fontFamily: GoogleFonts
                                                                    .montserrat()
                                                                .fontFamily,
                                                            fontWeight:
                                                                FontWeight.bold,
                                                            letterSpacing: 1.1,
                                                          )),
                                                    ],
                                                  ),
                                                ),
                                              ),
                                            ],
                                          ),
                                        ),
                                      ),
                                    ),
                                    const SizedBox(
                                      height: 5,
                                    ),
                                    Material(
                                      color: Colors.transparent,
                                      child: InkWell(
                                        focusColor: Colors.red,
                                        borderRadius: BorderRadius.circular(10),
                                        onTap: (() async {
                                          setState(() {
                                            showPickupContainer = true;
                                            hideMenuWidget = true;
                                          });
                                        }),
                                        child: Padding(
                                          padding:
                                              const EdgeInsets.only(top: 5),
                                          child: Ink(
                                            height: 40,
                                            width: MediaQuery.of(context)
                                                .size
                                                .width,
                                            child: Padding(
                                              padding: const EdgeInsets.only(
                                                  left: 17),
                                              child: Row(
                                                children: [
                                                  Icon(
                                                    Icons.home,
                                                    size: 22,
                                                    color: Colors.grey.shade400,
                                                  ),
                                                  const SizedBox(
                                                    width: 19,
                                                  ),
                                                  Column(
                                                    crossAxisAlignment:
                                                        CrossAxisAlignment
                                                            .start,
                                                    mainAxisAlignment: 
                                                        MainAxisAlignment
                                                            .center,
                                                    children: [
                                                      Text("Home",
                                                          style: TextStyle(
                                                            fontSize: 14,
                                                            fontFamily: GoogleFonts
                                                                    .montserrat()
                                                                .fontFamily,
                                                            fontWeight:
                                                                FontWeight.bold,
                                                            letterSpacing: 1.1,
                                                          )),
                                                      // Text(
                                                      //   "Kileleshwa, Likoni Lane, Nairobi, Kenya",
                                                      //   style: TextStyle(
                                                      //       color:
                                                      //           Colors.black54),
                                                      // )
                                                    ],
                                                  ),
                                                ],
                                              ),
                                            ),
                                          ),
                                        ),
                                      ),
                                    ),
                                    const SizedBox(
                                      height: 5,
                                    ),
                                    Container(
                                      height: 0.8,
                                      color: Colors.grey.shade500,
                                    ),
                                    const SizedBox(
                                      height: 5,
                                    ),
                                    Material(
                                      color: Colors.transparent,
                                      child: InkWell(
                                        borderRadius: BorderRadius.circular(10),
                                        onTap: (() async {
                                          setState(() {
                                            showPickupContainer = true;
                                            hideMenuWidget = true;
                                          });
                                        }),
                                        child: Padding(
                                          padding:
                                              const EdgeInsets.only(top: 5),
                                          child: Ink(
                                            height: 40,
                                            width: MediaQuery.of(context)
                                                .size
                                                .width,
                                            child: Padding(
                                              padding: const EdgeInsets.only(
                                                  left: 17),
                                              child: Row(
                                                children: [
                                                  Icon(
                                                    Icons.work_outline,
                                                    size: 22,
                                                    color: Colors.grey.shade400,
                                                  ),
                                                  const SizedBox(
                                                    width: 19,
                                                  ),
                                                  Column(
                                                    crossAxisAlignment:
                                                        CrossAxisAlignment
                                                            .start,
                                                            mainAxisAlignment: MainAxisAlignment.center,
                                                    children: [
                                                      Text("Work",
                                                          style: TextStyle(
                                                            fontSize: 14,
                                                            fontFamily: GoogleFonts
                                                                    .montserrat()
                                                                .fontFamily,
                                                            fontWeight:
                                                                FontWeight.bold,
                                                            letterSpacing: 1.1,
                                                          )),
                                                      // Text(
                                                      //   "54 Lenana Road, Nairobi, Kenya",
                                                      //   style: TextStyle(
                                                      //       color:
                                                      //           Colors.black54),
                                                      // )
                                                    ],
                                                  ),
                                                ],
                                              ),
                                            ),
                                          ),
                                        ),
                                      ),
                                    ),
                                    
                                  ],
                                ),
                              )),
                    ),
                  ),
                  
                  ),
                  payNow?Padding(
                padding: const EdgeInsets.only(top: 600),
                child: ElevatedButton(onPressed: (){
                  setState(() {
                     TotalAmount= paymentTotal(placeDistance).toString();
                     List chomu = TotalAmount.split('.');
                     ladu = chomu[0];
                     print('ladu' + ladu);
                  });

                  print('Op '+TotalAmount.split('.').toString());
                  Navigator.pushNamed(context, "payment");
                }, child: Text("Pay Now")),
              ):Container(),
            ],
          ),
        ),
      ),
    );
  }
}

 paymentTotal(Total){
  
  if(kg.selectedIndex == 0){  
    return  Total * 100;   // for 1 kg
  }else if(kg.selectedIndex == 1){
    return  Total *400; // for 5 kg
  }else if(kg.selectedIndex == 2){
    return  Total*700; // for 10 kg
  }else if(kg.selectedIndex == 3){
    return  Total*1300; // for 20 kg
  }else{
    return  Total*1700; // for above 20 kg
  }
  //rint('Op '+TotalAmount);
}

class HomePage extends StatefulWidget {
  const HomePage({Key? key}) : super(key: key);

  @override
  State<HomePage> createState() => HomePageState();
}

class HomePageState extends State<HomePage> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
        body: Stack(
      children: [
        Positioned(
          top: 0,
          bottom: 0,
          left: 0,
          right: 0,
          child: MapView(),
        ),
      ],
    ));
  }
}

// ignore: camel_case_types
class HidePickupContainer extends StatefulWidget {
  const HidePickupContainer({Key? key}) : super(key: key);

  @override
  State<HidePickupContainer> createState() => 
  
  
  HidePickupContainerState();
}

class HidePickupContainerState extends State<HidePickupContainer> {
  @override
  Widget build(BuildContext context) {
    return AnimatedContainer(
        decoration: const BoxDecoration(
          borderRadius: BorderRadius.only(
              topLeft: Radius.circular(20), topRight: Radius.circular(20)),
          color: Colors.white,
        ),
        height: 180,
        width: MediaQuery.of(context).size.width,
        duration: const Duration(milliseconds: 800),
        child: Padding(
            padding: const EdgeInsets.fromLTRB(30, 12, 30, 0),
            child: Column(children: [
              Container(
                height: 6,
                width: 45,
                decoration: BoxDecoration(
                  borderRadius: BorderRadius.circular(4),
                  color: Colors.grey.shade200,
                ),
              ),
              Padding(
                padding: const EdgeInsets.fromLTRB(0, 18, 0, 0),
                child: Material(
                  color: Colors.white,
                  child: InkWell(
                    borderRadius: BorderRadius.circular(10),
                    onTap: (() async {
                      setState(() {
                        showPickupContainer = true;
                        hideMenuWidget = true;
                      });
                    }),
                    child: Column(
                      children: [
                        Ink(
                          height: 40,
                          width: MediaQuery.of(context).size.width,
                          decoration: BoxDecoration(
                            borderRadius: BorderRadius.circular(10),
                            color: Colors.grey.shade200,
                          ),
                          child: Padding(
                            padding: const EdgeInsets.only(left: 12),
                            child: Row(
                              children: [
                                Container(
                                    height: 30,
                                    width: 30,
                                    decoration: BoxDecoration(
                                        shape: BoxShape.circle,
                                        color: Colors.grey.shade300),
                                    child: const Icon(
                                      Icons.search,
                                      size: 20,
                                    )),
                                const SizedBox(
                                  width: 15,
                                ),
                                Text("Enter Pickup",
                                    textAlign: TextAlign.left,
                                    style: TextStyle(
                                      fontSize: 14,
                                      fontFamily:
                                          GoogleFonts.montserrat().fontFamily,
                                      fontWeight: FontWeight.bold,
                                      letterSpacing: 1.1,
                                    )),
                              ],
                            ),
                          ),
                        ),
                      ],
                    ),
                  ),
                ),
              ),
            ])));
  }
}

Widget buildDashedLine() => const Center(
      child: DottedLine(
        direction: Axis.vertical,
        lineLength: 32,
        dashColor: Colors.black,
      ),
    );




sendOrders() {
    i++;
      // ignore: avoid_single_cascade_in_expression_statements
      sendOrder.child(user.uid)..child('order').child("$i").set({
        'PickUp_Address' : pickUpController.text,
        'delivery_Address' : deliveryController.text,
        'pTime': '${time1.hour} : ${time1.minute}',
        'dTime': '${time2.hour} : ${time2.minute}',
        'Sender_Number' : pickUpPhoneNumber.text,
        'Receiver_Number' : receiverPhoneNumber.text,
        'Your_Number' : yourPhoneNumber.text,
        'cValue' : cValue.text,
        'dType' : buttons.elementAt(dtype.selectedIndex as int).toString(),
        'kgs' : kgs.elementAt(kg.selectedIndex as int).toString(),
        'Total_Amount' : ladu,
        'Total_distance' : placeDistance,
        
      });
    }