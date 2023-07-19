import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:test/providers/auth.dart';
import 'package:test/providers/profile.dart';
import 'package:test/screens/diagnosis.dart';
import 'package:test/screens/doctorsRecommendation.dart';
import 'package:test/screens/email-otp.dart';
import 'package:test/screens/resultScreen.dart';
import 'package:test/screens/symptomsScreen.dart';
import './screens/authentication.dart';
import './screens/tabScreen.dart';
import './screens/homeScreen.dart';
import './screens/profile.dart';
import './screens/settings.dart';
import 'models/user.dart';
import 'models/users.dart';
import './screens/xrayDiagnosis.dart';
import './screens/aboutUs.dart';
import './screens/ctscanDiagnosis.dart';
import './screens/nearbyDoctors.dart';
import './screens/reportScreen.dart';
import './screens/xrayUploadScreen.dart';
import 'models/diseaseLabels.dart';
import 'models/reports.dart';
import 'screens/addProfile.dart';

void main() {
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});
  @override
  Widget build(BuildContext context) {
    MaterialColor createMaterialColor(Color color) {
      List strengths = <double>[.05];
      Map<int, Color> swatch = {};
      final int r = color.red, g = color.green, b = color.blue;

      for (int i = 1; i < 10; i++) {
        strengths.add(0.1 * i);
      }
      for (var strength in strengths) {
        final double ds = 0.5 - strength;
        swatch[(strength * 1000).round()] = Color.fromRGBO(
          r + ((ds < 0 ? r : (255 - r)) * ds).round(),
          g + ((ds < 0 ? g : (255 - g)) * ds).round(),
          b + ((ds < 0 ? b : (255 - b)) * ds).round(),
          1,
        );
      }
      return MaterialColor(color.value, swatch);
    }

    return MultiProvider(
        providers: [
          ChangeNotifierProvider<Auth>(
            create: (ctx) => Auth(),
          ),
          ChangeNotifierProvider<Doctor>(
            create: (ctx) => Doctor.fromdoc(),
          ),
          ChangeNotifierProvider<Patient>(
            create: (ctx) => Patient.frompat(),
          ),
          ChangeNotifierProvider<Radiologist>(
            create: (ctx) => Radiologist.fromrad(),
          ),
          ChangeNotifierProvider<User>(
            create: (ctx) => User.fromuser(),
          ),
          ChangeNotifierProvider<DiseaseLabels>(
            create: (ctx) => DiseaseLabels(),
          ),
          ChangeNotifierProvider<Reports>(
            create: (ctx) => Reports(),
          ),
        ],
        child: Consumer<Auth>(
          builder: (context, auth, _) => MaterialApp(
            debugShowCheckedModeBanner: false,
            title: 'Point-Of-Care',
            theme: ThemeData(
              primarySwatch: createMaterialColor(Color(0xFF7F80D2)),
              scaffoldBackgroundColor: Colors.white,
            ),
            home: auth.isAuth ? TabsScreen() : Authentication(),
            routes: {
              TabsScreen.routeName: (ctx) => TabsScreen(),
              HomeScreen.routeName: (ctx) => HomeScreen(),
              Setting.routeName: (ctx) => Setting(),
              Profile.routeName: (ctx) => Profile(),
              XrayDiagnosis.routeName: (ctx) => XrayDiagnosis(),
              CTscanDiagnosis.routeName: (ctx) => CTscanDiagnosis(),
              AboutUs.routeName: (ctx) => AboutUs(),
              DoctorRecommendationScreen.routeName: (ctx) =>
                  DoctorRecommendationScreen(),
              SymptomsScreen.routeName: (ctx) => SymptomsScreen(),
              Diagnosis.routeName: (ctx) => Diagnosis(),
              NearbyDoctors.routeName: (ctx) => ReportScreen(),
              XrayUploadScreen.routeName: (ctx) => XrayUploadScreen(),
              ResultScreen.routeName: (ctx) => ResultScreen(),
              ReportScreen.routeName: (ctx) => ReportScreen(),
              DoctorProfile.routeName: (ctx) => DoctorProfile(),
              EmailOtp.routeName: (ctx) => EmailOtp(),
              DoctorRecommendationScreen.routeName: (ctx) =>
                  DoctorRecommendationScreen(),
            },
            // onUnknownRoute: (settings) {
            //   return MaterialPageRoute(builder: (ctx) => HomeScreen());
            // },
          ),
        ));
  }
}
