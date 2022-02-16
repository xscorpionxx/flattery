import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:teste/logic/contactlogic.dart';
class Detailoffer extends StatefulWidget{
  var data;
  Detailoffer({this.data});
  @override
  State<StatefulWidget> createState() {
    // TODO: implement createState
    return StateDetailoffer(data: data);
  }
}
class StateDetailoffer extends State<Detailoffer>{
  var data;
  StateDetailoffer({this.data});
  //Contactlogic contactlogic;
  @override
  void initState() {
    print(data);
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
    return Scaffold(body: Container(color: Colors.white60,child:data==null? Center(child: CircularProgressIndicator(),): ListView(children: [
      Container(height: MediaQuery.of(context).size.height*0.07,color: Colors.blue,child: Row(children: [
        Expanded(child: InkWell(onTap: (){
          Navigator.of(context).pop();},
          child: Container(alignment: Alignment.centerLeft,margin: EdgeInsets.only(left: MediaQuery.of(context).size.width*0.025),child: Icon( Icons.arrow_back_ios,size:MediaQuery.of(context).size.height * 0.04 ,color: Colors.white,)
          ),
          )),
          Expanded(child: Container(margin: EdgeInsets.only(right: MediaQuery.of(context).size.width*0.03) ,alignment: Alignment.centerRight
          ,child: Text("تفاصيل العرض",style:TextStyle(fontSize: MediaQuery.of(context).size.height*0.02,color: Colors.white),),))],),),
      Container(margin: EdgeInsets.only(top: MediaQuery.of(context).size.height*0.12,left: MediaQuery.of(context).size.width*0.07
          ,right:MediaQuery.of(context).size.width*0.07), child: SingleChildScrollView(child: Directionality(textDirection: TextDirection.rtl,child: Text(data["name"],style: TextStyle(fontSize: MediaQuery.of(context).size.height*0.025),))),),
      Container(margin: EdgeInsets.only(left: MediaQuery.of(context).size.width*0.07
          ,right:MediaQuery.of(context).size.width*0.07), child: Directionality(textDirection: TextDirection.rtl,child: Text("الوصف :",style: TextStyle(fontSize: MediaQuery.of(context).size.height*0.025,color: Colors.blue),)),),
      Directionality(textDirection: TextDirection.rtl,child: SingleChildScrollView(
        child: Container(height: MediaQuery.of(context).size.height*0.4 ,margin: EdgeInsets.only(left: MediaQuery.of(context).size.width*0.07
            ,right:MediaQuery.of(context).size.width*0.07 ),child: Text(data["desc"],style: TextStyle(fontSize: MediaQuery.of(context).size.height*0.025),),),
      )),
      Container(child: Divider(thickness: 1.2,),margin: EdgeInsets.only(left: MediaQuery.of(context).size.width*0.1,right:MediaQuery.of(context).size.width*0.1 ),),
      Container(child: Text("تواصل معنا",style: TextStyle(color: Colors.lightBlue),),margin: EdgeInsets.only(right: MediaQuery.of(context).size.width*0.1),alignment: Alignment.centerRight,)
      ,Container(margin: EdgeInsets.only(top: MediaQuery.of(context).size.height*0.03),height: MediaQuery.of(context).size.height * 0.07,child: Row(children: [Expanded(flex: 2,child:Container(alignment: Alignment.centerRight,child: Text(data["phone"],style: TextStyle(color: Colors.black,fontSize: MediaQuery.of(context).size.height* 0.02),),) ),
    Expanded(child:Container(width:MediaQuery.of(context).size.height*0.05 ,height: MediaQuery.of(context).size.height*0.05,child: Image(image: AssetImage("comp/phone.png"),fit: BoxFit.fill,) ,alignment: Alignment.centerRight,margin: EdgeInsets.only(right: MediaQuery.of(context).size.width*0.1),) )],),),
    Container(margin: EdgeInsets.only(top: MediaQuery.of(context).size.height*0.01),height: MediaQuery.of(context).size.height * 0.07,child: Row(children: [Expanded(flex: 2,child:Container(alignment: Alignment.centerRight,child: Text(data["whatsapp"],style: TextStyle(color: Colors.black,fontSize: MediaQuery.of(context).size.height* 0.02),),) ),
    Expanded(child:Container(width:MediaQuery.of(context).size.height*0.05 ,height: MediaQuery.of(context).size.height*0.05,child:Image(image: AssetImage("comp/whats.png"),fit: BoxFit.fill,) ,alignment: Alignment.centerRight,margin: EdgeInsets.only(right: MediaQuery.of(context).size.width*0.1),) )],),),
    ],),),);
  }
}