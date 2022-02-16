import 'dart:convert';

import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:http/http.dart'as http;
import 'package:teste/logic/signuplogic.dart';
import 'package:teste/loginscreen.dart';

import 'homescreen.dart';
class Signup extends StatefulWidget{
  @override
  State<StatefulWidget> createState() {
    return Secondstates();
  }
}
class Secondstates extends State<Signup>{
  var stringa = "";
  List usernames =[];
  List emails =[];
  List phones =[];
  var dateable = false;
  var datetime;
  TextEditingController address= new TextEditingController();
  TextEditingController finaldate= new TextEditingController();
  TextEditingController name = new TextEditingController();
  TextEditingController email = new TextEditingController();
  TextEditingController password = new TextEditingController();
  TextEditingController repassword = new TextEditingController();
  TextEditingController phone = new TextEditingController();
  Signuplogic signuplogic;
  var nothave = false;
  final GlobalKey<FormState> formKey = GlobalKey<FormState>();
  var Value = false;
  List data1 =[];
  List data2 =[];
  List countries =[];
  List citites =[];
  List typebackup = [];
  List types =[];
  var type;
  List maintainbackup =[];
  List maintains =[];
  var maintain;
  var done = false ;
  getdata1()async{
    var data1a = await signuplogic.getlat();
    data1 = data1a["1"] ;
    countries.add("اختر المحافظة");
    for(int g = 0 ; g< data1.length;g++){
      countries.add(data1[g]["name"]);
    }
    print(countries);
    typebackup = data1a["2"];
    for(int g = 0 ; g<typebackup.length;g++){
      types.add(typebackup[g]["type"].toString());
    }
    types = types.toSet().toList();
    maintainbackup = data1a["3"];
    for(int g = 0 ; g<maintainbackup.length;g++){
      maintains.add(maintainbackup[g]["name"].toString());
    }
    setState(() {});
  }
  getdata2(id)async{
    citites.clear();
    data2 = await signuplogic.getlat2(id.toString());
    print(data2);
    citites.add("اختر المنطقة");
    for(int g = 0 ; g< data2.length;g++){
      citites.add(data2[g]["name"].toString());
    }
    print(citites);
    setState(() {});
  }
  @override
  void initState() {
    signuplogic = new Signuplogic(context);
     getdata1();
    super.initState();
  }
  var val1 ="اختر المحافظة";
  var val2 ="اختر المنطقة";
  @override
  Widget build(BuildContext context) {
    return Scaffold(body:Form(key: formKey,
      child: ListView(children: [
        Stack(
          children:[ Center(child: Container(margin: EdgeInsets.only(top: MediaQuery.of(context).size.height * 0.05),width: MediaQuery.of(context).size.width * 0.4,height: MediaQuery.of(context).size.height*0.25,
            child: Image(image: AssetImage("comp/logo.png"),),),),
          Positioned(top: MediaQuery.of(context).size.height*0.03,left:MediaQuery.of(context).size.width*0.03 ,child: IconButton(onPressed:signuplogic.navigateback,icon: Icon(Icons.arrow_back_ios,size: MediaQuery.of(context).size.height * 0.03,),))],
        )
        ,Container(
          child:done?Container():  Container(padding: EdgeInsets.only(right: 10),margin: EdgeInsets.only(top: MediaQuery.of(context).size.height * 0.05
              ,right:MediaQuery.of(context).size.width * 0.08,left: MediaQuery.of(context).size.width * 0.08 ),
            decoration: BoxDecoration(borderRadius: BorderRadius.circular(20),color: Colors.white)
            ,child: Center(
              child: Directionality(textDirection: TextDirection.rtl,child:
              TextFormField(controller: name,validator: signuplogic.validatename,style: TextStyle(fontSize: MediaQuery.of(context).size.height* 0.018),decoration: InputDecoration(hintText: "اسم الحساب",prefixIcon:Icon(Icons.people,color: Colors.blue,) ,border: InputBorder.none),)),
            ),),
        ),Container(
          child:done?Container(): Container(padding: EdgeInsets.only(right: 10),margin: EdgeInsets.only(top: MediaQuery.of(context).size.height * 0.05
              ,right:MediaQuery.of(context).size.width * 0.08,left: MediaQuery.of(context).size.width * 0.08 ),
            decoration: BoxDecoration(borderRadius: BorderRadius.circular(20),color: Colors.white)
            ,child: Center(
              child: Directionality(textDirection: TextDirection.rtl,child:
              TextFormField(style: TextStyle(fontSize: MediaQuery.of(context).size.height* 0.018,),textDirection: TextDirection.ltr,obscureText: true,validator: signuplogic.validatepassword,controller: password,decoration: InputDecoration(hintText: "كلمة السر",prefixIcon:Icon(Icons.lock,color: Colors.blue,) ,border: InputBorder.none),)),
            ),),
        ),Container(
          child:done?Container(): Container(padding: EdgeInsets.only(right: 10),margin: EdgeInsets.only(top: MediaQuery.of(context).size.height * 0.05
              ,right:MediaQuery.of(context).size.width * 0.08,left: MediaQuery.of(context).size.width * 0.08 ),
            decoration: BoxDecoration(borderRadius: BorderRadius.circular(20),color: Colors.white)
            ,child: Center(
              child: Directionality(textDirection: TextDirection.rtl,child:
              TextFormField(style: TextStyle(fontSize: MediaQuery.of(context).size.height* 0.018),textDirection: TextDirection.ltr,obscureText: true,validator: signuplogic.validatepasswordre,controller: repassword,decoration: InputDecoration(hintText: "تأكيد كلمة السر",prefixIcon:Icon(Icons.lock,color: Colors.blue,) ,border: InputBorder.none),)),
            ),),
        ),Container(
          child:done?Container(): Container(padding: EdgeInsets.only(right: 10),margin: EdgeInsets.only(top: MediaQuery.of(context).size.height * 0.05
              ,right:MediaQuery.of(context).size.width * 0.08,left: MediaQuery.of(context).size.width * 0.08 ),
            decoration: BoxDecoration(borderRadius: BorderRadius.circular(20),color: Colors.white)
            ,child: Center(
              child: Directionality(textDirection: TextDirection.rtl,child:
              TextFormField(style: TextStyle(fontSize: MediaQuery.of(context).size.height* 0.018),textDirection: TextDirection.ltr,controller: email,validator: signuplogic.validateemail,decoration: InputDecoration(hintText: "البريد الالكتروني",prefixIcon:Icon(Icons.mail,color: Colors.blue,) ,border: InputBorder.none),)),
            ),),
        ),
        Container(
          child:done?Container(): Container(padding: EdgeInsets.only(right: 10),margin: EdgeInsets.only(top: MediaQuery.of(context).size.height * 0.05
              ,right:MediaQuery.of(context).size.width * 0.08,left: MediaQuery.of(context).size.width * 0.08 ),
            decoration: BoxDecoration(borderRadius: BorderRadius.circular(20),color: Colors.white)
            ,child: Center(
              child: Directionality(textDirection: TextDirection.rtl,child:
              TextFormField(style: TextStyle(fontSize: MediaQuery.of(context).size.height* 0.018),controller: phone,validator: signuplogic.validateMobile,keyboardType: TextInputType.number,decoration: InputDecoration(hintText: "رقم الهاتف",prefixIcon:Icon(Icons.phone,color: Colors.blue,) ,border: InputBorder.none),)),
            ),),
        ),
        Container(
          child:!done?Container(): Container(padding: EdgeInsets.all(MediaQuery.of(context).size.width*0.01),margin: EdgeInsets.only(top: MediaQuery.of(context).size.height * 0.05
              ,right:MediaQuery.of(context).size.width * 0.08,left: MediaQuery.of(context).size.width * 0.08 ),
            decoration: BoxDecoration(borderRadius: BorderRadius.circular(20),color: Colors.white)
            ,child:Directionality(textDirection: TextDirection.rtl,
              child: Container( width: MediaQuery.of(context).size.width*0.4,alignment: Alignment.centerRight,margin: EdgeInsets.only(right: MediaQuery.of(context).size.width*0.02),
                child: ListTile(
                  title: DropdownButtonHideUnderline(
                      child: DropdownButton(hint: Text("اختر نوع الجهاز"),
                        value: type
                        ,items: types.map((e) => DropdownMenuItem(child: Text('$e'),value: e,)).toList(),
                        onChanged: (_) {
                            type =_;
                            setState(() {});
                        },
                      )),
                ),
              ),
            ),),
        ),
        Container(
          child:!done?Container(): Container(padding: EdgeInsets.all(MediaQuery.of(context).size.width*0.01),margin: EdgeInsets.only(top: MediaQuery.of(context).size.height * 0.05
              ,right:MediaQuery.of(context).size.width * 0.08,left: MediaQuery.of(context).size.width * 0.08 ),
            decoration: BoxDecoration(borderRadius: BorderRadius.circular(20),color: Colors.white)
            ,child:Directionality(textDirection: TextDirection.rtl,
              child: Container( width: MediaQuery.of(context).size.width*0.4,alignment: Alignment.centerRight,margin: EdgeInsets.only(right: MediaQuery.of(context).size.width*0.02),
                child: ListTile(
                  title: DropdownButtonHideUnderline(
                      child: DropdownButton(hint: FittedBox(child: Text("اختر نوع باقة الصيانة المناسبة لك")),
                        value: maintain
                        ,items: maintains.map((e) => DropdownMenuItem(child: Text('$e'),value: e,)).toList(),
                        onChanged: (_) {
                          maintain =_;
                          setState(() {});
                        },
                      )),
                ),
              ),
            ),),
        ),
        Container(
          child:!done?Container(): Container(padding: EdgeInsets.only(right: 10),margin: EdgeInsets.only(top: MediaQuery.of(context).size.height * 0.05
              ,right:MediaQuery.of(context).size.width * 0.08,left: MediaQuery.of(context).size.width * 0.08 ),
            decoration: BoxDecoration(borderRadius: BorderRadius.circular(20),color: Colors.white)
            ,child: Center(
              child: InkWell( onTap: (){
                setState(() {
                  if(!dateable) {
                    dateable = true;
                  }
                  else{
                    dateable = false;
                  }
                });
              },child: ListTile(leading: Icon(Icons.arrow_drop_down),title: Container(alignment: Alignment.centerRight,child:datetime !=null?Text(datetime): Text("اختر اخر ميعاد للصيانة للجهاز")),trailing: Icon(Icons.date_range,color: Colors.blueAccent,),),),
            ),),
        ),
        Container(
          child:!done?Container(): Container( child:!dateable?Container():  Container(width: MediaQuery.of(context).size.width,child: CalendarDatePicker(firstDate: DateTime.now().subtract(Duration(days: 1000)),lastDate:DateTime.now().add(Duration(days: 356))  ,currentDate: DateTime.now(),initialDate:DateTime.now() , onDateChanged: (val){
            setState(() {
              datetime = val.toString().substring(0,10);
            });
          },),)),
        ),
        if (!done) Container() else Container(margin: EdgeInsets.only(top: MediaQuery.of(context).size.height*0.03,left: MediaQuery.of(context).size.width*0.1,right: MediaQuery.of(context).size.width*0.1),alignment: Alignment.center,child:  CheckboxListTile(
          title: FittedBox(
            child: Text("في حال عدم امتلاكك لجهاز يمكنك بدء التسجيل مباشرة",
              style: TextStyle(color: Colors.blue),),
          ),value: nothave,onChanged: (val){setState(() {
          nothave = val;
        });},
        ),),!done?Container(): Container(margin: EdgeInsets.only(top: MediaQuery.of(context).size.height*0.05),alignment: Alignment.center,child: ElevatedButton(child: Text("رجوع",),onPressed: (){
          setState(() {
            done = false;
          });
        },),),
        Container(
          child:done?Container(): Container(padding: EdgeInsets.all(MediaQuery.of(context).size.width*0.01),margin: EdgeInsets.only(top: MediaQuery.of(context).size.height * 0.05
              ,right:MediaQuery.of(context).size.width * 0.08,left: MediaQuery.of(context).size.width * 0.08 ),
            decoration: BoxDecoration(borderRadius: BorderRadius.circular(20),color: Colors.white)
            ,child:Directionality(textDirection: TextDirection.rtl,
              child: Container( width: MediaQuery.of(context).size.width*0.4,alignment: Alignment.centerRight,margin: EdgeInsets.only(right: MediaQuery.of(context).size.width*0.02),
                      child: ListTile(
                        title: DropdownButtonHideUnderline(
                          child: DropdownButton(
                        value: val1
                        ,items: countries.map((e) => DropdownMenuItem(child: Text('$e'),value: e,)).toList(),
                        onChanged: (_) {
                            if(_ !="اختر المحافظة"){
                              getdata2(data1[countries.indexOf(_)-1]["id"]);
                              val1 =_;
                              setState(() {});
                            }
                        },
                )),
                      ),
              ),
            ),),
        ),
        Container(
          child:done?Container(): Container(padding: EdgeInsets.all(MediaQuery.of(context).size.width*0.01),margin: EdgeInsets.only(top: MediaQuery.of(context).size.height * 0.05
              ,right:MediaQuery.of(context).size.width * 0.08,left: MediaQuery.of(context).size.width * 0.08 ),
            decoration: BoxDecoration(borderRadius: BorderRadius.circular(20),color: Colors.white)
            ,child:Directionality(textDirection: TextDirection.rtl,
              child: Container( width: MediaQuery.of(context).size.width*0.4,alignment: Alignment.centerRight,margin: EdgeInsets.only(right: MediaQuery.of(context).size.width*0.02),
                child: ListTile(
                  title: DropdownButtonHideUnderline(
                      child: DropdownButton(
                        value: val2
    ,items: citites.map((e) => DropdownMenuItem(child: Text('$e'),value: e,)).toList(),
                        onChanged: (_) {
                          val2 =_;
                          setState(() {});
                        },
                      )),
                ),
              ),
            ),),
        ),
        Container(
          child:done?Container(): Container(padding: EdgeInsets.only(right: 10),margin: EdgeInsets.only(top: MediaQuery.of(context).size.height * 0.05
              ,right:MediaQuery.of(context).size.width * 0.08,left: MediaQuery.of(context).size.width * 0.08 ),
            decoration: BoxDecoration(borderRadius: BorderRadius.circular(20),color: Colors.white)
            ,child: Center(
              child: Directionality(textDirection: TextDirection.rtl,child:
              TextFormField(style: TextStyle(fontSize: MediaQuery.of(context).size.height* 0.018),controller: address,validator: signuplogic.validate,decoration: InputDecoration(hintText: "العنوان بالتفصيل",prefixIcon:Icon(Icons.home_filled,color: Colors.blue,) ,border: InputBorder.none),)),
            ),),
        )
    ,Container(
      child:true?Container(): Container(alignment: Alignment.centerRight,margin: EdgeInsets.only(top: MediaQuery.of(context).size.height * 0.05
              ,right:MediaQuery.of(context).size.width * 0.08,left: MediaQuery.of(context).size.width * 0.08 ),
            decoration: BoxDecoration(borderRadius: BorderRadius.circular(20),color: Colors.white)
            , child: Directionality(textDirection: TextDirection.rtl,child:
              InkWell(onTap:null,child: ListTile(trailing: Icon(Icons.keyboard_arrow_down_outlined,color: Colors.blue,size: MediaQuery.of(context).size.height*0.05 ,),title: Text("حساب مميز",style: TextStyle(fontSize: MediaQuery.of(context).size.height*0.015),)))),
            ),
    ),
        InkWell(onTap: (){
          if(done){
            if(nothave){
              sign(false);
            }
            else{
              if(datetime !=null){
                if(type ==null || maintain==null){
                  showDialog(context: context, builder: (context) {
                    return AlertDialog(
                        content: Directionality(textDirection: TextDirection.rtl,
                            child: new Text(
                                "يجب أن تختار نوع الجهاز و باقة الصيانة المناسبة")),
                        actions: [
                          new ElevatedButton(onPressed: () {
                            Navigator.of(context).pop();
                          }, child: Text("ok")),
                        ]);
                  });
                }
                else{
                  sign(true);
                }
              }
              else{
                showDialog(context: context, builder: (context) {
                  return AlertDialog(
                      content: Directionality(textDirection: TextDirection.rtl,
                          child: new Text(
                              "يجب أن تختار الوقت بالشكل المناسب")),
                      actions: [
                        new ElevatedButton(onPressed: () {
                          Navigator.of(context).pop();
                        }, child: Text("ok")),
                      ]);
                });
              }
            }
          }
          else {
            if (formKey.currentState.validate()) {
              if (val1 == "اختر المحافظة" || val2 == "اختر المنطقة") {
                showDialog(context: context, builder: (context) {
                  return AlertDialog(
                      content: Directionality(textDirection: TextDirection.rtl,
                          child: new Text(
                              "يجب أن تختار المحافظة والمنطقة بالطريقة المناسبة")),
                      actions: [
                        new ElevatedButton(onPressed: () {
                          Navigator.of(context).pop();
                        }, child: Text("ok")),
                      ]);
                });
              }
              else {
                done = true;
                setState(() {});
              }
            }
          }
        },child: Container(margin: EdgeInsets.only(bottom: MediaQuery.of(context).size.width * 0.1,top:MediaQuery.of(context).size.width * 0.06 ,left: MediaQuery.of(context).size.width * 0.25,right:MediaQuery.of(context).size.width * 0.25 ),height: MediaQuery.of(context).size.height * 0.07,decoration: BoxDecoration(color: Colors.blue,borderRadius: BorderRadius.circular(10)),child:Center(child: Text(!done?"اكمال عميلة التسجيل" :"تسجيل",style: TextStyle(color: Colors.white,fontSize: MediaQuery.of(context).size.height* 0.02))) )),
      ],),
    ) ,);
  }
  doneit(){

  }
  sign(nothave){
    signuplogic.signup(formKey,name.text,email.text,phone.text,password.text,val1,val2,data1,data2, type ,address.text ,maintain , datetime.toString(),nothave);
  }
}