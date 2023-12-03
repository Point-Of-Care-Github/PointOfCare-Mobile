// import 'package:firebase_core/firebase_core.dart';

import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:test/constants/const.dart';
import 'package:test/firebase_options.dart';
import 'package:test/providers/appointment_services.dart';
import 'package:test/providers/auth.dart';
import 'package:test/providers/doctor.dart';
import 'package:test/providers/doctor_profile.dart';
import 'package:test/providers/feedback.dart';
import 'package:test/providers/patient.dart';
import 'package:test/providers/patient_profile.dart';
import 'package:test/providers/radiologist.dart';
import 'package:test/providers/report.dart';
import 'package:test/providers/user_provider.dart';
import 'package:test/screens/Appointments/screens/availableDoctors.dart';
import 'package:test/screens/Diagnosis/screens/ctscanDiagnosis.dart';
import 'package:test/screens/Diagnosis/screens/diagnosis.dart';
import 'package:test/screens/Diagnosis/screens/symptomsScreen.dart';
import 'package:test/screens/Diagnosis/screens/xrayDiagnosis.dart';
import 'package:test/screens/Diagnosis/screens/xrayUploadScreen.dart';
import 'package:test/screens/Doctor%20Recommendation/screens/nearbyDoctors.dart';
import 'package:test/screens/Feedback%20and%20Settings/screens/setting.dart';
import 'package:test/screens/Main/screens/aboutUs.dart';
import 'package:test/screens/Main/screens/homeScreen.dart';
import 'package:test/screens/Main/screens/tabScreen.dart';
import 'package:test/screens/Result%20and%20Reporting/screens/reportScreen.dart';
import 'package:test/screens/Result%20and%20Reporting/screens/resultScreen.dart';
import 'package:test/screens/User%20Profiling/screens/addProfile.dart';
import 'package:test/screens/User%20Profiling/screens/authentication.dart';
import 'package:test/screens/User%20Profiling/screens/email-otp.dart';
import 'package:test/screens/User%20Profiling/screens/profile.dart';
import 'utils/reports.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await Firebase.initializeApp(
    options: DefaultFirebaseOptions.currentPlatform,
  );
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
            create: (ctx) => Auth.toauth(),
          ),
          ChangeNotifierProvider<Results>(
            create: (ctx) => Results(),
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
          ChangeNotifierProvider(
            create: (_) => UserProvider(),
          ),
          ChangeNotifierProvider(
            create: (_) => DoctorProvider(),
          ),
          ChangeNotifierProvider(
            create: (_) => AppointmentServices(),
          ),
          ChangeNotifierProvider(
            create: (_) => PatientProvider(),
          ),
          ChangeNotifierProvider<Reports>(
            create: (ctx) => Reports(),
          ),
          ChangeNotifierProvider(
            create: (_) => FeedbackServices(),
          ),
        ],
        child: Consumer<Auth>(
          builder: (context, auth, _) => MaterialApp(
            debugShowCheckedModeBanner: false,
            title: 'Point-Of-Care',
            theme: ThemeData(
                primarySwatch: createMaterialColor(primaryColor),
                scaffoldBackgroundColor: Colors.white,
                fontFamily: 'Poppins'),
            home:

                // AddProfile(),

                auth.userId != null ? TabsScreen() : Authentication(),
            routes: {
              TabsScreen.routeName: (ctx) => TabsScreen(),
              HomeScreen.routeName: (ctx) => HomeScreen(),
              SettingScreen.routeName: (ctx) => SettingScreen(),
              Profile.routeName: (ctx) => Profile(),
              XrayDiagnosis.routeName: (ctx) => XrayDiagnosis(),
              CTscanDiagnosis.routeName: (ctx) => CTscanDiagnosis(),
              AboutUs.routeName: (ctx) => AboutUs(),
              // DoctorRecommendationScreen.routeName: (ctx) =>
              //     DoctorRecommendationScreen(),
              SymptomsScreen.routeName: (ctx) => SymptomsScreen(),
              Diagnosis.routeName: (ctx) => Diagnosis(),
              NearbyDoctors.routeName: (ctx) => NearbyDoctors(),
              XrayUploadScreen.routeName: (ctx) => XrayUploadScreen(),
              ResultScreen.routeName: (ctx) => ResultScreen(),
              ReportScreen.routeName: (ctx) => ReportScreen(),
              DoctorProfile.routeName: (ctx) => DoctorProfile(),
              //AddProfile.routeName: (ctx) => AddProfile(),

              EmailOtp.routeName: (ctx) => EmailOtp(),
              // DoctorRecommendationScreen.routeName: (ctx) =>
              //     DoctorRecommendationScreen(),
              AvailableDoctorsScreen.routeName: (ctx) =>
                  AvailableDoctorsScreen()
            },
            // onUnknownRoute: (settings) {
            //   return MaterialPageRoute(builder: (ctx) => HomeScreen());
            // },
          ),
        ));
  }
}
