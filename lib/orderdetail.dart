import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_countdown_timer/current_remaining_time.dart';
import 'package:flutter_countdown_timer/flutter_countdown_timer.dart';
import 'package:teste/logic/contactlogic.dart';
class Orderdetail1 extends StatefulWidget{
  var data;
  Orderdetail1({this.data});
  @override
  State<StatefulWidget> createState() {
    // TODO: implement createState
    return StateOrderdetail(data: data);
  }
}
class StateOrderdetail extends State<Orderdetail1>{
  var data;
  StateOrderdetail({this.data});
  //Contactlogic contactlogic;
  int endtime;
  @override
  void initState() {
    print(data);
    if (data["details"]["end_date"].toString() != "null") {
      endtime = DateTime
          .parse(data["details"]["end_date"].toString()
      )
          .millisecondsSinceEpoch + 1000 * 30;
    }
    //contactlogic = new Contactlogic(context);
    // TODO: implement initState
    super.initState();
  }
  @override
  Widget build(BuildContext context) {
    // TODO: implement build
    return Scaffold(body: Container(color: Colors.white60,child:data==null? Center(child: CircularProgressIndicator(),): ListView(children: [
      Container(height: MediaQuery.of(context).size.height*0.07,color: Colors.blue,child: Row(children: [
        Expanded(child: InkWell(onTap: (){
          Navigator.of(context).pop();},
          child: Container(alignment: Alignment.centerLeft,margin: EdgeInsets.only(left: MediaQuery.of(context).size.width*0.025),child: Icon( Icons.arrow_back_ios,size:MediaQuery.of(context).size.height * 0.04 ,color: Colors.white,)
          ),
        )),
        Expanded(child: Container(margin: EdgeInsets.only(right: MediaQuery.of(context).size.width*0.03) ,alignment: Alignment.centerRight
          ,child: Text("تفاصيل الطلب",style:TextStyle(fontSize: MediaQuery.of(context).size.height*0.02,color: Colors.white),),))],),),
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
            ,right:MediaQuery.of(context).size.width*0.07 ),child: Text(data["details"]["price"].toString(),style: TextStyle(fontSize: MediaQuery.of(context).size.height*0.025),),),
      )),
      Container(margin: EdgeInsets.only(left: MediaQuery.of(context).size.width*0.07
          ,right:MediaQuery.of(context).size.width*0.07), child: Directionality(textDirection: TextDirection.rtl,child: Text("سعر العرض بعد الخصم :",style: TextStyle(fontSize: MediaQuery.of(context).size.height*0.025,color: Colors.blue),)),),
      Directionality(textDirection: TextDirection.rtl,child: SingleChildScrollView(
        child: Container(margin: EdgeInsets.only(left: MediaQuery.of(context).size.width*0.07
            ,right:MediaQuery.of(context).size.width*0.07 ),child: Text(data["details"]["price_discount"].toString(),style: TextStyle(fontSize: MediaQuery.of(context).size.height*0.025),),),
      )),
      Container(margin: EdgeInsets.only(left: MediaQuery.of(context).size.width*0.07
          ,right:MediaQuery.of(context).size.width*0.07), child: Directionality(textDirection: TextDirection.rtl,child: Text("الوصف :",style: TextStyle(fontSize: MediaQuery.of(context).size.height*0.025,color: Colors.blue),)),),
      Directionality(textDirection: TextDirection.rtl,child: SingleChildScrollView(
        child: Container(height: MediaQuery.of(context).size.height*0.2 ,margin: EdgeInsets.only(left: MediaQuery.of(context).size.width*0.07
            ,right:MediaQuery.of(context).size.width*0.07 ),child: Text(data["details"]["desc"],style: TextStyle(fontSize: MediaQuery.of(context).size.height*0.025),),),
      )),
      Container(
        child:data["details"]["image"]!=null? Container( margin: EdgeInsets.only(left: MediaQuery.of(context).size.width*0.07,bottom: 10
            ,right:MediaQuery.of(context).size.width*0.07), child: Directionality(textDirection: TextDirection.rtl,child: Text("صورة العرض :",style: TextStyle(fontSize: MediaQuery.of(context).size.height*0.025,color: Colors.blue),)),):Container(),
      ),
      Container(decoration: BoxDecoration(border: Border.all(color: Colors.blue),borderRadius: BorderRadius.circular(25)), margin: EdgeInsets.only(left: 50,right: 50,bottom: 50),height: MediaQuery.of(context).size.height*0.2,width: MediaQuery.of(context).size.width,child:data["details"]["image"]!=null? FadeInImage( placeholder: AssetImage("comp/logo.png"),image: NetworkImage(data["details"]["image"]),fit: BoxFit.fill,):Container(),)
    ],),),);
  }
}