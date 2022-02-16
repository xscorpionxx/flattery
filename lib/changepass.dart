import 'dart:convert';
import 'package:http/http.dart'as http;
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:teste/logic/profilelogic.dart';
import 'logic/signuplogic.dart';

class Changepass extends  StatefulWidget{
  @override
  State<StatefulWidget> createState() {
    // TODO: implement createState
    return Statepass();
  }
}
class Statepass extends State<Changepass>{
  Profilelogic profilelogic;
  var moha ;
  var mad;
  TextEditingController passpast ;
  TextEditingController passnew ;
  GlobalKey<FormState> key ;
  var stringa = "";
  List usernames =[];
  List emails =[];
  List phones =[];
  TextEditingController address= new TextEditingController();
  TextEditingController finaldate= new TextEditingController();
  TextEditingController name = new TextEditingController();
  TextEditingController email = new TextEditingController();
  TextEditingController repassword = new TextEditingController();
  TextEditingController phone = new TextEditingController();
  Signuplogic signuplogic;
  final GlobalKey<FormState> formKey = GlobalKey<FormState>();
  var Value = false;
  List data1 =[];
  List data2 =[];
  List countries =[];
  List citites =[];
  List typebackup = [];
  var password;
  List types =[];
  var type;
  List maintainbackup =[];
  List maintains =[];
  var maintain;
  var done = false ;
  getdata() async{
    SharedPreferences sharedPreferences = await SharedPreferences.getInstance();
    password = sharedPreferences.getString("password");
    setState(() {});
  }
  var val1 ="اختر المحافظة";
  var val2 ="اختر المنطقة";
  var changepass = false;
  var updateable = false;
  @override
  void initState() {
    key = new GlobalKey<FormState>();
    passpast= new TextEditingController();
    passnew = new TextEditingController();
    profilelogic = new Profilelogic(context);
    signuplogic = new Signuplogic(context);
    getdata();
    super.initState();
  }
  @override
  Widget build(BuildContext context) {
    // TODO: implement build
    return Scaffold(body: Form(key: key,
      child: Container(
        child:  ListView(children: [
          Container(height: MediaQuery.of(context).size.height*0.07,color: Colors.blue,child: Row(children: [
            Expanded(child: InkWell( onTap: (){
                Navigator.of(context).pop();
            },child: Container(alignment: Alignment.centerLeft,child: IconButton(icon: Icon(Icons.arrow_back_ios,size:MediaQuery.of(context).size.height * 0.04 ,color: Colors.white,))))),
            Expanded(child: Container(alignment: Alignment.centerRight,child: Text("تعديل كلمة السر",style:TextStyle(fontSize: MediaQuery.of(context).size.height*0.02,color: Colors.white),),))],),),
          Container(margin: EdgeInsets.only(top: MediaQuery.of(context).size.height * 0.05),width: MediaQuery.of(context).size.height * 0.25,height: MediaQuery.of(context).size.height * 0.25,
            child: Image(image: AssetImage("comp/logo.png"),),),
          Container(
            child:Container(padding: EdgeInsets.only(right: 10),margin: EdgeInsets.only(top: MediaQuery.of(context).size.height * 0.05
                ,right:MediaQuery.of(context).size.width * 0.08,left: MediaQuery.of(context).size.width * 0.08 ),
              decoration: BoxDecoration(borderRadius: BorderRadius.circular(20),color: Colors.white)
              ,child: Center(
                child: Directionality(textDirection: TextDirection.rtl,child:
                TextFormField(style: TextStyle(fontSize: MediaQuery.of(context).size.height* 0.018,),textDirection: TextDirection.ltr,obscureText: true,validator: signuplogic.validatepassword,controller: passpast,decoration: InputDecoration(hintText: "كلمة السر الحالية",prefixIcon:Icon(Icons.lock,color: Colors.blue,) ,border: InputBorder.none),)),
              ),),
          ),Container(
            child: Container(padding: EdgeInsets.only(right: 10),margin: EdgeInsets.only(top: MediaQuery.of(context).size.height * 0.05
                ,right:MediaQuery.of(context).size.width * 0.08,left: MediaQuery.of(context).size.width * 0.08 ),
              decoration: BoxDecoration(borderRadius: BorderRadius.circular(20),color: Colors.white)
              ,child: Center(
                child: Directionality(textDirection: TextDirection.rtl,child:
                TextFormField(style: TextStyle(fontSize: MediaQuery.of(context).size.height* 0.018),textDirection: TextDirection.ltr,obscureText: true,validator: signuplogic.validatepassword,controller: passnew,decoration: InputDecoration(hintText: " كلمة السر الجديدة",prefixIcon:Icon(Icons.lock,color: Colors.blue,) ,border: InputBorder.none),)),
              ),),),
          Container(
            child: Container(margin: EdgeInsets.only(bottom: MediaQuery.of(context).size.height*0.03,left: MediaQuery.of(context).size.width*0.3,right:MediaQuery.of(context).size.width*0.3,top: MediaQuery.of(context).size.height*0.05 ),child: ElevatedButton(onPressed: (){
               profilelogic.changethepass(key, password, passpast.text, passnew.text);
            },child: Text("تعديل"),),),
          )
        ],),
      ),
    ),);
  }
}