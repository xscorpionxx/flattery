import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:http/http.dart'as http;


class Maintainhistlogic {
  var contexta;
  Maintainhistlogic(BuildContext context){
    contexta = context;
  }
  void navigate(){
    Navigator.of(contexta).pop();
  }
  getdata() async{
    //put the url of api here
    var url = "https://filtery-eg.com/api/auth/maintenance_contract";
    SharedPreferences sharedPreferences = await SharedPreferences.getInstance();
    var token = sharedPreferences.getString("token");
    var response=await http.get(Uri.parse(url),headers: {
      'Content-Type': 'application/json',
      'Accept': 'application/json',
      'Authorization': 'Bearer $token',
    });
    var body = jsonDecode(response.body);
    var contract = body["data"]["contract"];
    print(body);
    //note : you should name the gabs with the right names from api
    return {"contract" : contract};
  }
}