import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_countdown_timer/current_remaining_time.dart';
import 'package:flutter_countdown_timer/flutter_countdown_timer.dart';
import 'package:teste/logic/contactlogic.dart';
class Orderdetail2 extends StatefulWidget{
  var data;
  Orderdetail2({this.data});
  @override
  State<StatefulWidget> createState() {
    // TODO: implement createState
    return StateOrderdetail(data: data);
  }
}
class StateOrderdetail extends State<Orderdetail2>{
  var data;
  StateOrderdetail({this.data});
  //Contactlogic contactlogic;
  int endtime;
  @override
  void initState() {
    print(data);
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
       Container(height: MediaQuery
          .of(context)
          .size
          .height * 0.8, margin: EdgeInsets.only(top: 25),
          child: GridView.builder(scrollDirection: Axis.vertical,
            gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
                crossAxisCount: 2,
                childAspectRatio:  (MediaQuery
                    .of(context)
                    .size
                    .width * 1.2 / MediaQuery
                    .of(context)
                    .size
                    .height * 1.4)),
            itemCount: data.length,
            itemBuilder: (context, i) {
              return InkWell(onTap: () async {
              //  Provider.of<Notifires>(context,listen: false).getdatas(data[i]["id"], context, tabController);
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
                            fit: BoxFit.fill,)),)),
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
                                    fontSize: MediaQuery
                                        .of(context)
                                        .size
                                        .height * 0.015,
                                    color: Colors.blue),))),),
                  ],),
                ),
              );
            },
          )
      ), ],),),);
  }
}