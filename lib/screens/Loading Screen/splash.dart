
import 'package:concise_clone/screens/Loading%20Screen/tabs_screen.dart';
import 'package:flutter/material.dart';

class SplashScreen extends StatefulWidget {


  @override
  State<SplashScreen> createState() => _SplashScreenState();
}

class _SplashScreenState extends State<SplashScreen> {
  @override
  void initState() {
    super.initState();
    _navigateTab();
  }

  void _navigateTab()async{
    await Future.delayed(Duration(milliseconds: 1500),(){
      Navigator.pushReplacementNamed(context, TabsScreen.routeName);
    });
  }
    @override
  Widget build(BuildContext context) {
    return Container(
      decoration: BoxDecoration(
        color: Color(0xff1d425d)
      ),
      child: Center(
          child:Column(
        children: [
          SizedBox(
            height:MediaQuery.of(context).size.height/2.9,
          ),
          const Text('concise',style: TextStyle(fontSize: 35,color: Colors.white,fontWeight: FontWeight.w600,fontFamily: 'Tinos-Regular'),),
          const Text('Only the News Worth Your Time',
            style: TextStyle(fontSize: 16,color: Colors.white,fontStyle: FontStyle.italic,fontFamily: 'Tinos-Regular'),),
          SizedBox(
            height:MediaQuery.of(context).size.height/2.1,
          ),
          const Text('from ',
              style: TextStyle(color: Colors.grey,fontFamily: 'Poppins-Regular')),
          const Text('Stellar',
              style: TextStyle(color: Colors.white,fontSize: 17,fontFamily: 'Poppins-Regular'),
          )
        ],
      ),),
    );
  }
}
