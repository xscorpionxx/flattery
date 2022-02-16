
import 'dart:convert';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:http/http.dart' as http;
import 'package:teste/paymentmaintain.dart';
import 'package:teste/paymentway2.dart';
class SubMaintainlogic {
  var contexta;
  SubMaintainlogic(BuildContext context){
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
            new ElevatedButton(onPressed:(){Navigator.of(context).pop();}, child: Directionality(textDirection: TextDirection.rtl,child: Text("الغاء"))),
          ]);
    });
  }
  String validatelocation(String value) {
    if(value.isEmpty){
      return 'لا يمكن أن يكون العنوان فارغ' ;
    }
    return null;
  }
  String validatdesc(String value) {
    if(value.isEmpty){
      return 'لا يمكن أن يكون الوصف فارغ!';
    }
    return null;
  }
  getdata() async{
    SharedPreferences sharedPreferences = await SharedPreferences.getInstance();
    var token = sharedPreferences.getString("token");
    alertwait();
    var url = "https://filtery-eg.com/api/auth/maintenance";
    var response=await http.get(Uri.parse(url),headers: {
      'Content-Type': 'application/json',
      'Accept': 'application/json',
      'Authorization': 'Bearer $token',
    });
    var body = jsonDecode(response.body);
    Navigator.of(contexta).pop();
    List data =body["data"];
    //note : you should name the gabs with the right names from api
    return{"data": data};
  }
  void alertmessage(message){
    showDialog(context: contexta, builder: (context) {
      return AlertDialog(
          content: Directionality(textDirection: TextDirection.rtl,child: new Text(message)),
          actions: [
            new ElevatedButton(onPressed:(){Navigator.of(context).pop();}, child: Directionality(textDirection: TextDirection.rtl,child: Text("نعم"))),
          ]);
    });
  }
  alertwait(){
    showDialog(barrierDismissible: false,context: contexta, builder: (context) {
      return AlertDialog(elevation: 0,backgroundColor: Colors.transparent,content: Container(width: 30,height:30,
          child: Center(child :SizedBox( width: 30,height: 30, child: CircularProgressIndicator()))),
      );});
  }
  select(List checkboxes,data,datamaintain) async{
    bool able = false;
    print(checkboxes);
    int num =0;
    for(int f =0 ; f<checkboxes.length ; f++) {
      if (checkboxes[f]==true) {
        able = true;
        num = num +1;
      }
    }
    if(num >1){
      able = false;
      showDialog(context: contexta, builder: (context) {
        return AlertDialog(
            content: Directionality(textDirection: TextDirection.rtl,child: new Text("لا يمكن اختيار أكثر من باقة في نفس الوقت!")),
            actions: [
              new ElevatedButton(onPressed:(){Navigator.of(context).pop();}, child: Directionality(textDirection: TextDirection.rtl,child: Text("نعم"))),
            ]);
      });
    }
    if(num ==1 &&able) {
      //we will check if he had contract before
      alertwait();
      var url = "https://filtery-eg.com/api/auth/maintenance_contract";
      SharedPreferences sharedPreferences = await SharedPreferences.getInstance();
      var token = sharedPreferences.getString("token");
      var response=await http.get(Uri.parse(url),headers: {
        'Content-Type': 'application/json',
        'Accept': 'application/json',
        'Authorization': 'Bearer $token',
      });
      var body = jsonDecode(response.body);
      List contract = body["data"]["contract"];
      Navigator.of(contexta,rootNavigator: true).pop('dialog');
      if( contract.length ==0){
        var selected;
        int numofitems = 0;
        for(int y =0 ; y<checkboxes.length; y++){
            if (checkboxes[y] == true) {
              numofitems = 1;
              var price = data[y]["price"].toString().trim();
              var id = data[y]["id"].toString().trim();
              selected = {"price": price, "id": id};
            }
        }
        if(numofitems == 1){
          print(selected);
          Navigator.of(contexta).push(MaterialPageRoute(builder: (contexta){
            return PaymentMaintain(data: selected , datamaintain: datamaintain);
          }));
        }
      }
      else{
        showDialog(context: contexta, builder: (context) {
          return AlertDialog(
              content: Directionality(textDirection: TextDirection.rtl,child: new Text("أنت بالفعل قمت بشراء عقد صيانة دورية من قبل !")),
              actions: [
                new ElevatedButton(onPressed:(){Navigator.of(context).pop();}, child: Directionality(textDirection: TextDirection.rtl,child: Text("نعم"))),
              ]);
        });
      }
    }
    if(num ==0) {
      showDialog(context: contexta, builder: (context) {
        return AlertDialog(
            content: Directionality(textDirection: TextDirection.rtl,child: new Text("لم تقم بتحديد أية خيار في الاعلى!")),
            actions: [
              new ElevatedButton(onPressed:(){Navigator.of(context).pop();}, child: Directionality(textDirection: TextDirection.rtl,child: Text("نعم"))),
            ]);
      });
    }
    }
  }
