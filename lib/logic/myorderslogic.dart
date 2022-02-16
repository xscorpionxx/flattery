import 'dart:convert';

import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:http/http.dart' as http;
class Myorderlogic{
  var contexta;

  Myorderlogic(BuildContext context) {
    contexta = context;
  }
  showdetail(data){
    if(data !=null) {
      showDialog(context: contexta, builder: (context) {
        return AlertDialog(title: new Text("تفاصيل"),
            content: Directionality(
                textDirection: TextDirection.rtl, child: new Text(data)),
            actions: [
              new ElevatedButton(onPressed: () {
                Navigator.of(context).pop();
              }, child: Text("تم")),
            ]);
      });
    }
    else{
      showDialog(context: contexta, builder: (context) {
        return AlertDialog(title: new Text("تفاصيل"),
            content: Directionality(
                textDirection: TextDirection.rtl, child: new Text("لا توجد تفاصيل خاصة بهذا المنتج")),
            actions: [
              new ElevatedButton(onPressed: () {
                Navigator.of(context).pop();
              }, child: Text("تم")),
            ]);
      });
    }
  }
  alertwait(){
    showDialog(barrierDismissible: false,context: contexta, builder: (context) {
      return AlertDialog(elevation: 0 ,backgroundColor: Colors.transparent,content: Container(width: 30,height:30,
          child: Center(child :SizedBox( width: 30,height: 30, child: CircularProgressIndicator()))),
      );});
  }
  getdata() async{
    SharedPreferences sharedPreferences = await SharedPreferences.getInstance();
    var token = sharedPreferences.getString("token");
    alertwait();
    print(token);
    var url = "https://filtery-eg.com/api/auth/my-orders";
    var response=await http.get(Uri.parse(url),headers: {
      'Content-Type': 'application/json',
      'Accept': 'application/json',
      'Authorization': 'Bearer $token',
    });
    Navigator.of(contexta,rootNavigator: true).pop("dialog");
    var body = jsonDecode(response.body);
    return body["data"];
  }
}