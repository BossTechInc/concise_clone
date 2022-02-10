import 'package:concise_clone/models/push_notification_model.dart';
import 'package:concise_clone/providers/local_notifications_service.dart';
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
  String? routeData;
 

  @override
  void initState() {
    LocalNotificationService.initialize(context);

    FirebaseMessaging.instance.getInitialMessage().then((message) {
      if(message != null){
        final routeFromMessage = message.data['route'];
      }
    });

// foreground 


  FirebaseMessaging.onMessage.listen((message){
    // print(message.notification!.body);
    // print(message.notification!.title);


    LocalNotificationService.display(message);


  });

  
//   when app is is background 

  FirebaseMessaging.onMessageOpenedApp.listen((message){
     
     final String routeFromMessage = message.data["route"] ;
   setState(() {
      routeData = routeFromMessage;
   }); 
  //  print(routeFromMessage);

   Navigator.of(context).pushNamed("/tabs", arguments: routeData );
   print(routeData); //arguments: routeFromMessage == null ? 0 : routeFromMessage);

  });

  

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
    String arguments ="";

    if(ModalRoute.of(context)!.settings.arguments  == null){
       arguments = "0";
      }else{
        arguments = ModalRoute.of(context)!.settings.arguments as String ;
      }
    
     final PageController _pageController = PageController(initialPage: arguments.isEmpty ? 0 : arguments as int ) ;

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
                      print(_pageController.initialPage);
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
