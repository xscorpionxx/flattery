import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_countdown_timer/current_remaining_time.dart';
import 'package:flutter_countdown_timer/flutter_countdown_timer.dart';
import 'package:teste/logic/contactlogic.dart';
import 'package:teste/paymentway2.dart';

import 'logic/shoppinglogic.dart';
class Detailoffers extends StatefulWidget{
  var data;
  Detailoffers({this.data});
  @override
  State<StatefulWidget> createState() {
    // TODO: implement createState
    return StateDetailoffers(data: data);
  }
}
class StateDetailoffers extends State<Detailoffers>{
  var data;
  StateDetailoffers({this.data});
  //Contactlogic contactlogic;
  int endtime;
  TextEditingController madina;
  TextEditingController address;
  TextEditingController phone;
  Shoppinglogic shoppinglogic;
  GlobalKey<FormState> key;
  var able = false;
  @override
  void initState() {
    print(data);
    key = new GlobalKey<FormState>();
    shoppinglogic = new Shoppinglogic(context);
    madina = new TextEditingController();
    address = new TextEditingController();
    phone = new TextEditingController();
    if (data["end_date"].toString() != "null") {
      endtime = DateTime
          .parse(data["end_date"].toString()
      )
          .millisecondsSinceEpoch + 1000 * 30;
    }
    print(endtime);
    //contactlogic = new Contactlogic(context);
    getdata();
    // TODO: implement initState
    super.initState();
  }
  getdata()async{
    //  data = await contactlogic.getus();
    setState(() {});
  }
  @override
  Widget build(BuildContext context) {
    // TODO: implement build
    return Scaffold(body: Form(key: key,
      child: Container(color: Colors.white60,child:data==null? Center(child: CircularProgressIndicator(),): ListView(children: [
        Container(height: MediaQuery.of(context).size.height*0.07,color: Colors.blue,child: Row(children: [
          Expanded(child: InkWell(onTap: (){
            Navigator.of(context).pop();},
            child: Container(alignment: Alignment.centerLeft,margin: EdgeInsets.only(left: MediaQuery.of(context).size.width*0.025),child: Icon( Icons.arrow_back_ios,size:MediaQuery.of(context).size.height * 0.04 ,color: Colors.white,)
            ),
          )),
          Expanded(child: Container(margin: EdgeInsets.only(right: MediaQuery.of(context).size.width*0.03) ,alignment: Alignment.centerRight
            ,child: Text("تفاصيل العرض",style:TextStyle(fontSize: MediaQuery.of(context).size.height*0.02,color: Colors.white),),))],),),
        Container(margin: EdgeInsets.only(top: MediaQuery.of(context).size.height*0.12,left: MediaQuery.of(context).size.width*0.07
            ,right:MediaQuery.of(context).size.width*0.07), child: Directionality(textDirection: TextDirection.rtl,child: Text("الوقت المتبقي للعرض :",style: TextStyle(fontSize: MediaQuery.of(context).size.height*0.025,color: Colors.blue),)),),
        Container(margin: EdgeInsets.only(right: 30),
          child: CountdownTimer(
              endTime: endtime,
              widgetBuilder: (_, CurrentRemainingTime time) {
                if (time == null) {
                  return Directionality(textDirection: TextDirection.rtl,child: Text(' انتهى الوقت المخصص لعرض'));
                }
                if(time.days.toString()=="null"){
                  return Directionality(textDirection: TextDirection.rtl,child: Text(' انتهى الوقت المخصص لعرض'));
                }
                return Directionality(
                  textDirection: TextDirection.rtl,
                  child: Text(
                    '   ${time.days} أيام ',
                    style: TextStyle(fontSize: MediaQuery
                        .of(context)
                        .textScaleFactor * 13),),
                );
              }),
        ),
        Container(margin: EdgeInsets.only(left: MediaQuery.of(context).size.width*0.07
            ,right:MediaQuery.of(context).size.width*0.07), child: Directionality(textDirection: TextDirection.rtl,child: Text("سعر العرض :",style: TextStyle(fontSize: MediaQuery.of(context).size.height*0.025,color: Colors.blue),)),),
        Directionality(textDirection: TextDirection.rtl,child: SingleChildScrollView(
          child: Container(margin: EdgeInsets.only(left: MediaQuery.of(context).size.width*0.07
              ,right:MediaQuery.of(context).size.width*0.07 ),child: Text(data["price"].toString(),style: TextStyle(fontSize: MediaQuery.of(context).size.height*0.025),),),
        )),
        Container(margin: EdgeInsets.only(left: MediaQuery.of(context).size.width*0.07
            ,right:MediaQuery.of(context).size.width*0.07), child: Directionality(textDirection: TextDirection.rtl,child: Text("سعر العرض بعد الخصم :",style: TextStyle(fontSize: MediaQuery.of(context).size.height*0.025,color: Colors.blue),)),),
        Directionality(textDirection: TextDirection.rtl,child: SingleChildScrollView(
          child: Container(margin: EdgeInsets.only(left: MediaQuery.of(context).size.width*0.07
              ,right:MediaQuery.of(context).size.width*0.07 ),child: Text(data["price_discount"].toString(),style: TextStyle(fontSize: MediaQuery.of(context).size.height*0.025),),),
        )),
        Container(margin: EdgeInsets.only(left: MediaQuery.of(context).size.width*0.07
            ,right:MediaQuery.of(context).size.width*0.07), child: Directionality(textDirection: TextDirection.rtl,child: Text("الوصف :",style: TextStyle(fontSize: MediaQuery.of(context).size.height*0.025,color: Colors.blue),)),),
        Directionality(textDirection: TextDirection.rtl,child: SingleChildScrollView(
          child: Container(height: MediaQuery.of(context).size.height*0.2 ,margin: EdgeInsets.only(left: MediaQuery.of(context).size.width*0.07
              ,right:MediaQuery.of(context).size.width*0.07 ),child: Text(data["desc"],style: TextStyle(fontSize: MediaQuery.of(context).size.height*0.025),),),
        )),
        Container(
          child:!able?Container(): Container(margin: EdgeInsets.only(top: MediaQuery
              .of(context)
              .size
              .height * 0.01, bottom: MediaQuery
              .of(context)
              .size
              .height * 0.01, left: MediaQuery
              .of(context)
              .size
              .width * 0.05, right: MediaQuery
              .of(context)
              .size
              .width * 0.05), child: Row(children: [
            Expanded(flex: 2,
                child: Container(child: Container(
                  margin: EdgeInsets.only(right: MediaQuery
                      .of(context)
                      .size
                      .height * 0.01),
                  padding: EdgeInsets.all(MediaQuery
                      .of(context)
                      .size
                      .width * 0.01),
                  child: TextFormField(
                    keyboardType: TextInputType.phone,
                    textDirection: TextDirection.ltr,
                    style: TextStyle(fontSize: MediaQuery
                        .of(context)
                        .size
                        .height * 0.015),
                    controller: phone,
                    validator: shoppinglogic.validphone,
                    decoration: InputDecoration(
                        hintText: "رقم الجوال",
                        border: InputBorder.none),),
                  decoration: BoxDecoration(
                      borderRadius: BorderRadius.circular(20),
                      border: Border.all(color: Colors.black)),))),
            Expanded(child: Container(child: Directionality(
                textDirection: TextDirection.rtl,
                child: Container(padding: EdgeInsets.all(MediaQuery
                    .of(context)
                    .size
                    .width * 0.01),
                  child: TextFormField(
                    style: TextStyle(fontSize: MediaQuery
                        .of(context)
                        .size
                        .height * 0.015),
                    controller: madina,
                    validator: shoppinglogic.valid,
                    decoration: InputDecoration(hintText: "المدينة",
                        border: InputBorder.none),),
                  decoration: BoxDecoration(
                      borderRadius: BorderRadius.circular(20),
                      border: Border.all(color: Colors.black)),)),))
          ],)),
        ),
        Container(
          child:able? Container(margin: EdgeInsets.only(left: MediaQuery
              .of(context)
              .size
              .width * 0.05, right: MediaQuery
              .of(context)
              .size
              .width * 0.05), child: Container(padding: EdgeInsets
              .all(MediaQuery
              .of(context)
              .size
              .width * 0.01),
            child: Directionality(textDirection: TextDirection.rtl,
                child: TextFormField(maxLines: 2,
                  style: TextStyle(fontSize: MediaQuery
                      .of(context)
                      .size
                      .height * 0.015),
                  validator: shoppinglogic.valid,
                  controller: address,
                  textInputAction: TextInputAction.done,
                  decoration: InputDecoration(
                      hintText: "العنوان بالتفصيل",
                      border: InputBorder.none),)),
            decoration: BoxDecoration(
                borderRadius: BorderRadius.circular(20),
                border: Border.all(color: Colors.black)),)):Container(),
        ),
        Container( margin: EdgeInsets.only(top: 10,left: 30,right: 30),child: InkWell( onTap: (){
          setState(() {
            if(!able) {
              able = true;
            }
            else{
              if(key.currentState.validate()){
                var dataa = {"phone" : phone.text , "address" : address.text,"id" : data["id"] ,"price" : data["price_discount"].toString()};
                Navigator.of(context).push(MaterialPageRoute(builder: (context){
                  return Paymentway2(data: dataa,);
                }));
              }
            }
          });
        },child: Container( decoration: BoxDecoration(color: Colors.blue),child: Center(child: Text(able?"اتمام الشراء": "شراء العرض",style: TextStyle(color: Colors.white,fontSize: 13),)),)))
       ,      Container(
         child:!able?Container(): Container( margin: EdgeInsets.only(bottom: 20,top: 10,left: 30,right: 30),child: InkWell( onTap: (){
            setState(() {
              able = false;
            });
          },child: Container( decoration: BoxDecoration(color: Colors.blue),child: Center(child: Text("رجوع",style: TextStyle(color: Colors.white,fontSize: 13),)),))),
       )],),),
    ),);
  }
}