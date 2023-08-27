import 'package:flutter/material.dart';
import 'package:geolocator/geolocator.dart';
import 'package:geocoding/geocoding.dart';
import 'dart:convert';
import 'package:async/async.dart';
import 'package:http/http.dart' as http;
import 'package:flutter_spinkit/flutter_spinkit.dart';
import '../utils/maps_utils.dart';

class NearDoctorList extends StatefulWidget {
  @override
  State<NearDoctorList> createState() => _NearDoctorListState();
}

class _NearDoctorListState extends State<NearDoctorList> {
  double? lat;
  double? long;
  String? address;
  var names = [];
  var images = [];
  var specialization = [];
  var degree = [];
  var waitTime = [];
  var exp = [];
  var satisfied = [];
  var location = [];
  var available = [];
  var fee = [];

  Future<Position> _determinePosition() async {
    bool serviceEnabled;
    LocationPermission permission;

    // Test if location services are enabled.
    serviceEnabled = await Geolocator.isLocationServiceEnabled();
    if (!serviceEnabled) {
      // Location services are not enabled don't continue
      // accessing the position and request users of the
      // App to enable the location services.
      return Future.error('Location services are disabled.');
    }

    permission = await Geolocator.checkPermission();
    if (permission == LocationPermission.denied) {
      permission = await Geolocator.requestPermission();
      if (permission == LocationPermission.denied) {
        // Permissions are denied, next time you could try
        // requesting permissions again (this is also where
        // Android's shouldShowRequestPermissionRationale
        // returned true. According to Android guidelines
        // your App should show an explanatory UI now.
        return Future.error('Location permissions are denied');
      }
    }

    if (permission == LocationPermission.deniedForever) {
      // Permissions are denied forever, handle appropriately.
      return Future.error(
          'Location permissions are permanently denied, we cannot request permissions.');
    }

    // When we reach here, permissions are granted and we can
    // continue accessing the position of the device.
    return await Geolocator.getCurrentPosition(
        desiredAccuracy: LocationAccuracy.high);
  }

  getLatLong() {
    Future<Position> data = _determinePosition();
    data.then((value) async {
      setState(() {
        lat = value.latitude;
        long = value.longitude;
      });
      List<Placemark> placemarks =
          await placemarkFromCoordinates(value.latitude, value.longitude);
      setState(() {
        address = placemarks[0].locality!;
      });
      print(lat);
      print(long);
      print(address);
      const url = 'http://127.0.0.1:5000/NearbyDoctors';
      await http.post(Uri.parse(url),
          body: json.encode(
              {'latitude': lat, 'longitude': long, 'address': address}));
      final doctorData = await http.get(Uri.parse(url));
      final decoded = json.decode(doctorData.body) as Map<String, dynamic>;
      setState(() {
        names = decoded['Names'];
        images = decoded['Images'];
        specialization = decoded['Specialization'];
        degree = decoded['Degree'];
        waitTime = decoded['WaitTime'];
        exp = decoded['Experience'];
        satisfied = decoded['Satisfied'];
        location = decoded['location'];
        available = decoded['AvailableTime'];
        fee = decoded['Fee'];
      });
      print(names);
    }).catchError((error) {
      print("Error $error");
    });
  }

  @override
  void initState() {
    super.initState();
    getLatLong();
  }

