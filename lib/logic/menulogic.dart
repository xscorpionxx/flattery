

import 'package:firebase_auth/firebase_auth.dart';
import 'package:firebase_messaging/firebase_messaging.dart';
import 'package:flutter/material.dart';
import 'package:flutter_facebook_auth/flutter_facebook_auth.dart';
import 'package:google_sign_in/google_sign_in.dart';
import 'package:provider/provider.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:teste/changepass.dart';
import 'package:teste/contactwithus.dart';
import 'package:teste/homescreen.dart';
import 'package:teste/profilescreen.dart';
import 'package:teste/who_us.dart';

import '../main.dart';
import 'mainlogic.dart';

class Menulogic{
  var contexta;
  Menulogic(BuildContext context){
    contexta = context;
  }
  void navigatetoprofile(){
    Navigator.of(contexta).push(MaterialPageRoute(builder: (context){
      return Profilescreen();
    }));
  }
  void navigatetochangepass(){
    Navigator.of(contexta).push(MaterialPageRoute(builder: (context){
      return Changepass();
    }));
  }
  void navigatetohome(){
    Navigator.of(contexta).pop();
    //push(MaterialPageRoute(builder: (context){
    //   return Mainpage();
    // }));
  }
  void navigatetomaintain(){
    Navigator.of(contexta).push(MaterialPageRoute(builder: (context){
      //return Maintainscreen();
    }));
  }
  void navigatetosubmaintain(){
    Navigator.of(contexta).push(MaterialPageRoute(builder: (context){
      //return Info();
    }));
  }

  void navigatetomaintainhist(){
    Navigator.of(contexta).push(MaterialPageRoute(builder: (context){
      //return Maintainhistscreen();
    }));
  }
  void navigatetoshopping(){
    Navigator.of(contexta).push(MaterialPageRoute(builder: (context){
  //    return Shopping();
    }));
  }
  void navigatetocontact(){
    Navigator.of(contexta).push(MaterialPageRoute(builder: (context){
      return Contact();
    }));
  }
  void navigatetowhous(){
    Navigator.of(contexta).push(MaterialPageRoute(builder: (context){
      return Whous();
    }));
  }
  final googlesignin = GoogleSignIn();
  void signout(tabController)async{
    SharedPreferences sharedPreferences = await SharedPreferences.getInstance();
    var type = sharedPreferences.getString("logintype");
    if(type == "google" ||type == "facebook"){
      if(type == "google"){
        final googleusera = await googlesignin.currentUser;
        if( googleusera !=null){
          googleusera.clearAuthCache();
        }
      }else{
        final dataa = await FacebookAuth.instance..getUserData();
        await dataa.logOut();
        await FirebaseAuth.instance.signOut();
      }
      FirebaseAuth.instance.currentUser.delete();
      FirebaseAuth.instance.signOut();
    }
    Provider.of<Notifires>(contexta,listen: false).getindex(tabController, "home", 1, contexta);
    Provider.of<Notifires>(contexta,listen: false).reset();
    sharedPreferences.clear();
    Navigator.of(contexta).pushReplacement(MaterialPageRoute(builder: (context){
      return MyApp();
    }));
  }
}