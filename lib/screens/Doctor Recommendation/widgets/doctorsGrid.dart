// ignore_for_file: file_names

import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:test/providers/appointment_services.dart';
import 'package:test/providers/auth.dart';
import 'package:test/providers/doctor.dart';
import 'package:test/providers/doctor_profile.dart';
import 'package:test/screens/User%20Profiling/screens/doctorDetail.dart';
// import 'package:test/screens/doctorDetail.dart';
// import 'package:ionicons/ionicons.dart';
// import 'package:test/services/appointment_services.dart';

// ignore: use_key_in_widget_constructors
class DoctorsGrid extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    var doctorProvider = Provider.of<Doctor>(context).doctors;
    final users = Provider.of<Auth>(context, listen: false).users;

    AppointmentServices appointmentServices = AppointmentServices();
    return Container(
      margin: EdgeInsets.only(
        // top: MediaQuery.of(context).size.height * 0.22,
        left: MediaQuery.of(context).size.width * 0.05,
        right: MediaQuery.of(context).size.width * 0.05,
      ),
      child: ListView.builder(
        shrinkWrap: true,
        itemCount: doctorProvider.length,
        itemBuilder: (context, index) {
          final doctor = doctorProvider[index];
          final user =
              users.firstWhere((element) => element.userId == doctor.userId);

          return GestureDetector(
            onTap: () async {
              Navigator.of(context).push(
                MaterialPageRoute(
                    builder: (context) => DoctorDetail(doctor, user)),
              );
            },
            child: Card(
              elevation: 3,
              margin: const EdgeInsets.only(bottom: 18),
              child: Padding(
                padding: const EdgeInsets.all(16),
                child: Row(
                  children: [
                    Container(
                      width: 100,
                      height: 100,
                      decoration: BoxDecoration(
                        borderRadius: BorderRadius.circular(10),
                        image: DecorationImage(
                          image: NetworkImage(
                              doctor.image!), // Use the doctor's image URL
                          fit: BoxFit.cover,
                        ),
                      ),
                    ),
                    const SizedBox(width: 10),
                    Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Text(
                          "Dr. ${user.userName!}",
                          style: const TextStyle(
                            fontSize: 16,
                            fontWeight: FontWeight.bold,
                          ),
                        ),
                        const SizedBox(height: 8),
                        SizedBox(
                          width: 180,
                          child: Text(
                            doctor.specialization!,
                            softWrap: true,
                          ),
                        ),
                        const SizedBox(height: 16),
                        Row(
                          children: [
                            Icon(
                              Icons.star,
                              color: Colors.yellow[700],
                              size: 18,
                            ),
                            const Padding(
                              padding: EdgeInsets.only(left: 4, right: 6),
                              child: Text(
                                "4.0",
                                style: TextStyle(fontWeight: FontWeight.bold),
                              ),
                            ),
                            const Text("195 Reviews"),
                          ],
                        ),
                        const SizedBox(height: 10),
                        Row(
                          children: [
                            const Icon(
                              Icons.watch_later,
                              color: Color(0xFF7165D6),
                              size: 20,
                            ),
                            Padding(
                              padding: const EdgeInsets.only(left: 4, right: 6),
                              child: Text(
                                doctor.time!,
                                style: const TextStyle(
                                    fontWeight: FontWeight.bold),
                              ),
                            ),
                          ],
                        )
                      ],
                    )
                  ],
                ),
              ),
            ),
          );
        },
      ),
    );
  }
}
