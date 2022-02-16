
import 'dart:convert';
  import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:shared_preferences/shared_preferences.dart';
  import 'package:http/http.dart' as http;
import 'package:teste/access.dart';
import '../homescreen.dart';
  class Maintainlogic {
    var contexta;
    Maintainlogic(BuildContext context){
      contexta = context;
    }
    void navigate(){
      Navigator.of(contexta).pop();
    }
    void alert(){
      showDialog(context: contexta, builder: (context) {
        return AlertDialog(
            content: Directionality(textDirection: TextDirection.rtl,child: new Text("هل أنت متأكد من أنك أكملت جميع متطلباتك")),
            actions: [
              new ElevatedButton(onPressed:(){Navigator.of(context).push(MaterialPageRoute(builder: (contexta){
                //return Payment();
              }));}, child: Text("ok")),
              new ElevatedButton(onPressed:(){Navigator.of(context).pop();}, child: Text("الغاء")),
            ]);
      });
    }
    String validatelocation(String value) {
      if(value.isEmpty){
        return 'لا يمكن أن يكون العنوان فارغ' ;
      }
      return null;
    }
    String validate(String value) {
      if(value.isEmpty){
        return 'لا يمكن أن يكون الحقل فارغ' ;
      }
      return null;
    }
    String validatdesc(String value) {
      if(value.isEmpty){
        return 'لا يمكن أن يكون الوصف فارغ!';
      }
      return null;
    }

    alertwait(){
      showDialog(barrierDismissible: false,context: contexta, builder: (context) {
        return AlertDialog(elevation: 0,backgroundColor: Colors.transparent,content: Container(width: 30,height:30,
            child: Center(child :SizedBox( width: 30,height: 30, child: CircularProgressIndicator()))),
        );});
    }
    void alertmessage(message ,code){
      if(message == "success") {
        Navigator.of(contexta).pushReplacement(MaterialPageRoute(builder: (context){
          return Access(code: code,);
        }));
      }
      else{
        showDialog(context: contexta, builder: (context) {
          return AlertDialog(
              content: Directionality(
                  textDirection: TextDirection.rtl, child: new Text(code)),
              actions: [
                new ElevatedButton(onPressed: () {
                  Navigator.of(context).pop();
                }, child: Text("نعم")),
              ]);
        });
      }
    }
    send(location,desc,GlobalKey<FormState> key, country , city ,type ,maintaindate , lastmaintaindate,types , countries ,citites )async{
     if(key.currentState.validate()) {
       //print(country + city + type);
       if (country == null|| city == null || type == null) {
         showDialog(context: contexta, builder: (context) {
           return AlertDialog(
               content: Directionality(
                   textDirection: TextDirection.rtl,
                   child: new Text(
                       "يجب أن تختار المحافظة والمنطقة ونوع الجهاز بالشكل المناسب")),
               actions: [
                 new ElevatedButton(onPressed: () {
                   Navigator.of(context).pop();
                 }, child: Text("نعم")),
               ]);
         });
       }else {
         if (maintaindate != "null" && lastmaintaindate != "null") {
           var url = "https://filtery-eg.com/api/auth/singleMaintenanceOrder";
           alertwait();
           SharedPreferences sharedPreferences = await SharedPreferences
               .getInstance();
           var token = sharedPreferences.getString("token");
           var id1;
           var id2;
           var typeid;
           for (int f = 0; countries.length > f; f++) {
             if (countries[f]["name"].toString().trim() ==
                 country.toString().trim()) {
               id1 = countries[f]["id"];
             }
           }
           for (int f = 0; citites.length > f; f++) {
             if (citites[f]["name"].toString().trim() ==
                 city.toString().trim()) {
               id2 = citites[f]["id"];
             }
           }
           for (int f = 0; types.length > f; f++) {
             if (types[f]["type"].toString().trim() == type.toString().trim()) {
               typeid = types[f]["id"];
             }
           }
           var data = {
             "name": sharedPreferences.getString("name"),
             "email": sharedPreferences.getString("email"),
             "phone": sharedPreferences.getString("phone"),
             "address": location.toString(),
             "desc": desc.toString(),
             "country_id": id1.toString(),
             "region_id": id2.toString(),
             "device_id": typeid.toString(),
             "recent_date": lastmaintaindate.toString(),
             "maintenance_date": maintaindate.toString()
           };
           print(data);
           var response = await http.post(Uri.parse(url), body: data,
               headers: {
                 'Accept': 'application/json',
                 'Authorization': 'Bearer $token',
               });
           var body = jsonDecode(response.body);
           print(body);
           Navigator.of(contexta).pop("dialog");
           if (body["success"] == true) {
             alertmessage("success", body["data"]["code"].toString());
           }
           else {
             alertmessage("", body["message"]);
           }
         }
         else{
           showDialog(context: contexta, builder: (context) {
             return AlertDialog(
                 content: Directionality(
                     textDirection: TextDirection.rtl,
                     child: new Text(
                         "يجب أن تختار أوقات الصيانة بالشكل المناسب")),
                 actions: [
                   new ElevatedButton(onPressed: () {
                     Navigator.of(context).pop();
                   }, child: Text("نعم")),
                 ]);
           });
         }
       }
     }
    }
  }





