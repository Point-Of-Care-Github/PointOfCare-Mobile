import 'package:flutter/material.dart';
import 'package:test/constants/const.dart';
import 'package:test/providers/appointment_services.dart';

class UpcomingAppointmentCard extends StatelessWidget {
  final us;
  final doc;
  final appointment;
  UpcomingAppointmentCard(
      {required this.us, required this.doc, required this.appointment});

  AppointmentServices appointmentServices = AppointmentServices();

  @override
  Widget build(BuildContext context) {
    return Container(
      margin: EdgeInsets.symmetric(horizontal: 10, vertical: 10),
      padding: const EdgeInsets.symmetric(vertical: 5),
      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.circular(10),
        boxShadow: const [
          BoxShadow(
            color: Colors.black12,
            blurRadius: 15,
          ),
        ],
      ),
      child: Container(
        width: MediaQuery.of(context).size.width - 50,
        padding: EdgeInsets.symmetric(horizontal: 12),
        child: Column(
          children: [
            ListTile(
              title: Text(
                'Dr. ${us.userName}',
                style: const TextStyle(
                  fontWeight: FontWeight.bold,
                ),
              ),
              subtitle: Text(
                "${doc.specialization}",
                style:
                    TextStyle(color: Colors.grey, fontWeight: FontWeight.w600),
              ),
              trailing: Container(
                padding: EdgeInsets.only(bottom: 20),
                child: FittedBox(
                  fit: BoxFit.contain,
                  child: Row(children: [
                    Icon(
                      Icons.star,
                      size: 18,
                      color: Colors.amber,
                    ),
                    SizedBox(
                      width: 5,
                    ),
                    Text(
                      "5.0",
                      style: TextStyle(fontWeight: FontWeight.bold),
                    )
                  ]),
                ),
              ),
              leading: CircleAvatar(
                radius: 25,
                backgroundImage: NetworkImage(doc.image!),
              ),
            ),
            Container(
              padding: EdgeInsets.all(15),
              decoration: BoxDecoration(
                  color: Colors.grey.shade100,
                  borderRadius: BorderRadius.circular(10)),
              child: IntrinsicHeight(
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.spaceAround,
                  children: [
                    Wrap(
                      crossAxisAlignment: WrapCrossAlignment.center,
                      children: [
                        Image.asset(
                          "assets/images/calendar1.png",
                          height: 23,
                        ),
                        const SizedBox(width: 5),
                        Text(
                          appointment.date,
                        ),
                      ],
                    ),

                    const VerticalDivider(
                      thickness: 1,
                      width: 12,
                    ),
                    Wrap(
                      crossAxisAlignment: WrapCrossAlignment.center,
                      children: [
                        Image.asset(
                          "assets/images/clock.png",
                          height: 23,
                        ),
                        const SizedBox(width: 5),
                        Text(
                          appointment.time,
                        ),
                      ],
                    ),
                    // Row(
                    //   children: [
                    //     Container(
                    //       padding: const EdgeInsets.all(5),
                    //       decoration: const BoxDecoration(
                    //         color: Colors.blue,
                    //         shape: BoxShape.circle,
                    //       ),
                    //     ),
                    //     const SizedBox(width: 5),
                    //     Text(
                    //       appointment.status,
                    //       style: const TextStyle(
                    //         color: Colors.black54,
                    //       ),
                    //     ),
                    //   ],
                    // ),
                  ],
                ),
              ),
            ),
            // const SizedBox(height: 15),
            // Row(
            //   mainAxisAlignment: MainAxisAlignment.spaceEvenly,
            //   children: [
            //     InkWell(
            //       onTap: () {
            //         print(appointment.id);
            //         appointmentServices.cancelAppointment(
            //             context: context,
            //             id: appointment.id,
            //             status: 'cancelled');
            //       },
            //       child: Container(
            //         width: 150,
            //         padding: const EdgeInsets.symmetric(vertical: 12),
            //         decoration: BoxDecoration(
            //           color: const Color(0xFFF4F6FA),
            //           borderRadius: BorderRadius.circular(10),
            //         ),
            //         child: const Center(
            //           child: Text(
            //             "Cancel",
            //             style: TextStyle(
            //               fontSize: 16,
            //               fontWeight: FontWeight.w500,
            //               color: Colors.black54,
            //             ),
            //           ),
            //         ),
            //       ),
            //     ),
            //     InkWell(
            //       onTap: () async {
            //         appointmentServices.getAppointmentInformation(
            //             context: context, id: appointment.id);
            //       },
            //       child: Container(
            //         width: 150,
            //         padding: const EdgeInsets.symmetric(vertical: 12),
            //         decoration: BoxDecoration(
            //           color: Theme.of(context).primaryColor,
            //           borderRadius: BorderRadius.circular(10),
            //         ),
            //         child: const Center(
            //           child: Text(
            //             "Reschedule",
            //             style: TextStyle(
            //               fontSize: 16,
            //               fontWeight: FontWeight.w500,
            //               color: Colors.white,
            //             ),
            //           ),
            //         ),
            //       ),
            //     ),
            //   ],
            // ),
            // const SizedBox(height: 10),
          ],
        ),
      ),
    );
  }
}
