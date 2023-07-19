import 'package:flutter/material.dart';
import '../models/gridItem.dart';
import '../screens/aboutUs.dart';
import '../screens/nearbyDoctors.dart';
import '../screens/doctorsRecommendation.dart';
import '../screens/reportScreen.dart';
import '../screens/diagnosis.dart';

class HomeGrid extends StatelessWidget {
  final List<GridItem> _items = [
    GridItem(
      id: 'g1',
      title: 'Diagnosis',
      icon: 'assets/images/diagnostic.png',
    ),
    GridItem(
      id: 'g2',
      title: 'Appointment',
      icon: 'assets/images/appointment.png',
    ),
    GridItem(
      id: 'g3',
      title: 'Nearby Doctors',
      icon: 'assets/images/location.png',
    ),
    GridItem(
      id: 'g4',
      title: 'My Reports',
      icon: 'assets/images/report.png',
    ),
    GridItem(
      id: 'g5',
      title: 'About Us',
      icon: 'assets/images/about.png',
    ),
  ];

  @override
  Widget build(BuildContext context) {
    final deviceSize = MediaQuery.of(context).size;

    return Center(
      child: Container(
        width: deviceSize.width * 0.85,
        margin: EdgeInsets.only(top: deviceSize.height * 0.58),
        decoration: BoxDecoration(
          borderRadius: BorderRadius.circular(30),
        ),
        child: GridView.count(
          mainAxisSpacing: deviceSize.width * 0.03,
          crossAxisCount: 3,
          children: List.generate(5, (index) {
            return GestureDetector(
              onTap: () {
                if (_items[index].title == 'Diagnosis') {
                  Navigator.of(context).push(
                    MaterialPageRoute(builder: (context) => Diagnosis()),
                  );
                }
                if (_items[index].title == 'Appointment') {
                  Navigator.of(context).push(
                    MaterialPageRoute(
                        builder: (context) => DoctorRecommendationScreen()),
                  );
                }
                if (_items[index].title == 'Nearby Doctors') {
                  Navigator.of(context).push(
                    MaterialPageRoute(builder: (context) => NearbyDoctors()),
                  );
                }
                if (_items[index].title == 'My Reports') {
                  Navigator.of(context).push(
                    MaterialPageRoute(builder: (context) => ReportScreen()),
                  );
                }
                if (_items[index].title == 'About Us') {
                  Navigator.of(context).push(
                    MaterialPageRoute(builder: (context) => AboutUs()),
                  );
                }
              },
              child: Card(
                elevation: 20,
                shadowColor: Colors.black,
                color: Colors.white,
                child: Column(
                  children: <Widget>[
                    Container(
                      margin: EdgeInsets.only(top: deviceSize.height * 0.018),
                      child: Image(
                        image: AssetImage(_items[index].icon),
                        width: deviceSize.width * 0.2067,
                        height: deviceSize.width * 0.1097,
                      ),
                    ),
                    Container(
                      margin: EdgeInsets.only(top: deviceSize.height * 0.008),
                      child: Text(
                        _items[index].title,
                        style: TextStyle(
                          fontSize: deviceSize.width * 0.03,
                          color: Color(0xFF8081D4),
                          fontFamily: 'Poppins',
                          fontWeight: FontWeight.w600,
                        ),
                      ),
                    ),
                  ],
                ),
              ),
            );
          }),
        ),
      ),
    );
  }
}
