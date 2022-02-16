import 'dart:convert';
import 'package:http/http.dart' as http;
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:teste/homescreen.dart';
import 'package:teste/paymentway1.dart';

class Shoppinglogic{
  var contexta;
  Shoppinglogic(BuildContext context){
    contexta = context;
  }
  void navigate(){
    Navigator.of(contexta).push(MaterialPageRoute(builder: (context){
      return Mainpage();
    }));
  }
  void alert(message){
    showDialog(context: contexta, builder: (context) {
      return AlertDialog(
          content: Directionality(textDirection: TextDirection.rtl,child: new Text(message)),
          actions: [
            new ElevatedButton(onPressed:(){Navigator.of(context).pop();}, child: Text("موافق")),
          ]);
    });
  }
  void alertbuy(List data1 ,  totalprice ,GlobalKey<FormState> ket , datapay) {
    if (ket.currentState.validate()) {
      showDialog(context: contexta, builder: (context) {
        return AlertDialog(
            content: Directionality(textDirection: TextDirection.rtl,
                child: new Text(
                    " هل أنت متأكد من أنك أكملت جميع متطلباتك مع العلم أن مجمل السعر هو :" +
                        totalprice.toString() + "ج.م")),
            actions: [
              new ElevatedButton(onPressed: () {
                Navigator.of(contexta).pop("dialog");
                Navigator.of(context).push(
                    MaterialPageRoute(builder: (contexta) {
                      return Paymentway1(data1: data1, totalprice: totalprice,datapay: datapay,);
                    }));
              }, child: Text("نعم")),
              new ElevatedButton(onPressed: () {
                Navigator.of(context).pop();
              },
                  child: Directionality(
                      textDirection: TextDirection.rtl, child: Text("الغاء"))),
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
  plus(id)async{
    SharedPreferences sharedPreferences = await SharedPreferences.getInstance();
    List shoopingh =[];
    List data1 = sharedPreferences.getString("basket").toString().trim().substring(2,sharedPreferences.getString("basket").toString().trim().length-2).split("}, {");
    for(int g =0 ; g<data1.length ; g++){
      List detail = data1[g].toString().trim().split(",");
      var name = detail[4].toString().trim().substring(5,detail[4].toString().trim().length);
      var url = detail[2].toString().trim().substring(5,detail[2].toString().trim().length);
      var price =  detail[3].toString().trim().substring(7,detail[3].toString().trim().length);
      var id = int.parse(detail[0].toString().trim().substring(4,detail[0].toString().trim().length));
      var num =int.parse(  detail[1].toString().trim().substring(5,detail[1].toString().trim().length));
      shoopingh.add({"id" : id , "num" : num , "img" : url ,"price":double.parse( price) , "name" : name});
    }
    for(int g = 0;g < shoopingh.length ; g++){
      if(shoopingh[g]["id"].toString().trim() == id.toString().trim()){
        shoopingh[g]["num"] = int.parse(shoopingh[g]["num"].toString()) +1;
        break;
      }
    }
    print("look");
    print(shoopingh);
    sharedPreferences.setString("basket",shoopingh.toString());
  }
  minus(id) async{
    SharedPreferences sharedPreferences = await SharedPreferences.getInstance();
    List shoopingh =[];
    List data1 = sharedPreferences.getString("basket").toString().trim().substring(2,sharedPreferences.getString("basket").toString().trim().length-2).split("}, {");
    for(int g =0 ; g<data1.length ; g++){
      List detail = data1[g].toString().trim().split(",");
      var name = detail[4].toString().trim().substring(5,detail[4].toString().trim().length);
      var url = detail[2].toString().trim().substring(5,detail[2].toString().trim().length);
      var price =  detail[3].toString().trim().substring(7,detail[3].toString().trim().length);
      var id = int.parse(detail[0].toString().trim().substring(4,detail[0].toString().trim().length));
      var num =int.parse(  detail[1].toString().trim().substring(5,detail[1].toString().trim().length));
      shoopingh.add({"id" : id , "num" : num , "img" : url ,"price":double.parse( price) , "name" : name});
    }
    for(int g = 0;g < shoopingh.length ; g++){
      if(shoopingh[g]["id"].toString().trim() == id.toString().trim()){
        if( shoopingh[g]["num"]== 1) {
          break;
        }
        else{
          shoopingh[g]["num"] = int.parse(shoopingh[g]["num"].toString()) -1;
          break;
        }
      }}
    sharedPreferences.setString("basket",shoopingh.toString());

  }
  deletecart(List selectedshop, id)async{
    SharedPreferences sharedPreferences = await SharedPreferences.getInstance();
    List shoopingh =[];
    List data1 = sharedPreferences.getString("basket").toString().trim().substring(2,sharedPreferences.getString("basket").toString().trim().length-2).split("}, {");
    for(int g =0 ; g<data1.length ; g++){
      List detail = data1[g].toString().trim().split(",");
      var name = detail[4].toString().trim().substring(5,detail[4].toString().trim().length);
      var url = detail[2].toString().trim().substring(5,detail[2].toString().trim().length);
      var price =  detail[3].toString().trim().substring(7,detail[3].toString().trim().length);
      var id = int.parse(detail[0].toString().trim().substring(4,detail[0].toString().trim().length));
      var num =int.parse(  detail[1].toString().trim().substring(5,detail[1].toString().trim().length));
      shoopingh.add({"id" : id , "num" : num , "img" : url ,"price":int.parse( price) , "name" : name});
    }
    print(id);
    for(int g = 0;g < shoopingh.length ; g++){
      if(shoopingh[g]["id"].toString().trim() == id.toString().trim()){
        shoopingh[g]["num"] = 0;
        break;
      }
    }
    print(shoopingh);
    sharedPreferences.setString("basket",shoopingh.toString());
  }
  double computetotal(datashopp){
    double totalprice =0;
    for(int g =0 ;g<datashopp.length ; g++){
      totalprice = totalprice + datashopp[g]["price"]*double.parse(datashopp[g]["num"].toString());
    }
    return totalprice;
  }
  String valid(String value){
    if(value.isEmpty){
      return "لا يجوز أن تبقي المعلومات فارغة";
    }
    return null;
  }
  String validphone(String value) {
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
  deleteall()async{
    SharedPreferences sharedPreferences = await SharedPreferences.getInstance();
    List shoopingh =[];
    List data1 = sharedPreferences.getString("basket").toString().trim().substring(2,sharedPreferences.getString("basket").toString().trim().length-2).split("}, {");
    for(int g =0 ; g<data1.length ; g++){
      List detail = data1[g].toString().trim().split(",");
      var name = detail[4].toString().trim().substring(5,detail[4].toString().trim().length);
      var url = detail[2].toString().trim().substring(5,detail[2].toString().trim().length);
      var price =  detail[3].toString().trim().substring(7,detail[3].toString().trim().length);
      var id = int.parse(detail[0].toString().trim().substring(4,detail[0].toString().trim().length));
      var num =int.parse(  detail[1].toString().trim().substring(5,detail[1].toString().trim().length));
      shoopingh.add({"id" : id , "num" : num , "img" : url ,"price":double.parse( price) , "name" : name});
    }
    for(int g = 0;g < shoopingh.length ; g++){
      shoopingh[g]["num"] = 0;
    }
    print("here");
    print(shoopingh);
    sharedPreferences.setString("basket",shoopingh.toString());
  }
  getdata() async {
    List shoppingbasket =[];
    List selctedbasket =[];
    List finaldata =[];
    SharedPreferences sharedPreferences = await SharedPreferences.getInstance();
    alertwait();
    print("here");
    print(sharedPreferences.get("basket"));
    List data1 = sharedPreferences.getString("basket").toString().trim().substring(2,sharedPreferences.getString("basket").toString().trim().length-2).split("}, {");
    for(int g =0 ; g<data1.length ; g++){
     List detail = data1[g].toString().trim().split(",");
     var name = detail[4].toString().trim().substring(5,detail[4].toString().trim().length);
     var url = detail[2].toString().trim().substring(5,detail[2].toString().trim().length);
     var price =  detail[3].toString().trim().substring(7,detail[3].toString().trim().length);
     var id = int.parse(detail[0].toString().trim().substring(4,detail[0].toString().trim().length));
     var num =int.parse(  detail[1].toString().trim().substring(5,detail[1].toString().trim().length));
     shoppingbasket.add({"id" : id , "num" : num , "img" : url ,"price":double.parse( price) , "name" : name});
    }
    for(int h =0 ; h< shoppingbasket.length; h++){
      if(shoppingbasket[h]["num"]>0){
        selctedbasket.add(shoppingbasket[h]);
      }
    }
    print(selctedbasket);
    Navigator.of(contexta,rootNavigator: true).pop('dialog');
    return {"datanum" : selctedbasket};
    }
}