import 'dart:convert';

import 'package:http/http.dart' as http;
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:teste/access.dart';
import 'package:teste/homescreen.dart';
import 'mainlogic.dart';
class Paymentmaintainlogic{
  var contexta;
  Paymentmaintainlogic(BuildContext context){
    contexta = context;
  }
  String validatepassword(String value){
    if(value.isEmpty){
      return 'لا يجوز ابقاء خانة كلمة السر فارغة' ;
    }
    return null;
  }
  String validatecard(String value) {
    if(value.length < 14){
      return 'يجب أنتكون رقم الكارت مكون من 14 رقم';
    }
    return null;
  }
  String validateMobile(String value) {
    String patttern = r'(^(?:[+0]9)?[0-9]{10,12}$)';
    RegExp regExp = new RegExp(patttern);
    if (value.length == 0) {
      return 'لا يمكنك ترك الرقم فارغ!';
    }
    if (!regExp.hasMatch(value)) {
      return 'هذا الرقم غير صالح!';
    }
    return null;
  }
  void alert(message){
    print(message);
    if(message == "success"){
      showDialog(context: contexta, builder: (context) {
        return AlertDialog(
            content: Directionality(textDirection: TextDirection.rtl,child: new Text("تم الاشتراك بالباقة بنجاح")),
            actions: [
              new ElevatedButton(onPressed:(){navigatetohome();}, child: Text("نعم")),
            ]);
      });
    }
    else{
      showDialog(context: contexta, builder: (context) {
        return AlertDialog(
            content: Directionality(textDirection: TextDirection.rtl,child: new Text(message)),
            actions: [
              new ElevatedButton(onPressed:(){Navigator.of(context).pop();}, child: Text("نعم")),
            ]);
      });
    }
  }
  alertwait(){
    showDialog(barrierDismissible: false,context: contexta, builder: (context) {
      return AlertDialog(backgroundColor: Colors.transparent,content: Container(width: 30,height:30,
          child: Center(child :SizedBox( width: 30,height: 30, child: CircularProgressIndicator()))),
      );});
  }
  //قم بالشراء على الفيزا
  Future<bool> makepaymentvisa() async{
  return true;
  }
  //قم بالشراء على فودافون
  Future<bool> makepaymentvodafon() async{
  return true;
  }
  //الشراء
  void pay(key,sectionone, sectiontow ,visacardnum,visapassword,phone,phonepass,data , datamaintain)async{
    if(key.currentState.validate()){
      alertwait();
      print("hrerawd");
      print(datamaintain);
      if(sectionone ||sectiontow){
        if(sectionone){
          //visa
          //here we shouldpay
          bool makeorder =await makepaymentvisa();
          int paymentdone = 0;
          if(makeorder){
            paymentdone =1;
          }
          makepayment(paymentdone,data , datamaintain);
        }
        else{
          //vodafon
          bool makeorder =true;
          int paymentdone = 0;
          if(makeorder){
            paymentdone =1;
          }
          makepayment(paymentdone,data,datamaintain);
        }
      }
      else{
        showDialog(context: contexta, builder: (context) {
          return AlertDialog(title: new Text("تنبيه"),
              content: Directionality(textDirection: TextDirection.rtl,child: new Text("يجب على الاقل اختيار طريقة للدفع لاكمال الدفع")),
              actions: [
                new ElevatedButton(onPressed:(){Navigator.of(context).pop();}, child: Text("نعم")),
              ]);
        });
      }
    }
  }
  void makepayment(paymentdone ,datas , datamaintain)async{
    SharedPreferences sharedPreferences = await SharedPreferences.getInstance();
    var token = sharedPreferences.getString("token");
    var url = "https://filtery-eg.com/api/auth/subscribe_maintenance";
    var data ;
    if(datamaintain["type"].toString() !="null"){
      data = {
        "payment_done" : paymentdone.toString(),
        "maintenance_id" : datas["id"].toString(),
        "desc":datamaintain["type"].toString(),
        "device_type" : datamaintain["devicename"].toString(),
        //"address" : datamaintain["address"].toString()
      };
    }
    else{
      data = {
        "payment_done" : paymentdone.toString(),
        "maintenance_id" : datas["id"].toString(),
        "device_id":datamaintain["id"].toString()
      };
    }
    var response = await http.post(Uri.parse(url),body: data,headers: {
      'Authorization': 'Bearer $token',
    });
    var body = jsonDecode(response.body);
    Navigator.of(contexta).pop("dialog");
    //get response
    if(body["success"].toString().trim() == "true"){
      alert("success");
    }
    else{
      alert(body["message"].toString());
    }
  }
  void navigate(){
    Navigator.of(contexta).pop();
  }
  void navigatetohome(){
    Provider.of<Notifires>(contexta,listen: false).sethome(contexta);
    Navigator.of(contexta).popUntil((route) => route.isFirst);
    Navigator.pushReplacement(contexta, MaterialPageRoute(builder: (BuildContext context) => Mainpage()));
   // Navigator.of(contexta).pushReplacement(contexta,MaterialPageRoute(builder: (contexta){
   //   return Mainpage();
    //}));
  }
}