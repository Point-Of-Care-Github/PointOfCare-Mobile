import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter_stripe/flutter_stripe.dart';
import 'package:provider/provider.dart';
import 'package:syncfusion_flutter_datepicker/datepicker.dart';
import 'package:intl/intl.dart';
import 'package:test/providers/appointment_services.dart';
import 'package:test/providers/auth.dart';
import 'package:http/http.dart' as http;
import 'package:test/providers/doctor.dart';
import 'package:test/utils/snack_bar_util.dart';

class BookAppointment extends StatefulWidget {
  static const routeName = '/book-appointment';

  Doctor doctor;
  BookAppointment(this.doctor);

  @override
  State<BookAppointment> createState() => _BookAppointmentState();
}

class _BookAppointmentState extends State<BookAppointment> {
  var appointmentService;

  @override
  void initState() {
    appointmentService =
        Provider.of<AppointmentServices>(context, listen: false);
    super.initState();
  }

  String selectedAge = '';
  bool _isLoading = false;
  List<String> age = [
    "0-10",
    "10-20",
    "20-30",
    "30-40",
    "40-50",
    "50-60",
    "60+"
  ];
  int id = 1;
  String radioButtonItem = 'Male';
  DateTime? selectedDate;
  String selectedTime = '';
  final TextEditingController _nameController = TextEditingController();
  final TextEditingController _contactController = TextEditingController();
  final TextEditingController _reasonController = TextEditingController();
  final TextEditingController _dateController = TextEditingController();
  Map<String, dynamic>? paymentIntentData;

  Future<void> makePayment() async {
    try {
      paymentIntentData = await createPaymentIntent('20', 'USD');
      await Stripe.instance.initPaymentSheet(
          paymentSheetParameters: SetupPaymentSheetParameters(
              paymentIntentClientSecret: paymentIntentData!['client_secret'],
              googlePay: PaymentSheetGooglePay(merchantCountryCode: 'US'),
              merchantDisplayName: "Point-Of-Care"));

      displayPaymentSheet();
    } catch (c) {
      print(c.toString());
    }
  }

  displayPaymentSheet() async {
    try {
      await Stripe.instance.initPaymentSheet(
          paymentSheetParameters: SetupPaymentSheetParameters(
              merchantDisplayName: "Point-Of-Care",
              paymentIntentClientSecret: paymentIntentData!['client_secret']));
      await Stripe.instance.presentPaymentSheet();
      setState(() {
        paymentIntentData = null;
      });

      showSnackBar(context, "Paid successfully!");
    } on StripeException catch (e) {
      print(e.toString());
      showDialog(
          context: context,
          builder: (context) => AlertDialog(
                content: Text("Cancelled."),
              ));
    }
  }

  createPaymentIntent(String amount, String currency) async {
    try {
      Map<String, dynamic> body = {
        'amount': calculateAmount(amount),
        'currency': currency,
        'payment_method_types[]': 'card'
      };

      var response = await http.post(
          Uri.parse("https://api.stripe.com/v1/payment_intents"),
          body: body,
          headers: {
            "Authorization":
                "Bearer sk_test_51OLPrsJlgl4sLrLcnH9Qid8FmH5q97cM9MwLO5sSfumgtxlWFhnGKss4IHOT3wKcpPzvbzyDCmUXwW12IcK74oJO00epPjgwkH",
            "Content-Type": "application/x-www-form-urlencoded"
          });
      return jsonDecode(response.body.toString());
    } catch (e) {
      print(e.toString());
    }
  }

  calculateAmount(String amount) {
    final price = int.parse(amount) * 100;
    return price.toString();
  }

  void addAppointment(String doctorId, String userId) {
    setState(() {
      _isLoading = true;
    });
    appointmentService.addAppointment(
      context: context,
      userId: userId,
      doctorId: doctorId,
      gender: radioButtonItem,
      contact: _contactController.text,
      reason: _reasonController.text,
      status: "confirmed",
      date: _dateController.text,
      time: selectedTime,
      name: _nameController.text,
      age: selectedAge,
    );
  }