  void _showDoctorDetailsModal(int index, double deviceSize) {
    showModalBottomSheet(
      context: context,
      builder: (BuildContext context) {
        return Container(
          height: deviceSize,
          padding: EdgeInsets.all(16.0),
          decoration: BoxDecoration(
            borderRadius: BorderRadius.only(
              topLeft: Radius.circular(20),
              topRight: Radius.circular(20),
            ),
          ),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Row(
                children: [
                  ClipRRect(
                    borderRadius: BorderRadius.circular(20.0),
                    child: Image.network(
                      images[index],
                      height: 100,
                      width: 100,
                    ),
                  ),
                  Container(
                    margin: EdgeInsets.only(left: 5),
                    child: Text(
                      names[index],
                      style: TextStyle(
                        fontSize: 15,
                        fontWeight: FontWeight.bold,
                        fontFamily: 'Poppins',
                      ),
                    ),
                  ),
                ],
              ),
              SizedBox(height: 8.0),
              Text(
                'Specialization: ${specialization[index]}',
                style: TextStyle(fontFamily: 'Poppins', fontSize: 13),
              ),
              Text(
                'Degree: ${degree[index]}',
                style: TextStyle(fontFamily: 'Poppins', fontSize: 13),
              ),
              Text(
                'Wait Time: ${waitTime[index]}',
                style: TextStyle(fontFamily: 'Poppins', fontSize: 13),
              ),
              Text(
                'Experience: ${exp[index]}',
                style: TextStyle(fontFamily: 'Poppins', fontSize: 13),
              ),
              Text(
                'Satisfied Patients: ${satisfied[index]}',
                style: TextStyle(fontFamily: 'Poppins', fontSize: 13),
              ),
              Text(
                'Location: ${location[index]}',
                style: TextStyle(fontFamily: 'Poppins', fontSize: 13),
              ),
              Text(
                'Available Time: ${available[index]}',
                style: TextStyle(fontFamily: 'Poppins', fontSize: 13),
              ),
              Text(
                'Fee: ${fee[index]}',
                style: TextStyle(fontFamily: 'Poppins', fontSize: 13),
              ),
              Align(
                alignment: Alignment.bottomRight,
                child: ElevatedButton(
                  onPressed: () {
                    MapUtils.openMap(location[index]);
                  },
                  style: ElevatedButton.styleFrom(
                    padding: EdgeInsets.zero,
                    shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(50),
                    ),
                  ),
                  child: Ink(
                    decoration: BoxDecoration(
                      gradient: const LinearGradient(
                        begin: Alignment.topRight,
                        end: Alignment.bottomLeft,
                        colors: [
                          Color(0xFFB9A0E6),
                          Color(0xFF8587DC),
                        ],
                      ),
                      borderRadius: BorderRadius.circular(50),
                    ),
                    child: Container(
                      width: deviceSize / 3,
                      height: deviceSize / 15,
                      alignment: Alignment.center,
                      child: Center(
                        child: Text(
                          'Open Directions',
                          style: TextStyle(
                            fontSize: 16,
                            fontFamily: 'Poppins',
                            fontWeight: FontWeight.w600,
                          ),
                        ),
                      ),
                    ),
                  ),
                ),
              ),
            ],
          ),
        );
      },
    );
  }

  @override
  Widget build(BuildContext context) {
    final deviceSize = MediaQuery.of(context).size;
    double modalHeight = deviceSize.height * 0.8;

    return Align(
      alignment: Alignment.center,
      child: Builder(
        builder: (BuildContext context) {
          if (names.isEmpty) {
            return Container(
              margin: EdgeInsets.only(top: deviceSize.height * 0.24),
              child: Column(
                children: [
                  SpinKitPouringHourGlassRefined(
                    color: Theme.of(context).primaryColor,
                    size: 50.0,
                  ),
                  Text(
                    'Please wait!!!',
                    style: TextStyle(
                        fontFamily: 'Poppins',
                        fontSize: 10,
                        color: Theme.of(context).primaryColor),
                  ),
                ],
              ),
            );
          } else {
            return SizedBox(
              width: deviceSize.width * 0.85,
              child: GridView.builder(
                itemCount: names.length,
                gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
                  crossAxisCount: deviceSize.width > 600 ? 3 : 2,
                  childAspectRatio: 1.0,
                  crossAxisSpacing: 10.0,
                  mainAxisSpacing: 10.0,
                ),
                itemBuilder: (BuildContext context, int index) {
                  return GestureDetector(
                    onTap: () => _showDoctorDetailsModal(index, modalHeight),
                    child: Card(
                      elevation: 10,
                      shape: RoundedRectangleBorder(
                        borderRadius: BorderRadius.circular(8),
                      ),
                      child: GridTile(
                        child: Image.network(
                          images[index],
                          fit: BoxFit.cover,
                        ),
                        footer: GridTileBar(
                          backgroundColor: Colors.black54,
                          title: Text(
                            names[index],
                            textAlign: TextAlign.center,
                            style: TextStyle(fontSize: 14.0),
                          ),
                        ),
                      ),
                    ),
                  );
                },
              ),
            );
          }
        },
      ),
    );
  }
}
