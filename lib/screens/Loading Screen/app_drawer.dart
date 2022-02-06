import 'package:concise_clone/screens/Contact%20And%20Details/contact_us.dart';
import 'package:concise_clone/screens/Contact%20And%20Details/privacy_policy.dart';
import 'package:flutter/material.dart';

class AppDrawer extends StatelessWidget {
  static String routeName = '/drawer';
  @override
  Widget build(BuildContext context) {
    return Drawer(
        backgroundColor: Colors.white,
        child: Center(
          child: Container(
            height: MediaQuery.of(context).size.height,
            width: 250,
            decoration: const BoxDecoration(
              borderRadius: BorderRadius.all(Radius.circular(10)),
            ),
            child: Center(
              child: Column(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  const SizedBox(
                    height: 40,
                  ),
                  Container(
                    height: 70,
                    width: 70,
                    decoration: const BoxDecoration(
                      borderRadius: BorderRadius.all(
                        const Radius.circular(5),
                      ),
                      color: Colors.white,
                      image: DecorationImage(
                          image: AssetImage("assets/ic_launcher.png"),
                          fit: BoxFit.cover),
                    ),
                  ),
                  // SizedBox(
                  //   height: MediaQuery.of(context).size.height/5,
                  // ),

                  Container(
                    child: Column(
                      children: const [
                        Text(
                          'concise',
                          style: TextStyle(
                              fontSize: 40,
                              color: Color(0xff1d425d),
                              fontFamily: 'Tinos-Regular'),
                        ),
                        Text(
                          'Only the News Worth Your Time',
                          style: TextStyle(
                              fontSize: 15,
                              color: Color(0xff1d425d),
                              fontStyle: FontStyle.italic,
                              fontFamily: 'Tinos-Regular'),
                        ),
                      ],
                    ),
                  ),
                  SizedBox(
                    height: MediaQuery.of(context).size.height / 2.2,
                  ),
                  Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      InkWell(
                        onTap: (){ Navigator.push(
                          context,
                          MaterialPageRoute(
                              builder: (context) => ContactUs()),
                        );},
                        child: Row(
                          children: const [
                            Icon(
                              Icons.phone_android,
                              color: Color(0xff1d425d),
                            ),
                            Padding(
                              padding: EdgeInsets.only(left: 10.0),
                              child: Text(
                                'Contact Us',
                                style: TextStyle(
                                    color: Color(0xff1d425d),
                                    fontFamily: 'Tinos-Regular',fontSize: 16),
                              ),
                            ),
                          ],
                        ),
                      ),
                      const SizedBox(height: 15),
                      InkWell(
                          onTap: () {
                            Navigator.push(
                              context,
                              MaterialPageRoute(
                                  builder: (context) => const PrivacyPolicy()),
                            );
                          },
                          child: Row(

                            children: const [
                              Icon(
                                Icons.lock,
                                color: Color(0xff1d425d),
                              ),
                              Padding(
                                padding: EdgeInsets.only(left: 10.0),
                                child: Text(
                                  'Privacy Policy',
                                  style: TextStyle(
                                      color: Color(0xff1d425d),
                                      fontFamily: 'Tinos-Regular',fontSize: 16),
                                ),
                              ),
                            ],
                          )),
                      const SizedBox(height: 25),
                      Row(
                        mainAxisAlignment: MainAxisAlignment.center,
                        children: const [
                          // Icon(
                          //   Icons.phone,
                          //   color: Color(0xff1d425d),
                          // ),
                          Text(
                            'Version 1.0.0 ',
                            style: TextStyle(
                                color: Color(0xff1d425d),
                                fontFamily: 'Tinos-Regular',fontSize: 11),
                          ),
                        ],
                      ),
                    ],
                  ),

                  const SizedBox(
                    height: 5,
                  ),
                ],
              ),
            ),
          ),
        ));
  }
}
