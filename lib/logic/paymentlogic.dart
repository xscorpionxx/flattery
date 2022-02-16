import 'dart:convert';
import '';
import 'package:http/http.dart' as http;
import 'package:flutter/material.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:teste/access.dart';
import 'package:teste/homescreen.dart';
class Paymentlogic{
  var contexta;
  Paymentlogic(BuildContext context){
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
  void alert(message , code){
    if(message == "success"){
      Navigator.of(contexta).pushReplacement(MaterialPageRoute(builder: (context){
        return Access(code : code);
      }));
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
      return AlertDialog(elevation: 0,backgroundColor: Colors.transparent,content: Container(width: 30,height:30,
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
  void pay(key,sectionone, sectiontow ,visacardnum,visapassword,phone,phonepass,totalprice,data2 ,datapay)async{
    if(key.currentState.validate()){
      if(sectionone ||sectiontow){
        alertwait();
        if(sectionone){
         //visa
         //here we shouldpay
         bool makeorder =await makepaymentvisa();
         int paymentdone = 0;
         if(makeorder){
           paymentdone =1;
         }
          makepayment(paymentdone,totalprice,data2 ,datapay);
        }
        else{
        //vodafon
          bool makeorder =await makepaymentvodafon();
          int paymentdone = 0;
          if(makeorder){
            paymentdone =1;
          }
          makepayment(paymentdone,totalprice,data2,datapay);
        }
      }
      else{
        showDialog(context: contexta, builder: (context) {
          return AlertDialog(
              content: Directionality(textDirection: TextDirection.rtl,child: new Text("يجب على الاقل اختيار طريقة للدفع لاكمال الدفع")),
              actions: [
                new ElevatedButton(onPressed:(){Navigator.of(context).pop();}, child: Text("نعم")),
              ]);
        });
      }
    }
  }
  void payoffer(key,sectionone, sectiontow ,visacardnum,visapassword,phone,phonepass,data)async{
    if(key.currentState.validate()){
      if(sectionone ||sectiontow){
        if(sectionone){
          //visa
          //here we shouldpay
          bool makeorder =await makepaymentvisa();
          int paymentdone = 0;
          if(makeorder){
            paymentdone =1;
          }
          makepaymentoffer(paymentdone,data);
        }
        else{
          //vodafon
          bool makeorder =await makepaymentvodafon();
          int paymentdone = 0;
          if(makeorder){
            paymentdone =1;
          }
          makepaymentoffer(paymentdone,data);
        }
      }
      else{
        showDialog(context: contexta, builder: (context) {
          return AlertDialog(
              content: Directionality(textDirection: TextDirection.rtl,child: new Text("يجب على الاقل اختيار طريقة للدفع لاكمال الدفع")),
              actions: [
                new ElevatedButton(onPressed:(){Navigator.of(context).pop();}, child: Text("نعم")),
              ]);
        });
      }
    }
  }
  var product;
  void makeorder(totalprice,List data2 ,datapay)async{
    print(datapay);
    List<dynamic> datas1 =[];
    List<dynamic> datas2 =[];
    alertwait();
    for(int g =0 ; g<data2.length ; g++){
      datas1.add(data2[g]["id"]);
      datas2.add(data2[g]["num"]);
    }
    SharedPreferences sharedPreferences = await SharedPreferences.getInstance();
    var token = sharedPreferences.getString("token");
    var url = "https://filtery-eg.com/api/auth/makeOrder" ;
    var data ={
      "payment_done" : "0",
      "payment_on_delevery" : "1",
      "name" : sharedPreferences.getString("name"),
      "phone" : datapay["phone"].toString(),
      "email" : sharedPreferences.getString("email"),
      "address" : datapay["address"].toString(),
      "total_price" :totalprice.toString(),
      "ids" : datas1.toString().substring(1,datas1.toString().length-1),
      "qts" : datas2.toString().substring(1,datas2.toString().length-1)
    };
    print("first");
    print(data);
    var response = await http.post(Uri.parse(url),body: data,headers: {
      'Authorization': 'Bearer $token',
    });
    var body = jsonDecode(response.body);
    print("second");
    print(body);
    Navigator.of(contexta).pop("dialog");
    //get response
    if(body["success"].toString().trim() == "true"){
      alert("success" , body["data"]["code"].toString().trim());
    }
    else{
      alert(body["message"].toString() , "null");
    }
  }
  void makeorderoffers(dataa )async{
    alertwait();
    SharedPreferences sharedPreferences = await SharedPreferences.getInstance();
    var token = sharedPreferences.getString("token");
    var url1 = "https://filtery-eg.com/api/auth/profile";
    var response1= await http.get(Uri.parse(url1),
        headers: {
          //'Content-Type': 'application/json',
          'Accept': 'application/json',
          'Authorization': 'Bearer $token',
        });
    var body1 = jsonDecode(response1.body);
    var url = "https://filtery-eg.com/api/auth/offerOrder";
    var data ={
      "payment_done" : "0",
      "payment_on_delevery" : "1",
      "name" : body1["data"]["name"],
      "phone" : dataa["phone"],
      "email" : body1["data"]["email"],
      "address" : dataa["address"],
      "offer_id" :dataa["id"].toString().toString(),
      "country_id" : body1["data"]["country_id"].toString(),
      "region_id" : body1["data"]["region_id"].toString()
    };
    var response = await http.post(Uri.parse(url),body: data,headers: {
      'Authorization': 'Bearer $token',
    });
    var body = jsonDecode(response.body);
    print("second");
    print(body);
    Navigator.of(contexta,rootNavigator: true).pop("dialog");
    //get response
    if(body["success"].toString().trim() == "true"){
      alert("success" , body["data"]["code"].toString().trim());
    }
    else{
      alert(body["message"].toString() , "null");
    }
  }
  void makepaymentoffer(paymentdone ,dataa)async{
    alertwait();
    SharedPreferences sharedPreferences = await SharedPreferences.getInstance();
    var token = sharedPreferences.getString("token");
    var url1 = "https://filtery-eg.com/api/auth/profile";
    var response1= await http.get(Uri.parse(url1),
        headers: {
          //'Content-Type': 'application/json',
          'Accept': 'application/json',
          'Authorization': 'Bearer $token',
        });
    var body1 = jsonDecode(response1.body);
    var url = "https://filtery-eg.com/api/auth/offerOrder";
    var data ={
      "payment_done" : paymentdone.toString(),
      "payment_on_delevery" : "0",
      "name" : body1["data"]["name"],
      "phone" : dataa["phone"],
      "email" : body1["data"]["email"],
      "address" : dataa["address"],
      "offer_id" :dataa["id"].toString().toString(),
      "country_id" : body1["data"]["country_id"].toString(),
      "region_id" : body1["data"]["region_id"].toString()
    };
    var response = await http.post(Uri.parse(url),body: data,headers: {
      'Authorization': 'Bearer $token',
    });
    var body = jsonDecode(response.body);
    print("second");
    print(body);
    Navigator.of(contexta,rootNavigator: true).pop("dialog");
    //get response
    if(body["success"].toString().trim() == "true"){
      alert("success" , body["data"]["code"].toString().trim());
    }
    else{
      alert(body["message"].toString() , "null");
    }
  }
  void makepayment(paymentdone ,totalprice,List data2 ,datapay)async{
    print(datapay);
    List<dynamic> datas1 =[];
    List<dynamic> datas2 =[];
   for(int g =0 ; g<data2.length ; g++){
     datas1.add(data2[g]["id"]);
     datas2.add(data2[g]["num"]);
   }
    SharedPreferences sharedPreferences = await SharedPreferences.getInstance();
    var token = sharedPreferences.getString("token");
    var url = "https://filtery-eg.com/api/auth/makeOrder" ;
     var data ={
      "payment_done" : paymentdone.toString(),
       "payment_on_delevery" : "0",
      "name" : sharedPreferences.getString("name"),
      "phone" : datapay["phone"].toString(),
      "email" : sharedPreferences.getString("email"),
      "address" : datapay["address"].toString(),
      "total_price" :totalprice.toString(),
      "ids" : datas1.toString().substring(1,datas1.toString().length-1),
       "qts" : datas2.toString().substring(1,datas2.toString().length-1)
    };
     print("first");
     print(data);
   var response = await http.post(Uri.parse(url),body: data,headers: {
      'Authorization': 'Bearer $token',
    });
    var body = jsonDecode(response.body);
    print("second");
    print(body);
    Navigator.of(contexta).pop("dialog");
    //get response
    if(body["success"].toString().trim() == "true"){
     alert("success" , body["data"]["code"].toString().trim());
   }
    else{
      alert(body["message"].toString() , "null");
    }
  }
  void navigate(){
    Navigator.of(contexta).pop();
  }
}