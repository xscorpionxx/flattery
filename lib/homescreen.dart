import 'dart:async';
import 'dart:convert';
import 'package:auto_size_text/auto_size_text.dart';
import 'package:carousel_slider/carousel_slider.dart';
import 'package:firebase_messaging/firebase_messaging.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_countdown_timer/countdown_controller.dart';
import 'package:flutter_countdown_timer/current_remaining_time.dart';
import 'package:flutter_countdown_timer/flutter_countdown_timer.dart';
import 'package:flutter_local_notifications/flutter_local_notifications.dart';
import 'package:http/http.dart' as http;
import 'package:provider/provider.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:smooth_page_indicator/smooth_page_indicator.dart';
import 'package:teste/detailoffer.dart';
import 'package:teste/logic/homescreen.dart';
import 'package:teste/logic/mainlogic.dart';
import 'package:teste/logic/signuplogic.dart';
import 'package:teste/orderdetail.dart';
import 'detailofferbanner.dart';
import 'logic/detaillogic.dart';
import 'logic/maintainence.dart';
import 'logic/maintainhislogic.dart';
import 'logic/menulogic.dart';
import 'logic/myorderslogic.dart';
import 'logic/shoppinglogic.dart';
import 'logic/submaintainlogic.dart';
import 'orderdetail2.dart';
class Mainpage extends StatefulWidget{
  var password ;
  var phone ;
  var email ;
  var username;
  Mainpage({this.password,this.email,this.phone,this.username});
  @override
  State<StatefulWidget> createState() {
    // TODO: implement createState
    return Statemain();
  }
}
class Statemain extends State<Mainpage> with SingleTickerProviderStateMixin {
  List datalatlang1 =[];
  List datalatlang2 =[];
  List countries =[];
  List citites =[];
  var city;
  var country;
  List types = [];
  List typebackup = [];
  var type;
  Signuplogic signuplogic;
  List offersdata = [];
  Maintainhistlogic maintainhistlogic ;
  List contract =[] ;
  var download ;
  Maintainlogic maintainlogic ;
  TextEditingController locationmaintain;
  TextEditingController lastmaintaindate;
  TextEditingController maintaindate;
  TextEditingController descmaintain;
  GlobalKey<FormState> maintainKey =new GlobalKey<FormState>() ;
  SubMaintainlogic subMaintainlogic;
  TextEditingController devicenameinfo;
  TextEditingController phoneinfo;
  TextEditingController addressinfo;
  TextEditingController nameinfo;
  TextEditingController typeinfo;
  GlobalKey<FormState> keyinfo;
  var valueinfo;
  List valuesinfo = [];
  List devicesinfo = [];
  var notav = false;
  var dataofmaintain;
  SubMaintainlogic submaintainlogic ;
  List checkboxessub =[];
  List datasubmaintain =[];
  Myorderlogic myorderlogic ;
  List myorders =[];
  var email;
  var active ;
  List databannerimages = [];
  var username;
  List shoppingbackup =[];
  List shoppingbasket = [];
  HomeScreenlogic homeScreenlogic ;
  List Urls =[];
  List nameofproduct = [];
  List prices = [];
  List data = [];
  List datasearch =[];
  List datarepo = [];
  Shoppinglogic shoppinglogic ;
  List datashopp =[];
  int activee = 0;
  bool able ;
  var discount;
  var lastmin ;
  int lastmindate ;
  var Device;
  var lastDeviceM;
  Detaillogic detaillogic;
  List datas = [];
  List images =[];
  var index;
  var totalprice ;
  var ids ;
  navigatetohome2(){
    datas.clear();
    able = false;
    setState(() {});
    tabController.animateTo(0);
    Future.delayed(Duration(milliseconds: 500) ,(){
      images.clear();
      ids = null;
      setState((){});
      activee = 0;
    });
  }
  Future hide(){
    SystemChrome.setEnabledSystemUIOverlays([SystemUiOverlay.top]);
  }
  getdatahome(){
    Future.delayed(Duration(seconds: 1) ,(){
      if(mounted) {
        Provider.of<Notifires>(context, listen: false).getdatahomescreen(
            context);
      }
    });
  }
  TabController tabController;
  TextEditingController query ;
  TextEditingController madina ;
  TextEditingController phone ;
  TextEditingController address ;
  GlobalKey<FormState> key;
  Menulogic menulogic ;
  var activenow;
  //Info info = new Info();
  @override
  void initState() {
    //hide();
    maintaindate = new TextEditingController();
    lastmaintaindate = new TextEditingController();
    signuplogic = new Signuplogic(context);
    maintainhistlogic = new Maintainhistlogic(context);
    locationmaintain = new TextEditingController();
    descmaintain = new TextEditingController();
    maintainKey = new GlobalKey();
    phoneinfo = new TextEditingController();
    devicenameinfo = new TextEditingController();
    addressinfo = new TextEditingController();
    nameinfo = new TextEditingController();
    typeinfo = new TextEditingController();
    keyinfo = new GlobalKey<FormState>();
    maintainlogic = new Maintainlogic(context);
    submaintainlogic = new SubMaintainlogic(context);
    myorderlogic = new Myorderlogic(context);
    menulogic = new Menulogic(context);
    key = new GlobalKey();
    homeScreenlogic = new HomeScreenlogic(context);
    shoppinglogic = new Shoppinglogic(context);
    madina = new TextEditingController();
    phone = new TextEditingController();
    address = new TextEditingController();
    detaillogic = new Detaillogic(context);
    tabController = new TabController(vsync: this, length:10);
    getdatahome();
    query = new TextEditingController();
    active = 0;
    super.initState();
  }
  @override
  Widget build(BuildContext context) {
    data = Provider.of<Notifires>(context).data;
    shoppingbasket = Provider.of<Notifires>(context).shoppingbasket;
    shoppingbackup = Provider.of<Notifires>(context).shoppingbackup;
    lastmindate = Provider.of<Notifires>(context).lastmindate;
    lastmin = Provider.of<Notifires>(context).lastmin;
    discount = Provider.of<Notifires>(context).discount;
    databannerimages = Provider.of<Notifires>(context).databannerimages;
    offersdata =Provider.of<Notifires>(context).offersdata;
    contract =Provider.of<Notifires>(context).contract;
    download =Provider.of<Notifires>(context).download;
    datashopp = Provider.of<Notifires>(context).datashopp;
    activenow = Provider.of<Notifires>(context).active;
    countries = Provider.of<Notifires>(context).countries;
    datalatlang1 =Provider.of<Notifires>(context).datalatlang1;
    typebackup =Provider.of<Notifires>(context).typebackup;
    types =Provider.of<Notifires>(context).types;
    citites = Provider.of<Notifires>(context).citites;
    datalatlang2 =Provider.of<Notifires>(context).datalatlang2;
    devicesinfo =Provider.of<Notifires>(context).devicesinfo;
    valuesinfo =Provider.of<Notifires>(context).valuesinfo;
    valueinfo =Provider.of<Notifires>(context).valueinfo;
    datasubmaintain = Provider.of<Notifires>(context).datasubmaintain;
    checkboxessub =Provider.of<Notifires>(context).checkboxessub;
    able =Provider.of<Notifires>(context).able ;
    images = Provider.of<Notifires>(context).images;
    datas =Provider.of<Notifires>(context).datas;
    ids =Provider.of<Notifires>(context).ids ;
    index =Provider.of<Notifires>(context).index ;
    lastDeviceM =Provider.of<Notifires>(context).lastDeviceM ;
    Device=Provider.of<Notifires>(context).Device ;
    myorders = Provider.of<Notifires>(context).myorders ;
    // TODO: implement build
   return Scaffold(body:
   SingleChildScrollView(
     child: Column(
       children:[
      Container(width: MediaQuery.of(context).size.width,height: MediaQuery.of(context).size.height*0.93 ,child: TabBarView(physics: NeverScrollableScrollPhysics() ,controller: tabController,children:[
        Homescreen1(),
        detailwidget(),
        shopping(),
        offers(),
        Menu(),
        myorderswidget(myorders, context, myorderlogic,tabController),
        submaintainwidget(),
        infosub(keyinfo, notav, valueinfo, valuesinfo, shoppinglogic, subMaintainlogic, devicenameinfo, typeinfo,
            devicesinfo),
        maintain(),
        hist()
    ]))
    ,Container(
      child:activenow=="detail"?Container() :Container(color: tabController.index ==4?Colors.black12:Colors.transparent,
        child: Container(width: MediaQuery.of(context).size.width//,margin: EdgeInsets.only(top:tabController.index == 2? MediaQuery.of(context).size.height *0.01 : MediaQuery.of(context).size.height*0.01)
          ,height: MediaQuery.of(context).size.height*0.07,decoration: BoxDecoration(borderRadius: BorderRadius.only(topRight: Radius.circular(30),topLeft: Radius.circular(30)),color: Colors.black87),child: Row(children: [
               Expanded(child:InkWell(onTap: (){
                 if(!download) {
                   Provider.of<Notifires>(context, listen: false).getindex(
                       tabController, "home", 0, context);
                 }},child: Container(width: MediaQuery.of(context).size.height*0.015,height: MediaQuery.of(context).size.height*0.035,child : Image( image: AssetImage("comp/Group4.png"),)))),
               Container(margin: EdgeInsets.only(top: 10,bottom: 10),child: VerticalDivider(color: Colors.white,thickness: 2,))
               ,Expanded(child:InkWell(onTap: (){
                 if(!download) {
                   Provider.of<Notifires>(context, listen: false).getindex(
                       tabController, "offers", 3, context);
                 }},child: Container(width: MediaQuery.of(context).size.height*0.035,height: MediaQuery.of(context).size.height*0.035,child : Image(image: AssetImage("comp/Group2.png"),)))),
               Container(margin: EdgeInsets.only(top: 10,bottom: 10),child: VerticalDivider(color: Colors.white,thickness: 2,))
               ,Expanded(child:InkWell(onTap:(){
                 if(!download) {
                   Provider.of<Notifires>(context, listen: false).getindex(
                       tabController, "shopping", 2, context);
                   Provider.of<Notifires>(context, listen: false).getdatashopp(
                       context);
                 }},child: Container(width: MediaQuery.of(context).size.height*0.035,height: MediaQuery.of(context).size.height*0.035,child : Image(image: AssetImage("comp/Group5.png"),)))),
               Container(margin: EdgeInsets.only(top: 10,bottom: 10),child: VerticalDivider(color: Colors.white,thickness: 2,))
               ,Expanded(child:InkWell(onTap: (){
                 if(!download){
                 homeScreenlogic.navigatetoprofile();}
            },child: Container(width: MediaQuery.of(context).size.height*0.035,height: MediaQuery.of(context).size.height*0.035,child : Image(image: AssetImage("comp/Group3.png"),))))
             ],),),
      ),
    )
       ],
     ),
   ),);
  }
   // صفحة الرئيسية
  Widget Homescreen1() {
    if(activenow =="home"){
    return Container(height: MediaQuery
        .of(context)
        .size
        .height * 0.5, child: Column(children: [
      Container(
        child: Container(padding: EdgeInsets.only(right: MediaQuery
            .of(context)
            .size
            .height * 0.01, left: MediaQuery
            .of(context)
            .size
            .height * 0.02),
            margin: EdgeInsets.only(top: MediaQuery
                .of(context)
                .size
                .height * 0.02),
            height: MediaQuery
                .of(context)
                .size
                .height * 0.12,
            width: MediaQuery
                .of(context)
                .size
                .width
            ,
            child: Row(children: [
              Expanded(child: Container(margin: EdgeInsets.only(top: MediaQuery
                  .of(context)
                  .size
                  .height * 0.03),
                height: MediaQuery
                    .of(context)
                    .size
                    .width * 0.4,
                width: MediaQuery
                    .of(context)
                    .size
                    .width * 0.5,
                child: Image(image: AssetImage("comp/logo.png"),),)),
              Expanded(flex: 6,
                  child: Container(margin: EdgeInsets.only(top: MediaQuery
                      .of(context)
                      .size
                      .height * 0.03, left: MediaQuery
                      .of(context)
                      .size
                      .width * 0.2, right: MediaQuery
                      .of(context)
                      .size
                      .width * 0.2,),
                      child: FittedBox(child: Text("  ", style: TextStyle(
                          color: Colors.blue),)))),
              Expanded(child: Container(margin: EdgeInsets.only(top: MediaQuery
                  .of(context)
                  .size
                  .height * 0.03),
                child: IconButton(icon: IconButton(icon: Icon(Icons.menu,
                  color: Colors.blue, size: 30,), onPressed: () {
                  if(!download) {
                    Provider.of<Notifires>(context, listen: false).getindex(
                        tabController, "menu", 4, context);
                  }}),),))
            ],)),
      ),
      Container(width: MediaQuery
          .of(context)
          .size
          .width, height: MediaQuery
          .of(context)
          .size
          .height * 0.17, child: databannerimages.length == 0 ? Container() :
      CarouselSlider.builder(options: CarouselOptions(height: MediaQuery
          .of(context)
          .size
          .height * 0.43, viewportFraction: 1, autoPlay: false),
        itemBuilder: (context, index, real) {
          print(databannerimages);
          int endtime;
          if (databannerimages[index]["end_time"].toString() != "null") {
            endtime = DateTime
                .parse(databannerimages[index]["end_time"].toString()
            )
                .millisecondsSinceEpoch + 1000 * 30;
          }
          return Container(decoration: BoxDecoration(
              border: Border.all(color: Colors.white)), width: MediaQuery
              .of(context)
              .size
              .width, height: MediaQuery
              .of(context)
              .size
              .height, child:
          Directionality(textDirection: TextDirection.rtl,
            child: Container(alignment: Alignment.center,
              padding: EdgeInsets.all(MediaQuery
                  .of(context)
                  .size
                  .width * 0.01),
              margin: EdgeInsets.only(right: MediaQuery
                  .of(context)
                  .size
                  .width * 0.01, left: MediaQuery
                  .of(context)
                  .size
                  .width * 0.01),
              child: Column(
                children: [Container(
                  child: Row(
                      children: [Expanded(flex: 4, child: Container(child:
                      // Column(children: [
                      Container(alignment: Alignment.center,
                          child: Directionality(
                              textDirection: TextDirection.rtl,
                              child: Text(databannerimages[index]["name"],
                                style: TextStyle(fontStyle: FontStyle.italic,
                                    fontSize: MediaQuery
                                        .of(context)
                                        .textScaleFactor * 15,
                                    color: Colors.white),))),
                        //Container(child: Directionality(textDirection: TextDirection.rtl,child: Text(databannerimages[index]["desc"],style: TextStyle(fontStyle: FontStyle.italic,fontSize: MediaQuery.of(context).textScaleFactor*15,color: Colors.black54),))),
                      ),), Expanded(child: Container(height: MediaQuery
                          .of(context)
                          .size
                          .height * 0.05,
                        child: VerticalDivider(color: Colors.white,),)),
                        Expanded(flex: 4,
                            child: Container(
                                alignment: Alignment.centerLeft, child:
                            Container(
                              padding: EdgeInsets.only(bottom: MediaQuery
                                  .of(context)
                                  .size
                                  .height * 0.01, top: MediaQuery
                                  .of(context)
                                  .size
                                  .height * 0.01, left: MediaQuery
                                  .of(context)
                                  .size
                                  .width * 0.01, right: MediaQuery
                                  .of(context)
                                  .size
                                  .width * 0.02),
                              child: Container(color: Colors.white,
                                child: TextButton(
                                  child: Text("المزيد"), onPressed: () {
                                  Navigator.of(context).push(
                                      MaterialPageRoute(builder: (context) {
                                        return Detailoffer(
                                            data: databannerimages[index]);
                                      }));
                                },),
                              ),)
                            ))
                      ]),
                ), Spacer(), Container(child: Row(children: [
                  Expanded(child: Container(alignment: Alignment.centerLeft,
                      child: Directionality(textDirection: TextDirection.rtl,
                          child: Text("الوقت المتبقي :", style: TextStyle(
                              fontStyle: FontStyle.italic, fontSize: MediaQuery
                              .of(context)
                              .textScaleFactor * 15, color: Colors.white),)))),
                  Expanded(child: Directionality(
                      textDirection: TextDirection.ltr,
                      child: Container(alignment: Alignment.centerRight,
                        margin: EdgeInsets.only(left: MediaQuery
                            .of(context)
                            .size
                            .width * 0.05, right: MediaQuery
                            .of(context)
                            .size
                            .width * 0.05),
                        child: CountdownTimer(endTime: endtime,
                            widgetBuilder: (_, CurrentRemainingTime time) {
                              if (time == null) {
                                return FittedBox(child: Directionality(textDirection: TextDirection.rtl,child:  Text(' انتهى الوقت المخصص لعرض')));
                              }
                              if(time.days.toString()=="null"){
                                return FittedBox(child: Directionality(textDirection: TextDirection.rtl,child: Text(' انتهى الوقت المخصص لعرض')));
                              }
                              return Directionality(
                                textDirection: TextDirection.rtl,
                                child: FittedBox(child: Text(
                                  '   ${time.days} أيام ',
                                  style: TextStyle(fontSize: MediaQuery
                                      .of(context)
                                      .textScaleFactor * 13),)),
                              );
                            }),)))
                ],),
                )
                ],
              ),
              color: Colors.lightBlueAccent,),
          )
          );
        }, itemCount: databannerimages.length,)
      ),
      Container(child: lastmin.toString() == "0" || lastmin == null ||lastmin.toString()== "لا توجد صيانة"
          ? Container()
          : Container(height: MediaQuery
          .of(context)
          .size
          .height * 0.03,
        child: Row(children: [
          Expanded(child: Container(child: CountdownTimer(endTime: lastmindate,
              widgetBuilder: (_, CurrentRemainingTime time) {
                if (time == null) {
                  return FittedBox(child: Directionality(textDirection: TextDirection.rtl,child: Text(' انتهى الوقت المخصص للصيانة')));
                }
                if(time.days.toString()=="null"){
                  return FittedBox(child: Directionality(textDirection: TextDirection.rtl,child: Text(' انتهى الوقت المخصص لعرض')));
                }
                return Directionality(
                  textDirection: TextDirection.rtl,
                  child: FittedBox(child: Text(
                    '   ${time.days} أيام ',
                    style: TextStyle(fontSize: MediaQuery
                        .of(context)
                        .textScaleFactor * 13),)),
                );
              }),)),
          Expanded(child: Container(child: FittedBox(child: Directionality(
              textDirection: TextDirection.rtl, child: Text(
            "الوقت المتبقي للصيانة التالية :",
            style: TextStyle(color: Colors.blue),))),))
        ],),)),
      Container(child: Device == null
          ? Container()
          : Container(height: MediaQuery
          .of(context)
          .size
          .height * 0.03,
        child: Row(children: [
          Expanded(child: Container(alignment: Alignment.center,child: FittedBox(child: Text(Device.toString(),style: TextStyle(fontSize: 12),)),)),
          Expanded(child: Container(child: FittedBox(child: Directionality(
              textDirection: TextDirection.rtl, child: Text(
            "نوع الجهاز الخاص بك :",
            style: TextStyle(color: Colors.blue,fontSize: 12),))),))
        ],),)),
      Container(child: lastDeviceM == null
          ? Container()
          : Container(height: MediaQuery
          .of(context)
          .size
          .height * 0.03,
        child: Row(children: [
          Expanded(child: Container(margin: EdgeInsets.only(right: 10),alignment: Alignment.center,child: FittedBox(child: AutoSizeText(lastDeviceM.toString(),maxLines: 1,style: TextStyle(fontSize: 12),)),)),
          Expanded(child: Container(child: FittedBox(child: Directionality(
              textDirection: TextDirection.rtl, child: Text(
            "تاريخ أخر صيانة للجهاز :",
            style: TextStyle(color: Colors.blue,fontSize: 12),))),))
        ],),)),
      Container(height: MediaQuery
          .of(context)
          .size
          .height * 0.05,
        margin: EdgeInsets.only(top: MediaQuery
            .of(context)
            .size
            .height * 0.01, bottom: MediaQuery
            .of(context)
            .size
            .height * 0.01),
        child: Row(children: [
          Expanded(child: Container()),
          Expanded(flex: 2, child: Container(width: 200,
              height: MediaQuery
                  .of(context)
                  .size
                  .height * 0.07,
              decoration: BoxDecoration(
                  color: Colors.blue, borderRadius: BorderRadius.circular(10)),
              child: Center(child: InkWell(onTap: () {
                if(!download) {
                  Provider.of<Notifires>(context, listen: false).getindex(
                      tabController, "maintain", 8, context);
                  Provider.of<Notifires>(context, listen: false).getlat1(
                      context);
                } }, child: Text("صيانة فورية", style: TextStyle(color: Colors
                  .white, fontSize: MediaQuery
                  .of(context)
                  .size
                  .height * 0.015)))))),
          Expanded(child: Container()),
          Expanded(flex: 2, child: Container(height: MediaQuery
              .of(context)
              .size
              .height * 0.07,
              decoration: BoxDecoration(
                  color: Colors.blue, borderRadius: BorderRadius.circular(10)),
              child: Center(child: InkWell(onTap: () {
                if(!download) {
                  Provider.of<Notifires>(context, listen: false).getindex(
                      tabController, "infosub", 7, context);
                  Provider.of<Notifires>(context, listen: false).getdatainfo(
                      context);
                }}, child: Text("صيانة دورية", style: TextStyle(color: Colors
                  .white, fontSize: MediaQuery
                  .of(context)
                  .size
                  .height * 0.015)))))),
          Expanded(child: Container())
        ],),)
      ,
      Container(
          child: download == true ? Container(
            child: Container(margin: EdgeInsets.only(top: MediaQuery
                .of(context)
                .size
                .height * 0.25),
                child: Center(child: SizedBox(width: 30,
                    height: 30,
                    child: CircularProgressIndicator()))),) : Container(
              child: contract.length == 0 ? Container(width: MediaQuery
                  .of(context)
                  .size
                  .width, margin: EdgeInsets.only(top: MediaQuery
                  .of(context)
                  .size
                  .height * 0.2), child: Center(
                child: Directionality(textDirection: TextDirection.rtl, child:
                Text("لا توجد عقود صيانة حاليا متوفرة لديك",
                  style: TextStyle(color: Colors.black54, fontSize: MediaQuery
                      .of(context)
                      .size
                      .height * 0.02),)),
              ),) : Container(height: MediaQuery
                  .of(context)
                  .size
                  .height * 0.45,
                child: ListView.builder(
                    itemCount: contract.length, itemBuilder: (context, i) {
                  int endtime;
                  DateTime date = DateTime.parse(contract[i]["contract_start"]);
                  if (DateTime.now().isAfter(date)) {
                    return Container();
                  }
                  else {
                    endtime = DateTime
                        .parse(contract[i]["contract_start"].toString()
                    )
                        .millisecondsSinceEpoch + 1000 * 30;
                    print(endtime);
                    return Container(margin: EdgeInsets.only(top: MediaQuery
                        .of(context)
                        .size
                        .height * 0),
                      height: MediaQuery
                          .of(context)
                          .size
                          .height * 0.15,
                      child: Column(children: [
                        Container(
                            child: Container(child: Container(width: MediaQuery
                                .of(
                                context)
                                .size
                                .width,
                                margin: EdgeInsets.only(right: MediaQuery
                                    .of(context)
                                    .size
                                    .width * 0.01, left: MediaQuery
                                    .of(context)
                                    .size
                                    .width * 0.01),
                                child:
                                Container(child: Container(width: MediaQuery
                                    .of(context)
                                    .size
                                    .width,
                                  margin: EdgeInsets.only(right: MediaQuery
                                      .of(context)
                                      .size
                                      .width * 0.05, top: MediaQuery
                                      .of(context)
                                      .size
                                      .height * 0.00, left: MediaQuery
                                      .of(context)
                                      .size
                                      .width * 0.05),
                                  child: Directionality(
                                      textDirection: TextDirection.rtl, child:
                                  Container(
                                    margin: EdgeInsets.only(left: MediaQuery
                                        .of(context)
                                        .size
                                        .width * 0.02),
                                    child: Row(children:
                                    [
                                      Expanded(flex: 2,
                                          child: Directionality(
                                              textDirection: TextDirection
                                                  .rtl,
                                              child: Container(
                                                margin: EdgeInsets.only(
                                                    left: MediaQuery
                                                        .of(context)
                                                        .size
                                                        .width * 0.04),
                                                child: AutoSizeText(
                                                      "الوقت المتبقي لبدء موعد الصيانة :",maxLines: 1,
                                                      style: TextStyle(
                                                          fontSize: 13)),
                                                ),
                                              )),
                                      Expanded(
                                          child: CountdownTimer(
                                              endTime: endtime,
                                              widgetBuilder: (_,
                                                  CurrentRemainingTime time) {
                                                if (time == null) {
                                                  return Directionality(textDirection: TextDirection.rtl,child: AutoSizeText(' انتهى الوقت',maxLines: 1,style: TextStyle(fontSize:12 ),));
                                                }
                                                if(time.days.toString()=="null"){
                                                  return Directionality(textDirection: TextDirection.rtl,child: AutoSizeText(' انتهى الوقت',maxLines: 1,style: TextStyle(fontSize:12 ),));
                                                }
                                                return Directionality(
                                                  textDirection: TextDirection
                                                      .rtl, child: Text(
                                                  '   ${time.days} أيام ',
                                                  style: TextStyle(
                                                      color: Colors.blue,
                                                      fontSize: MediaQuery
                                                          .of(context)
                                                          .textScaleFactor *
                                                          13),),
                                                );
                                              })),
                                      //Expanded(child: Directionality(textDirection: TextDirection.rtl,child: Text("تاريخ الانتهاء",style: TextStyle(fontSize: MediaQuery.of(context).size.height*0.015)))),
                                      //Expanded(child: Text(""//contract[i]["contract_end"]
                                      //  ,style: TextStyle(color: Colors.blueAccent,fontSize: MediaQuery.of(context).size.height*0.015)))
                                    ]),
                                  )),))))),
                        //Container(child: contract == null? Container():Container(width: MediaQuery.of(context).size.width,margin: EdgeInsets.all(MediaQuery.of(context).size.width*0.05),
                        //child: Directionality(textDirection: TextDirection.rtl,child: Text("فترات الصيانة المتاحة",style: TextStyle(color: Colors.blueAccent,fontSize: MediaQuery.of(context).size.height*0.025),)),))
                        Container(margin: EdgeInsets.only(right: MediaQuery
                            .of(context)
                            .size
                            .width * 0.05), width: MediaQuery
                            .of(context)
                            .size
                            .width, alignment: Alignment.centerRight, child:
                        Row(children: [
                          Expanded(child: Container(
                              alignment: Alignment.centerRight,
                              child: Text(contract[i]["type"], style: TextStyle(
                                  color: Colors.blueAccent, fontSize: MediaQuery
                                  .of(context)
                                  .size
                                  .height * 0.015),)))
                          ,
                          Expanded(child: Container(
                              alignment: Alignment.centerRight,
                              child: Text(": نوع الصيانة ",
                                  style: TextStyle(fontSize: MediaQuery
                                      .of(context)
                                      .size
                                      .height * 0.015)))),
                        ]),
                        ),
                        Container(margin: EdgeInsets.only(right: MediaQuery
                            .of(context)
                            .size
                            .width * 0.07),
                          child: contract == null ? Container() : Row(
                              children: [
                                Expanded(child: Container(
                                    alignment: Alignment.centerRight,
                                    child: Directionality(
                                        textDirection: TextDirection.rtl,
                                        child: contract[i]["desc"] == null
                                            ? Text("لا يوجد وصف",
                                            style: TextStyle(
                                                color: Colors.blueAccent,
                                                fontSize: MediaQuery
                                                    .of(context)
                                                    .size
                                                    .height * 0.02))
                                            : Text(
                                          contract[i]["desc"].toString() + " ",
                                          style: TextStyle(
                                              color: Colors.blueAccent,
                                              fontSize: MediaQuery
                                                  .of(context)
                                                  .size
                                                  .height * 0.015),))))
                                ,
                                Expanded(child: Container(
                                    alignment: Alignment.centerRight,
                                    child: Text(": الوصف ",
                                        style: TextStyle(fontSize: MediaQuery
                                            .of(context)
                                            .size
                                            .height * 0.015)))),
                              ]),)
                        ,
                        Container(child: Divider(),)
                      ],),
                    );
                  }
                }),
              )))
    ],),);
  }
    else{
      return Container();
    }
}//// صفحة التفاصيل
  Widget myorderswidget(data,context,myorderlogic,tab){
    if(activenow =="myorders") {
      return Directionality(textDirection: TextDirection.rtl,
          child: Scaffold(body:
          ListView(
            children: [Directionality(textDirection: TextDirection.ltr,
              child: Container(height: MediaQuery
                  .of(context)
                  .size
                  .height * 0.07, color: Colors.blue, child: Row(children: [
                Expanded(child: InkWell(onTap: () {
                  tab.animateTo(4);
                }, child: Container(alignment: Alignment.centerLeft,
                    child: IconButton(
                        icon: Icon(Icons.arrow_back_ios, size: MediaQuery
                            .of(context)
                            .size
                            .height * 0.04, color: Colors.white,))))),
                Expanded(
                    child: Container(margin: EdgeInsets.only(right: MediaQuery
                        .of(context)
                        .size
                        .width * 0.05),
                      alignment: Alignment.centerRight,
                      child: Text("طلباتي", style: TextStyle(
                          fontSize: MediaQuery
                              .of(context)
                              .size
                              .height * 0.025, color: Colors.white),),))
              ],),),
            ), Container(height: MediaQuery
                .of(context)
                .size
                .height * 0.8,
                child: data.length == 0
                    ? Container(
                  child: Center(child: Text("لا توجد أية طلب مسبق"),),)
                    : Container(
                  margin: EdgeInsets.only(top: MediaQuery
                      .of(context)
                      .size
                      .height * 0.05),
                  child: ListView.builder(
                      itemCount: data.length, itemBuilder: (context, i) {
                    return Container(margin: EdgeInsets.only(top: MediaQuery
                        .of(context)
                        .size
                        .height * 0.01, bottom: MediaQuery
                        .of(context)
                        .size
                        .height * 0.01), color: Colors.white,
                      child: Column(
                        children: [
                          Row(children: [
                            Expanded(flex: 3,
                              child: Container(
                                padding: EdgeInsets.all(MediaQuery
                                    .of(context)
                                    .size
                                    .width * 0.01),
                                child: Column(
                                    children: [Container(child: Row(children: [
                                      Container(margin: EdgeInsets.only(
                                          right: MediaQuery
                                              .of(context)
                                              .size
                                              .width * 0.01),
                                        child: Text("رقم الطلب :",
                                          style: TextStyle(fontSize: MediaQuery
                                              .of(context)
                                              .size
                                              .height * 0.015,
                                              color: Colors.blue),),),
                                      Container(
                                          alignment: Alignment.centerRight,
                                          child: Text(data[i]["code"],
                                            style: TextStyle(
                                                fontSize: MediaQuery
                                                    .of(context)
                                                    .size
                                                    .height * 0.015),))
                                    ])),
                                      Container(alignment: Alignment.centerLeft,
                                          child: Row(children: [
                                            Container(margin: EdgeInsets.only(
                                                right: MediaQuery
                                                    .of(context)
                                                    .size
                                                    .width * 0.01),
                                              child: Text("نوع الخدمة :",
                                                style: TextStyle(
                                                    fontSize: MediaQuery
                                                        .of(context)
                                                        .size
                                                        .height * 0.015,
                                                    color: Colors.blue),),),
                                            Container(
                                                alignment: Alignment.centerLeft,
                                                child: Directionality(
                                                    textDirection: TextDirection
                                                        .ltr,
                                                    child: Text(data[i]["type"],
                                                      style: TextStyle(
                                                          fontSize: MediaQuery
                                                              .of(context)
                                                              .size
                                                              .height *
                                                              0.015),)))
                                          ])), Container(
                                        child: data[i]["price"] == null
                                            ? Container()
                                            : Container(
                                            alignment: Alignment.centerLeft,
                                            child: Row(children: [
                                              Container(margin: EdgeInsets.only(
                                                  right: MediaQuery
                                                      .of(context)
                                                      .size
                                                      .width * 0.01),
                                                child: Text("قيمة الطلب :",
                                                  style: TextStyle(
                                                      fontSize: MediaQuery
                                                          .of(context)
                                                          .size
                                                          .height * 0.015,
                                                      color: Colors.blue),),),
                                              Container(alignment: Alignment
                                                  .centerLeft,
                                                  child: Directionality(
                                                      textDirection: TextDirection
                                                          .ltr,
                                                      child: Text(
                                                        data[i]["price"],
                                                        style: TextStyle(
                                                            fontSize: MediaQuery
                                                                .of(context)
                                                                .size
                                                                .height *
                                                                0.015),)))
                                            ])),
                                      )
                                    ]),),),
                            Expanded(flex: 3,
                                child: Container(
                                    padding: EdgeInsets.all(MediaQuery
                                        .of(context)
                                        .size
                                        .width * 0.01),
                                    margin: EdgeInsets.all(MediaQuery
                                        .of(context)
                                        .size
                                        .width * 0.01),
                                    child: Column(children: [
                                      Container(child: Row(children: [
                                        Container(margin: EdgeInsets.only(
                                            right: MediaQuery
                                                .of(context)
                                                .size
                                                .width * 0),
                                          child: Directionality(
                                              textDirection: TextDirection.rtl,
                                              child: Text("تاريخ الطلب :",
                                                style: TextStyle(
                                                    color: Colors.blue,
                                                    fontSize: MediaQuery
                                                        .of(context)
                                                        .size
                                                        .height * 0.015),)),),
                                        Container(margin: EdgeInsets.only(
                                            right: MediaQuery
                                                .of(context)
                                                .size
                                                .width * 0),
                                            alignment: Alignment.centerRight,
                                            child: Directionality(
                                                textDirection: TextDirection
                                                    .ltr,
                                                child: Text(data[i]["date"],
                                                  style: TextStyle(
                                                      fontSize: MediaQuery
                                                          .of(context)
                                                          .size
                                                          .height * 0.015),))),
                                      ])),
                                      Container(child: Row(children: [
                                        Container(margin: EdgeInsets.only(
                                            right: MediaQuery
                                                .of(context)
                                                .size
                                                .width * 0),
                                          child: Text("حالة الطلب :",
                                            style: TextStyle(color: Colors.blue,
                                                fontSize: MediaQuery
                                                    .of(context)
                                                    .size
                                                    .height * 0.015),),),
                                        Container(margin: EdgeInsets.only(
                                            right: MediaQuery
                                                .of(context)
                                                .size
                                                .width * 0),
                                            alignment: Alignment.centerRight,
                                            child: Text(data[i]["status"],
                                              style: TextStyle(
                                                  fontSize: MediaQuery
                                                      .of(context)
                                                      .size
                                                      .height * 0.015),))
                                      ]),)
                                    ],))),Expanded(child:data[i]["type"].toString()=="منتج"||data[i]["type"].toString()=="عرض"? InkWell( onTap: (){
                                          if(data[i]["type"].toString()=="منتج"){
                                            Navigator.of(context).push(MaterialPageRoute(builder: (context){
                                              return Orderdetail2(data: data[i]["details"],);
                                            }));
                                          }
                                          else{
                                            Navigator.of(context).push(MaterialPageRoute(builder: (context){
                                              return Orderdetail1(data: data[i],);
                                            }));
                                          }
                            },child: Directionality( textDirection: TextDirection.ltr,child: Container(alignment: Alignment.center,child: Icon(Icons.arrow_back_ios,color: Colors.blue,),))):Container())
                          ]),
                          //Center(child: InkWell(onTap: ()=>myorderlogic.showdetail(data[i]["desc"]),child: Container(width: MediaQuery.of(context).size.width*0.2 ,color: Colors.blue,alignment: Alignment.center,child: Text("تفاصيل",style: TextStyle(fontSize: MediaQuery.of(context).size.height*0.015,color: Colors.white),),)))
                        ],
                      ),
                    );
                  }),
                ))
            ],
          )));
    }
    else{
      return Container();
    }
  }
  Widget detailwidget(){
    if(activenow =="detail") {
      if (!able) {
        return Container(child: Center(child: CircularProgressIndicator()));
      }
      if (able) {
        return Container(
          child: ids == null ? Container(
              child: Center(child: CircularProgressIndicator())) : Container(
            height: MediaQuery
                .of(context)
                .size
                .height * 0.78,
            child: images.length == 0 ? Container(
              child: Center(child: CircularProgressIndicator()),) : ListView(
              children: [
                Container(
                  child: Container(padding: EdgeInsets.only(right: MediaQuery
                      .of(context)
                      .size
                      .height * 0.01, left: MediaQuery
                      .of(context)
                      .size
                      .height * 0.02),
                      margin: EdgeInsets.only(top: MediaQuery
                          .of(context)
                          .size
                          .height * 0),
                      height: MediaQuery
                          .of(context)
                          .size
                          .height * 0.12,
                      width: MediaQuery
                          .of(context)
                          .size
                          .width
                      ,
                      child: Row(children: [Expanded(child: InkWell(onTap: () {
                        Provider.of<Notifires>(context,listen: false).getindex(tabController, "hist", 9, context);
                      },
                          child: Container(
                              margin: EdgeInsets.only(top: MediaQuery
                                  .of(context)
                                  .size
                                  .height * 0.03),
                              height: MediaQuery
                                  .of(context)
                                  .size
                                  .width * 0.4,
                              width: MediaQuery
                                  .of(context)
                                  .size
                                  .width * 0.5,
                              child: Icon(
                                Icons.arrow_back_ios, color: Colors.blue,)))),
                        Expanded(flex: 6, child: Container(margin: EdgeInsets
                            .only(top: MediaQuery
                            .of(context)
                            .size
                            .height * 0.03, left: MediaQuery
                            .of(context)
                            .size
                            .width * 0.2, right: MediaQuery
                            .of(context)
                            .size
                            .width * 0.2,),
                            child:  AutoSizeText("تفاصيل المنتج",maxLines: 1,
                              style: TextStyle(color: Colors.blue,fontSize: 20),))),
                      ],)),
                ),
                Container(margin: EdgeInsets.all(20),
                  decoration: BoxDecoration(
                      borderRadius: BorderRadius.circular(30)),
                  width: MediaQuery
                      .of(context)
                      .size
                      .width,
                  height: MediaQuery
                      .of(context)
                      .size
                      .height * 0.25,
                  child: Container(
                    child: images.length == 0 ? Container() : CarouselSlider
                        .builder(options: CarouselOptions(height: MediaQuery
                        .of(context)
                        .size
                        .height * 0.3, viewportFraction: 1,
                        onPageChanged: (ind, reson) {
                          setState(() {
                            activee = ind;
                          });
                        }, autoPlay: false),
                      itemBuilder: (context, index, real) {
                        return Container(margin: EdgeInsets.only(
                            left: MediaQuery
                                .of(context)
                                .size
                                .width * 0, right: MediaQuery
                            .of(context)
                            .size
                            .width * 0),
                            width: MediaQuery
                                .of(context)
                                .size
                                .width * 1.2,
                            height: MediaQuery
                                .of(context)
                                .size
                                .height * 0.3,
                            child: images[activee] == null
                                ? Container()
                                : Image(fit: BoxFit.fill,
                              image: NetworkImage(images[activee]),));
                      }, itemCount: images.length,),
                  ),
                ),
                Container(child: images.length != 0 ? Center(
                  child: AnimatedSmoothIndicator(count: images.length,
                    activeIndex: activee,),
                ) : Container(),),
                Directionality(textDirection: TextDirection.rtl,
                    child: Container(margin: EdgeInsets.all(MediaQuery
                        .of(context)
                        .size
                        .width * 0.03),
                      child: Center(child: Text(datas[0]["name"],
                        style: TextStyle(fontSize: 20, color: Colors
                            .black38),)),)),
                Directionality(textDirection: TextDirection.rtl,
                    child: Container(margin: EdgeInsets.all(MediaQuery
                        .of(context)
                        .size
                        .width * 0.03),
                      child: Center(child: Text(datas[0]["desc"],
                        style: TextStyle(fontSize: 20, color: Colors
                            .black38),)),)),
                Directionality(textDirection: TextDirection.rtl,
                    child: Container(
                        margin: EdgeInsets.only(top: 10, right: MediaQuery
                            .of(context)
                            .size
                            .width * 0.07),
                        child: Row(
                          children: [Text("السعر  : ", style: TextStyle(
                              decoration: discount == "0" ? TextDecoration
                                  .lineThrough : TextDecoration.none,
                              fontSize: 20,
                              color: Colors.lightBlue),), Text(datas[0]["price"]
                              .toString() + "  " + "ج.م", style: TextStyle(
                              decoration: discount == "0" ? TextDecoration
                                  .lineThrough : TextDecoration.none,
                              fontSize: 20,
                              color: Colors.lightBlue),)
                          ],))),
                Container(child: discount == "1" ? Container() : Directionality(
                    textDirection: TextDirection.rtl,
                    child: Container(
                        margin: EdgeInsets.only(top: 15, right: MediaQuery
                            .of(context)
                            .size
                            .width * 0.07), child: Row(children: [
                      Text("السعر الجديد : ", style: TextStyle(
                          fontSize: 20, color: Colors.lightBlue),),
                      Text((int.parse(datas[0]["price"].toString()) / 2)
                          .toString() + "  " + "ج.م", style: TextStyle(
                          fontSize: 20, color: Colors.lightBlue),)
                    ],)))),
                Container(margin: EdgeInsets.only( top: 10, right:MediaQuery
                    .of(context)
                    .size
                    .width * 0.1 ,left: MediaQuery
                    .of(context)
                    .size
                    .width * 0.1),
                  height: MediaQuery
                      .of(context)
                      .size
                      .height * 0.05,
                  color: Colors.blue,
                  child: Center(child: InkWell(child: Text(
                    "اضافة الى السلة", style: TextStyle(fontSize: MediaQuery
                      .of(context)
                      .size
                      .height * 0.015, color: Colors.white),),
                    onTap: (){Provider.of<Notifires>(context,listen: false).addtobasket(context, tabController);},)),)
              ],),
          ),
        );
      }
    }else{
      return Container();
    }
}
 // صفحة العروض
Widget offers(){
   // if(activenow =="offers") {
      return Container(height: MediaQuery
          .of(context)
          .size
          .height * 0.5, child: Column(children: [
        Container(
          child: Container(padding: EdgeInsets.only(right: MediaQuery
              .of(context)
              .size
              .height * 0.01, left: MediaQuery
              .of(context)
              .size
              .height * 0.02),
              margin: EdgeInsets.only(top: MediaQuery
                  .of(context)
                  .size
                  .height * 0.02),
              height: MediaQuery
                  .of(context)
                  .size
                  .height * 0.12,
              width: MediaQuery
                  .of(context)
                  .size
                  .width
              ,
              child: Row(children: [
                Expanded(
                    child: Container(margin: EdgeInsets.only(top: MediaQuery
                        .of(context)
                        .size
                        .height * 0.03),
                      height: MediaQuery
                          .of(context)
                          .size
                          .width * 0.4,
                      width: MediaQuery
                          .of(context)
                          .size
                          .width * 0.5,
                      child: Image(image: AssetImage("comp/logo.png"),),)),
                Expanded(flex: 6,
                    child: Container(margin: EdgeInsets.only(top: MediaQuery
                        .of(context)
                        .size
                        .height * 0.03, left: MediaQuery
                        .of(context)
                        .size
                        .width * 0.2, right: MediaQuery
                        .of(context)
                        .size
                        .width * 0.2,),
                        child: FittedBox(
                            child: Text("صفحة العروض", style: TextStyle(
                                color: Colors.blue),)))),
                Expanded(
                    child: Container(margin: EdgeInsets.only(top: MediaQuery
                        .of(context)
                        .size
                        .height * 0.03),
                      child: IconButton(icon: IconButton(icon: Icon(
                        Icons.menu, color: Colors.blue, size: 30,),
                          onPressed: () {
                    Provider.of<Notifires>(context,listen: false).getindex(tabController, "menu", 4, context);
                          }),),))
              ],)),
        )
        ,
        Container(
          child: offersdata.length == 0
              ? Container(height: MediaQuery
              .of(context)
              .size
              .height * 0.73, child: Center(child: Text("لا يوجد هناك عروض")))
              : Container(height: MediaQuery
              .of(context)
              .size
              .height * 0.75,
              child: GridView.builder(scrollDirection: Axis.vertical,
                gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
                  crossAxisCount: 2, childAspectRatio: (MediaQuery
                    .of(context)
                    .size
                    .width * 1.2 / MediaQuery
                    .of(context)
                    .size
                    .height * 1.65),),
                itemCount: offersdata.length,
                itemBuilder: (context, i) {
                  int endtime;
                  if (offersdata[i]["end_date"].toString() != "null") {
                    endtime = DateTime
                        .parse(offersdata[i]["end_date"].toString()
                    )
                        .millisecondsSinceEpoch + 1000 * 30;
                  }
                  return Container(margin: EdgeInsets.only(left: MediaQuery
                      .of(context)
                      .size
                      .height * 0.01, bottom: MediaQuery
                      .of(context)
                      .size
                      .height * 0.01, right: MediaQuery
                      .of(context)
                      .size
                      .height * 0.01),
                    decoration: BoxDecoration(boxShadow: [
                      BoxShadow(
                        color: Colors.black26,
                        blurRadius: 1.0,
                        spreadRadius: 0.0,
                        offset: Offset(
                            2.0, 2.0), // shadow direction: bottom right
                      )
                    ],
                        color: Colors.white,
                        borderRadius: BorderRadius.circular(20)),
                    width: MediaQuery
                        .of(context)
                        .size
                        .width * 0.1,
                    height: MediaQuery
                        .of(context)
                        .size
                        .height * 0.2,
                    child:Column(children:[ Container(
                        child: offersdata[i]["image"].toString() == "" ||
                            offersdata[i]["image"].toString() == "null" ?
                        Container(margin: EdgeInsets.only(top: 15) , child:
                        Column(children: [
                          Container(height: MediaQuery
                              .of(context)
                              .size
                              .height * 0.05,
                            margin: EdgeInsets.only(top: MediaQuery
                                .of(context)
                                .size
                                .height * 0.01),
                            child: Container(
                              margin: EdgeInsets.only(left: MediaQuery
                                  .of(context)
                                  .size
                                  .width * 0.05, right: MediaQuery
                                  .of(context)
                                  .size
                                  .width * 0.05),
                              alignment: Alignment.center,
                              child: Directionality(
                                  textDirection: TextDirection.rtl,
                                  child:  Text(
                                    offersdata[i]["desc"].toString(), maxLines: 1,overflow: TextOverflow.ellipsis,
                                    style: TextStyle(fontSize: MediaQuery
                                        .of(context)
                                        .size
                                        .height * 0.015,
                                        color: Colors.blue))),),),
                          Container(height: MediaQuery
                              .of(context)
                              .size
                              .height * 0.03,
                              margin: EdgeInsets.only(top: MediaQuery
                                  .of(context)
                                  .size
                                  .height * 0.01, left: MediaQuery
                                  .of(context)
                                  .size
                                  .width * 0.05, right: MediaQuery
                                  .of(context)
                                  .size
                                  .width * 0.05),
                              child: Directionality(
                                  textDirection: TextDirection.rtl,
                                  child: FittedBox(
                                    child: Text("متبقي للعرض :"
                                      //"للتواصل مع الرقم :" +databannerimages[index]["phone"]
                                      , style: TextStyle(
                                          fontStyle: FontStyle.italic,
                                          fontSize: MediaQuery
                                              .of(context)
                                              .textScaleFactor * 15,
                                          color: Colors.blueAccent),),
                                  ))),
                          Container(height: MediaQuery
                              .of(context)
                              .size
                              .height * 0.03,
                            margin: EdgeInsets.only(left: MediaQuery
                                .of(context)
                                .size
                                .width * 0.05, right: MediaQuery
                                .of(context)
                                .size
                                .width * 0.05),
                            child: FittedBox(child: CountdownTimer(
                                endTime: endtime,
                                widgetBuilder: (_, CurrentRemainingTime time) {
                                  if (time == null) {
                                    return FittedBox(
                                        child: Directionality(textDirection: TextDirection.rtl,child: Text(' انتهى الوقت المخصص لعرض')));
                                  }
                                  if(time.days.toString()=="null"){
                                    return Directionality(textDirection: TextDirection.rtl,child: Text(' انتهى الوقت المخصص لعرض'));
                                  }
                                  return Directionality(
                                    textDirection: TextDirection.rtl,
                                    child: FittedBox(child: Text(
                                      '   ${time.days} أيام ',
                                      style: TextStyle(fontSize: MediaQuery
                                          .of(context)
                                          .textScaleFactor * 13),)),
                                  );
                                })),)
                        ],)) : Container(height: MediaQuery.of(context).size.height*0.15,width: MediaQuery.of(context).size.width,child:
                        Container(decoration: BoxDecoration(
                            borderRadius: BorderRadius.circular(20)),
                            child: ClipRRect(
                              borderRadius: BorderRadius.circular(20),
                              child: FadeInImage(placeholder: AssetImage("comp/logo.png"),fit: BoxFit.fill,
                                image: NetworkImage(offersdata[i]["image"])
                                ,),
                            )))),InkWell( onTap: (){
                              Navigator.of(context).push(MaterialPageRoute(builder: (context){
                                return Detailoffers(data: offersdata[i],);
                              }));
                    },child: Container( margin: EdgeInsets.only(top: 5),padding: EdgeInsets.all(5),decoration: BoxDecoration(borderRadius: BorderRadius.circular(10),color: Colors.blue) ,child:Text("تفاصيل",style: TextStyle(color: Colors.white,fontSize: 14),))) ]),
                  );
                },
              )
          ),
        )
        // ,Container(height: MediaQuery.of(context).size.height *0.05,child: Row(children: [Expanded(child: Container()),Expanded(flex: 2,child: Container(width: 200,height: MediaQuery.of(context).size.height * 0.07,decoration: BoxDecoration(color: Colors.blue,borderRadius: BorderRadius.circular(10)),child:Center(child : InkWell(onTap:()=> navigatetomaintain()
        //     ,child: Text("طلب خدمة",style: TextStyle(color: Colors.white,fontSize: MediaQuery.of(context).size.height* 0.015)))) )),Expanded(child: Container()),
        //  Expanded(flex: 2,child: Container(height: MediaQuery.of(context).size.height * 0.07,decoration: BoxDecoration(color: Colors.blue,borderRadius: BorderRadius.circular(10)),child:Center(child : InkWell(onTap:homeScreenlogic.navigatetocontact,child: Text("تواصل معنا",style: TextStyle(color: Colors.white,fontSize: MediaQuery.of(context).size.height* 0.015)))) )),Expanded(child: Container())],),)

      ],),);
    //}
   // else{
   //   return Container();
   // }
  }

