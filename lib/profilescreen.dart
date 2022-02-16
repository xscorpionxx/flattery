import 'dart:convert';
import 'package:http/http.dart'as http;
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:teste/logic/profilelogic.dart';

import 'logic/signuplogic.dart';

class Profilescreen extends  StatefulWidget{
  @override
  State<StatefulWidget> createState() {
    // TODO: implement createState
    return Stateprofile();
  }
}
class Stateprofile extends State<Profilescreen>{
  Profilelogic profilelogic;
 // var username ;
 // var email;
  var moha ;
  var mad;
  var dateable = false;
 // var updateable ;
 // var password;
 // var phone;
 // var changepass = false;
 // TextEditingController namec ;
 // TextEditingController emailc ;
//  TextEditingController phonec ;
  TextEditingController passpast ;
  TextEditingController passnew ;
 // TextEditingController mohac ;
 // TextEditingController madc ;
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
  var datetime;
  var type;
  List maintainbackup =[];
  List maintains =[];
  var maintain;
  var done = false ;
  getdata() async{
    var data= await profilelogic.getdatas();
    name.text = data["username"];
    email.text = data["email"];
    phone.text = data["phone"];
    type = data["type"];
    maintain = data["maintain"];
    datetime = data["final_date"];
    address.text = data["address"];
    val1 = data["re1"];
    val2 = data["re2"];
    data1 = data["countries"] ;
    for(int g = 0 ; g< data1.length;g++){
      countries.add(data1[g]["name"]);
    }
    data2 = data["cities"] ;
    for(int g = 0 ; g< data2.length;g++){
      citites.add(data2[g]["name"]);
    }
    typebackup = data["devices"];
    for(int g = 0 ; g<typebackup.length;g++){
      types.add(typebackup[g]["type"].toString());
    }
    types = types.toSet().toList();
    maintainbackup = data["maintains"];
    for(int g = 0 ; g<maintainbackup.length;g++){
      maintains.add(maintainbackup[g]["name"].toString());
    }
   setState(() {});
    //  username = data["username"];
  //  email = data["email"];
  //  phone = data["phone"];
  //  moha = data["moha"];
  //  mad = data["mad"];
  //  password = data["password"];
   // emailc.text = email;
   // namec.text = username;
  //  phonec.text = phone;
  //  mohac.text = moha;
  //  madc.text = mad;
    setState(() {});
  }
  update()async{
  //  var trues = await profilelogic.update(namec.text, emailc.text, phonec.text ,mohac.text,madc.text);
  //  await getdata();
  //  updateable = false;
  }
  var val1 ="اختر المحافظة";
  var val2 ="اختر المنطقة";
  var changepass = false;
  var updateable = false;
  @override
  void initState() {
    key = new GlobalKey<FormState>();
   // updateable = false;
   // namec = new TextEditingController();
   // emailc = new TextEditingController();
   // phonec = new TextEditingController();
   // mohac = new TextEditingController();
  //  madc = new TextEditingController();
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
              Expanded(child: Container(alignment: Alignment.centerRight,child: Text("بروفايل",style:TextStyle(fontSize: MediaQuery.of(context).size.height*0.02,color: Colors.white),),))],),),
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
                },child: ListTile(leading:dateable?InkWell(child: Text("تم",style: TextStyle(color: Colors.blue),),onTap: (){
                  setState(() {
                    dateable = false;
                  });
                },) :Icon(Icons.arrow_drop_down),title: Container(alignment: Alignment.centerRight,child:datetime !=null?Text(datetime): FittedBox(child: Text("اختر اخر ميعاد للصيانة للجهاز"))),trailing: Icon(Icons.date_range,color: Colors.blueAccent,),),),
              ),),
          ),
          Container( child:!dateable?Container():  Container(width: MediaQuery.of(context).size.width,child: CalendarDatePicker(firstDate: DateTime.now(),lastDate:DateTime.now().add(Duration(days: 356))  ,currentDate: DateTime.now(),initialDate:DateTime.now() , onDateChanged: (val){
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
                              //getdata2(data1[countries.indexOf(_)-1]["id"]);
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
         //    Container(margin: EdgeInsets.only(top:MediaQuery.of(context).size.width * 0.06 ,left: MediaQuery.of(context).size.width * 0.25,right:MediaQuery.of(context).size.width * 0.25 ),
        //          height: MediaQuery.of(context).size.height * 0.07,decoration: BoxDecoration(color: Colors.blue,borderRadius: BorderRadius.circular(10)),child:Center(child : InkWell(onTap: null,child: Text("حساب مميز",style: TextStyle(color: Colors.white,fontSize: MediaQuery.of(context).size.height* 0.015)))) ),
        //Container(
          //    child:changepass ?Container(): Container(margin: EdgeInsets.only(top: MediaQuery.of(context).size.height*0.05),height: MediaQuery.of(context).size.height * 0.1,child: Row(children: [Expanded(child:Container(margin: EdgeInsets.only(left: MediaQuery.of(context).size.width*0.05),child:
         //     updateable?Container(margin: EdgeInsets.only(left: MediaQuery.of(context).size.width*0.05),child: TextFormField(textDirection: TextDirection.rtl,),): Container(alignment: Alignment.centerRight,child: Text("",style: TextStyle(color: Colors.blue,fontSize: MediaQuery.of(context).size.height* 0.017),),)) ),
         //       Expanded(child:Container(child: Text(":  اسم الحساب",style: TextStyle(fontSize: MediaQuery.of(context).size.height* 0.017)),alignment: Alignment.centerRight,margin: EdgeInsets.only(right: MediaQuery.of(context).size.width*0.1),) )],),),
         //   ),
        ///    Container(
        //      child:changepass ?Container(): Container(height: MediaQuery.of(context).size.height * 0.1,child: Row(children: [Expanded(child: updateable?Container(margin: EdgeInsets.only(left: MediaQuery.of(context).size.width*0.05),child: TextFormField(decoration: InputDecoration(),textDirection: TextDirection.rtl,),): Container(alignment: Alignment.centerRight,child: Text("$email",style: TextStyle(color: Colors.blue,fontSize: MediaQuery.of(context).size.height* 0.017),),) ),
         //       Expanded(child:Container(child: Text(": بريد الالكتروني",style: TextStyle(fontSize: MediaQuery.of(context).size.height* 0.017)),alignment: Alignment.centerRight,margin: EdgeInsets.only(right: MediaQuery.of(context).size.width*0.1),) )],),),
         //   ),
        //    Container(
        //      child:changepass ?Container(): Container(height: MediaQuery.of(context).size.height * 0.1,child: Row(children: [Expanded(child:updateable?Container(margin: EdgeInsets.only(left: MediaQuery.of(context).size.width*0.05),child: TextFormField(textDirection: TextDirection.rtl,),): Container(alignment: Alignment.centerRight,child: Text("$phone",style: TextStyle(color: Colors.blue,fontSize: MediaQuery.of(context).size.height* 0.017),),) ),
        //        Expanded(child:Container(child: Text(":  رقم الهاتف",style: TextStyle(fontSize: MediaQuery.of(context).size.height* 0.017)),alignment: Alignment.centerRight,margin: EdgeInsets.only(right: MediaQuery.of(context).size.width*0.1),) )],),),
        //    ),
        ////  Container(
         //   child:changepass ?Container(): Container(height: MediaQuery.of(context).size.height * 0.1,child: Row(children: [Expanded(child:updateable?Container(margin: EdgeInsets.only(left: MediaQuery.of(context).size.width*0.05),child: TextFormField(textDirection: TextDirection.rtl,),): Container(alignment: Alignment.centerRight,child: Text("$moha",style: TextStyle(color: Colors.blue,fontSize: MediaQuery.of(context).size.height* 0.017),),) ),
         //     Expanded(child:Container(child: Text(":  المحافظة",style: TextStyle(fontSize: MediaQuery.of(context).size.height* 0.017)),alignment: Alignment.centerRight,margin: EdgeInsets.only(right: MediaQuery.of(context).size.width*0.1),) )],),),
        //  ),
        //  Container(
        //    child:changepass ?Container(): Container(height: MediaQuery.of(context).size.height * 0.1,child: Row(children: [Expanded(child:updateable?Container(margin: EdgeInsets.only(left: MediaQuery.of(context).size.width*0.05),child: TextFormField(textDirection: TextDirection.rtl,),): Container(alignment: Alignment.centerRight,child: Text("$mad",style: TextStyle(color: Colors.blue,fontSize: MediaQuery.of(context).size.height* 0.017),),) ),
        //      Expanded(child:Container(child: Text(":  المدينة",style: TextStyle(fontSize: MediaQuery.of(context).size.height* 0.017)),alignment: Alignment.centerRight,margin: EdgeInsets.only(right: MediaQuery.of(context).size.width*0.1),) )],),),
        //  ),
         // Container(
        //    child:changepass ?Container():
         //   Container(margin: EdgeInsets.only(bottom: MediaQuery.of(context).size.height*0.03,left: MediaQuery.of(context).size.width*0.1,right:MediaQuery.of(context).size.width*0.1 ),child: ElevatedButton(onPressed: (){
         //     changepass = true;
         //     setState(() {});
         //   },child: Text("تعديل كلمة السر",style: TextStyle(fontSize: MediaQuery.of(context).size.height*0.015),),),),
        //  ),
            Container(
              child:Container(width: MediaQuery.of(context).size.width,margin: EdgeInsets.only(left: MediaQuery.of(context).size.width*0.1,right: MediaQuery.of(context).size.width*0.1,bottom: MediaQuery.of(context).size.height*0.03),
                alignment: Alignment.center,child:ElevatedButton(child: Text("تعديل"),onPressed: (){
                 profilelogic.update(key, name.text, email.text, phone.text, val1, val2, data1, data2, type, maintain, typebackup, maintainbackup, address.text, datetime.toString());
                },),),
            ),
        //  Container(
        //    child:changepass ?Container(): Container(width: MediaQuery.of(context).size.width,margin: EdgeInsets.only( bottom: MediaQuery.of(context).size.height*0.1,left: MediaQuery.of(context).size.width*0.1,right: MediaQuery.of(context).size.width*0.1),
        //      alignment: Alignment.center,child:ElevatedButton(onPressed: getdata, child: Icon(Icons.refresh,color: Colors.white,size: MediaQuery.of(context).size.height*0.03,)),),
        //  ),
         // Container(child:!changepass?Container(): Directionality(textDirection: TextDirection.rtl,child: Container(padding: EdgeInsets.all(MediaQuery.of(context).size.width*0.01) ,margin: EdgeInsets.all(MediaQuery.of(context).size.width*0.03),decoration: BoxDecoration(borderRadius: BorderRadius.circular(20),border: Border.all(color: Colors.black54)),child: TextFormField(validator:profilelogic.passpastvalid ,controller: passpast ,decoration: InputDecoration(hintText: "كلمة السر الحالية",border: InputBorder.none),),))),
          //Container(child:!changepass?Container(): Directionality(textDirection: TextDirection.rtl,child: Container(padding: EdgeInsets.all(MediaQuery.of(context).size.width*0.01) ,margin: EdgeInsets.all(MediaQuery.of(context).size.width*0.03),decoration: BoxDecoration(borderRadius: BorderRadius.circular(20),border: Border.all(color: Colors.black54)),child: TextFormField(validator:profilelogic.passnewvalid ,controller: passnew, decoration: InputDecoration(hintText: "كلمة السر الجديدة",border: InputBorder.none),),)))
        //  Container(
           // child:!changepass?Container(): Container(margin: EdgeInsets.only(bottom: MediaQuery.of(context).size.height*0.03,left: MediaQuery.of(context).size.width*0.3,right:MediaQuery.of(context).size.width*0.3 ),child: ElevatedButton(onPressed: (){
              // profilelogic.changethepass(key, password, passpast, passnew);
            //   changepass = false;
           //    setState(() {});
        //    },child: Text("أجراء التغييرات"),),),
        //  )
          ],),
      ),
    ),);
  }
}