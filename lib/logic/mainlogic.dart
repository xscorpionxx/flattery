import 'dart:convert';

import 'package:firebase_messaging/firebase_messaging.dart';
import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;
import 'package:shared_preferences/shared_preferences.dart';
import 'package:teste/logic/contactlogic.dart';
import 'package:teste/logic/detaillogic.dart';
import 'package:teste/logic/homescreen.dart';
import 'package:teste/logic/maintainhislogic.dart';
import 'package:teste/logic/myorderslogic.dart';
import 'package:teste/logic/shoppinglogic.dart';
import 'package:teste/logic/signuplogic.dart';
import 'package:teste/logic/submaintainlogic.dart';
import 'package:teste/loginscreen.dart';
class Mainlogic{
  final FirebaseMessaging fire = FirebaseMessaging.instance;
  var message ;
  var data;
  var token ;
  Future<String> gettoken() {
    fire.getToken().then((value) {
      token = value;
      return value;
    });
  }

  var profile;
  Future login(phone ,password)async{
      var data = {"password": password, "phone": phone , "token" :token};
      //put here the url to add account
      var url = "https://filtery-eg.com/api/auth/login";
      var response = await http.post(Uri.parse(url), body: data);
      var body = jsonDecode(response.body);
      if(body["message"]=="login Successfuly") {
        SharedPreferences sharedPreferences = await SharedPreferences
            .getInstance();
        sharedPreferences.setString("token", body["data"]["access_token"]);
      }
      message = body["message"];
      print(body["data"]["access_token"]);
      return body["message"];
    }
  Future getprofile()async{
    SharedPreferences sharedPreferences = await SharedPreferences.getInstance();
    var token = sharedPreferences.getString("token");
    var url = "https://filtery-eg.com/api/auth/profile";
    var response = await http.get(Uri.parse(url),
        headers: {
          //'Content-Type': 'application/json',
          'Accept': 'application/json',
          'Authorization': 'Bearer $token',
        });
    var body = jsonDecode(response.body);
    profile = body["data"];
    return body["data"];
  }
  getdata() async{
    SharedPreferences sharedPreferences = await SharedPreferences.getInstance();
    sharedPreferences.setString("basket", "null");
    var phone =   sharedPreferences.getString("phone");
    var token = sharedPreferences.getString("token");
    var password = sharedPreferences.getString("password");
    var type = sharedPreferences.getString("logintype");
    data ={
      "phone" : phone , "password" : password , "logintype" : type , "token" : token
    };
    return data ;
  }
}
class Notifires extends ChangeNotifier{
  List offersdata =[];
  List databannerimages =[];
  List data =[];
  List shoppingbasket = [];
  List shoppingbackup = [];
  var discount;
  var lastmindate;
  List contract =[];
  var lastDeviceM;
  var Device;
  var lastmin;
  var download =true;
  getdatahomescreen(context) async{
    // var datag = await homeScreenlogic.getbannerimages();
    // print(datag);
    // if(datag.toString().trim() != "null"){
    //   databannerimages= datag;
    // }
    HomeScreenlogic homeScreenlogic = new HomeScreenlogic(context);
    homeScreenlogic.initializesnotification();
    var dataofers = await homeScreenlogic.getoffers1();
    //هي العروض
    offersdata = dataofers;
    var databanners = await homeScreenlogic.getbannerimages();
    databannerimages= databanners;
    var  datat =await homeScreenlogic.getdata();
    data = datat["data"];
    shoppingbasket = datat["basket"];
    shoppingbackup = datat["basket"];
    discount = datat["discount"];
    lastmin = datat["lastmin"];
    if(lastmin.toString() != "0"&&lastmin.toString()!= "لا توجد صيانة"){
      lastmindate = DateTime.parse(lastmin.toString()).millisecondsSinceEpoch + 1000 * 30;
    }
      contract = datat["contract"];
      lastDeviceM= datat["lastDeviceM"];
      Device = datat["Device"];
      download = false;
    notifyListeners();
  }
  List datashopp =[];
  getdatashopp(context) async{
    Shoppinglogic shoppinglogic = new Shoppinglogic(context);
    var  datat = await shoppinglogic.getdata();
    datashopp = datat["datanum"];
    notifyListeners();
  }
  var active = "home";
  void getindex(tab,name,ind,context){
    active = name;
    tab.animateTo(ind);
    print(active);
    notifyListeners();
  }
  List countries = [];
  List datalatlang1 =[];
  List typebackup =[];
  List types =[];
  List citites = [];
  List datalatlang2 =[];
  getlat1(context)async{
    if(countries.length ==0) {
      Signuplogic signuplogic = new Signuplogic(context);
      var data1a = await signuplogic.getlat();
      datalatlang1 = data1a["1"];
      //countries.add("اختر المحافظة");
      for (int g = 0; g < datalatlang1.length; g++) {
        countries.add(datalatlang1[g]["name"]);
      }
      typebackup = data1a["2"];
      for (int g = 0; g < typebackup.length; g++) {
        types.add(typebackup[g]["type"].toString());
      }
      types = types.toSet().toList();
      notifyListeners();
    }
  }
  getlat2(id,context)async{
    citites.clear();
    Signuplogic signuplogic = new Signuplogic(context);
    datalatlang2 = await signuplogic.getlat2(id.toString());
    //citites.add("اختر المنطقة");
    for(int g = 0 ; g< datalatlang2.length;g++){
      citites.add(datalatlang2[g]["name"].toString());
    }
    print(citites);
    notifyListeners();
  }
  List devicesinfo =[];
  List valuesinfo =["اختر نوع الجهاز"];
  var valueinfo = "اختر نوع الجهاز";
  getdatainfo(context) async {
    Shoppinglogic shoppinglogic =new Shoppinglogic(context);
    SubMaintainlogic subMaintainlogic = new SubMaintainlogic(context);
    shoppinglogic = new Shoppinglogic(context);
    subMaintainlogic = new SubMaintainlogic(context);
    SharedPreferences sharedPreferences = await SharedPreferences.getInstance();
    var token = sharedPreferences.getString("token");
    var url = "https://filtery-eg.com/api/auth/devices";
    var response = await http.get(Uri.parse(url), headers: {
      'Content-Type': 'application/json',
      'Accept': 'application/json',
      'Authorization': 'Bearer $token',
    });
    var body = jsonDecode(response.body);
    devicesinfo = body["data"];
    print(body);
    for (int g = 0; g < devicesinfo.length; g++) {
      if (!valuesinfo.contains(devicesinfo[g]["type"])) {
        valuesinfo.add(devicesinfo[g]["type"]);
      }
    }
    notifyListeners();
  }
  changevalueofdevice(value){
    valueinfo =value;
    notifyListeners();
  }
  List datasubmaintain =[];
  List checkboxessub =[];
  getdatasubmaintain(context)async{
    SubMaintainlogic subMaintainlogic = new SubMaintainlogic(context);
    var datas = await subMaintainlogic.getdata();
    datasubmaintain = datas["data"];
    for(int g = 0 ; g< data.length ; g++){
      checkboxessub.add(false);
    }
    notifyListeners();
  }
  check(val,i){
    checkboxessub[i] = val;
    notifyListeners();
  }
  var who_us ;
  getwho_us(context)async{
    if(who_us==null) {
      Contactlogic contactlogic = new Contactlogic(context);
      who_us = await contactlogic.getus();
      notifyListeners();
    }
  }
  var contact ;
  getcontact(context)async{
    if(contact==null) {
      Contactlogic contactlogic = new Contactlogic(context);
      contact = await contactlogic.contactwithus();
      notifyListeners();
    }
  }
  var able =false ;
  List images = [];
  List datas =[];
  var ids ;
  var index ;
  void getdatas(id,context,tabController,) async{
    images.clear();
    // Future.delayed(Duration(microseconds: 10),()async{
    able = false;
    notifyListeners();
    datas.clear();
    ids = id;
    Detaillogic detaillogic = new Detaillogic(context);
    var  commondata = await detaillogic.getdata(id);
    datas = commondata["data"];
    index = commondata["index"];
    List imgdata = datas[0]["images"].toList();
    for(int j =0 ;j< imgdata.length ;j++){
      images.add(datas[0]["images"][j]["path"]);
    }
    able = true;
    getindex(tabController, "detail", 1, context);
    //});
  }
  void addtobasket(context,tab){
    for(int g =0 ; g< shoppingbasket.length;g++){
      if(shoppingbasket[g]["id"].toString().trim() == datas[0]["id"].toString().trim()){
        shoppingbasket[g]["num"] = 1;
      }
    }
    Detaillogic detaillogic = new Detaillogic(context);
    detaillogic.alertbuy(shoppingbasket, tab, datas[0]["price"], datas[0]["id"],context);
    images.clear();
    ids = null;
    datas.clear();
  }
  List myorders =[];
  getmyorders(context)async{
    Myorderlogic myorderlogic =new Myorderlogic(context);
    var data= await myorderlogic.getdata();
    if(myorders.toString()=="null"){

    }
    else {
      myorders = data;
      notifyListeners();
    }
  }
  reset(){
    myorders.clear();
    images.clear();
    datas.clear();
    data.clear();
    contract.clear();
    offersdata.clear();
    databannerimages.clear();
    shoppingbasket.clear();
    shoppingbackup.clear();
    Device = null;
    download = true;
    lastmin =null;
    lastDeviceM = null;
    lastmindate = null;
    notifyListeners();
  }
  sethome(context){
    active ="home";
    getdatahomescreen(context);
    datashopp.clear();
    notifyListeners();
  }

}