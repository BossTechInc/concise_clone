import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
class ContactUs extends StatelessWidget {
   @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white,
      appBar: AppBar(
        systemOverlayStyle: const SystemUiOverlayStyle(
          statusBarColor: Color(0xff1d425d), // transparent status bar
        ),
        elevation: 1,
        title: Text(
          "Contact Us",
          style: TextStyle(
              fontSize: MediaQuery.of(context).size.height / 40,
              fontWeight: FontWeight.w500,
              color: Colors.white,
              fontFamily: 'Poppins-Regular'),
        ),
        centerTitle: true,
        backgroundColor: const Color(0xff1d425d),
      ),
      body: Container(
        margin: const EdgeInsets.all(10),
        height: MediaQuery.of(context).size.height/5,
          width: MediaQuery.of(context).size.width,
        decoration: const BoxDecoration(
          color:Color(0xff1d425d),
          borderRadius: BorderRadius.all(Radius.circular(10)),
        ),
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          // crossAxisAlignment: CrossAxisAlignment.center,
          children: [
             Padding(
               padding: const EdgeInsets.all(10.0),
               child: Row(
                 mainAxisAlignment: MainAxisAlignment.center,
                 children: const [
                   Icon(Icons.mail_outline,color: Colors.white,),
                   SizedBox(
                     width: 10,
                   ),
                   Text('official.conciseapp@gmail.com',style: TextStyle( fontSize: 15,
                       fontWeight: FontWeight.w500,
                       color: Colors.white70,
                       fontFamily: 'Poppins-Regular'),),
                 ],
               ),
             ),

            Padding(
              padding: const EdgeInsets.all(10.0),
              child: Row(
                mainAxisAlignment: MainAxisAlignment.center,
                children: const [
                  Icon(Icons.phone,color: Colors.white,),
                  SizedBox(
                    width: 10,
                  ),
                  Text('+91 8770805985',style: TextStyle( fontSize: 15,
                      fontWeight: FontWeight.w500,
                      color: Colors.white70,
                      fontFamily: 'Poppins-Regular'),),
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }
}
