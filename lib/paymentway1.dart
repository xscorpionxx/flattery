import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:teste/logic/paymentlogic.dart';
import 'package:teste/paymentscreen.dart';

class Paymentway1 extends StatefulWidget{
  List data1 =[];
  List data2 =[];
  var totalprice;
  var datapay;

  Paymentway1({this.data1,this.data2,this.totalprice ,this.datapay});
  @override
  State<StatefulWidget> createState() {
    // TODO: implement createState
    return Statepayway(data1: data1 , data2: data2,totalprice: totalprice , datapay: datapay);
  }
}
class Statepayway extends State<Paymentway1>{
  Paymentlogic paymentlogic ;
  TextEditingController visacardnum;
  TextEditingController visacardpassword;
  TextEditingController phonenum;
  TextEditingController phonepassword;
  GlobalKey<FormState> key;
  List data1 =[];
  List data2 =[];
  var totalprice;
  var datapay;
  Statepayway({this.data1,this.data2,this.totalprice,this.datapay});
  var sectionone = false;
  var sectiontow = false;
  @override
  void initState() {
    print("datapay");
    print(datapay);
    paymentlogic = new Paymentlogic(context);
    visacardnum = new TextEditingController();
    visacardpassword = new TextEditingController();
    phonenum = new TextEditingController();
    phonepassword = new TextEditingController();
    key = new GlobalKey();
    super.initState();
  }
  @override
  Widget build(BuildContext context) {
    // TODO: implement build
    return Scaffold(body: Form(key: key,
      child: ListView(children: [
        Container(height: MediaQuery.of(context).size.height*0.07,color: Colors.blue,child: Row(children: [
          Expanded(child: InkWell(onTap: (){
            Navigator.of(context).pop();
          },child: Container(margin: EdgeInsets.only(left: 10) ,alignment: Alignment.centerLeft,child:  Icon(Icons.arrow_back_ios,size:MediaQuery.of(context).size.height * 0.03 ,color: Colors.white,)))),
          Expanded(child: Container(margin: EdgeInsets.only(right: MediaQuery.of(context).size.width*0.05),alignment: Alignment.centerRight,child: Text("طريقة الدفع",style:TextStyle(fontSize: MediaQuery.of(context).size.height*0.02,color: Colors.white),),))],),),
        Container(margin: EdgeInsets.only(top: MediaQuery.of(context).size.height * 0.05),alignment: Alignment.center,child: Text("الاجمالي",style: TextStyle(fontSize:MediaQuery.of(context).size.height * 0.025 ),),),
        Container(margin: EdgeInsets.only(top: MediaQuery.of(context).size.height * 0.02),alignment: Alignment.center,child: Text("$totalprice  "+"جنيه  ",style: TextStyle(fontSize:MediaQuery.of(context).size.height * 0.04 ),),),
        Container(margin: EdgeInsets.only(top: MediaQuery.of(context).size.height * 0.1),child: InkWell(onTap: (){setState(() {
          Navigator.of(context).push(MaterialPageRoute(builder: (context){
            return Payment(data1: data1, totalprice: totalprice,datapay: datapay,);
          }));
        });},child: ListTile(trailing: Icon(Icons.arrow_left_sharp,color: Colors.blueAccent,size: MediaQuery.of(context).size.height*0.06,),title: Directionality(textDirection: TextDirection.rtl,child: Text("الدفع فوري")),)),),
        Container(child: InkWell(onTap: (){setState(() {
          paymentlogic.makeorder(totalprice, data1, datapay);
        });},child: ListTile(trailing: Icon(Icons.arrow_left_sharp,color: Colors.blueAccent,size: MediaQuery.of(context).size.height*0.06,),title: Directionality(textDirection: TextDirection.rtl,child: Text("الدفع عند الاستلام")),)),)
      ],),
    ),);
  }
}