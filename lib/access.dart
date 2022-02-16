import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_restart/flutter_restart.dart';
import 'package:provider/provider.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:teste/homescreen.dart';
import 'package:teste/logic/mainlogic.dart';
import 'package:teste/logic/shoppinglogic.dart';

class Access extends StatefulWidget{
  var code;
  Access({this.code});
  @override
  State<StatefulWidget> createState() {
    // TODO: implement createState
    return StateAcess(code: code);
  }
}
class  StateAcess extends State<Access>{
  var code ;
  StateAcess({this.code});
  Shoppinglogic shoppinglogic;
  @override
  void initState() {
    shoppinglogic = new Shoppinglogic(context);
   shoppinglogic.deleteall();
    super.initState();
  }
  @override
  Widget build(BuildContext context) {
    // TODO: implement build
    return Scaffold(body:Column(children: [
      Container(child: Center(child: Icon(Icons.check,size: MediaQuery.of(context).size.height*0.1,color: Colors.white,)),margin: EdgeInsets.only(bottom:MediaQuery.of(context).size.height*0.05 ,top: MediaQuery.of(context).size.height*0.2) ,width: MediaQuery.of(context).size.height*0.2,height:MediaQuery.of(context).size.height*0.2 ,decoration: BoxDecoration(
        color: Colors.blue, borderRadius: BorderRadius.circular(100)
      ),),
      Directionality(textDirection: TextDirection.rtl ,child: Container(child:Center(child: Text("اكتمل طلبك بنجاح",style: TextStyle(fontSize: MediaQuery.of(context).size.height*0.025,color: Colors.blue),)),)),
      Directionality(textDirection: TextDirection.rtl ,child: Container(child:Center(child: Text("رقم الطلب"+code.toString(),style: TextStyle(fontSize: MediaQuery.of(context).size.height*0.025,color: Colors.blue),)),)),
        Container(margin: EdgeInsets.only(bottom:MediaQuery.of(context).size.height*0.05 ,top: MediaQuery.of(context).size.height*0.09) ,child: Center(child: InkWell(onTap: (){
        Provider.of<Notifires>(context,listen: false).sethome(context);
      Navigator.of(context).popUntil((route) => route.isFirst);
      Navigator.of(context).pushReplacement(MaterialPageRoute(builder: (context){
        return Mainpage();
      }));
    },child: Container(color: Colors.blue,child: Text("العودة للصفحة الرئيسية",style: TextStyle(fontSize: MediaQuery.of(context).size.height*0.02,color: Colors.white))))),)

    ],) ,);
  }
}