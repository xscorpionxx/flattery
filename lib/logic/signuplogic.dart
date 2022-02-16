import 'dart:convert';
import 'package:firebase_messaging/firebase_messaging.dart';
import 'package:http/http.dart' as http;
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:teste/homescreen.dart';

import '../loginscreen.dart';

class Signuplogic{
  final FirebaseMessaging fire = FirebaseMessaging.instance;
  Future<String> gettoken(){
    fire.getToken().then((value){
    return value;
  });
  }
  var contexta;
  Signuplogic(BuildContext context){
    contexta = context;
  }
  var stringa ;
  // هدول الدوال مشان التأكد من الاسم وكلمة السر وباقي المعلومات
   String validateemail(String value) {
    RegExp exp = new RegExp(r'^(([^<>()[\]\\.,;:\s@\"]+(\.[^<>()[\]\\.,;:\s@\"]+)*)|(\".+\"))@((\[[0-9]{1,3}\.[0-9]{1,3}\.[0-9]{1,3}\.[0-9]{1,3}\])|(([a-zA-Z\-0-9]+\.)+[a-zA-Z]{2,}))$');
    if(exp.hasMatch(value)){
      return null;
    }
    else{
      return "لا يمكن لايميل أن يكون هكذا!";
    }
  }
  String validatepassword(String value){
    stringa = value;
    if(value.length <6){
      return 'كلمة السر يجب أن تكون أكثر من 6 خانات على الاقل!' ;
    }
    if(value.isEmpty){
      return 'لا يمكن أن تكون كلمة السر فارغة' ;
    }
    return null;
  }
  String validatepasswordre(String value){
    if(value != stringa){
      return 'لا يوجد تطابق بين كلمتي السر' ;
    }
    return null;
  }
  String validatename(String value) {
    if(value.isEmpty){
      return 'لا يمكن أن تبقي الاسم فارغ';
    }
    return null;
  }
  String validate(String value) {
    if(value.isEmpty){
      return 'لا يمكن أن تبقي العنوان فارغ';
    }
    return null;
  }
  String validate1(String value) {
    if(value.isEmpty){
      return 'لا يمكن أن تبقي تاريخ الصيانة فارغ';
    }
    return null;
  }
  String validateMobile(String value) {
    String patttern = r'(^(?:[+0]9)?[0-9]{10,12}$)';
    RegExp regExp = new RegExp(patttern);
    if (value.length == 0) {
      return 'لا يمكنك ترك الرقم فارغ!';
    }
    else if (!regExp.hasMatch(value)) {
      return 'هذا الرقم غير صالح!';
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
          content: Directionality(textDirection: TextDirection.rtl,child: new Text(message)),
          actions: [
            new ElevatedButton(onPressed:(){Navigator.of(context).pop();}, child: Text("ok")),
          ]);
    });
  }
  alertwait(){
    showDialog(barrierDismissible: false,context: contexta, builder: (context) {
      return AlertDialog(elevation: 0,backgroundColor: Colors.transparent,content: Container(width: 30,height:30,
          child: Center(child :SizedBox( width: 30,height: 30, child: CircularProgressIndicator()))),
      );});
  }
  List values=[];
  List maintains=[];
  getlat()async{
    //put here the url to add account
    var url = "https://filtery-eg.com/api/auth/countries";
    var response = await http.get(Uri.parse(url));
    print(response);
    var body = jsonDecode(response.body);
    List datacount = body["data"];
    SharedPreferences sharedPreferences = await SharedPreferences.getInstance();
    var token = sharedPreferences.getString("token");
    var url2 = "https://filtery-eg.com/api/auth/devices";
    var response2 = await http.get(Uri.parse(url2));
    var body2 = jsonDecode(response2.body);
    values= body2["data"];
    var url3 = "https://filtery-eg.com/api/auth/maintenance";
    var response3 = await http.get(Uri.parse(url3), headers: {
    });
    var body3 = jsonDecode(response3.body);
    maintains= body3["data"];
    return {"1" :datacount , "2" : values , "3" : maintains};
  }
  getlat2(id)async{
    var url = "https://filtery-eg.com/api/auth/regions/"+"$id";
    var response = await http.get(Uri.parse(url));
    var body = jsonDecode(response.body);
    List datacount = body["data"];
    print(datacount);
    return datacount;
  }
 void navigateback(){
   Navigator.of(contexta).pushReplacement(MaterialPageRoute(builder: (context){
     return Loginpage();
   }));
 }
  void signup(GlobalKey<FormState> key ,name , email , phone , password , val1,val2 ,List data1,data2,type,address ,maintain,finaldate,nothave) async{
      if(val1.toString() != "اختر المحافظة" && val2.toString() != "اختر المنطقة"){
        var id1;
        var id2;
        for(int f = 0; data1.length>f ; f++){
          if(data1[f]["name"].toString().trim() == val1.toString().trim()) {
           id1= data1[f]["id"];
          }
        }
        for(int f = 0; data2.length>f ; f++){
          if(data2[f]["name"].toString().trim() == val2.toString().trim()) {
            id2= data2[f]["id"];
          }
        }
      fire.getToken().then((value)async{
        var data ;
        if(!nothave){
          data =  {"password": password, "phone": phone,"email":email,"name": name , "token" : value , "region_id":id2.toString() ,"country_id":id1.toString()
          ,"address": address.toString()};
        }
        else{
          var deviceid;
          var maintainid;
          for(int f = 0; values.length>f ; f++){
            if(values[f]["type"].toString().trim() == type) {
              deviceid= values[f]["id"];
            }
          }
          for(int f = 0; maintains.length>f ; f++){
            if(maintains[f]["name"].toString().trim() == maintain) {
              maintainid= maintains[f]["id"];
            }
          }
          data =  {"password": password, "phone": phone,"email":email,"name": name , "token" : value , "region_id":id2.toString() ,"country_id":id1.toString()
            ,"address": address.toString() , "device_type" : deviceid.toString() , "maintenance_id" : maintainid.toString() , "final_date" : finaldate.toString()};
        }
        //put here the url to add account
        var url = "https://filtery-eg.com/api/auth/register";
        alertwait();
        var response = await http.post(Uri.parse(url), body: data);
        var body = jsonDecode(response.body);
        Navigator.of(contexta,rootNavigator: true).pop('dialog');
        if (body["message"] == "User register successfully.") {
          await savetoken(body["data"]["access_token"],phone,password,body["data"]["user"]["email"],
              body["data"]["user"]["name"],val1,val2);
          navigate();
        }
        else {
          //alert(body["message"]);
          print(body["data"]["email"]);
          if (body["data"]["final_date"].toString() == "null") {
            if (body["data"]["email"].toString() == "null") {
              alert("الرقم موجود بالفعل في التطبيق الرجاء اختيار رقم أخر!");
            }
            else {
              if (body["data"]["phone"].toString() == "null") {
                alert(
                    "هذا الايميل موجود بالفعل في التطبيق الرجاء تغير الايميل!");
              }
              else {
                alert(
                    "الرقم والايميل موجودين بالفعل في التطبيق الرجاء اختيار رقم أخر وعنوان ايميل أخر!");
              }
            }
          }
          else{
            alert("التاريخ ليس مكتوب بالشكل الصحيح");
          }
        }
      });
    }else{
        alert("الرجاء تحديد المحافظة والمنطقة قبل انشاء الحساب");
      }
  }

  void savetoken(token,phone ,password,email , name,val1,val2)async {
    SharedPreferences sharedPreferences = await SharedPreferences.getInstance();
    sharedPreferences.setString("token", token);
    sharedPreferences.setString("phone",phone );
    sharedPreferences.setString("password", password);
    sharedPreferences.setString("email", email);
    sharedPreferences.setString("name", name);
    sharedPreferences.setString("moha", val1.toString());
    sharedPreferences.setString("mad", val2.toString());
  }

}