import 'dart:convert';
import 'package:http/http.dart'as http;
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:teste/logic/profilelogic.dart';
import 'logic/signuplogic.dart';

class Complete extends  StatefulWidget{
  @override
  State<StatefulWidget> createState() {
    // TODO: implement createState
    return Statecomplete();
  }
}
class Statecomplete extends State<Complete>{
  var datetime;
  var dateable = false;
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
  Profilelogic profilelogic;
  TextEditingController pass;
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
  TextEditingController password = new TextEditingController();
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
  List types =[];
  var type;
  List maintainbackup =[];
  List maintains =[];
  var maintain;
  var done = false ;
  getdata() async{
    SharedPreferences sharedPreferences = await SharedPreferences.getInstance();
     name.text = sharedPreferences.getString("name");
     email.text = sharedPreferences.getString("email");
    setState(() {});
  }
  var val1 ="اختر المحافظة";
  var val2 ="اختر المنطقة";
  var changepass = false;
  var updateable = false;
  @override
  void initState() {
    key = new GlobalKey<FormState>();
    pass= new TextEditingController();
    passnew = new TextEditingController();
    profilelogic = new Profilelogic(context);
    signuplogic = new Signuplogic(context);
    getdata();
    getdata1();
    super.initState();
  }
  @override
  Widget build(BuildContext context) {
    // TODO: implement build
    return Scaffold(body: Form(key: key,
      child: Container(
        child:  ListView(children: [
          Container(margin: EdgeInsets.only(top: MediaQuery.of(context).size.height * 0.05),width: MediaQuery.of(context).size.height * 0.25,height: MediaQuery.of(context).size.height * 0.25,
            child: Image(image: AssetImage("comp/logo.png"),),),
          Container(
            child:  Container(padding: EdgeInsets.only(right: 10),margin: EdgeInsets.only(top: MediaQuery.of(context).size.height * 0.05
                ,right:MediaQuery.of(context).size.width * 0.08,left: MediaQuery.of(context).size.width * 0.08 ),
              decoration: BoxDecoration(borderRadius: BorderRadius.circular(20),color: Colors.white)
              ,child: Center(
                child: Directionality(textDirection: TextDirection.rtl,child:
                TextFormField(controller: name,validator: signuplogic.validatename,style: TextStyle(fontSize: MediaQuery.of(context).size.height* 0.018),decoration: InputDecoration(hintText: "اسم الحساب",prefixIcon:Icon(Icons.people,color: Colors.blue,) ,border: InputBorder.none),)),
              ),),
          ),Container(
            child: Container(padding: EdgeInsets.only(right: 10),margin: EdgeInsets.only(top: MediaQuery.of(context).size.height * 0.05
                ,right:MediaQuery.of(context).size.width * 0.08,left: MediaQuery.of(context).size.width * 0.08 ),
              decoration: BoxDecoration(borderRadius: BorderRadius.circular(20),color: Colors.white)
              ,child: Center(
                child: Directionality(textDirection: TextDirection.rtl,child:
                TextFormField(style: TextStyle(fontSize: MediaQuery.of(context).size.height* 0.018),textDirection: TextDirection.ltr,controller: email,validator: signuplogic.validateemail,decoration: InputDecoration(hintText: "البريد الالكتروني",prefixIcon:Icon(Icons.mail,color: Colors.blue,) ,border: InputBorder.none),)),
              ),),
          ),
          Container(
            child: Container(padding: EdgeInsets.only(right: 10),margin: EdgeInsets.only(top: MediaQuery.of(context).size.height * 0.05
                ,right:MediaQuery.of(context).size.width * 0.08,left: MediaQuery.of(context).size.width * 0.08 ),
              decoration: BoxDecoration(borderRadius: BorderRadius.circular(20),color: Colors.white)
              ,child: Center(
                child: Directionality(textDirection: TextDirection.rtl,child:
                TextFormField(style: TextStyle(fontSize: MediaQuery.of(context).size.height* 0.018),controller: phone,validator: signuplogic.validateMobile,keyboardType: TextInputType.number,decoration: InputDecoration(hintText: "رقم الهاتف",prefixIcon:Icon(Icons.phone,color: Colors.blue,) ,border: InputBorder.none),)),
              ),),
          ),
          Container(
            child: Container(padding: EdgeInsets.only(right: 10),margin: EdgeInsets.only(top: MediaQuery.of(context).size.height * 0.05
                ,right:MediaQuery.of(context).size.width * 0.08,left: MediaQuery.of(context).size.width * 0.08 ),
              decoration: BoxDecoration(borderRadius: BorderRadius.circular(20),color: Colors.white)
              ,child: Center(
                child: Directionality(textDirection: TextDirection.rtl,child:
                TextFormField(style: TextStyle(fontSize: MediaQuery.of(context).size.height* 0.018),obscureText: true,controller: pass,validator: signuplogic.validatepassword,decoration: InputDecoration(hintText: "كلمة المرور",prefixIcon:Icon(Icons.lock,color: Colors.blue,) ,border: InputBorder.none),)),
              ),),
          ),
          Container(
            child: Container(padding: EdgeInsets.all(MediaQuery.of(context).size.width*0.01),margin: EdgeInsets.only(top: MediaQuery.of(context).size.height * 0.05
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
                            if(_ !="اختر نوع الجهاز"){
                              type =_;
                              setState(() {});
                            }
                          },
                        )),
                  ),
                ),
              ),),
          ),
          Container(
            child: Container(padding: EdgeInsets.all(MediaQuery.of(context).size.width*0.01),margin: EdgeInsets.only(top: MediaQuery.of(context).size.height * 0.05
                ,right:MediaQuery.of(context).size.width * 0.08,left: MediaQuery.of(context).size.width * 0.08 ),
              decoration: BoxDecoration(borderRadius: BorderRadius.circular(20),color: Colors.white)
              ,child:Directionality(textDirection: TextDirection.rtl,
                child: Container( width: MediaQuery.of(context).size.width*0.4,alignment: Alignment.centerRight,margin: EdgeInsets.only(right: MediaQuery.of(context).size.width*0.02),
                  child: ListTile(
                    title: DropdownButtonHideUnderline(
                        child: DropdownButton(hint: Text("اختر نوع الصيانة المناسبة لك"),
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
            child:Container(padding: EdgeInsets.only(right: 10),margin: EdgeInsets.only(top: MediaQuery.of(context).size.height * 0.05
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
                },child: ListTile(leading: dateable?InkWell(child: Text("تم",style: TextStyle(color: Colors.blue),),onTap: (){
                  setState(() {
                    dateable = false;
                  });
                },) :Icon(Icons.arrow_drop_down),title: Container(alignment: Alignment.centerRight,child:datetime !=null?Text(datetime): Text("اختر اخر ميعاد للصيانة للجهاز")),trailing: Icon(Icons.date_range,color: Colors.blueAccent,),),),
              ),),
          ),
          Container( child:!dateable?Container():  Container(width: MediaQuery.of(context).size.width,child: CalendarDatePicker(firstDate: DateTime.now().subtract(Duration(days: 1000)),lastDate:DateTime.now().add(Duration(days: 356))  ,currentDate: DateTime.now(),initialDate:DateTime.now() , onDateChanged: (val){
            setState(() {
              datetime = val.toString().substring(0,10);
            });
          },),)),
          Container(
            child: Container(padding: EdgeInsets.all(MediaQuery.of(context).size.width*0.01),margin: EdgeInsets.only(top: MediaQuery.of(context).size.height * 0.05
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
            child: Container(padding: EdgeInsets.all(MediaQuery.of(context).size.width*0.01),margin: EdgeInsets.only(top: MediaQuery.of(context).size.height * 0.05
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
            child: Container(padding: EdgeInsets.only(right: 10),margin: EdgeInsets.only(top: MediaQuery.of(context).size.height * 0.05,bottom: MediaQuery.of(context).size.height*0.025
                ,right:MediaQuery.of(context).size.width * 0.08,left: MediaQuery.of(context).size.width * 0.08 ),
              decoration: BoxDecoration(borderRadius: BorderRadius.circular(20),color: Colors.white)
              ,child: Center(
                child: Directionality(textDirection: TextDirection.rtl,child:
                TextFormField(style: TextStyle(fontSize: MediaQuery.of(context).size.height* 0.018),controller: address,validator: signuplogic.validate,decoration: InputDecoration(hintText: "العنوان بالتفصيل",prefixIcon:Icon(Icons.home_filled,color: Colors.blue,) ,border: InputBorder.none),)),
              ),),
          ),
          Container(
            child:Container(width: MediaQuery.of(context).size.width,margin: EdgeInsets.only(left: MediaQuery.of(context).size.width*0.1,right: MediaQuery.of(context).size.width*0.1,bottom: MediaQuery.of(context).size.height*0.03),
              alignment: Alignment.center,child:ElevatedButton(child: Text("اكمال عملية التسجيل"),onPressed: (){
                profilelogic.complete( pass.text,key,name.text, email.text, phone.text, val1, val2, data1, data2, address.text,
                    type, typebackup, maintain, maintainbackup, datetime.toString());
                setState(() {});
              },),),
          ),
        ],),
      ),
    ),);
  }
}