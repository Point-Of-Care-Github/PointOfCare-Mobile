import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import '../models/users.dart';

class ProfileData extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    final productsData = Provider.of<Users>(context);
    final products = productsData.users;
    final deviceSize = MediaQuery.of(context).size;
    return Container(
      margin: EdgeInsets.only(top: 140, left: 40),
      child: Column(
        children: <Widget>[
          Row(
            children: [
              Align(
                alignment: Alignment.topLeft,
                child: Container(
                  width: 90,
                  height: 90,
                  margin: const EdgeInsets.only(right: 15),
                  child: CircleAvatar(
                    backgroundImage: NetworkImage(products[1].pic.toString()),
                  ),
                ),
              ),
              Text(
                products[1].name.toString(),
                style: TextStyle(
                  fontFamily: 'Poppins',
                  fontSize: 22,
                  fontWeight: FontWeight.w600,
                ),
              )
            ],
          ),
          Container(
            margin: EdgeInsets.only(top: 15, left: 25),
            child: Row(
              children: <Widget>[
                Icon(
                  Icons.account_circle_outlined,
                  color: Color(0xFF8587dc),
                  size: 30,
                ),
              ],
            ),
          ),
          Container(
            margin: EdgeInsets.only(top: 10, left: 25),
            child: Row(
              children: <Widget>[
                Icon(
                  Icons.email_outlined,
                  color: Color(0xFF8587dc),
                  size: 30,
                ),
                Container(
                  width: deviceSize.width * 0.5,
                  margin: EdgeInsets.only(left: 20),
                  child: TextFormField(
                    decoration: const InputDecoration(
                      labelText: 'Email',
                      //contentPadding: const EdgeInsets.only(bottom: 3),
                      labelStyle: TextStyle(
                        fontFamily: 'League Spartan',
                        fontSize: 19,
                        fontWeight: FontWeight.w600,
                      ),
                    ),
                    style: const TextStyle(
                      fontSize: 16,
                      fontWeight: FontWeight.w600,
                      fontFamily: 'League Spartan',
                    ),
                    initialValue: products[1].email,
                    readOnly: true,
                  ),
                ),
              ],
            ),
          ),
          Container(
            margin: EdgeInsets.only(top: 10, left: 25),
            child: Row(
              children: <Widget>[
                Icon(
                  Icons.phone_enabled,
                  color: Color(0xFF8587dc),
                  size: 30,
                ),
                Container(
                  width: deviceSize.width * 0.5,
                  margin: EdgeInsets.only(left: 20),
                  child: TextFormField(
                    decoration: const InputDecoration(
                      labelText: 'Contact',
                      //contentPadding: const EdgeInsets.only(bottom: 3),
                      labelStyle: TextStyle(
                        fontFamily: 'League Spartan',
                        fontSize: 19,
                        fontWeight: FontWeight.w600,
                      ),
                    ),
                    style: const TextStyle(
                      fontSize: 16,
                      fontWeight: FontWeight.w600,
                      fontFamily: 'League Spartan',
                    ),
                    initialValue: products[1].contact,
                    readOnly: true,
                  ),
                ),
              ],
            ),
          ),
          Container(
            margin: EdgeInsets.only(top: 10, left: 25),
            child: Row(
              children: <Widget>[
                Icon(
                  Icons.group,
                  color: Color(0xFF8587dc),
                  size: 30,
                ),
                Container(
                  width: deviceSize.width * 0.5,
                  margin: EdgeInsets.only(left: 20),
                  child: TextFormField(
                    decoration: const InputDecoration(
                      labelText: 'Age',
                      //contentPadding: const EdgeInsets.only(bottom: 3),
                      labelStyle: TextStyle(
                        fontFamily: 'League Spartan',
                        fontSize: 19,
                        fontWeight: FontWeight.w600,
                      ),
                    ),
                    style: const TextStyle(
                      fontSize: 16,
                      fontWeight: FontWeight.w600,
                      fontFamily: 'League Spartan',
                    ),
                    initialValue: products[1].age,
                    readOnly: true,
                  ),
                ),
              ],
            ),
          ),
          Container(
            margin: EdgeInsets.only(top: 10, left: 25),
            child: Row(
              children: <Widget>[
                Icon(
                  Icons.male_outlined,
                  color: Color(0xFF8587dc),
                  size: 30,
                ),
                Container(
                  width: deviceSize.width * 0.5,
                  margin: EdgeInsets.only(left: 20),
                  child: TextFormField(
                    decoration: const InputDecoration(
                      labelText: 'Gender',
                      labelStyle: TextStyle(
                        fontFamily: 'League Spartan',
                        fontSize: 19,
                        fontWeight: FontWeight.w600,
                      ),
                    ),
                    style: const TextStyle(
                      fontSize: 16,
                      fontWeight: FontWeight.w600,
                      fontFamily: 'League Spartan',
                    ),
                    initialValue: products[1].gender,
                    readOnly: true,
                  ),
                ),
              ],
            ),
          ),
          Container(
            margin: EdgeInsets.only(top: 10, left: 25),
            child: Row(
              children: <Widget>[
                Icon(
                  Icons.location_on,
                  color: Color(0xFF8587dc),
                  size: 30,
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }
}