// صفحة المشتريات
Widget shopping(){
    //if(activenow =="shopping") {
      return Form(key: key,
        child: ListView(
          children: [
            Container(
              child: Container(padding: EdgeInsets.only(right: MediaQuery
                  .of(context)
                  .size
                  .height * 0.01, left: MediaQuery
                  .of(context)
                  .size
                  .height * 0.02),
                  height: MediaQuery
                      .of(context)
                      .size
                      .height * 0.12,
                  width: MediaQuery
                      .of(context)
                      .size
                      .width
                  ,
                  child: Row(children: [
                    Expanded(
                        child: Container(margin: EdgeInsets.only(top: MediaQuery
                            .of(context)
                            .size
                            .height * 0.03),
                          height: MediaQuery
                              .of(context)
                              .size
                              .width * 0.4,
                          width: MediaQuery
                              .of(context)
                              .size
                              .width * 0.5,
                          child: Image(image: AssetImage("comp/logo.png"),),)),
                    Expanded(flex: 6,
                        child: Container(margin: EdgeInsets.only(top: MediaQuery
                            .of(context)
                            .size
                            .height * 0.03, left: MediaQuery
                            .of(context)
                            .size
                            .width * 0.2, right: MediaQuery
                            .of(context)
                            .size
                            .width * 0.2,),
                            child: FittedBox(
                                child: Text("سلة المشتريات", style: TextStyle(
                                    color: Colors.blue),)))),
                    Expanded(
                        child: Container(margin: EdgeInsets.only(top: MediaQuery
                            .of(context)
                            .size
                            .height * 0.03),
                          child: IconButton(icon: IconButton(icon: Icon(
                            Icons.menu, color: Colors.blue, size: 30,),
                              onPressed: () {
                                Provider.of<Notifires>(context,listen: false).getindex(tabController, "menu", 4, context);
                              }),),))
                  ],)),
            ),
            Container(width: MediaQuery
                .of(context)
                .size
                .width, height: MediaQuery
                .of(context)
                .size
                .height * 0.82,
              child: datashopp.length == 0 ? Center(child: Text(
                "لا يوجد أي منتج حاليا في السلة ",
                style: TextStyle(color: Colors.black54),),) : ListView(
                children: [
                  Directionality(textDirection: TextDirection.rtl,
                      child: Container(margin: EdgeInsets.only(left: MediaQuery
                          .of(context)
                          .size
                          .width * 0.1, top: MediaQuery
                          .of(context)
                          .size
                          .width * 0.05,
                          bottom: MediaQuery
                              .of(context)
                              .size
                              .width * 0.05, right: MediaQuery
                              .of(context)
                              .size
                              .width * 0.1),
                        child: Row(children: [Expanded(child: Container(
                          alignment: Alignment.centerRight,
                          child: Directionality(
                              textDirection: TextDirection.rtl,
                              child: Text(
                                  "لديك " + datashopp.length.toString() +
                                      "عنصر في السلة")),)),
                          Expanded(child: Container(
                            alignment: Alignment.centerLeft,
                            child: InkWell(onTap: () {
                              shoppinglogic.deleteall();
                              Provider.of<Notifires>(context, listen: false)
                                  .getdatashopp(context);
                            },
                                child: Text("حذف الكل", style: TextStyle(
                                    decoration: TextDecoration.underline,
                                    color: Colors.redAccent,
                                    fontSize: MediaQuery
                                        .of(context)
                                        .size
                                        .height * 0.02),)),))
                        ],),)),
                  Container(height: MediaQuery
                      .of(context)
                      .size
                      .height * 0.3,
                    width: MediaQuery
                        .of(context)
                        .size
                        .width,
                    child: ListView.builder(
                        itemCount: datashopp.length, itemBuilder: (context, i) {
                      return Container(margin: EdgeInsets.only(top: MediaQuery
                          .of(context)
                          .size
                          .height * 0.01),height: MediaQuery.of(context).size.height*0.15, decoration: BoxDecoration(
                          borderRadius: BorderRadius.circular(20),
                          color: Colors.white), child: Row(children: [
                        Expanded(child: Container(width: MediaQuery
                            .of(context)
                            .size
                            .width * 0.1, child: Column(children: [
                          Directionality(textDirection: TextDirection.rtl,
                              child: Text(
                                  (datashopp[i]["price"] * datashopp[i]["num"])
                                      .toString() + "ج.م", style: TextStyle(
                                  color: Colors.red, fontSize: MediaQuery
                                  .of(context)
                                  .size
                                  .height * 0.02))),
                          IconButton(
                              icon: Icon(Icons.delete, color: Colors.red,),
                              onPressed: () {
                                shoppinglogic.deletecart(
                                    datashopp, datashopp[i]["id"]);
                                Provider.of<Notifires>(context, listen: false)
                                    .getdatashopp(context);
                              })
                        ],),)), Expanded(child: Container(width: MediaQuery
                            .of(context)
                            .size
                            .width * 0.1, child: Column(children: [
                          Directionality(textDirection: TextDirection.rtl,
                              child: Text(
                                  datashopp[i]["name"].toString().trim(),
                                  style: TextStyle(
                                      color: Colors.black, fontSize: MediaQuery
                                      .of(context)
                                      .size
                                      .height * 0.02))),
                          Container(child: Row(children: [
                            Expanded(child: IconButton(onPressed: () {
                              shoppinglogic.plus(datashopp[i]["id"]);
                              Provider.of<Notifires>(context, listen: false)
                                  .getdatashopp(context);
                            }, icon: Icon(Icons.add_box_sharp),)),
                            Expanded(child: Container(
                                alignment: Alignment.center,
                                child: Text(datashopp[i]["num"].toString()))),
                            Expanded(child: IconButton(onPressed: () {
                              shoppinglogic.minus(datashopp[i]["id"]);
                              Provider.of<Notifires>(context, listen: false)
                                  .getdatashopp(context);
                            }, icon: Icon(Icons.indeterminate_check_box),))
                          ],),)
                        ],),)),
                        Expanded(child: Container(child: Image(
                          image: NetworkImage(datashopp[i]["img"]),
                          fit: BoxFit.fill,),))
                      ],)
                        ,);
                    }),),
                  Container(child: Divider(color: Colors.black,),),
                  Container(margin: EdgeInsets.only(top: MediaQuery
                      .of(context)
                      .size
                      .height * 0.05),
                    color: Colors.white,
                    width: MediaQuery
                        .of(context)
                        .size
                        .width,
                    height: MediaQuery
                        .of(context)
                        .size
                        .height * 0.12,
                    child: Column(children: [
                      Container(child: Text("تفاصيل الطلب", style: TextStyle(
                          fontSize: MediaQuery
                              .of(context)
                              .size
                              .height * 0.02),),
                        alignment: Alignment.centerRight,
                        margin: EdgeInsets.only(right: MediaQuery
                            .of(context)
                            .size
                            .width * 0.1),),
                      Container(margin: EdgeInsets.only(left: MediaQuery
                          .of(context)
                          .size
                          .width * 0.1, right: MediaQuery
                          .of(context)
                          .size
                          .width * 0.1), child: Divider(thickness: 1,),),
                      Container(margin: EdgeInsets.only(left: MediaQuery
                          .of(context)
                          .size
                          .width * 0.1, right: MediaQuery
                          .of(context)
                          .size
                          .width * 0.1), child: Row(children: [
                        Expanded(child: Container(
                            alignment: Alignment.centerLeft,
                            child: Directionality(
                                textDirection: TextDirection.rtl,
                                child: Text(
                                    shoppinglogic.computetotal(datashopp)
                                        .toString() + "ج.م",
                                    style: TextStyle(fontSize: MediaQuery
                                        .of(context)
                                        .size
                                        .height * 0.015)))))
                        ,
                        Expanded(child: Container(
                            alignment: Alignment.centerRight,
                            child: Text("الاجمالي",
                                style: TextStyle(fontSize: MediaQuery
                                    .of(context)
                                    .size
                                    .height * 0.02))))
                      ],),)
                    ],),),
                  Container(margin: EdgeInsets.only(top: MediaQuery
                      .of(context)
                      .size
                      .height * 0.05), color: Colors.white, width: MediaQuery
                      .of(context)
                      .size
                      .width, child: Column(children: [
                    Container(margin: EdgeInsets.only(left: MediaQuery
                        .of(context)
                        .size
                        .width * 0.1, right: MediaQuery
                        .of(context)
                        .size
                        .width * 0.1), child: Container(alignment: Alignment
                        .centerRight, child: Text(
                        "العنوان", style: TextStyle(fontSize: MediaQuery
                        .of(context)
                        .size
                        .height * 0.02)),)),
                    Container(margin: EdgeInsets.only(top: MediaQuery
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
                    Container(margin: EdgeInsets.only(left: MediaQuery
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
                          border: Border.all(color: Colors.black)),)),
                  ],),),
                  InkWell(
                    onTap: () {
                      var datapay = {
                        "phone": phone.text,
                        "madina": madina.text, "address": address.text
                      };
                      shoppinglogic.alertbuy(datashopp,
                          shoppinglogic.computetotal(datashopp).toString(), key,
                          datapay);
                    },
                    child: Container(height: MediaQuery
                        .of(context)
                        .size
                        .height * 0.09,
                      decoration: BoxDecoration(
                          borderRadius: BorderRadius.circular(20),
                          color: Colors.lightBlueAccent),
                      margin: EdgeInsets.only(bottom: MediaQuery
                          .of(context)
                          .size
                          .height * 0.05, top: MediaQuery
                          .of(context)
                          .size
                          .height * 0.05),
                      child: Row(children: [
                        Expanded(child: Container(
                          margin: EdgeInsets.only(left: MediaQuery
                              .of(context)
                              .size
                              .width * 0.05),
                          child: InkWell(child: Text("اتمام الطلب",
                            style: TextStyle(
                                color: Colors.white, fontSize: MediaQuery
                                .of(context)
                                .size
                                .height * 0.02),)),)),
                        Expanded(child: Container(
                          alignment: Alignment.centerRight,
                          margin: EdgeInsets.only(right: MediaQuery
                              .of(context)
                              .size
                              .width * 0.1),
                          child: Column(children: [
                            Text("المجموع", style: TextStyle(
                                color: Colors.white, fontSize: MediaQuery
                                .of(context)
                                .size
                                .height * 0.02),),
                            Directionality(textDirection: TextDirection.rtl,
                                child: Text(
                                  shoppinglogic.computetotal(datashopp)
                                      .toString() + "ج.م", style: TextStyle(
                                    color: Colors.white, fontSize: MediaQuery
                                    .of(context)
                                    .size
                                    .height * 0.015),))
                          ]),))
                      ],),),
                  )

                ],),
            )
          ],
        ),
      );
   // }
  //  else{
   //   return Container();
   // }
}
Widget Menu(){
   // if(activenow =="menu") {
      return Container(color: Colors.white,
        child: Stack(children: [Container(),
          Positioned(top: MediaQuery
              .of(context)
              .size
              .height * 0.1,
              width: MediaQuery
                  .of(context)
                  .size
                  .width,
              child: Container(decoration: BoxDecoration(color: Colors.black12,
                  borderRadius: BorderRadius.only(
                      topLeft: Radius.circular(40))), height: MediaQuery
                  .of(context)
                  .size
                  .height * 0.9,
                  child: ListView(children: [
                    Container(width: MediaQuery
                        .of(context)
                        .size
                        .width * 0.4,
                      height: MediaQuery
                          .of(context)
                          .size
                          .width * 0.4,
                      child: Image(image: AssetImage("comp/logo.png"),),),
                    Directionality(textDirection: TextDirection.rtl,
                        child: InkWell(onTap: () {
                          Provider.of<Notifires>(context,listen: false).getindex(tabController, "home", 0, context);
                        },
                            child: Container(
                                margin: EdgeInsets.only(top: MediaQuery
                                    .of(context)
                                    .size
                                    .height * 0.05, left: MediaQuery
                                    .of(context)
                                    .size
                                    .width * 0.1, right: MediaQuery
                                    .of(context)
                                    .size
                                    .width * 0.1), child: ListTile(title: Text(
                              "الصفحة الرئيسية", style: TextStyle(
                                color: Colors.blue, fontSize: MediaQuery
                                .of(context)
                                .size
                                .height * 0.02),), leading: Container(
                                width: MediaQuery
                                    .of(context)
                                    .size
                                    .height * 0.035,
                                height: MediaQuery
                                    .of(context)
                                    .size
                                    .height * 0.035,
                                child: Image(fit: BoxFit.fill,
                                    image: AssetImage("comp/home.png"))),))))
                    ,
                    Container(margin: EdgeInsets.only(left: MediaQuery
                        .of(context)
                        .size
                        .width * 0.1, right: MediaQuery
                        .of(context)
                        .size
                        .width * 0.1),
                      child: Divider(color: Colors.blue, thickness: 1,),)
                    ,
                    Directionality(textDirection: TextDirection.rtl,
                        child: Container(
                            margin: EdgeInsets.only(left: MediaQuery
                                .of(context)
                                .size
                                .width * 0.1, right: MediaQuery
                                .of(context)
                                .size
                                .width * 0.1),
                            child: InkWell(onTap: menulogic.navigatetowhous,
                                child: ListTile(title: Text("من نحن",
                                  style: TextStyle(
                                      color: Colors.blue, fontSize: MediaQuery
                                      .of(context)
                                      .size
                                      .height * 0.02),), leading: Container(
                                    width: MediaQuery
                                        .of(context)
                                        .size
                                        .height * 0.035,
                                    height: MediaQuery
                                        .of(context)
                                        .size
                                        .height * 0.035,
                                    child: Image(fit: BoxFit.fill,
                                        image: AssetImage("comp/us.png"))),))))
                    ,
                    Container(margin: EdgeInsets.only(left: MediaQuery
                        .of(context)
                        .size
                        .width * 0.1, right: MediaQuery
                        .of(context)
                        .size
                        .width * 0.1),
                      child: Divider(color: Colors.blue, thickness: 1,),),
                    Directionality(textDirection: TextDirection.rtl,
                        child: InkWell(onTap: menulogic.navigatetocontact,
                            child: Container(
                                margin: EdgeInsets.only(left: MediaQuery
                                    .of(context)
                                    .size
                                    .width * 0.1, right: MediaQuery
                                    .of(context)
                                    .size
                                    .width * 0.1), child: ListTile(title: Text(
                              "تواصل معنا", style: TextStyle(
                                color: Colors.blue, fontSize: MediaQuery
                                .of(context)
                                .size
                                .height * 0.02),), leading: Container(
                                width: MediaQuery
                                    .of(context)
                                    .size
                                    .height * 0.035,
                                height: MediaQuery
                                    .of(context)
                                    .size
                                    .height * 0.035,
                                child: Image(fit: BoxFit.fill,
                                    image: AssetImage("comp/contact.png")))))))
                    //Container(margin: EdgeInsets.only(left: MediaQuery.of(context).size.width*0.1,right: MediaQuery.of(context).size.width*0.1),child: Divider(color: Colors.blue,thickness: 1,),),Directionality(textDirection: TextDirection.rtl,child: InkWell(onTap: menulogic.navigatetoshopping,child: Container(margin: EdgeInsets.only( left: MediaQuery.of(context).size.width*0.1,right: MediaQuery.of(context).size.width*0.1),child: ListTile(title:Text("سلة المشتريات",style: TextStyle(color: Colors.blue,fontSize: MediaQuery.of(context).size.height*0.02),),leading: Container(width: MediaQuery.of(context).size.height*0.035,height:MediaQuery.of(context).size.height*0.035  ,child: Image( fit: BoxFit.fill,image : AssetImage( "comp/basket.png")))))))
                    ,
                    Container(margin: EdgeInsets.only(left: MediaQuery
                        .of(context)
                        .size
                        .width * 0.1, right: MediaQuery
                        .of(context)
                        .size
                        .width * 0.1),
                      child: Divider(color: Colors.blue, thickness: 1,),),
                    Directionality(textDirection: TextDirection.rtl,
                        child: Container(
                            margin: EdgeInsets.only(left: MediaQuery
                                .of(context)
                                .size
                                .width * 0.1, right: MediaQuery
                                .of(context)
                                .size
                                .width * 0.1), child: InkWell(onTap: () {
                          Provider.of<Notifires>(context,listen: false).getindex(tabController, "myorders", 5, context);
                          if(mounted) {
                            Provider.of<Notifires>(context, listen: false)
                                .getmyorders(context);
                          }
                        }, child: ListTile(title: Text("طلباتي",
                          style: TextStyle(
                              color: Colors.blue, fontSize: MediaQuery
                              .of(context)
                              .size
                              .height * 0.02),), leading: Container(
                            width: MediaQuery
                                .of(context)
                                .size
                                .height * 0.035,
                            height: MediaQuery
                                .of(context)
                                .size
                                .height * 0.035,
                            child: Image(fit: BoxFit.fill,
                                image: AssetImage("comp/us.png"))))))),
                    Container(margin: EdgeInsets.only(left: MediaQuery
                        .of(context)
                        .size
                        .width * 0.1, right: MediaQuery
                        .of(context)
                        .size
                        .width * 0.1),
                      child: Divider(color: Colors.blue, thickness: 1,),),
                    Directionality(textDirection: TextDirection.rtl,
                        child: InkWell(onTap: menulogic.navigatetoprofile,
                            child: Container(
                                margin: EdgeInsets.only(left: MediaQuery
                                    .of(context)
                                    .size
                                    .width * 0.1, right: MediaQuery
                                    .of(context)
                                    .size
                                    .width * 0.1), child: ListTile(title: Text(
                              "بروفايل", style: TextStyle(
                                color: Colors.blue, fontSize: MediaQuery
                                .of(context)
                                .size
                                .height * 0.02),), leading: Container(
                                width: MediaQuery
                                    .of(context)
                                    .size
                                    .height * 0.035,
                                height: MediaQuery
                                    .of(context)
                                    .size
                                    .height * 0.035,
                                child: Image(fit: BoxFit.fill,
                                    image: AssetImage(
                                        "comp/personf.png"))),)))),
                    Container(margin: EdgeInsets.only(left: MediaQuery
                        .of(context)
                        .size
                        .width * 0.1, right: MediaQuery
                        .of(context)
                        .size
                        .width * 0.1),
                      child: Divider(color: Colors.blue, thickness: 1,),),
                    Directionality(textDirection: TextDirection.rtl,
                        child: InkWell(onTap: menulogic.navigatetochangepass,
                            child: Container(
                                margin: EdgeInsets.only(left: MediaQuery
                                    .of(context)
                                    .size
                                    .width * 0.1, right: MediaQuery
                                    .of(context)
                                    .size
                                    .width * 0.1), child: ListTile(title: Text(
                              "تعديل كلمة السر", style: TextStyle(
                                color: Colors.blue, fontSize: MediaQuery
                                .of(context)
                                .size
                                .height * 0.02),), leading: Container(
                                width: MediaQuery
                                    .of(context)
                                    .size
                                    .height * 0.035,
                                height: MediaQuery
                                    .of(context)
                                    .size
                                    .height * 0.035,
                                child: Image(fit: BoxFit.fill,
                                    image: AssetImage("comp/personf.png"))),))))
                    ,
                    Container(margin: EdgeInsets.only(left: MediaQuery
                        .of(context)
                        .size
                        .width * 0.1, right: MediaQuery
                        .of(context)
                        .size
                        .width * 0.1),
                      child: Divider(color: Colors.blue, thickness: 1,),),
                    Directionality(textDirection: TextDirection.rtl,
                        child: Container(
                            margin: EdgeInsets.only(left: MediaQuery
                                .of(context)
                                .size
                                .width * 0.1, right: MediaQuery
                                .of(context)
                                .size
                                .width * 0.1), child: InkWell(onTap: () {
                          Provider.of<Notifires>(context,listen: false).getindex(tabController, "hist", 9, context);
                        }, child: ListTile(title: Text("قائمة المنتجات",
                          style: TextStyle(
                              color: Colors.blue, fontSize: MediaQuery
                              .of(context)
                              .size
                              .height * 0.02),), leading: Container(
                            width: MediaQuery
                                .of(context)
                                .size
                                .height * 0.035,
                            height: MediaQuery
                                .of(context)
                                .size
                                .height * 0.035,
                            child: Image(fit: BoxFit.fill,
                                image: AssetImage("comp/hist.png"))),))))
                    ,
                    Container(margin: EdgeInsets.only(left: MediaQuery
                        .of(context)
                        .size
                        .width * 0.1, right: MediaQuery
                        .of(context)
                        .size
                        .width * 0.1),
                      child: Divider(color: Colors.blue, thickness: 1,),),
                    Directionality(textDirection: TextDirection.rtl,
                        child: InkWell(onTap:()=> menulogic.signout(tabController),
                            child: Container(
                                margin: EdgeInsets.only(bottom: MediaQuery
                                    .of(context)
                                    .size
                                    .height * 0.2, left: MediaQuery
                                    .of(context)
                                    .size
                                    .width * 0.1, right: MediaQuery
                                    .of(context)
                                    .size
                                    .width * 0.1), child: ListTile(title: Text(
                              "تسجيل الخروج", style: TextStyle(
                                color: Colors.blue, fontSize: MediaQuery
                                .of(context)
                                .size
                                .height * 0.02),), leading: Container(
                                width: MediaQuery
                                    .of(context)
                                    .size
                                    .height * 0.035,
                                height: MediaQuery
                                    .of(context)
                                    .size
                                    .height * 0.035,
                                child: Image(fit: BoxFit.fill,
                                    image: AssetImage("comp/exit.png"))),))))
                  ],)))

        ],),
      );
   // }
   // else{
   //   return Container();
   // }
}
  Widget infosub(key , s, value ,values ,shoppinglogic ,subMaintainlogic , devicename , type , devices){
   // if(activenow=="infosub") {
      return Container(child: Form(key: keyinfo,
        child: ListView(children: [
          Container(height: MediaQuery
              .of(context)
              .size
              .height * 0.07, color: Colors.blue, child: Row(children: [
            Expanded(child: InkWell(onTap: () {
              Provider.of<Notifires>(context,listen: false).getindex(tabController, "home", 0, context);
            },
                child: Container(alignment: Alignment.centerLeft,
                    child: IconButton(icon: Icon(
                      Icons.arrow_back_ios, size: MediaQuery
                        .of(context)
                        .size
                        .height * 0.04, color: Colors.white,),)))),
            Expanded(child: Container(margin: EdgeInsets.only(right: MediaQuery
                .of(context)
                .size
                .width * 0.05),
              alignment: Alignment.centerRight,
              child: Text(
                "الصيانة الدورية", style: TextStyle(fontSize: MediaQuery
                  .of(context)
                  .size
                  .height * 0.025, color: Colors.white),),))
          ],),),
          Container(margin: EdgeInsets.only(top: MediaQuery
              .of(context)
              .size
              .height * 0.05, bottom: MediaQuery
              .of(context)
              .size
              .height * 0.05, right: MediaQuery
              .of(context)
              .size
              .width * 0.1),
            alignment: Alignment.centerRight,
            child: Directionality(textDirection: TextDirection.rtl,
                child: Text("املأ البيانات الاتية :",
                  style: TextStyle(color: Colors.blue, fontSize: MediaQuery
                      .of(context)
                      .size
                      .height * 0.02),)),),
          Container(
            child: !notav ? Container() : Directionality(
                textDirection: TextDirection.rtl,
                child: Container(padding: EdgeInsets.all(MediaQuery
                    .of(context)
                    .size
                    .width * 0.01),
                  margin: EdgeInsets.all(MediaQuery
                      .of(context)
                      .size
                      .width * 0.01)
                  ,
                  decoration: BoxDecoration(
                      border: Border.all(color: Colors.black54),
                      borderRadius: BorderRadius.circular(20)),
                  child: TextFormField(validator: shoppinglogic.valid,
                    style: TextStyle(fontSize: MediaQuery
                        .of(context)
                        .size
                        .height * 0.015),
                    controller: devicename,
                    decoration: InputDecoration(border: InputBorder.none,
                        hintText: "اسم الجهاز",
                        hintStyle: TextStyle(fontSize: MediaQuery
                            .of(context)
                            .size
                            .height * .015)),),)),
          ),
          Container(
            child: !notav ? Container() : Directionality(
                textDirection: TextDirection.rtl,
                child: Container(padding: EdgeInsets.all(MediaQuery
                    .of(context)
                    .size
                    .width * 0.01),
                  margin: EdgeInsets.all(MediaQuery
                      .of(context)
                      .size
                      .width * 0.01)
                  ,
                  decoration: BoxDecoration(
                      border: Border.all(color: Colors.black54),
                      borderRadius: BorderRadius.circular(20)),
                  child: TextFormField(validator: shoppinglogic.valid,
                    style: TextStyle(fontSize: MediaQuery
                        .of(context)
                        .size
                        .height * 0.015),
                    maxLines: 2,
                    minLines: 2,
                    controller: type,
                    decoration: InputDecoration(border: InputBorder.none,
                        hintText: "تفاصيل عن الصيانة",
                        hintStyle: TextStyle(fontSize: MediaQuery
                            .of(context)
                            .size
                            .height * .015)),),)),
          )
          ,
          Container(
            child: notav ? Container() : Container(
              padding: EdgeInsets.all(MediaQuery
                  .of(context)
                  .size
                  .width * 0.01), margin: EdgeInsets.only(top: MediaQuery
                .of(context)
                .size
                .height * 0.01
                , right: MediaQuery
                    .of(context)
                    .size
                    .width * 0.01, left: MediaQuery
                    .of(context)
                    .size
                    .width * 0.01),
              decoration: BoxDecoration(borderRadius: BorderRadius.circular(20),
                  border: Border.all(color: Colors.black))
              , child: Directionality(textDirection: TextDirection.rtl,
              child: Container(alignment: Alignment.centerRight,
                margin: EdgeInsets.only(right: MediaQuery
                    .of(context)
                    .size
                    .width * 0.02),
                child: ListTile(
                  title: DropdownButtonHideUnderline(
                      child: DropdownButton(
                        style: TextStyle(fontSize: MediaQuery
                            .of(context)
                            .size
                            .height * 0.015, color: Colors.black38),
                        value: valueinfo
                        ,
                        items: valuesinfo.map((e) =>
                            DropdownMenuItem(child: Text('$e'), value: e,))
                            .toList(),
                        onChanged: (_) {
                          if (_ != "اختر نوع الجهاز") {
                            Provider.of<Notifires>(context,listen: false).changevalueofdevice(_);
                          }
                        },
                      )),
                ),
              ),
            ),),
          ),
          Container(child: CheckboxListTile(value: notav,
            onChanged: (val) {
              setState(() {
                notav = val;
              });
            },
            title: Container(
                child: Directionality(textDirection: TextDirection.rtl,
                    child: FittedBox(child: Text(
                      "في حال لم يوجد جهازك في القائمة يمكنك اضافة الجهاز الخاص بك",
                      style: TextStyle(fontSize: MediaQuery
                          .of(context)
                          .size
                          .width * 0.03, color: Colors.blue),)))),),)
          ,
          Directionality(textDirection: TextDirection.rtl,
              child: Container(padding: EdgeInsets.all(MediaQuery
                  .of(context)
                  .size
                  .width * 0.01),
                margin: EdgeInsets.all(MediaQuery
                    .of(context)
                    .size
                    .width * 0.01)
                ,
                decoration: BoxDecoration(
                    border: Border.all(color: Colors.black54),
                    borderRadius: BorderRadius.circular(20)),
                child: TextFormField(validator: shoppinglogic.valid,
                  style: TextStyle(fontSize: MediaQuery
                      .of(context)
                      .size
                      .height * 0.015),
                  controller: address,
                  minLines: 2,
                  maxLines: 2,
                  textInputAction: TextInputAction.send,
                  decoration: InputDecoration(border: InputBorder.none,
                      hintText: "العنوان",
                      hintStyle: TextStyle(fontSize: MediaQuery
                          .of(context)
                          .size
                          .height * .015)),),))
          ,
          Container(margin: EdgeInsets.only(bottom: MediaQuery
              .of(context)
              .size
              .height * 0.1, top: MediaQuery
              .of(context)
              .size
              .height * 0.1, left: MediaQuery
              .of(context)
              .size
              .width * 0.25, right: MediaQuery
              .of(context)
              .size
              .width * 0.25),
              height: MediaQuery
                  .of(context)
                  .size
                  .height * 0.07,
              decoration: BoxDecoration(color: Colors.blueAccent,
                  borderRadius: BorderRadius.circular(10)),
              child: Center(child: InkWell(
                  onTap: () {
                    go(key,
                        valueinfo,
                        notav,
                        devicesinfo,
                        addressinfo,
                        context,
                        typeinfo);
                  }
                  ,
                  child: Text("حفظ المعومات",
                      style: TextStyle(color: Colors.white, fontSize: MediaQuery
                          .of(context)
                          .size
                          .height * 0.02))))),
        ],),
      ));
   // }
    //else{
   //   return Container();
   // }
  }
  Widget hist(){
    if(activenow =="hist") {
      return Container(color: Colors.white,
          child: ListView(children: [
            Container(height: MediaQuery
                .of(context)
                .size
                .height * 0.07, color: Colors.blue, child: Row(children: [
              Expanded(child: InkWell(onTap: () {
                Provider.of<Notifires>(context,listen: false).getindex(tabController, "menu", 4, context);
              },
                  child: Container(alignment: Alignment.centerLeft,
                      child: IconButton(icon: Icon(Icons.arrow_back_ios,
                        size: MediaQuery
                            .of(context)
                            .size
                            .height * 0.04, color: Colors.white,))))),
              Expanded(
                  child: Container(margin: EdgeInsets.only(right: MediaQuery
                      .of(context)
                      .size
                      .width * 0.05),
                    alignment: Alignment.centerRight,
                    child: FittedBox(child: Text(
                      "قائمة المنتجات", style: TextStyle(fontSize: MediaQuery
                        .of(context)
                        .size
                        .height * 0.025, color: Colors.white),)),))
            ],),),
            Container(
              child: data.length == 0
                  ? Container(height: MediaQuery
                  .of(context)
                  .size
                  .height * 0.8,
                  child: Center(child: CircularProgressIndicator()))
                  : Container(height: MediaQuery
                  .of(context)
                  .size
                  .height * 0.8, margin: EdgeInsets.only(top: MediaQuery
                  .of(context)
                  .size
                  .height * 0.02),
                  child: GridView.builder(scrollDirection: Axis.vertical,
                    gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
                        crossAxisCount: 2,
                        childAspectRatio: discount == "1" ? (MediaQuery
                            .of(context)
                            .size
                            .width * 1 / MediaQuery
                            .of(context)
                            .size
                            .height * 1.45) : (MediaQuery
                            .of(context)
                            .size
                            .width * 1 / MediaQuery
                            .of(context)
                            .size
                            .height * 1.3)),
                    itemCount: data.length,
                    itemBuilder: (context, i) {
                      return InkWell(onTap: () async {
                        Provider.of<Notifires>(context,listen: false).getdatas(data[i]["id"], context, tabController);
                        //getdatas(data[i]["id"]);
                      },
                        child: Container(
                          margin: EdgeInsets.only(left: MediaQuery
                              .of(context)
                              .size
                              .height * 0.01, bottom: MediaQuery
                              .of(context)
                              .size
                              .height * 0.01, right: MediaQuery
                              .of(context)
                              .size
                              .height * 0.01)
                          ,
                          decoration: BoxDecoration(boxShadow: [
                            BoxShadow(
                              color: Colors.black26,
                              blurRadius: 1.0,
                              spreadRadius: 0.0,
                              offset: Offset(
                                  2.0, 2.0), // shadow direction: bottom right
                            )
                          ], color: Colors.white, borderRadius: BorderRadius
                              .circular(20)),
                          width: MediaQuery
                              .of(context)
                              .size
                              .width,
                          height: MediaQuery
                              .of(context)
                              .size
                              .height,
                          child: Column(children: [
                            Container(child: Container(
                              margin: EdgeInsets.all(MediaQuery
                                  .of(context)
                                  .size
                                  .width * 0.01),
                              height: MediaQuery
                                  .of(context)
                                  .size
                                  .height * 0.17,
                              width: MediaQuery
                                  .of(context)
                                  .size
                                  .width,
                              child: ClipRRect(borderRadius: BorderRadius.all(
                                  Radius.circular(20)),
                                  child: data[i]["images"].length == 0
                                      ? Container()
                                      : Image(image: NetworkImage(
                                    data[i]["images"][0]["path"],),
                                    fit: BoxFit.fill,)),))
                            ,
                            Container(margin: EdgeInsets.only(top: MediaQuery
                                .of(context)
                                .size
                                .height * 0.01),
                              child: Container(
                                  margin: EdgeInsets.only(left: MediaQuery
                                      .of(context)
                                      .size
                                      .height * 0.01),
                                  alignment: Alignment.center,
                                  child: Directionality(
                                      textDirection: TextDirection.rtl,
                                      child: Text(data[i]["name"].toString(),
                                        style: TextStyle(fontSize: MediaQuery
                                            .of(context)
                                            .size
                                            .height * 0.015,
                                            color: Colors.blue),))),)
                            ,
                            Container(margin: EdgeInsets.only(top: MediaQuery
                                .of(context)
                                .size
                                .height * 0.01),
                              child: Container(
                                  margin: EdgeInsets.only(left: MediaQuery
                                      .of(context)
                                      .size
                                      .height * 0.01),
                                  alignment: Alignment.center,
                                  child: Directionality(
                                      textDirection: TextDirection.rtl,
                                      child: Text(
                                        data[i]["price"].toString() + "ج.م",
                                        style: TextStyle(
                                            decoration: discount == "0"
                                                ? TextDecoration.lineThrough
                                                : TextDecoration.none,
                                            fontSize: MediaQuery
                                                .of(context)
                                                .size
                                                .height * 0.015,
                                            color: Colors.blue),))),)
                            ,
                            Container(child: discount == "1"
                                ? Container()
                                : Container(
                              margin: EdgeInsets.only(top: MediaQuery
                                  .of(context)
                                  .size
                                  .height * 0.01),
                              child: Container(
                                margin: EdgeInsets.only(left: MediaQuery
                                    .of(context)
                                    .size
                                    .height * 0.01),
                                alignment: Alignment.center,
                                child: Directionality(
                                    textDirection: TextDirection.rtl,
                                    child: Text(
                                      (int.parse(data[i]["price"].toString()) /
                                          2).toString() + "ج.م",
                                      style: TextStyle(fontSize: MediaQuery
                                          .of(context)
                                          .size
                                          .height * 0.015,
                                          color: Colors.blue),)),),))
                            ,
                            Spacer(),
                            Container(
                              child: ElevatedButton(onPressed: () {
                                detaillogic.alertbuy2(
                                    shoppingbasket, data[i]["price"].toString(),
                                    data[i]["id"].toString(), i, data);
                              },
                                child: Text("اضافة الى سلة",
                                  style: TextStyle(fontSize: MediaQuery
                                      .of(context)
                                      .size
                                      .height * 0.015),),),
                            )
                          ],),
                        ),
                      );
                    },
                  )
              ),
            ),
            Container(
            )
            //Container(width: MediaQuery.of(context).size.width,margin: EdgeInsets.only(right:MediaQuery.of(context).size.width*0.1,left: MediaQuery.of(context).size.width*0.1 ,top: MediaQuery.of(context).size.height*0.6),height: 10,color: Colors.blue,)
          ],));
    }
    else{
      return Container();
    }
  }
  var datetime;
  var datetime2;
  var dateable = false;
  var dateable2 = false;
  Widget maintain(){
    if(activenow =="maintain") {
      return Container(
        child: Form(key: maintainKey,
          child: ListView(children: [
            Container(height: MediaQuery
                .of(context)
                .size
                .height * 0.07, color: Colors.blue, child: Row(children: [
              Expanded(child: InkWell(onTap: () {
                Provider.of<Notifires>(context,listen: false).getindex(tabController, "home", 0, context);
              },
                  child: Container(alignment: Alignment.centerLeft,
                      child: IconButton(icon: Icon(
                        Icons.arrow_back_ios, size: MediaQuery
                          .of(context)
                          .size
                          .height * 0.04, color: Colors.white,))))),
              Expanded(
                  child: Container(margin: EdgeInsets.only(right: MediaQuery
                      .of(context)
                      .size
                      .width * 0.05),
                    alignment: Alignment.centerRight,
                    child: Text(
                      "الصيانة الفورية", style: TextStyle(fontSize: MediaQuery
                        .of(context)
                        .size
                        .height * 0.025, color: Colors.white),),))
            ],),),
            Container(margin: EdgeInsets.only(top: MediaQuery
                .of(context)
                .size
                .height * 0.05, right: MediaQuery
                .of(context)
                .size
                .width * 0.1),
              alignment: Alignment.centerRight,
              child: Text("قم بارسال طلب الصيانة الان",
                style: TextStyle(color: Colors.blue, fontSize: MediaQuery
                    .of(context)
                    .size
                    .height * 0.023),),),
            Container(width: MediaQuery
                .of(context)
                .size
                .width, child: Column(children: [
              Container(padding: EdgeInsets.all(MediaQuery
                  .of(context)
                  .size
                  .width * 0.01), margin: EdgeInsets.only(top: MediaQuery
                  .of(context)
                  .size
                  .height * 0.05
                  , right: MediaQuery
                      .of(context)
                      .size
                      .width * 0.08, left: MediaQuery
                      .of(context)
                      .size
                      .width * 0.08),
                decoration: BoxDecoration(
                    borderRadius: BorderRadius.circular(20),
                    color: Colors.white)
                , child: Directionality(textDirection: TextDirection.rtl,
                  child: Container(width: MediaQuery
                      .of(context)
                      .size
                      .width,
                    alignment: Alignment.centerRight,
                    margin: EdgeInsets.only(right: MediaQuery
                        .of(context)
                        .size
                        .width * 0.02),
                    child: ListTile(
                      title: DropdownButtonHideUnderline(
                          child: DropdownButton(dropdownColor: Colors.white,
                            hint: Text("اختر المحافظة",
                              style: TextStyle(color: Colors.blue),),
                            value: country
                            ,
                            items: countries.map((e) =>
                                DropdownMenuItem(child: Text(
                                  '$e', style: TextStyle(color: Colors.blue),),
                                  value: e,)).toList(),
                            onChanged: (_) {
                              if (_ != "اختر المحافظة") {
                                Provider.of<Notifires>(context,listen: false).getlat2(datalatlang1[countries.indexOf(_)]["id"], context);
                                country = _;
                                setState(() {});
                              }
                            },
                          )),
                    ),
                  ),
                ),),
              Container(padding: EdgeInsets.all(MediaQuery
                  .of(context)
                  .size
                  .width * 0.01), margin: EdgeInsets.only(top: 10
                  , right: MediaQuery
                      .of(context)
                      .size
                      .width * 0.08, left: MediaQuery
                      .of(context)
                      .size
                      .width * 0.08),
                decoration: BoxDecoration(
                    borderRadius: BorderRadius.circular(20),
                    color: Colors.white)
                , child: Directionality(textDirection: TextDirection.rtl,
                  child: Container(width: MediaQuery
                      .of(context)
                      .size
                      .width,
                    alignment: Alignment.centerRight,
                    margin: EdgeInsets.only(right: MediaQuery
                        .of(context)
                        .size
                        .width * 0.02),
                    child: ListTile(
                      title: DropdownButtonHideUnderline(
                          child: DropdownButton(dropdownColor: Colors.white,
                            hint: Text("اختر المنطقة",
                              style: TextStyle(color: Colors.blue),),
                            value: city
                            ,
                            items: citites.map((e) =>
                                DropdownMenuItem(child: Text(
                                  '$e', style: TextStyle(color: Colors.blue),),
                                  value: e,)).toList(),
                            onChanged: (_) {
                              city = _;
                              setState(() {});
                            },
                          )),
                    ),
                  ),
                ),),
              Container(padding: EdgeInsets.all(MediaQuery
                  .of(context)
                  .size
                  .width * 0.01),
                decoration: BoxDecoration(color: Colors.white,
                    border: Border.all(color: Colors.white),
                    borderRadius: BorderRadius.circular(20)),
                margin: EdgeInsets.only(top: 10, left: MediaQuery
                    .of(context)
                    .size
                    .width * 0.07, right: MediaQuery
                    .of(context)
                    .size
                    .width * 0.07,),
                child: Directionality(textDirection: TextDirection.rtl,
                  child: TextFormField(textInputAction: TextInputAction.send,
                    validator: maintainlogic.validatelocation,
                    style: TextStyle(color: Colors.blue, fontSize: MediaQuery
                        .of(context)
                        .size
                        .height * 0.02),
                    minLines: 2,
                    maxLines: 3,
                    controller: locationmaintain,
                    decoration: InputDecoration(border: InputBorder.none,
                        hintStyle: TextStyle(color: Colors.blue),
                        hintText: "اختر العنوان المناسب"),),),)
              , Container(padding: EdgeInsets.all(MediaQuery
                  .of(context)
                  .size
                  .width * 0.01), margin: EdgeInsets.only(top: 10
                  , right: MediaQuery
                      .of(context)
                      .size
                      .width * 0.08, left: MediaQuery
                      .of(context)
                      .size
                      .width * 0.08),
                decoration: BoxDecoration(
                    borderRadius: BorderRadius.circular(20),
                    color: Colors.white)
                , child: Directionality(textDirection: TextDirection.rtl,
                  child: Container(alignment: Alignment.centerRight,
                    margin: EdgeInsets.only(right: MediaQuery
                        .of(context)
                        .size
                        .width * 0.02),
                    child: ListTile(
                      title: DropdownButtonHideUnderline(
                          child: DropdownButton(dropdownColor: Colors.white
                            ,
                            hint: Text("اختر نوع الجهاز",
                              style: TextStyle(color: Colors.blue),),
                            value: type
                            ,
                            items: types.map((e) =>
                                DropdownMenuItem(child: Text(
                                  '$e', style: TextStyle(color: Colors.blue),),
                                  value: e,)).toList(),
                            onChanged: (_) {
                              if (_ != "اختر نوع الجهاز") {
                                type = _;
                                setState(() {});
                              }
                            },
                          )),
                    ),
                  ),
                ),),
              Container(padding: EdgeInsets.all(MediaQuery
                  .of(context)
                  .size
                  .width * 0.01),
                decoration: BoxDecoration(color: Colors.white,
                    border: Border.all(color: Colors.white),
                    borderRadius: BorderRadius.circular(20)),
                margin: EdgeInsets.only(top: 10, left: MediaQuery
                    .of(context)
                    .size
                    .width * 0.07, right: MediaQuery
                    .of(context)
                    .size
                    .width * 0.07,),
                child: Directionality(textDirection: TextDirection.rtl,
                  child: TextFormField(validator: maintainlogic.validatdesc,textInputAction: TextInputAction.send,
                    style: TextStyle(color: Colors.blue, fontSize: MediaQuery
                        .of(context)
                        .size
                        .height * 0.02),
                    controller: descmaintain,
                    minLines: 4,
                    maxLines: 6,
                    decoration: InputDecoration(border: InputBorder.none,
                        hintStyle: TextStyle(color: Colors.blue),
                        hintText: "اكتب الوصف المناسب لمشكلتك"),),),),
              Container(
                child: Container(padding: EdgeInsets.only(right: 10),
                  margin: EdgeInsets.only(top: 10
                      , right: MediaQuery
                          .of(context)
                          .size
                          .width * 0.08, left: MediaQuery
                          .of(context)
                          .size
                          .width * 0.08),
                  decoration: BoxDecoration(
                      borderRadius: BorderRadius.circular(20),
                      color: Colors.white)
                  ,
                  child: Center(
                    child: InkWell(onTap: () {
                      setState(() {
                        if (!dateable) {
                          dateable = true;
                        }
                        else {
                          dateable = false;
                        }
                      });
                    }, child: ListTile(leading: dateable ? InkWell(
                      child: Text("تم", style: TextStyle(color: Colors.blue),),
                      onTap: () {
                        setState(() {
                          dateable = false;
                        });
                      },) : Icon(Icons.arrow_drop_down),
                      title: Container(alignment: Alignment.centerRight,
                          child: datetime != null ? Text(datetime) : Text(
                              "الموعد المطلوب للصيانة")),
                      trailing: Icon(
                        Icons.date_range, color: Colors.blueAccent,),),),
                  ),),
              ),
              Container(
                  child: !dateable ? Container() : Container(width: MediaQuery
                      .of(context)
                      .size
                      .width,
                    child: CalendarDatePicker(firstDate: DateTime.now(),
                      lastDate: DateTime.now().add(Duration(days: 356)),
                      currentDate: DateTime.now(),
                      initialDate: DateTime.now(),
                      onDateChanged: (val) {
                        setState(() {
                          datetime = val.toString().substring(0, 10);
                        });
                      },),)), Container(
                child: Container(padding: EdgeInsets.only(right: 10),
                  margin: EdgeInsets.only(top:10
                      , right: MediaQuery
                          .of(context)
                          .size
                          .width * 0.08, left: MediaQuery
                          .of(context)
                          .size
                          .width * 0.08),
                  decoration: BoxDecoration(
                      borderRadius: BorderRadius.circular(20),
                      color: Colors.white)
                  ,
                  child: Center(
                    child: InkWell(onTap: () {
                      setState(() {
                        if (!dateable2) {
                          dateable2 = true;
                        }
                        else {
                          dateable2 = false;
                        }
                      });
                    }, child: ListTile(leading: dateable2 ? InkWell(
                      child: Text("تم", style: TextStyle(color: Colors.blue),),
                      onTap: () {
                        setState(() {
                          dateable2 = false;
                        });
                      },) : Icon(Icons.arrow_drop_down),
                      title: Container(alignment: Alignment.centerRight,
                          child: datetime2 != null ? Text(datetime2) : Text(
                              "اخر موعد للصيانة")),
                      trailing: Icon(
                        Icons.date_range, color: Colors.blueAccent,),),),
                  ),),
              ),
              Container(
                  child: !dateable2 ? Container() : Container(width: MediaQuery
                      .of(context)
                      .size
                      .width,
                    child: CalendarDatePicker(firstDate: DateTime.now(),
                      lastDate: DateTime.now().add(Duration(days: 356)),
                      currentDate: DateTime.now(),
                      initialDate: DateTime.now(),
                      onDateChanged: (val) {
                        setState(() {
                          datetime2 = val.toString().substring(0, 10);
                        });
                      },),))
            ],),),
            InkWell(onTap: () {
              maintainlogic.send(
                  locationmaintain.text,
                  descmaintain.text,
                  maintainKey,
                  country,
                  city,
                  type,
                  datetime.toString(),
                  datetime2.toString(),
                  typebackup,
                  datalatlang1,
                  datalatlang2);
            },
              child: Container(margin: EdgeInsets.only(top: MediaQuery
                  .of(context)
                  .size
                  .height * 0.1, bottom: MediaQuery
                  .of(context)
                  .size
                  .height * 0.04, left: MediaQuery
                  .of(context)
                  .size
                  .width * 0.25, right: MediaQuery
                  .of(context)
                  .size
                  .width * 0.25),
                  height: MediaQuery
                      .of(context)
                      .size
                      .height * 0.07,
                  decoration: BoxDecoration(color: Colors.blue,
                      borderRadius: BorderRadius.circular(10)),
                  child: Center(
                      child: Text("ارسال", style: TextStyle(
                          color: Colors.white, fontSize: MediaQuery
                          .of(context)
                          .size
                          .height * 0.02)))),
            ),
          ],),
        ),
      );
    }
    else{
      return Container();
    }
  }
  //الئهاب من صفحة معلومات الى صفحة الصيانة الدورية
  go(key , value,notav , devices , addressinfo , context , typeinfo)async{
    if(keyinfo.currentState.validate()){
      if(!notav) {
        if (value != "اختر نوع الجهاز") {
          var id;
          for(int g =0 ; g<devices.length ; g++){
            if(devices[g]["type"].toString().trim() ==value.toString()) {
              id = devices[g]["id"];
            }
          }
          var data = {
            "address": addressinfo.text,
            "id": id
          };
          dataofmaintain = data;
          //setState(() {});
          Provider.of<Notifires>(context,listen: false).getindex(tabController, "submain", 6, context);
           Provider.of<Notifires>(context,listen: false).getdatasubmaintain(context);
        }
        else {
          showDialog(context: context, builder: (context) {
            return AlertDialog(title: new Text("خطأ"),
                content: Directionality(textDirection: TextDirection.rtl,
                    child: new Text("يجب أن تختار نوع الجهاز")),
                actions: [
                  new ElevatedButton(onPressed: () {
                    Navigator.of(context).pop();
                  }, child: Text("ok")),
                ]);
          });
        }
      }
      else{
        var data = {
          "address": addressinfo.text,
          "devicename": valueinfo,
          "type": typeinfo.text
        };
        dataofmaintain = data;
         Provider.of<Notifires>(context,listen: false).getindex(tabController, "submain", 6, context);
         Provider.of<Notifires>(context,listen: false).getdatasubmaintain(context);
      }
    }
  }
  Widget submaintainwidget( ){
   // if(activenow =="submain") {
      return Container(child:
      ListView(children: [
        Container(height: MediaQuery
            .of(context)
            .size
            .height * 0.07, color: Colors.blue, child: Row(children: [
          Expanded(child: InkWell(onTap: () {
            Provider.of<Notifires>(context,listen: false).getindex(tabController, "infosub", 7, context);
          },
            child: Container(alignment: Alignment.centerLeft,
                child: IconButton(icon: Icon(Icons.arrow_back_ios,
                  size: MediaQuery
                      .of(context)
                      .size
                      .height * 0.04, color: Colors.white,)
                  ,)),
          )),
          Expanded(child: Container(margin: EdgeInsets.only(right: MediaQuery
              .of(context)
              .size
              .width * 0.05),
            alignment: Alignment.centerRight,
            child: Text("الصيانة الدورية", style: TextStyle(fontSize: MediaQuery
                .of(context)
                .size
                .height * 0.025, color: Colors.white),),))
        ],),),
        Container(margin: EdgeInsets.only(top: MediaQuery
            .of(context)
            .size
            .height * 0.05, right: MediaQuery
            .of(context)
            .size
            .width * 0.1),
          alignment: Alignment.centerRight,
          child: Text("اختر باقتك المناسبة ",
            style: TextStyle(color: Colors.blue, fontSize: MediaQuery
                .of(context)
                .size
                .height * 0.025),),),
        Container(width: MediaQuery
            .of(context)
            .size
            .width,
          height: MediaQuery
              .of(context)
              .size
              .height * 0.5,
          child: datasubmaintain.length == 0 ? Center(child: Text(
            "لا يوجد باقات الان", style: TextStyle(fontSize: MediaQuery
              .of(context)
              .size
              .height * 0.025, color: Colors.black54),),) : ListView.builder(
              itemCount: datasubmaintain.length, itemBuilder: (context, i) {
            return Directionality(textDirection: TextDirection.rtl,
              child: Container(child: Row(children: [ Expanded(
                  flex: 4, child: Container(padding: EdgeInsets.all(MediaQuery
                  .of(context)
                  .size
                  .width * 0.01),
                  margin: EdgeInsets.all(MediaQuery
                      .of(context)
                      .size
                      .width * 0.05),
                  decoration: BoxDecoration(color: Colors.blueAccent,
                      borderRadius: BorderRadius.circular(20)),
                  child: Column(children: [
                    Container(margin: EdgeInsets.all(MediaQuery
                        .of(context)
                        .size
                        .width * 0.01),
                      alignment: Alignment.centerRight,
                      child: Text(datasubmaintain[i]["name"], style: TextStyle(
                          color: Colors.white, fontSize: MediaQuery
                          .of(context)
                          .size
                          .height * 0.02),),)
                    , Container(margin: EdgeInsets.all(MediaQuery
                        .of(context)
                        .size
                        .width * 0.01),
                      alignment: Alignment.centerRight,
                      child: Text(datasubmaintain[i]["desc"], style: TextStyle(
                          color: Colors.white, fontSize: MediaQuery
                          .of(context)
                          .size
                          .height * 0.02),),)
                  ],)))
                , Expanded(child: Checkbox(onChanged: (val) {
                  Provider.of<Notifires>(context,listen: false).check(val,i);
                }, value: checkboxessub[i],))
              ])),
            );
          }),),
        InkWell(onTap: () {
          submaintainlogic.select(checkboxessub, datasubmaintain, dataofmaintain);
        },
          child: Container(margin: EdgeInsets.only(top: MediaQuery
              .of(context)
              .size
              .height * 0.1, left: MediaQuery
              .of(context)
              .size
              .width * 0.25, right: MediaQuery
              .of(context)
              .size
              .width * 0.25),
              height: MediaQuery
                  .of(context)
                  .size
                  .height * 0.07,
              decoration: BoxDecoration(color: Colors.blueAccent,
                  borderRadius: BorderRadius.circular(10)),
              child: Center(child:
              Text("ارسال",
                  style: TextStyle(color: Colors.white, fontSize: MediaQuery
                      .of(context)
                      .size
                      .height * 0.025)))),
        ),
      ],),);
    //}
    //else{
     // return Container();
    //}
  }
}
