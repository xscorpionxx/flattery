import 'dart:convert';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:http/http.dart'as http;
import 'package:provider/provider.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:teste/homescreen.dart';
import 'package:teste/logic/mainlogic.dart';
import '../profilescreen.dart';
class Detaillogic {
  var contexta;
  Detaillogic(BuildContext context){
    contexta = context;
  }
  plus(shopingbasket ,i,data)async{
    if(shopingbasket[i]["num"] == 0){
      shopingbasket[i]["img"] = data;
    }
    print(shopingbasket[i]["num"]);
    shopingbasket[i]["num"] = int.parse(shopingbasket[i]["num"].toString() )+ 1 ;
    print(shopingbasket);
    return shopingbasket;
  }
  minus(shobasket ,i,data) async{
    if(shobasket[i]["num"] == 0) {
      return shobasket;
    }
    else{
      shobasket[i]["num"] = int.parse(shobasket[i]["num"].toString() ) - 1 ;
      print(shobasket);
      return shobasket;
    }
  }
  void alertbuy(shopping,tab,price,id,context){
    showDialog(context: contexta, builder: (context) {
      return AlertDialog(title: new Text("تنبيه"),
          content: Directionality(textDirection: TextDirection.rtl,child: new Text("الرجاء الضغط على موافق لتأكيد الشراء ووضع النتج في السلة الخاص بالمشتريات")),
          actions: [
            new ElevatedButton(onPressed:()async{
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
              for(int d = 0 ; d<shoopingh.length ; d++){
                for(int g =0 ; g< shopping.length ;g++) {
                  if (shoopingh[d]["id"] == shopping[g]["id"]) {
                    if(shopping[g]["num"].toString().trim() != 0.toString()){
                      shoopingh[d]["num"] = 1;
                      shoopingh[d]["img"] = shopping[g]["img"];
                    }
                  }
                }
              }
              sharedPreferences.setString("basket", shoopingh.toString());
              for(int g = 0 ; g<shopping.length ; g++){
                shopping[g]["num"] = 0;
              }
              price = 0;
              Navigator.of(context).pop();
              Provider.of<Notifires>(context,listen: false).getindex(tab, "hist", 9, context);
            }, child: Text("موافق")),
            new ElevatedButton(onPressed:(){
              Navigator.of(context).pop();
              tab.animateTo(0);}, child: Text("الغاء")),
          ]);
    });
  }
  void alertbuy2(shopping,price,id ,i,data){
    showDialog(context: contexta, builder: (context) {
      return AlertDialog(title: new Text("تنبيه"),
          content: Directionality(textDirection: TextDirection.rtl,child: new Text("الرجاء الضغط على موافق لتأكيد الشراء ووضع المنتج في السلة الخاص بالمشتريات")),
          actions: [
            new ElevatedButton(onPressed:()async{
              shopping[i]["num"] =1;
              shopping[i]["img"] = data[i]["images"][0]["path"];
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
              for(int d = 0 ; d<shoopingh.length ; d++){
                for(int g =0 ; g< shopping.length ;g++) {
                  if (shoopingh[d]["id"] == shopping[g]["id"]) {
                      if(shopping[g]["num"].toString().trim() != 0.toString()){
                        shoopingh[d]["num"] = shopping[g]["num"];
                        shoopingh[d]["img"] = shopping[g]["img"];
                      }
                  }
                }
              }
              sharedPreferences.setString("basket", shoopingh.toString());
              for(int g = 0 ; g<shopping.length ; g++){
                shopping[g]["num"] = 0.toString();
              }
              price = 0;
              Navigator.of(context).pop();
              showDialog(context: contexta, builder: (context) {
                return AlertDialog(
                    content: Directionality(textDirection: TextDirection.rtl,child: new Text("تمت اضافة المنتج الى سلة المشتريات")),
                    actions: [
                      new ElevatedButton(onPressed:()async{
                       Navigator.of(context).pop("dialog");
                      }, child: Text("تم")),
                    ]);
              });
            }, child: Text("موافق")),
            new ElevatedButton(onPressed:(){Navigator.of(context).pop();}, child: Text("الغاء")),
          ]);
    });
  }
  //compute the price
  computeprice(totalprice,data,shopping ,index){
   return  totalprice = int.parse(data[0]["price"].toString().trim())*int.parse(shopping[index]["num"].toString());
  }
  //الحصول على معلومات المنتج و سلة المشتريات
  alertwait(){
    showDialog(barrierDismissible: false,context: contexta, builder: (context) {
      return AlertDialog(backgroundColor: Colors.transparent,elevation: 0,content: Container(width: 30,height:30,
          child: Center(child :SizedBox( width: 30,height: 30, child: CircularProgressIndicator()))),
      );});
  }
  getdata(id) async {
    SharedPreferences sharedPreferences = await SharedPreferences.getInstance();
    //get list of shoppingbasket
    List shoppingbasket =[];
    alertwait();
    List data1 = sharedPreferences.getString("basket").toString().trim().substring(2,sharedPreferences.getString("basket").toString().trim().length-2).split("}, {");
    for(int g =0 ; g<data1.length ; g++){
      List detail = data1[g].toString().trim().split(",");
      print(detail);
      var id = int.parse(detail[0].toString().trim().substring(4,detail[0].toString().trim().length));
      var num =int.parse(  detail[1].toString().trim().substring(5,detail[1].toString().trim().length));
      shoppingbasket.add({"id" : id , "num" : num});
    }
    //getindex
    int index =0;
      for(int f =0 ; f<shoppingbasket.length ; f++){
        if(shoppingbasket[f]["id"].toString().trim() == id.toString().trim()){
          index = f;
        }
      }
    var token = sharedPreferences.getString("token");
    var url = "https://filtery-eg.com/api/auth/getProduct/" +
        id.toString();
    var response = await http.get(Uri.parse(url),headers: {
      'Content-Type': 'application/json',
      'Accept': 'application/json',
      'Authorization': 'Bearer $token',
    });
    var body = jsonDecode(response.body);
    Navigator.of(contexta).pop("dialog");
    return {"data" : body["data"] , "soppingbasket" : shoppingbasket,"index" : index};
  }
  void navigatetoprofile(){
    Navigator.of(contexta).push(MaterialPageRoute(builder: (context){
      return Profilescreen();
    }));
  }
  //  الحصول على العروض
  void getmore()async{
    //getdatafromapi
    var text = "awdadadadadawd";
    var imageurl = "https://cdn.pixabay.com/photo/2015/04/23/22/00/tree-736885__480.jpg";
    showDialog(context: contexta, builder: (context) {
      return Container(
        child: AlertDialog(backgroundColor: Colors.redAccent,
            content: Container(height: MediaQuery.of(context).size.height * 0.6,width: MediaQuery.of(context).size.width*0.8,
              decoration: BoxDecoration(color: Colors.redAccent),
              child: Column(children: [
                Container(alignment: Alignment.centerRight,child: IconButton(onPressed: (){Navigator.of(context).pop();},icon :Icon(Icons.close,color: Colors.white,size: MediaQuery.of(context).size.height*0.03,),))
                ,       Container(width: MediaQuery.of(context).size.width*0.4,height:MediaQuery.of(context).size.height*0.2,child: Image(fit: BoxFit.fill,image: NetworkImage(imageurl),),),
                Container(child: Text(text,style: TextStyle(fontSize: MediaQuery.of(context).size.height*0.035,color: Colors.white),),)
              ],),)
        ),
      );
    });
  }
 void navigatetohome (){
   Navigator.of(contexta).push(MaterialPageRoute(builder: (context){
     return Mainpage();
   }));
  }
}