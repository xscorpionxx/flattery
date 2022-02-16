import 'dart:convert';
import 'package:aws_translate/aws_translate.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:firebase_messaging/firebase_messaging.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_facebook_auth/flutter_facebook_auth.dart';
import 'package:flutter_translation/_translator.dart';
import 'package:google_cloud_translation/google_cloud_translation.dart';
import 'package:google_sign_in/google_sign_in.dart';
//import 'package:google_sign_in/google_sign_in.dart';
import 'package:http/http.dart'as http;
import 'package:shared_preferences/shared_preferences.dart';
import 'package:teste/complete.dart';
import 'package:teste/homescreen.dart';
import 'package:teste/main.dart';
import 'package:teste/profilescreen.dart';
class Loginlogic extends ChangeNotifier{
  final FirebaseMessaging fire = FirebaseMessaging.instance;
  var contexta;
  Loginlogic(BuildContext context){
    contexta = context;
  }
  final googlesignin = GoogleSignIn();
  GoogleSignInAccount _user;
  GoogleSignInAccount get user=> _user;
  Future<String> gettoken(){
    fire.getToken().then((value){
      print(value);
       return value;
    });
  }
  AwsTranslate awsTranslate = AwsTranslate(
      poolId: "1", // your pool id here
      region: Regions.AP_NORTHEAST_2);
  //Translation translation;
  //TranslationModel _translated = TranslationModel(translatedText:'', detectedSourceLanguage: 'en');
  googlelogin() async{
    //_translated = await translation.translate(text: "welcome", to: 'ar');
    final googleusera = await googlesignin.signInOption;
    final googleable = await googlesignin.isSignedIn();
    if(googleable) {
      await googlesignin.signOut();
    }
    final googleuser = await googlesignin.signIn();
    if(googleuser == null){
      return ;
    }
    else{
      _user = googleuser;
    }
    try {
      alertwait();
      final googleauth = await googleuser.authentication;
      final cred = GoogleAuthProvider.credential(
          accessToken: googleauth.accessToken,
          idToken: googleauth.idToken
      );
      await FirebaseAuth.instance.signInWithCredential(cred);
      loginfacebookgoogle("google", cred.accessToken);
    }
    on FirebaseAuthException catch (e){
      if(Navigator.maybePop(contexta) ==true){
        Navigator.of(contexta).pop();
      }
      alert(e.message.toString());
    }
  }
   String validatepassword(String value) {
    if(value.isEmpty){
      return 'لا يمكن أن تكون كلمة السر فارغة' ;
    }
    return null;
  }
   String validatphone(String value) {
    if(value.isEmpty){
      return 'لا يجب أن يكون الرقم فارغ';
    }
    return null;
  }
  void navigate(){
    Navigator.of(contexta).pushReplacement(MaterialPageRoute(builder: (context){
      return Mainpage();
    }));
  }
  void alert(message){
    showDialog(context: contexta, builder: (context) {
      return AlertDialog(
          content: Directionality(textDirection: TextDirection.rtl,child:Text(message)),
          actions: [
            new ElevatedButton(onPressed:(){Navigator.of(context).pop();}, child: Text("نعم")),
          ]);
    });
  }

  Future<UserCredential> signInWithFacebook() async {
    // Trigger the sign-in flow
    try {
      final LoginResult loginResult = await FacebookAuth.instance.login();
      // Create a credential from the access token
      final data = await FacebookAuth.instance.getUserData();
      alertwait();
      final OAuthCredential facebookAuthCredential = FacebookAuthProvider
          .credential(loginResult.accessToken.token);
      // Once signed in, return the UserCredential
      await FirebaseAuth.instance.signInWithCredential(facebookAuthCredential);
      loginfacebookgoogle("facebook", loginResult.accessToken.token);
    } on FirebaseAuthException catch (e){
      print(e.message);
      if(Navigator.maybePop(contexta) ==true){
        Navigator.of(contexta).pop();
      }
      alert(e.message.toString());
    }
  }
  Loginnow() async{
    SharedPreferences sharedPreferences = await SharedPreferences.getInstance();
    var type =  sharedPreferences.getString("logintype");
    if(type =="google"){

    }
    else{

    }
  }
  Future loginfacebookgoogle(type,token)async{
    //put here the url to add account
    var url;
    if(type == "google"){
      url = "https://filtery-eg.com/api/auth/callback/google/"+token.toString();
    }
    else{
      url = "https://filtery-eg.com/api/auth/callback/facebook/"+token.toString();
    }
    var response = await http.post(Uri.parse(url));
    Navigator.of(contexta,rootNavigator: true).pop('dialog');
    var body = jsonDecode(response.body);
    print(body);
    if (body["success"].toString() == "true") {
      SharedPreferences sharedPreferences = await SharedPreferences.getInstance();
      sharedPreferences.setString("logintype", type);
      await savetoken(body["data"]["access_token"],"","",body["data"]["email"],
          body["data"]["name"]);
      if( body["data"]["country_id"].toString() != "null"
      ){
        Navigator.of(contexta).pushReplacement(MaterialPageRoute(builder: (contexta) {
          return Mainpage();
        }));
      }else {
        Navigator.of(contexta).pushReplacement(MaterialPageRoute(builder: (contexta) {
          return Complete();
        }));
      }
    }
    else {
      alert(body["message"].toString());
    }
  }
  alertwait(){
    showDialog(barrierDismissible: false,context: contexta, builder: (context) {
      return AlertDialog(elevation: 0,backgroundColor: Colors.transparent,content: Container(width: 30,height:30,
          child: Center(child :SizedBox( width: 30,height: 30, child: CircularProgressIndicator()))),
      );});
  }
  Future login(phone ,password,GlobalKey<FormState> key)async{
    if(key.currentState.validate()) {
      fire.getToken().then((value)async{
        var data = {"password": password, "phone": phone ,"token" : value};
        //put here the url to add account
        var url = "https://filtery-eg.com/api/auth/login";
        alertwait();
        var response = await http.post(Uri.parse(url), body: data);
        Navigator.of(contexta,rootNavigator: true).pop('dialog');
        var body = jsonDecode(response.body);
        print(body);
        if (body["message"] == "login Successfuly") {
          await savetoken(body["data"]["access_token"],phone,password,body["data"]["user"]["email"],
          body["data"]["user"]["name"]);
          print(body["data"]["access_token"]);
          navigate();
        }
        else {
          alert("الرجاء اعادة المحاولة والتأكد من كلمة السر و الرقم!");
        }
      });
    }
  }
  void savetoken(token,phone ,password,email,name)async {
    SharedPreferences sharedPreferences = await SharedPreferences.getInstance();
    sharedPreferences.setString("token", token);
    sharedPreferences.setString("phone",phone );
    sharedPreferences.setString("password",password );
    sharedPreferences.setString("email", email);
    sharedPreferences.setString("name", name);
  }
}