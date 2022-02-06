import 'package:concise_clone/models/push_notification_model.dart';
import 'package:concise_clone/screens/Home%20Screens/Entertainment.dart';
import 'package:concise_clone/screens/Home%20Screens/Finance.dart';
import 'package:concise_clone/screens/Home%20Screens/Health.dart';
import 'package:concise_clone/screens/Home%20Screens/InternationalAffairs.dart';
import 'package:concise_clone/screens/Home%20Screens/Politics.dart';
import 'package:concise_clone/screens/Home%20Screens/Sports.dart';
import 'package:concise_clone/screens/Home%20Screens/Tech&Science.dart';
import 'package:concise_clone/widgets/notification_badge.dart';
import 'package:connectivity_plus/connectivity_plus.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:firebase_messaging/firebase_messaging.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:intl/intl.dart';
import 'package:overlay_support/overlay_support.dart';
import 'package:fluttertoast/fluttertoast.dart';

import 'app_drawer.dart';

class TabsScreen extends StatefulWidget {
  static String routeName = '/tabs';

  @override
  _TabsScreenState createState() => _TabsScreenState();
}

class _TabsScreenState extends State<TabsScreen> {
  var subscription;
  var connectionStatus;

  late final FirebaseMessaging _messaging;

  PushNotication? _notificationInfo;
  var now = DateTime.now();

  void registerNotification() async {
    _messaging = FirebaseMessaging.instance;
    await Firebase.initializeApp();

    NotificationSettings settings = await _messaging.requestPermission(
      alert: true,
      badge: true,
      provisional: false,
      sound: true,
    );

    if (settings.authorizationStatus == AuthorizationStatus.authorized) {
    //  print("User granted permission");

      FirebaseMessaging.onMessage.listen(
        (RemoteMessage message) {
          PushNotication notification = PushNotication(
            message.notification!.title as String,
            message.notification!.body as String,
          );
          setState(() {
            _notificationInfo = notification;
          });

          if (notification != null) {
            showSimpleNotification(
              Text(_notificationInfo!.title),
              leading: NotificationBadge(),
              subtitle: Text(_notificationInfo!.body),
              background: Colors.cyan.shade700,
              duration: const Duration(seconds: 2),
            );
          }
        },
      );
    } else {
     // print("permission denied");
    }
  }

  checkForInitialMessage() async {
    await Firebase.initializeApp();
    RemoteMessage? initialMessage =
        await FirebaseMessaging.instance.getInitialMessage();

    if (initialMessage != null) {
      PushNotication notification = PushNotication(
        initialMessage.notification!.title as String,
        initialMessage.notification!.body as String,
      );

      setState(() {
        _notificationInfo = notification;
      });
    }
  }

  @override
  void initState() {
    subscription = Connectivity()
        .onConnectivityChanged
        .listen((ConnectivityResult result) {
      setState(() => connectionStatus = result);
      checkInternetConnectivity();
    });

//   when app is is background

    FirebaseMessaging.onMessageOpenedApp.listen((RemoteMessage message) {
      PushNotication notification = PushNotication(
        message.notification!.title as String,
        message.notification!.body as String,
      );
      setState(() {
        _notificationInfo = notification;
      });
    });

// normal notification in foreground state i.e app is running

    registerNotification();

// when app is in terminated state

    checkForInitialMessage();

    super.initState();
  }

  int selectedPageIndex = 0;
  final ScrollController _controller = ScrollController();

  final double _height = 100.0;

  void _animateToIndex(int index) {
    _controller.animateTo(
      index * _height,
      duration: const Duration(milliseconds: 500),
      curve: Curves.fastOutSlowIn,
    );
  }

  var date = DateTime.now();
  double i = 50;

  Widget buildTab(context, int i, String text, VoidCallback tapHandler) {
    bool select = (i == selectedPageIndex);

    return FlatButton(
      onPressed: tapHandler,
      child: (!select)
          ? Text(
              text,
              style: TextStyle(fontSize: 18, color: Colors.white,fontFamily: 'Tinos-Regular'),
            )
          : Container(
              padding: const EdgeInsets.symmetric(horizontal: 10, vertical: 5),
              decoration: const BoxDecoration(
                  borderRadius: BorderRadius.all(Radius.circular(15)),
                  color: Color(0xff03253e)),
              child: Text(
                text,
                style:
                    TextStyle(fontSize: 18, color: Colors.white,fontFamily: 'Tinos-Regular'),
              ),
            ),
    );
  }

