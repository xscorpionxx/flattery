import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:teste/logic/contactlogic.dart';
import 'package:teste/logic/mainlogic.dart';

class Whous extends StatefulWidget{
  @override
  State<StatefulWidget> createState() {
    // TODO: implement createState
    return Stateus();
  }
}
class Stateus extends State<Whous>{
  var data;
  getdata(){
    Provider.of<Notifires>(context,listen: false).getwho_us(context);
  }
  @override
  void initState() {
    getdata();
    // TODO: implement initState
    super.initState();
  }
  @override
  Widget build(BuildContext context) {
    data = Provider.of<Notifires>(context).who_us;
    // TODO: implement build
    return Scaffold(body: Container(color: Colors.white60,child:data==null? Center(child: CircularProgressIndicator(),): ListView(children: [
      Container(height: MediaQuery.of(context).size.height*0.07,color: Colors.blue,child: Row(children: [
          Expanded(child: InkWell(onTap: (){
            Navigator.of(context).pop();
          },
            child: Container(alignment: Alignment.centerLeft,child: IconButton(icon: Icon(Icons.arrow_back_ios,size:MediaQuery.of(context).size.height * 0.04 ,color: Colors.white,)
            )),
          ),
        ),
        Expanded(child: Container(margin: EdgeInsets.only(right: MediaQuery.of(context).size.width*0.03) ,alignment: Alignment.centerRight,child: Text("من نحن",style:TextStyle(fontSize: MediaQuery.of(context).size.height*0.02,color: Colors.white),),))],),),
      Directionality(textDirection: TextDirection.rtl,child: Container(margin: EdgeInsets.only(top: MediaQuery.of(context).size.width*0.2,left: MediaQuery.of(context).size.width*0.07
          ,right:MediaQuery.of(context).size.width*0.07 ),child: Text(data,style: TextStyle(fontSize: MediaQuery.of(context).size.height*0.025),),))
    ],),),);
  }
}