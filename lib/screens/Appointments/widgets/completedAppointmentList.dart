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
        .where((element) =>
            element.doctorId == user.userId && element.status == 'completed')
        .toList();
    final userAppointments = appointmentsList
        .where((element) =>
            element.userId == user.userId && element.status == 'completed')
        .toList();
    final doctor = Provider.of<Doctor>(context).doctors;
    final deviceSize = MediaQuery.of(context).size;

    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 15),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          role == 'Doctor'
              ? Container(
                  height: !flag ? deviceSize.height * .73 : 180,
                  child: doctorAppointments.length == 0
                      ? Center(
                          child: Text("No completed appointments yet."),
                        )
                      : ListView.builder(
                          padding: EdgeInsets.only(top: 10),
                          scrollDirection:
                              flag ? Axis.horizontal : Axis.vertical,
                          itemCount: doctorAppointments.length,
                          itemBuilder: (context, index) {
                            final appointment = doctorAppointments[index];
                            final doc = doctor.firstWhere((element) =>
                                element.userId == appointment.doctorId);
                            final us = user.users.firstWhere((element) =>
                                element.userId == appointment.doctorId);
                            return appointment.status == 'completed'
                                ? UpcomingAppointmentCard(
                                    us: us, doc: doc, appointment: appointment)
                                : Container();
                          },
                        ),
                )
              : Container(
                  height: !flag ? deviceSize.height * .73 : 180,
                  child: userAppointments.length == 0
                      ? Center(
                          child: Text("No completed appointments yet."),
                        )
                      : ListView.builder(
                          padding: EdgeInsets.only(top: 10),
                          scrollDirection:
                              flag ? Axis.horizontal : Axis.vertical,
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
