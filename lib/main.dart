import 'package:concise_clone/providers/concise_api.dart';
import 'package:concise_clone/providers/news_provider.dart';
import 'package:concise_clone/screens/Home%20Screens/Entertainment.dart';
import 'package:concise_clone/screens/Home%20Screens/Finance.dart';
import 'package:concise_clone/screens/Home%20Screens/Health.dart';
import 'package:concise_clone/screens/Home%20Screens/InternationalAffairs.dart';
import 'package:concise_clone/screens/Home%20Screens/Politics.dart';
import 'package:concise_clone/screens/Home%20Screens/Sports.dart';
import 'package:concise_clone/screens/Home%20Screens/Tech&Science.dart';
import 'package:concise_clone/screens/Loading%20Screen/app_drawer.dart';
import 'package:concise_clone/screens/Loading%20Screen/splash.dart';
import 'package:concise_clone/screens/Loading%20Screen/tabs_screen.dart';
import 'package:concise_clone/widgets/web_view.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:provider/provider.dart';
import 'package:overlay_support/overlay_support.dart';


void main()async {
  WidgetsFlutterBinding.ensureInitialized();
  await Firebase.initializeApp();
Provider.debugCheckInvalidValueType = null;
  SystemChrome.setPreferredOrientations([DeviceOrientation.portraitUp])
      .then((value) => runApp(MyApp()));
  SystemChrome.setSystemUIOverlayStyle(
      (SystemUiOverlayStyle(
        statusBarColor: Color(0xff1d425d), // transparent status bar
      )));
}

class MyApp extends StatelessWidget {

  @override
  Widget build(BuildContext context) {
    return MultiProvider(providers: [
      ChangeNotifierProvider(
        create: (context) => NewsProvider(),
        child: TabsScreen(),
      ),
     ChangeNotifierProvider(create: (_)=>ConciseApi())
    ],
      child: OverlaySupport.global(
        child: MaterialApp(
          debugShowCheckedModeBanner: false,
          title: 'Concise',
          theme: ThemeData(
            visualDensity: VisualDensity.adaptivePlatformDensity,
          ),
         home: Scaffold(
            body: SplashScreen(),
          ),
          routes: {
            Web.routeName:(ctx)=>Web(),
            AppDrawer.routeName:(ctx)=>AppDrawer(),
            Entertainment.routeName:(ctx)=>Entertainment(),
            Politics.routeName:(ctx)=>Politics(),
            Finance.routeName:(ctx)=>Finance(),
            Sports.routeName:(ctx)=>Sports(),
            TechScience.routeName:(ctx)=>TechScience(),
            International.routeName:(ctx)=>International(),
            Health.routeName:(ctx)=>Health(),
            TabsScreen.routeName:(ctx)=>TabsScreen(),
          },
         ),
      ),
    );
  }
}
