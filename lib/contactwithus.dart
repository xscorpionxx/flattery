import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:teste/logic/contactlogic.dart';

import 'logic/mainlogic.dart';

class Contact extends StatefulWidget{
  @override
  State<StatefulWidget> createState() {
    // TODO: implement createState
    return Statecontact();
  }
}
class Statecontact extends State<Contact>{
  Contactlogic contactlogic;
  var data ;
  @override
  void initState() {
    getdata();
    super.initState();
  }
  getdata()async{
      Provider.of<Notifires>(context,listen: false).getcontact(context);
  }
  @override
  Widget build(BuildContext context) {
    data = Provider.of<Notifires>(context).contact;
    // TODO: implement build
    return Scaffold(body: Container(color: Colors.white,child:data ==null?Center(child: CircularProgressIndicator(),): ListView(children: [
      Container(height: MediaQuery.of(context).size.height*0.07,color: Colors.blue,child: Row(children: [
         Expanded(child: InkWell( onTap: (){
      Navigator.of(context).pop();
    },child: Container(alignment: Alignment.centerLeft,child: IconButton(icon: Icon(Icons.arrow_back_ios,size:MediaQuery.of(context).size.height * 0.04 ,color: Colors.white,))))),
        Expanded(child: Container(alignment: Alignment.centerRight,child: Text("تواصيل معنا",style:TextStyle(fontSize: MediaQuery.of(context).size.height*0.02,color: Colors.white),),))],),),
      Container(margin: EdgeInsets.only(top: MediaQuery.of(context).size.height * 0.02),width: MediaQuery.of(context).size.height * 0.2,height: MediaQuery.of(context).size.height * 0.2,
        child: Image(image: AssetImage("comp/logo.png"),),),
      Container(margin: EdgeInsets.only(top: MediaQuery.of(context).size.height*0.03),height: MediaQuery.of(context).size.height * 0.07,child: Row(children: [Expanded(flex: 2,child:Container(alignment: Alignment.centerRight,child: Text(data["app_phone"],style: TextStyle(color: Colors.black,fontSize: MediaQuery.of(context).size.height* 0.02),),) ),
        Expanded(child:Container(width:MediaQuery.of(context).size.height*0.04 ,height: MediaQuery.of(context).size.height*0.04,child: InkWell( onTap: (){
          contactlogic.gophone(data["app_phone"]);
        },child: Image(image: AssetImage("comp/phone.png"),fit: BoxFit.fill,)) ,alignment: Alignment.centerRight,margin: EdgeInsets.only(right: MediaQuery.of(context).size.width*0.1),) )],),),
      Container(margin: EdgeInsets.only(top: MediaQuery.of(context).size.height*0.01),height: MediaQuery.of(context).size.height * 0.07,child: Row(children: [Expanded(flex: 2,child:Container(alignment: Alignment.centerRight,child: Text(data["app_whatsapp"],style: TextStyle(color: Colors.black,fontSize: MediaQuery.of(context).size.height* 0.02),),) ),
        Expanded(child:Container(width:MediaQuery.of(context).size.height*0.05 ,height: MediaQuery.of(context).size.height*0.05,child:InkWell(onTap: (){
          contactlogic.gowhatsapp(data["app_whatsapp"]);
        },child: Image(image: AssetImage("comp/whats.png"),fit: BoxFit.fill,)) ,alignment: Alignment.centerRight,margin: EdgeInsets.only(right: MediaQuery.of(context).size.width*0.1),) )],),),
      Container(margin: EdgeInsets.only(top: MediaQuery.of(context).size.height*0.01),height: MediaQuery.of(context).size.height * 0.07,child: Row(children: [Expanded(flex: 2,child:Container(alignment: Alignment.centerRight,child: Text(data["app_facebook"],style: TextStyle(color: Colors.black,fontSize: MediaQuery.of(context).size.height* 0.02),),) ),
        Expanded(child:Container(width:MediaQuery.of(context).size.height*0.05 ,height: MediaQuery.of(context).size.height*0.05,child:InkWell(onTap: (){
          contactlogic.gofacebook(data["app_facebook"]);
        },child: Image(image: AssetImage("comp/facebook.png"),fit: BoxFit.fill,)) ,alignment: Alignment.centerRight,margin: EdgeInsets.only(right: MediaQuery.of(context).size.width*0.1),) )],),),
      Container(margin: EdgeInsets.only(top: MediaQuery.of(context).size.height*0.01),height: MediaQuery.of(context).size.height * 0.07,child: Row(children: [Expanded(flex: 2,child:Container(alignment: Alignment.centerRight,child: Text(data["app_insta"],style: TextStyle(color: Colors.black,fontSize: MediaQuery.of(context).size.height* 0.02),),) ),
        Expanded(child:Container(width:MediaQuery.of(context).size.height*0.05 ,height: MediaQuery.of(context).size.height*0.05,child:InkWell( onTap: (){
          contactlogic.goinsta(data["app_insta"]);
        },child: Image(image: AssetImage("comp/insta.png"),fit: BoxFit.fill,)) ,alignment: Alignment.centerRight,margin: EdgeInsets.only(right: MediaQuery.of(context).size.width*0.1),) )],),),
      Container(margin: EdgeInsets.only(top: MediaQuery.of(context).size.height*0.01),height: MediaQuery.of(context).size.height * 0.07,child: Row(children: [Expanded(flex: 2,child:Container(alignment: Alignment.centerRight,child: Text(data["app_linkedin"],style: TextStyle(color: Colors.black,fontSize: MediaQuery.of(context).size.height* 0.02),),) ),
        Expanded(child:Container(width:MediaQuery.of(context).size.height*0.05 ,height: MediaQuery.of(context).size.height*0.05,child:InkWell(onTap: (){
          contactlogic.golink(data["app_linkedin"]);
        },child: Image(image: AssetImage("comp/in.png"),fit: BoxFit.fill,)) ,alignment: Alignment.centerRight,margin: EdgeInsets.only(right: MediaQuery.of(context).size.width*0.1),) )],),),
      Container(margin: EdgeInsets.only(left:MediaQuery.of(context).size.width* 0.1,right: MediaQuery.of(context).size.width* 0.1 ,top: MediaQuery.of(context).size.height*0.25),height: 10,color: Colors.blue,)
    ],),),);
  }
}