  final PageController _pageController = PageController(initialPage: 0);

  checkInternetConnectivity() {
    if (connectionStatus == ConnectivityResult.none) {
      return Fluttertoast.showToast(
          msg: "Check your internet connection",
          gravity: ToastGravity.BOTTOM,
          timeInSecForIosWeb: 10,
          backgroundColor: Colors.white54,
          textColor: Colors.black,
          fontSize: 16.0);
    }
  }

  @override
  dispose() {
    super.dispose();
    subscription.cancel();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SafeArea(
        child: NestedScrollView(
          physics: const NeverScrollableScrollPhysics(),
          floatHeaderSlivers: true,
          headerSliverBuilder: (context, innerBoxIsScrolled) => [
            SliverAppBar(
              systemOverlayStyle: const SystemUiOverlayStyle(
                statusBarColor: Color(0xff1d425d), // transparent status bar
              ),
              toolbarHeight: MediaQuery.of(context).size.height / 11,
              backgroundColor: const Color(0xff1d425d),
              elevation: 0,
              pinned: false,
              floating: true,
              snap: true,
              centerTitle: true,
              title: Text(
                DateFormat('EEEE, d MMMM').format(date),
                style: const TextStyle(
                  fontSize: 24,
                  fontWeight: FontWeight.w400,
                    fontFamily: 'Tinos-Regular'
                ),
              ),
            ),
          ],
          body: Container(
            decoration: const BoxDecoration(
              color: Color(0xff1d425d),
            ),
            child: Container(
              decoration: const BoxDecoration(
                color: Colors.white,
                borderRadius: BorderRadius.only(
                  topRight: Radius.circular(40),
                  topLeft: Radius.circular(40),
                ),
              ),
              child: Container(
                margin: const EdgeInsets.all(15),
                child: PageView(
                  controller: _pageController,
                  onPageChanged: (newIndex) {
                    setState(() {
                      _animateToIndex(newIndex);
                      selectedPageIndex = newIndex;
                    });
                  },
                  children: [
                    Health(),
                    Politics(),
                    Finance(),
                    International(),
                    TechScience(),
                    Sports(),
                    Entertainment(),
                    //Miscellaneous(),
                  ],
                ),
              ),
            ),
          ),
        ),
      ),
      drawer: AppDrawer(),
      bottomNavigationBar: BottomAppBar(

        child: Container(
          margin: const EdgeInsets.only(left: 10, right: 10, bottom: 10),
          decoration: const BoxDecoration(
              color: Color(0xff1d425d),
              borderRadius: BorderRadius.all(Radius.circular(10))),
          height: MediaQuery.of(context).size.height / 15,
          child: ListView(
            controller: _controller,
            scrollDirection: Axis.horizontal,
            children: [
              buildTab(BuildContext, 0, 'Health', () {
                _pageController.animateToPage(0,
                    duration: const Duration(microseconds: 500), curve: Curves.ease);
              }),
              buildTab(BuildContext, 1, 'Politics', () {
                _pageController.animateToPage(1,
                    duration: const Duration(microseconds: 500), curve: Curves.ease,);
              }),
              buildTab(BuildContext, 2, 'Finance', () {
                _pageController.animateToPage(2,
                    duration: const Duration(microseconds: 500), curve: Curves.ease);
              }),
              Container(
                child: buildTab(BuildContext, 3, 'International Affairs', () {
                  _pageController.animateToPage(3,
                      duration: const Duration(microseconds: 500), curve: Curves.ease);
                }),
              ),
              buildTab(BuildContext, 4, 'Science & Technology', () {
                _pageController.animateToPage(4,
                    duration: const Duration(microseconds: 500), curve: Curves.ease);
              }),
              buildTab(BuildContext, 5, 'Sports', () {
                _pageController.animateToPage(5,
                    duration: const Duration(microseconds: 500), curve: Curves.ease);
              }),
              buildTab(BuildContext, 6, 'Entertainment', () {
                _pageController.animateToPage(6,
                    duration: const Duration(microseconds: 500), curve: Curves.ease);
              }),
              // buildTab(BuildContext,7, 'Miscellaneous',
              //         (){_pageController.animateToPage(7, duration: Duration(microseconds: 500), curve: Curves.ease);}),
            ],
          ),
        ),
      ),
    );
  }
}