  @override
  Widget build(BuildContext context) {
    final deviceSize = MediaQuery.of(context).size;
    final user = Provider.of<Auth>(context);
    print(user.userId);
    DateTime parseTime(String timeStr) {
      final parts = timeStr.split(' ');
      final timeParts = parts[0].split(':');
      int hours = int.parse(timeParts[0]);
      int minutes = int.parse(timeParts[1]);

      if (parts[1] == 'P.M' && hours != 12) {
        hours += 12;
      } else if (parts[1] == 'A.M' && hours == 12) {
        hours = 0;
      }

      return DateTime(0, 1, 1, hours, minutes);
    }

    List<String> splitTimes = widget.doctor.time!.split("-");
    print(splitTimes);
    DateTime startTime = parseTime(splitTimes[0]);
    print(startTime);
    DateTime endTime = parseTime(splitTimes[1]);
    print(endTime);

    List<String> timeList = [];

// Generate time slots
    while (startTime.isBefore(endTime)) {
      timeList.add(DateFormat.jm().format(startTime));
      startTime = startTime.add(const Duration(minutes: 30));
    }

// Add the end time
    timeList.add(DateFormat.jm().format(endTime));

    return Scaffold(
      body: SingleChildScrollView(
        child: Stack(
          children: <Widget>[
            // Header Image
            const Image(
              image: AssetImage('assets/images/eclipse.png'),
            ),

            // Title
            Container(
              margin: EdgeInsets.only(
                top: deviceSize.height * 0.1,
                left: deviceSize.width * 0.2,
              ),
              child: Text(
                'Schedule Appointment',
                style: TextStyle(
                  color: const Color(0xff200E32).withOpacity(0.8),
                  fontFamily: 'Poppins',
                  fontWeight: FontWeight.w700,
                  fontSize: 20,
                ),
              ),
            ),

            // Back Button
            Container(
              margin: EdgeInsets.only(
                top: deviceSize.height * 0.09,
                left: deviceSize.width * 0.05,
              ),
              child: CupertinoNavigationBarBackButton(
                color: const Color(0xFF8587DC),
                onPressed: () {
                  Navigator.pop(context);
                },
              ),
            ),

            // Form
            Container(
              height: deviceSize.height * 1.45,
              margin: EdgeInsets.only(
                top: deviceSize.width * 0.35,
                left: deviceSize.width * 0.05,
              ),
              padding: const EdgeInsets.all(20),
              child: Column(
                children: [
                  Row(
                    children: [
                      const Icon(Icons.account_circle_outlined,
                          color: Colors.grey),
                      const SizedBox(
                        width: 10,
                      ),
                      Text(
                        "Patient Name",
                        style: TextStyle(
                          fontFamily: "League Spartan",
                          fontSize: deviceSize.width * 0.04,
                          color: Colors.grey,
                          fontWeight: FontWeight.w500,
                        ),
                      ),
                    ],
                  ),
                  Padding(
                    padding: const EdgeInsets.only(bottom: 2, left: 6),
                    child: TextField(
                      decoration: InputDecoration(
                        border: const UnderlineInputBorder(
                          borderSide: BorderSide(width: 1),
                        ),
                        hintText: 'Enter patient name',
                        hintStyle: TextStyle(
                            fontSize: deviceSize.width * 0.035,
                            fontFamily: 'League Spartan',
                            color: Colors.black26),
                      ),
                      controller: _nameController,
                    ),
                  ),
                  const SizedBox(
                    height: 10,
                  ),
                  Row(
                    children: [
                      const Icon(Icons.app_registration_rounded,
                          color: Colors.grey),
                      const SizedBox(
                        width: 10,
                      ),
                      Text(
                        "Select your age range",
                        style: TextStyle(
                          fontFamily: "League Spartan",
                          fontSize: deviceSize.width * 0.04,
                          color: Colors.grey,
                          fontWeight: FontWeight.w500,
                        ),
                      ),
                    ],
                  ),
                  const SizedBox(
                    height: 5,
                  ),
                  SizedBox(
                    height: 100,
                    child: ListView.builder(
                      scrollDirection: Axis.horizontal,
                      itemCount: age.length,
                      itemBuilder: (context, index) {
                        final ageRange = age[index];
                        final isSelected = selectedAge == ageRange;

                        return InkWell(
                          onTap: () {
                            setState(() {
                              selectedAge = ageRange;
                            });
                          },
                          child: Container(
                            margin: const EdgeInsets.all(10),
                            padding: const EdgeInsets.symmetric(vertical: 5),
                            decoration: BoxDecoration(
                              color: isSelected
                                  ? Theme.of(context)
                                      .primaryColor
                                      .withOpacity(0.5)
                                  : Colors.white,
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
                              width: deviceSize.width * 0.2,
                              child: Center(
                                child: Text(
                                  ageRange,
                                  style: TextStyle(
                                    color: isSelected
                                        ? Colors.white
                                        : Colors.black,
                                    fontSize: deviceSize.width * 0.04,
                                    fontFamily: 'League Spartan',
                                  ),
                                ),
                              ),
                            ),
                          ),
                        );
                      },
                    ),
                  ),
                  const SizedBox(
                    height: 10,
                  ),
                  Row(
                    children: [
                      const Icon(Icons.call, color: Colors.grey),
                      const SizedBox(
                        width: 10,
                      ),
                      Text(
                        "Contact Number",
                        style: TextStyle(
                          fontFamily: "League Spartan",
                          fontSize: deviceSize.width * 0.04,
                          color: Colors.grey,
                          fontWeight: FontWeight.w500,
                        ),
                      ),
                    ],
                  ),
                  Padding(
                    padding: const EdgeInsets.only(bottom: 2, left: 6),
                    child: TextField(
                      decoration: InputDecoration(
                        border: const UnderlineInputBorder(
                          borderSide: BorderSide(width: 1),
                        ),
                        hintText: 'Enter patient Contact number',
                        hintStyle: TextStyle(
                            fontSize: deviceSize.width * 0.035,
                            fontFamily: 'League Spartan',
                            color: Colors.black26),
                      ),
                      controller: _contactController,
                    ),
                  ),
                  const SizedBox(
                    height: 10,
                  ),
                  Row(
                    children: [
                      const Icon(Icons.group, color: Colors.grey),
                      const SizedBox(
                        width: 10,
                      ),
                      Text(
                        "Gender",
                        style: TextStyle(
                          fontFamily: "League Spartan",
                          fontSize: deviceSize.width * 0.04,
                          color: Colors.grey,
                          fontWeight: FontWeight.w500,
                        ),
                      ),
                    ],
                  ),
                  const SizedBox(
                    height: 5,
                  ),
                  Row(
                    children: [
                      Radio(
                        value: 1,
                        groupValue: id,
                        onChanged: (val) {
                          setState(() {
                            id = 1;
                            radioButtonItem = 'Male';
                          });
                        },
                      ),
                      Text(
                        'Male',
                        style: TextStyle(
                          fontFamily: 'League Spartan',
                          fontSize: deviceSize.width * 0.04,
                          fontWeight: FontWeight.w600,
                          color: const Color(0xFF696969),
                        ),
                      ),
                      Radio(
                        value: 2,
                        groupValue: id,
                        onChanged: (val) {
                          setState(() {
                            radioButtonItem = 'Female';
                            id = 2;
                          });
                        },
                      ),
                      Text(
                        'Female',
                        style: TextStyle(
                          fontFamily: 'League Spartan',
                          fontSize: deviceSize.width * 0.04,
                          fontWeight: FontWeight.w600,
                          color: const Color(0xFF696969),
                        ),
                      ),
                    ],
                  ),
                  const SizedBox(
                    height: 10,
                  ),
                  Row(
                    children: [
                      const Icon(Icons.calendar_month, color: Colors.grey),
                      const SizedBox(
                        width: 10,
                      ),
                      Text(
                        "Select the date for appointment",
                        style: TextStyle(
                          fontFamily: "League Spartan",
                          fontSize: deviceSize.width * 0.04,
                          color: Colors.grey,
                          fontWeight: FontWeight.w500,
                        ),
                      ),
                    ],
                  ),
                  Container(
                    height: 250,
                    margin: const EdgeInsets.symmetric(horizontal: 10),
                    child: SfDateRangePicker(
                      onSelectionChanged:
                          (DateRangePickerSelectionChangedArgs args) {
                        setState(() {
                          selectedDate = args.value;
                          String formattedDate =
                              DateFormat('dd-MM-yyyy').format(selectedDate!);
                          _dateController.text = formattedDate;
                        });
                      },
                      selectionMode: DateRangePickerSelectionMode.single,
                      minDate: DateTime.now(),
                      maxDate: DateTime(2040, 10, 20),
                      headerStyle: const DateRangePickerHeaderStyle(
                        textStyle: TextStyle(
                          fontSize: 14,
                          color: Colors.black87,
                          fontFamily: 'League Spartan',
                        ),
                      ),
                      monthCellStyle: const DateRangePickerMonthCellStyle(
                        textStyle: TextStyle(
                          fontSize: 12,
                          fontFamily: 'League Spartan',
                        ),
                      ),
                    ),
                  ),
                  Row(
                    children: [
                      const Icon(Icons.watch_later_outlined,
                          color: Colors.grey),
                      const SizedBox(
                        width: 10,
                      ),
                      Text(
                        "Select the time for appointment",
                        style: TextStyle(
                          fontFamily: "League Spartan",
                          fontSize: deviceSize.width * 0.04,
                          color: Colors.grey,
                          fontWeight: FontWeight.w500,
                        ),
                      ),
                    ],
                  ),
                  const SizedBox(
                    height: 5,
                  ),
                  SizedBox(
                    height: 100,
                    child: ListView.builder(
                      scrollDirection: Axis.horizontal,
                      itemCount: timeList.length,
                      itemBuilder: (context, index) {
                        final timeSlot = timeList[index];
                        final isSelected = selectedTime == timeSlot;

                        return InkWell(
                          onTap: () {
                            setState(() {
                              selectedTime = timeSlot;
                            });
                          },
                          child: Container(
                            margin: const EdgeInsets.all(10),
                            padding: const EdgeInsets.symmetric(vertical: 5),
                            decoration: BoxDecoration(
                              color: isSelected
                                  ? Theme.of(context)
                                      .primaryColor
                                      .withOpacity(0.5)
                                  : Colors.white,
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
                              width: deviceSize.width * 0.2,
                              child: Center(
                                child: Text(
                                  timeSlot,
                                  style: TextStyle(
                                    color: isSelected
                                        ? Colors.white
                                        : Colors.black,
                                    fontSize: deviceSize.width * 0.04,
                                    fontFamily: 'League Spartan',
                                  ),
                                ),
                              ),
                            ),
                          ),
                        );
                      },
                    ),
                  ),
                  const SizedBox(
                    height: 10,
                  ),
                  Row(
                    children: [
                      const Icon(Icons.note_add, color: Colors.grey),
                      const SizedBox(
                        width: 10,
                      ),
                      Text(
                        "Write reason for appointment",
                        style: TextStyle(
                          fontFamily: "League Spartan",
                          fontSize: deviceSize.width * 0.04,
                          color: Colors.grey,
                          fontWeight: FontWeight.w500,
                        ),
                      ),
                    ],
                  ),
                  Padding(
                    padding: const EdgeInsets.all(8),
                    child: TextField(
                      decoration: InputDecoration(
                        border: const OutlineInputBorder(),
                        hintText: 'Enter a reason',
                        hintStyle: TextStyle(
                          fontSize: deviceSize.width * 0.035,
                          fontFamily: 'League Spartan',
                          color: Colors.black26,
                        ),
                      ),
                      maxLines: 5,
                      controller: _reasonController,
                    ),
                  ),
                  const SizedBox(
                    height: 25,
                  ),
                  Align(
                    alignment: Alignment.bottomRight,
                    child: _isLoading
                        ? Center(
                            child: CircularProgressIndicator(),
                          )
                        : ElevatedButton(
                            onPressed: () async {
                              await makePayment();
                              // addAppointment(
                              //     widget.doctor.userId!, user.userId!);
                            },
                            style: ElevatedButton.styleFrom(
                              padding: EdgeInsets.zero,
                              shape: RoundedRectangleBorder(
                                borderRadius: BorderRadius.circular(10),
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
                                borderRadius: BorderRadius.circular(10),
                              ),
                              child: Container(
                                width: deviceSize.width * 0.85,
                                height: deviceSize.height * 0.065,
                                alignment: Alignment.center,
                                child: Center(
                                  child: Text(
                                    'Set Appointment',
                                    style: TextStyle(
                                      fontSize: deviceSize.width * 0.048,
                                      fontFamily: 'Poppins',
                                      fontWeight: FontWeight.w600,
                                    ),
                                  ),
                                ),
                              ),
                            ),
                          ),
                  )
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }
}
