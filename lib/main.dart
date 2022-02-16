import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/animation.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter/services.dart';
import 'package:flutter/services.dart';
import 'package:flutter/services.dart';
import 'package:provider/provider.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:teste/access.dart';
import 'package:teste/complete.dart';
import 'package:teste/erroralert.dart';
import 'package:teste/homescreen.dart';
import 'package:teste/logic/homescreen.dart';
import 'package:teste/logic/loginlogic.dart';
import 'package:teste/logic/mainlogic.dart';
import 'package:teste/loginscreen.dart';
import 'package:teste/paymentscreen.dart';
import 'package:teste/profilescreen.dart';
import 'package:teste/sign%20up.dart';
import 'package:teste/who_us.dart';
import 'package:flutter/services.dart';
//SystemChrome.setEnabledSystemUIOverlays([SystemUiOverlay.bottom]);
void main()async{
  WidgetsFlutterBinding.ensureInitialized();
  await Firebase.initializeApp();
  runApp(
      ChangeNotifierProvider(create: (_){
        return Notifires();
      },child: MyApp(),)
  );
}
class MyApp extends StatelessWidget{
  Mainlogic mainlogic = new Mainlogic();
  @override
  Widget build(BuildContext context) {
    mainlogic.gettoken();
    // TODO: implement build
    return
   // MaterialApp(theme: ThemeData(fontFamily: 'Cairo'),title: "Faltery",debugShowCheckedModeBanner: false,
    //  home:Loginpage());
      FutureBuilder(future: mainlogic.getdata() , builder: (context ,snapshot ){
            if(snapshot.hasError){
              return MaterialApp(title: "error",debugShowCheckedModeBanner: false,
                home: Scaffold(body: Center(child: Text("Pls check internet connection"),),),);
            }
            if(snapshot.connectionState ==ConnectionState.done){
              if(mainlogic.data["logintype"] == "google" ||mainlogic.data["logintype"] == "facebook" &&mainlogic.data["token"].toString() != "null") {
                return FutureBuilder(future: mainlogic.getprofile(),
                    builder: (context, snapshot) {
                      if (snapshot.hasError) {
                        return MaterialApp(
                            theme: ThemeData(fontFamily: 'Cairo'),
                            title: "Faltery",
                            debugShowCheckedModeBanner: false,
                            home: Loginpage()
                        );
                      }
                      if (snapshot.connectionState == ConnectionState.done) {
                        print(mainlogic.profile["country_id"].toString());
                        return MaterialApp(
                            theme: ThemeData(fontFamily: 'Cairo'),
                            title: "Flatery",
                            debugShowCheckedModeBanner: false,
                            home: mainlogic.profile["country_id"].toString() == "null"
                                ? Complete()
                                : Mainpage() //Section1(username: data,)
                        );
                      }
                      return MaterialApp(
                        title: "Loading", debugShowCheckedModeBanner: false,
                        home: Scaffold(body: Center(
                            child: CircularProgressIndicator()),),);
                    });
              }
              else {
                if (mainlogic.data["phone"] != null) {
                          return MaterialApp(
                              theme: ThemeData(fontFamily: 'Cairo'),
                              title: "Faltery",
                              debugShowCheckedModeBanner: false,
                              home: Mainpage());
                        }
                else {
                  return MaterialApp(theme: ThemeData(fontFamily: 'Cairo'),
                      title: "Flatery",
                      debugShowCheckedModeBanner: false,
                      home: Loginpage()
                  );
                }
              }
            }
            return MaterialApp(title:"Loading",debugShowCheckedModeBanner: false,
              home: Scaffold(body: Center(child: CircularProgressIndicator()),),);
          },);
        }
  }