
import 'dart:convert';
import 'package:firebase_messaging/firebase_messaging.dart';
import 'package:http/http.dart'as http;
import 'package:flutter/material.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:teste/homescreen.dart';


class Profilelogic {
  var contexta;
  Profilelogic(BuildContext context){
    contexta = context;
  }
  void navigate(){
     Navigator.of(contexta).pop();
  }
   getdatas() async {
    SharedPreferences sharedPreferences = await SharedPreferences.getInstance();
    var token = sharedPreferences.getString("token");
    alertwait();
    var url = "https://filtery-eg.com/api/auth/profile";
    var response = await http.get(Uri.parse(url),
        headers: {
          //'Content-Type': 'application/json',
          'Accept': 'application/json',
          'Authorization': 'Bearer $token',
        });
    var country;
    var citiy;
    var type;
    var maintain;
    var body = jsonDecode(response.body);
    var url2 = "https://filtery-eg.com/api/auth/countries";
    var response2 = await http.get(Uri.parse(url2));
    List cities =[];
    var body2 = jsonDecode(response2.body);
    List countries = body2["data"];
    if(body["data"]["country_id"].toString() !="null"){
      var url3 = "https://filtery-eg.com/api/auth/regions/"+body["data"]["country_id"].toString();
      var response3 = await http.get(Uri.parse(url3));
      var body3 = jsonDecode(response3.body);
       cities = body3["data"];
    }
    var url4 = "https://filtery-eg.com/api/auth/devices";
    var response4= await http.get(Uri.parse(url4));
    var body4 = jsonDecode(response4.body);
    List types = body4["data"];
    var url5 = "https://filtery-eg.com/api/auth/maintenance";
    var response5= await http.get(Uri.parse(url5));
    var body5 = jsonDecode(response5.body);
    List maintains = body5["data"];
    for(int f = 0 ; f<countries.length ; f++){
      if(countries[f]["id"].toString().trim() == body["data"]["country_id"].toString()){
        country = countries[f]["name"].toString();
      }
    }
    for(int f = 0 ; f<cities.length ; f++){
      if(cities[f]["id"].toString().trim() == body["data"]["region_id"].toString()){
        citiy = cities[f]["name"].toString();
      }
    }
    for(int f = 0 ; f<types.length ; f++){
      if(types[f]["id"].toString().trim() == body["data"]["device_id"].toString()){
        type = types[f]["type"].toString();
      }
    }
    for(int f = 0 ; f<maintains.length ; f++){
      if(maintains[f]["id"].toString().trim() == body["data"]["maintenance_id"].toString()){
        maintain = maintains[f]["name"].toString();
      }
    }
    Navigator.of(contexta,rootNavigator: true).pop("dialog");
    return {"username" : body["data"]["name"] , "email" : body["data"]["email"] , "phone" : body["data"]["phone"]
      ,"type" : type , "re1": country,"re2":citiy , "final_date" :body["data"]["final_date"] , "address" : body["data"]["address"] ,"maintain" : maintain , "maintains" : maintains,"countries" : countries, "cities" : cities , "devices" :types};
  }
  void alert(message){
    showDialog(context: contexta, builder: (context) {
      return AlertDialog(
          content: Directionality(textDirection: TextDirection.rtl,child: new Text(message)),
          actions: [
            new ElevatedButton(onPressed:(){Navigator.of(context).pop();}, child: Text("نعم")),
          ]);
    });
  }
  void alertpassword(message){
    showDialog(context: contexta, builder: (context) {
      return AlertDialog(
          content: Directionality(textDirection: TextDirection.rtl,child: new Text(message)),
          actions: [
            new ElevatedButton(onPressed:(){Navigator.of(context).pop("dialog");
            Navigator.of(context).pop();}, child: Text("نعم")),
          ]);
    });
  }
  update(key,name , email , phone,country,city ,countries , cities,type,maintain,types,maintains,address,finaldate)async{
    if(key.currentState.validate()) {
          var url = "https://filtery-eg.com/api/auth/userUpdate";
          SharedPreferences sharedPreferences = await SharedPreferences
              .getInstance();
          var token = sharedPreferences.getString("token");
          var id1;
          var id2;
          for (int f = 0; countries.length > f; f++) {
            if (countries[f]["name"].toString().trim() ==
                country.toString().trim()) {
              id1 = countries[f]["id"];
            }
          }
          for (int f = 0; cities.length > f; f++) {
            if (cities[f]["name"].toString().trim() ==
                city.toString().trim()) {
              id2 = cities[f]["id"];
            }
          }
          var typeid;
          var maintainid;
          if (type != null) {
            for (int f = 0; types.length > f; f++) {
              if (types[f]["type"].toString().trim() ==
                  type.toString().trim()) {
                typeid = types[f]["id"];
              }
            }
          }
          if (maintain != null) {
            for (int f = 0; maintains.length > f; f++) {
              if (maintains[f]["name"].toString().trim() ==
                  maintain.toString().trim()) {
                maintainid = maintains[f]["id"];
              }
            }
          }
          print(token);
          var data = {
            "name": name.toString(),
            "email": email.toString(),
            "phone": phone.toString(),
            "address": address.toString(),
            "country_id": id1.toString(),
            "region_id": id2.toString(),
            "device_type": type != null ? typeid.toString() : "",
            "final_date": finaldate != "null" ? finaldate.toString() : "",
            "maintenance_id": maintain != null ? maintainid.toString() : "",
          };
          alertwait();
          var response = await http.post(Uri.parse(url), body: data,
              headers: {
                //'Content-Type': 'application/json',
                'Accept': 'application/json',
                'Authorization': 'Bearer $token',
              });
          var body = jsonDecode(response.body);
          Navigator.of(contexta,rootNavigator: true).pop("dialog");
          if (body["success"].toString() == "true") {
            showDialog(context: contexta, builder: (context) {
              return AlertDialog(
                  content: Directionality(textDirection: TextDirection.rtl,child: new Text("تم تعديل البيانات بنجاح")),
                  actions: [
                    new ElevatedButton(onPressed:(){
                      Navigator.of(context).pop("dialog");
                      Navigator.of(context).pop();
                    }, child: Text("نعم")),
                  ]);
            });
          }
          else {
            alert(body["message"]);
          }
      }
  }
  final FirebaseMessaging fire = FirebaseMessaging.instance;
  Future<String> gettoken(){
    fire.getToken().then((value){
      return value;
    });
  }
  complete(pass,GlobalKey<FormState> key,name , email , phone,country,city , countries , cities ,address ,type,types, maintain,maintains,finaldate)async{
    if(key.currentState.validate()) {
      if (country != "اختر المحافظة" && city != "اختر المنطقة") {
         fire.getToken().then((value)async {
           var url = "https://filtery-eg.com/api/auth/userUpdate";
           SharedPreferences sharedPreferences = await SharedPreferences
               .getInstance();
           var token = sharedPreferences.getString("token");
           alertwait();
           var id1;
           var id2;
           for (int f = 0; countries.length > f; f++) {
             if (countries[f]["name"].toString().trim() ==
                 country.toString().trim()) {
               id1 = countries[f]["id"];
             }
           }
           for (int f = 0; cities.length > f; f++) {
             if (cities[f]["name"].toString().trim() ==
                 city.toString().trim()) {
               id2 = cities[f]["id"];
             }
           }
           var typeid;
           var maintainid;
           if (type != null) {
             for (int f = 0; types.length > f; f++) {
               if (types[f]["type"].toString().trim() ==
                   type.toString().trim()) {
                 typeid = types[f]["id"];
               }
             }
           }
           if (maintain != null) {
             for (int f = 0; maintains.length > f; f++) {
               if (maintains[f]["name"].toString().trim() ==
                   maintain.toString().trim()) {
                 maintainid = maintains[f]["id"];
               }
             }
           }
           print(token);
           var data = {
             "password": pass.toString(),
             "token": value.toString(),
             "name": name.toString(),
             "email": email.toString(),
             "phone": phone.toString(),
             "address": address.toString(),
             "country_id": id1.toString(),
             "region_id": id2.toString(),
             "device_type": type != null ? typeid.toString() : "",
             "final_date": finaldate != "null"? finaldate.toString() : "",
             "maintenance_id": maintain != null ? maintainid.toString() : "",
           };
           var response = await http.post(Uri.parse(url), body: data,
               headers: {
                 'Authorization': 'Bearer $token',
               });
           var body = jsonDecode(response.body);
           Navigator.of(contexta,rootNavigator: true).pop("dialog");
           if (body["success"].toString() == "true") {
             sharedPreferences.setString("password", pass.toString());
             //Navigator.of(contexta).popUntil((route) => route.isFirst);
             Navigator.of(contexta).pushReplacement(MaterialPageRoute(builder: (context) {
               return Mainpage();
             }));
           }
           else {
             alert(body["message"]);
           }
         });
      }
      else {
        alert("يجب أن تختار المنطقة والمحافظة بشكل مناسب");
      }
    }
    }
  alertwait(){
    showDialog(barrierDismissible: false,context: contexta, builder: (context) {
      return AlertDialog(elevation: 0,backgroundColor: Colors.transparent,content: Container(width: 30,height:30,
          child: Center(child :SizedBox( width: 30,height: 30, child: CircularProgressIndicator()))),
      );});
  }
  String passpastvalid(String value){
    if(password == value){
      return null;
    }
    else{
      return "كلمة السر ليست صحيحة";
    }
  }
  String passnewvalid(String value){
    if(value.isEmpty ){
      return 'الرجاء اختيار كلمة السر المناسبة ' ;
    }
    if(value.length <6){
      return 'لا يجوز أن تكةن كلمة السر أصغر من 6 خانات' ;
    }
    return null;
  }
  var password ;
  changethepass(key, passwords,passpast , passnew)async{
    print(passwords);
    password = passwords;
    if(key.currentState.validate()){
      SharedPreferences sharedPreferences = await SharedPreferences.getInstance();
      var token = sharedPreferences.getString("token");
      var data = {"old_password": passpast, "new_password": passnew};
      //put here the url to add account
      var url = "https://filtery-eg.com/api/auth/updatePassword";
      alertwait();
      var response = await http.post(Uri.parse(url), body: data,headers: {
        'Accept': 'application/json',
        'Authorization': 'Bearer $token',
      });
      Navigator.of(contexta,rootNavigator: true).pop('dialog');
      var body = jsonDecode(response.body);
      if (body["success"] == true) {
        SharedPreferences sharedPreferences = await SharedPreferences.getInstance();
        sharedPreferences.setString("password", passnew);
        alertpassword("تم تغيير كلمة السر بنجاح");
      }
      else {
        alert(body["message"]);
      }
    }
  }
}