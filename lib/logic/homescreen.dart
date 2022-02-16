import 'dart:convert';
import 'dart:io';
import 'package:auto_size_text/auto_size_text.dart';
import 'package:firebase_messaging/firebase_messaging.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_local_notifications/flutter_local_notifications.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:http/http.dart' as http;
import '../contactwithus.dart';
import '../profilescreen.dart';
FlutterLocalNotificationsPlugin notificationsPlugin = FlutterLocalNotificationsPlugin();
class HomeScreenlogic{
 var contexta;
 HomeScreenlogic(BuildContext context){
  contexta = context;
 }
  minus(shobasket ,i) async{
  if(shobasket[i]["num"] == 0) {
   return shobasket;
  }
  else{
   shobasket[i]["num"] = shobasket[i]["num"] - 1 ;
   SharedPreferences sharedPreferences = await SharedPreferences.getInstance();
   sharedPreferences.setString("basket", shobasket.toString());
   return shobasket;
  }
 }
  void navigatetocontact(){
   Navigator.of(contexta).push(MaterialPageRoute(builder: (context){
    return Contact();
   }));
  }
 void navigatetoprofile(){
  Navigator.of(contexta).push(MaterialPageRoute(builder: (context){
   return Profilescreen();
  }));
 }
 void navigatetoshopping(List s){
  if(s.length ==0){
   return null ;
  }
  else {
  }
 }final FirebaseMessaging fire = FirebaseMessaging.instance;
 void initializesnotification() async{
  var inita = AndroidInitializationSettings('@mipmap/logofl');
  var init = InitializationSettings(android: inita);
  notificationsPlugin.initialize(init);
  fire.getToken().then((value) {
   print(value);
  });
  FirebaseMessaging.onMessage.listen((RemoteMessage message) {
   if (message.notification != null) {
    show(message.notification.title, message.notification.body);
   }
  });
 }
  getbannerimages() async{
  SharedPreferences sharedPreferences = await SharedPreferences.getInstance();
  var token = sharedPreferences.getString("token");
  var url = "https://filtery-eg.com/api/auth/get-banners";
  var response=await http.get(Uri.parse(url),headers: {
   'Content-Type': 'application/json',
   'Accept': 'application/json',
   'Authorization': 'Bearer $token',
  });
  var body = jsonDecode(response.body);
  List data = body["data"];
  return data;
 }
 alertwait(){
  showDialog(barrierDismissible: false,context: contexta, builder: (context) {
   return AlertDialog(backgroundColor: Colors.transparent,content: Container(width: 30,height:30,
       child: Center(child :SizedBox( width: 30,height: 30, child: CircularProgressIndicator()))),
   );});
 }
 // هذه من أجل العروض
 void getmore()async{
  //getdatafromapi
  SharedPreferences sharedPreferences = await SharedPreferences.getInstance();
  var token = sharedPreferences.getString("token");
  alertwait();
  var url = "https://flattery.filtry-eg.com/api/auth/home";
  var response=await http.get(Uri.parse(url),headers: {
   'Content-Type': 'application/json',
   'Accept': 'application/json',
   'Authorization': 'Bearer $token',
  });
  var body = jsonDecode(response.body);
   if( body["data"]["register_offer_on"].toString().trim() =="1"){
    showDialog(context: contexta, builder: (context) {
     return Container(
      child: AlertDialog(backgroundColor: Colors.redAccent,
          content: Container(height: MediaQuery.of(context).size.height * 0.6,width: MediaQuery.of(context).size.width*0.8,
           decoration: BoxDecoration(color: Colors.redAccent),
           child: Column(children: [
            Container(alignment: Alignment.centerRight,child: IconButton(onPressed: (){Navigator.of(context).pop();},icon :Icon(Icons.close,color: Colors.white,size: MediaQuery.of(context).size.height*0.03,),))
            ,Container(alignment: Alignment.center,width: MediaQuery.of(context).size.width*0.4,height:MediaQuery.of(context).size.height*0.2,child: Text(body["data"]["register_offer"].toString().trim(),style: TextStyle(fontSize: MediaQuery.of(context).size.height*0.1,color: Colors.white),),),
            Directionality(textDirection: TextDirection.rtl,child: Container(child: Text("عزيزي المشترك لديك خصم على كامل المنتجات لدينا بقيمة "+body["data"]["register_offer"].toString().trim()+"بالمئة",style: TextStyle(fontSize: MediaQuery.of(context).size.height*0.030,color: Colors.black54),),))
           ],),)
      ),
     );
    });
   }
  showDialog(context: contexta, builder: (context) {
   return Container(
    child: AlertDialog(backgroundColor: Colors.redAccent,
        content: Container(height: MediaQuery.of(context).size.height * 0.6,width: MediaQuery.of(context).size.width*0.8,
         decoration: BoxDecoration(color: Colors.redAccent),
         child: Column(children: [
          Container(alignment: Alignment.centerRight,child: IconButton(onPressed: (){Navigator.of(context).pop();},icon :Icon(Icons.close,color: Colors.white,size: MediaQuery.of(context).size.height*0.03,),))
          ,Container(alignment: Alignment.center,width: MediaQuery.of(context).size.width*0.4,height:MediaQuery.of(context).size.height*0.2,child: Text("0",style: TextStyle(fontSize: MediaQuery.of(context).size.height*0.1,color: Colors.white),),),
          Directionality(textDirection: TextDirection.rtl,child: Container(child: Text(" عزيزي المشترك لا يوجد خصومات متوفرة الان وسيتم اعلامكم بأية حسومات قادمة",style: TextStyle(fontSize: MediaQuery.of(context).size.height*0.030,color: Colors.black54),),))
         ],),)
    ),
   );
  });
 }
 getoffers1() async{
  SharedPreferences sharedPreferences = await SharedPreferences.getInstance();
  var token = sharedPreferences.getString("token");
  var url = "https://filtery-eg.com/api/auth/get-offers";
  var response=await http.get(Uri.parse(url),headers: {
   'Authorization': 'Bearer $token',
  });
  var body = jsonDecode(response.body);
  List data = body["data"];
  return data;
 }
 getoffers(able , count)async{
  if(able.toString()=="1"){
  }
  else {
   showDialog(context: contexta, builder: (context) {
    return Container(
     child: AlertDialog(backgroundColor: Colors.redAccent,
         content: Container(height: MediaQuery
             .of(context)
             .size
             .height * 0.5, width: MediaQuery
             .of(context)
             .size
             .width ,
          decoration: BoxDecoration(color: Colors.redAccent),
          child:  SingleChildScrollView(
            child: Column(children: [
             Container(alignment: Alignment.centerRight,
                     child: IconButton(onPressed: () {
                      Navigator.of(context).pop();
                     }, icon: Icon(Icons.close, color: Colors.white, size: MediaQuery
                         .of(context)
                         .size
                         .height * 0.03,),)),
               Container(height: MediaQuery.of(context).size.height*0.2 ,child: Image(image: AssetImage("comp/50-percent.png"),fit: BoxFit.fill,),),
               Container(height: MediaQuery.of(context).size.height*0.2,
                   child: Directionality(textDirection: TextDirection.rtl,
                     child: Center(
                       child: AutoSizeText("مبروك لقد حصلت على خصم "+"$count%"+"لمدة يومين على جميع منتجات التطبيق",maxLines: 3, style: TextStyle(
                           fontSize: MediaQuery
                               .of(context)
                               .size
                               .width * 0.05, color: Colors.white),),
                     ),
                   )),
              // Directionality(textDirection: TextDirection.rtl,
             //      child: Container(child: FittedBox(child: Text(
              //      data[0]["desc"], style: TextStyle(fontSize: MediaQuery
               //        .of(context)
               //        .size
                //       .height * 0.030, color: Colors.white),),))),
              ],),
          ),
         )
     ),
    );
   });
  }
 }
  // الحصول على جميع البيانات في الصفحة و تعريف سلة المشتريات
  getdata() async{
   SharedPreferences sharedPreferences = await SharedPreferences.getInstance();
   var token = sharedPreferences.getString("token");
   var url = "https://filtery-eg.com/api/auth/home";
   var response=await http.get(Uri.parse(url),headers: {
    'Content-Type': 'application/json',
    'Accept': 'application/json',
    'Authorization': 'Bearer $token',
   });
   var body = jsonDecode(response.body);
   getoffers(body["data"]["register_offer_on"] ,body["data"]["register_offer"] );
   //Navigator.of(contexta).pop('dialog');
   List shoppingbasket =[];
   List data =[];
   var  dataa = body["data"]["products"];
   var contract = body["data"]["contract"];
   var Device = body["data"]["Device"];
   var lastDeviceM = body["data"]["lastDeviceM"];
   if(dataa.toString().trim() != "null") {
    data = dataa;
   }
   if(data.length !=0) {
    if(body["data"]["register_offer_on"].toString() =="1") {
     for (int g = 0; g < data.length; g++) {
      shoppingbasket.add({
       "id": data[g]["id"],
       "num": 0,
       "img": data[g]["images"][0]["path"],
       "price": data[g]["price"],
       "name": data[g]["name"]
      });
     }
     sharedPreferences.setString("basket", shoppingbasket.toString());
     print(shoppingbasket);
    }
    if(body["data"]["register_offer_on"].toString() =="0") {
     for (int g = 0; g < data.length; g++) {
      shoppingbasket.add({
       "id": data[g]["id"],
       "num": 0,
       "img": data[g]["images"][0]["path"],
       "price":int.parse(data[g]["price"].toString())/2,
       "name": data[g]["name"]
      });
     }
     sharedPreferences.setString("basket", shoppingbasket.toString());
     print(shoppingbasket);
    }
   }
   //else{
    //List data1 = sharedPreferences.getString("basket").toString().trim().substring(2,sharedPreferences.getString("basket").toString().trim().length-2).split("}, {");
    //for(int g =0 ; g<data1.length ; g++){
     //List detail = data1[g].toString().trim().split(",");
     //print(detail);
    // var id = int.parse(detail[0].toString().trim().substring(4,detail[0].toString().trim().length));
  //   var num =int.parse(  detail[1].toString().trim().substring(5,detail[1].toString().trim().length));
     //shoppingbasket.add({"id" : id , "num" : num});
    //}
  // }
   return {"contract" : contract,"Device" : Device,"lastDeviceM" : lastDeviceM ,"data" : data , "basket" : shoppingbasket,"lastmin" : body["data"]["lastMin"].toString() , "discount" : body["data"]["register_offer_on"].toString()} ;
 }
 void gettoken(){
 }
 Future<void> show(title ,body)async{
  notificationsPlugin.show(0, title, body,
      await NotificationDetails(
          android:  AndroidNotificationDetails(
              'channel id',
              'channel name',
              'channel description',
              importance: Importance.max
          ),
          iOS: IOSNotificationDetails()
      ));
 }
 search(List data , var query)async{
  var newlist =[];
  for(int r =0; r< data.length ; r++){
   newlist.add(data[r]["name"]);
  }
  newlist = query.isEmpty ? newlist : newlist.where((p) => p.contains(query)).toList();
  List newlistsuggest =[];
  for(int e =0; e<data.length ;e++){
   for(int s =0 ; s<newlist.length ; s++){
    if(data[e]["name"].toString().trim() == newlist[s]){
     newlistsuggest.add(data[e]);
    }
   }
  }
  return newlistsuggest;
 }
}