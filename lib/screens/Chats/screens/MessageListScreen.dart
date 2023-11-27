// ignore_for_file: file_names

import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:test/providers/auth.dart';
import 'package:test/providers/doctor.dart';
import 'package:test/screens/Chats/screens/chatScreen.dart';

// ignore: must_be_immutable
class MessagesScreen extends StatefulWidget {
  static const routeName = '/message-list';

  const MessagesScreen({super.key});

  @override
  State<MessagesScreen> createState() => _MessagesScreenState();
}

class _MessagesScreenState extends State<MessagesScreen> {
  @override
  Widget build(BuildContext context) {
    final doctorsProvider = Provider.of<Doctor>(context, listen: false).doctors;
    final users = Provider.of<Auth>(context, listen: false).users;

    final deviceSize = MediaQuery.of(context).size;
    return SafeArea(
      child: SingleChildScrollView(
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            SizedBox(
              height: 15,
            ),
            const Padding(
              padding: EdgeInsets.symmetric(horizontal: 20),
              child: Text(
                "Messages",
                style: TextStyle(
                  fontSize: 25,
                  fontFamily: "Poppins",
                  fontWeight: FontWeight.bold,
                ),
              ),
            ),
            const SizedBox(height: 20),
            Container(
              height: 130,
              child: ListView.builder(
                  scrollDirection: Axis.horizontal,
                  itemCount: doctorsProvider.length,
                  itemBuilder: (ctx, index) {
                    final doctor = doctorsProvider[index];
                    final user = users.firstWhere(
                        (element) => element.userId == doctor.userId);
                    return Container(
                      margin: EdgeInsets.all(8),
                      child: Column(
                        children: [
                          CircleAvatar(
                            radius: 40,
                            backgroundImage:
                                NetworkImage(doctor.image.toString()),
                          ),
                          Text(user.userName.toString())
                        ],
                      ),
                    );
                  }),
            ),
            Padding(
              padding: const EdgeInsets.symmetric(horizontal: 15),
              child: Container(
                padding: const EdgeInsets.symmetric(horizontal: 15),
                decoration: BoxDecoration(
                  color: Colors.white,
                  borderRadius: BorderRadius.circular(10),
                  boxShadow: const [
                    BoxShadow(
                      color: Colors.black12,
                      blurRadius: 10,
                      spreadRadius: 2,
                      offset: Offset(0, 3),
                    ),
                  ],
                ),
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    SizedBox(
                      width: deviceSize.width * 0.3,
                      child: Padding(
                        padding: const EdgeInsets.symmetric(horizontal: 8),
                        child: TextFormField(
                          decoration: const InputDecoration(
                            hintText: "Search",
                            border: InputBorder.none,
                            hintStyle: TextStyle(
                              fontFamily: "Poppins",
                              fontSize: 14,
                            ),
                          ),
                        ),
                      ),
                    ),
                    const Icon(
                      Icons.search,
                      size: 20,
                      color: Colors.black54,
                    ),
                  ],
                ),
              ),
            ),
            const SizedBox(height: 20),
            ListView.builder(
              itemCount: doctorsProvider.length,
              shrinkWrap: true,
              itemBuilder: (context, index) {
                final doctor = doctorsProvider[index];
                final user = users
                    .firstWhere((element) => element.userId == doctor.userId);
                return ListTile(
                  onTap: () {
                    Navigator.push(
                        context,
                        MaterialPageRoute(
                          builder: (context) => const ChatScreen(),
                        ));
                  },
                  leading: CircleAvatar(
                    radius: 30,
                    backgroundImage: NetworkImage(
                      doctor.image.toString(),
                    ),
                  ),
                  title: Text(
                    user.username.toString(),
                    style: TextStyle(
                      fontSize: 16,
                      fontFamily: "Poppins",
                      fontWeight: FontWeight.w500,
                    ),
                  ),
                  subtitle: const Text(
                    "Hello, Doctor, are you there? ",
                    maxLines: 1,
                    overflow: TextOverflow.ellipsis,
                    style: TextStyle(
                      fontSize: 13,
                      fontFamily: "Poppins",
                      color: Colors.black54,
                    ),
                  ),
                  trailing: const Text(
                    "12:30",
                    style: TextStyle(
                        fontSize: 12,
                        fontFamily: "Poppins",
                        color: Colors.black54),
                  ),
                );
              },
            )
          ],
        ),
      ),
    );
  }
}
