import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:test/models/appointment.dart';
import 'package:test/providers/auth.dart';
import 'package:test/providers/doctor.dart';
import 'package:test/providers/appointment_services.dart';
import 'package:test/screens/Appointments/widgets/upcomingAppointmentCard.dart';

class CompletedSchedule extends StatelessWidget {
  final bool flag;

  CompletedSchedule({required this.flag});
  bool isCompletedAppointment(List<Appointment> appointmentsList) {
    for (final appointment in appointmentsList) {
      if (appointment.status != 'completed') {
        continue;
      } else {
        return false;
      }
    }
    return true;
  }

  @override
  Widget build(BuildContext context) {
    AppointmentServices appointmentServices = AppointmentServices();
    final user = Provider.of<Auth>(context);
    final role = user.role;
    final appointmentsList =
        Provider.of<AppointmentServices>(context).appointmentsList;
    print("Hello:" + appointmentsList.toString());
    final doctorAppointments = appointmentsList
        .where((element) => element.doctorId == user.userId)
        .toList();
    final userAppointments = appointmentsList
        .where((element) => element.userId == user.userId)
        .toList();
    final doctor = Provider.of<Doctor>(context).doctors;

    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 15),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          role == 'Doctor'
              ? Container(
                  height: flag ? 200 : 500,
                  child: ListView.builder(
                    scrollDirection: flag ? Axis.horizontal : Axis.vertical,
                    itemCount: doctorAppointments.length,
                    itemBuilder: (context, index) {
                      final appointment = doctorAppointments[index];
                      return appointment.status == 'completed'
                          ? Container(
                              padding: const EdgeInsets.symmetric(vertical: 5),
                              decoration: BoxDecoration(
                                color: Colors.white,
                                borderRadius: BorderRadius.circular(10),
                                boxShadow: const [
                                  BoxShadow(
                                    color: Colors.black12,
                                    blurRadius: 4,
                                    spreadRadius: 2,
                                  ),
                                ],
                              ),
                              child: SizedBox(
                                width: MediaQuery.of(context).size.width,
                                child: Column(
                                  children: [
                                    ListTile(
                                      title: Text(
                                        appointment.name,
                                        style: const TextStyle(
                                          fontWeight: FontWeight.bold,
                                        ),
                                      ),
                                      subtitle:
                                          Text("Reason: ${appointment.reason}"),
                                    ),
                                    const Padding(
                                      padding:
                                          EdgeInsets.symmetric(horizontal: 15),
                                      child: Divider(
                                        thickness: 1,
                                        height: 20,
                                      ),
                                    ),
                                    Row(
                                      mainAxisAlignment:
                                          MainAxisAlignment.spaceAround,
                                      children: [
                                        Row(
                                          children: [
                                            const Icon(
                                              Icons.calendar_month,
                                              color: Colors.black54,
                                            ),
                                            const SizedBox(width: 5),
                                            Text(
                                              appointment.date,
                                              style: const TextStyle(
                                                color: Colors.black54,
                                              ),
                                            ),
                                          ],
                                        ),
                                        Row(
                                          children: [
                                            const Icon(
                                              Icons.access_time_filled,
                                              color: Colors.black54,
                                            ),
                                            const SizedBox(width: 5),
                                            Text(
                                              appointment.time,
                                              style: const TextStyle(
                                                color: Colors.black54,
                                              ),
                                            ),
                                          ],
                                        ),
                                        Row(
                                          children: [
                                            Container(
                                              padding: const EdgeInsets.all(5),
                                              decoration: const BoxDecoration(
                                                color: Colors.blue,
                                                shape: BoxShape.circle,
                                              ),
                                            ),
                                            const SizedBox(width: 5),
                                            Text(
                                              appointment.status,
                                              style: const TextStyle(
                                                color: Colors.black54,
                                              ),
                                            ),
                                          ],
                                        ),
                                      ],
                                    ),
                                    const SizedBox(height: 10),
                                  ],
                                ),
                              ),
                            )
                          : Container();
                    },
                  ),
                )
              : Container(
                  height: flag ? 170 : 500,
                  child: ListView.builder(
                      scrollDirection: flag ? Axis.horizontal : Axis.vertical,
                      itemCount: userAppointments.length,
                      itemBuilder: (context, index) {
                        final appointment = userAppointments[index];
                        final doc = doctor.firstWhere((element) =>
                            element.userId == appointment.doctorId);
                        final us = user.users.firstWhere((element) =>
                            element.userId == appointment.doctorId);
                        return appointment.status == 'completed'
                            ? UpcomingAppointmentCard(
                                us: us, doc: doc, appointment: appointment)
                            : Container();
                      })),
        ],
      ),
    );
  }
}
