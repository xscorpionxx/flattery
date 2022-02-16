import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:http/http.dart' as http;
import 'package:url_launcher/url_launcher.dart';
class Contactlogic {
  var contexta;
  Contactlogic(BuildContext context){
    contexta = context;
  }
  void navigate(){
    Navigator.of(contexta).pop();
  }
  contactwithus()async{
    SharedPreferences sharedPreferences = await SharedPreferences.getInstance();
    var token = sharedPreferences.getString("token");
    var url = "https://filtery-eg.com/api/auth/contact_us";
    var response=await http.get(Uri.parse(url),headers: {
      'Authorization': 'Bearer $token',
    });
    var body = jsonDecode(response.body);
    var data = body["data"];
    return data;
  }
  getus()async{
    SharedPreferences sharedPreferences = await SharedPreferences.getInstance();
    var token = sharedPreferences.getString("token");
    var url = "https://filtery-eg.com/api/auth/about";
    var response=await http.get(Uri.parse(url),headers: {
      'Authorization': 'Bearer $token',
    });
    var body = jsonDecode(response.body);
    var data = body["data"];
    return data;
  }
  gowhatsapp(phone)async{
    var url = "whatsapp://send?phone="+phone+"&text= ";
    if (await canLaunch(url)) {
    await launch(url);
    } else {
    throw 'Could not launch $url';
    }
  }
  gophone(phone)async{
    var url = "tel:"+phone.toString();
    if (await canLaunch(url)) {
    await launch(url);
    } else {
    throw 'Could not launch $url';
    }
  }
  gofacebook(url)async{
    if (await canLaunch(url)) {
    await launch(url);
    } else {
    throw 'Could not launch $url';
    }
  }
  goinsta(url)async{
    if (await canLaunch(url)) {
    await launch(url);
    } else {
    throw 'Could not launch $url';
    }
  }
  golink(url)async{
    if (await canLaunch(url)) {
    await launch(url);
    } else {
    throw 'Could not launch $url';
    }
  }
}