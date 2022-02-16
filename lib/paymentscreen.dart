import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:teste/logic/paymentlogic.dart';

class Payment extends StatefulWidget{
  List data1 =[];
  List data2 =[];
  var totalprice;
  var datapay;

  Payment({this.data1,this.data2,this.totalprice ,this.datapay});
  @override
  State<StatefulWidget> createState() {
    // TODO: implement createState
    return Statepay(data1: data1 , data2: data2,totalprice: totalprice , datapay: datapay);
  }
}
class Statepay extends State<Payment>{
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
  Statepay({this.data1,this.data2,this.totalprice,this.datapay});
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
        },child: Container(alignment: Alignment.centerLeft,child: Icon(Icons.arrow_back_ios,size:MediaQuery.of(context).size.height * 0.03 ,color: Colors.white,)))),
          Expanded(child: Container(margin: EdgeInsets.only(right: MediaQuery.of(context).size.width*0.05),alignment: Alignment.centerRight,child: Text("طريقة الدفع",style:TextStyle(fontSize: MediaQuery.of(context).size.height*0.02,color: Colors.white),),))],),),
        Container(margin: EdgeInsets.only(top: MediaQuery.of(context).size.height * 0.05),alignment: Alignment.center,child: Text("الاجمالي",style: TextStyle(fontSize:MediaQuery.of(context).size.height * 0.025 ),),),
        Container(margin: EdgeInsets.only(top: MediaQuery.of(context).size.height * 0.02),alignment: Alignment.center,child: Text("$totalprice  "+"جنيه  ",style: TextStyle(fontSize:MediaQuery.of(context).size.height * 0.04 ),),),
         Container(child: InkWell(onTap: (){setState(() {
           sectionone =true ; sectiontow = false;
         });},child: ListTile(trailing: Icon(Icons.arrow_left_sharp,color: Colors.blueAccent,size: MediaQuery.of(context).size.height*0.06,),title: Directionality(textDirection: TextDirection.rtl,child: Text("الدفع بالفيزا")),)),),
       Directionality(textDirection: TextDirection.rtl,
           child:sectionone == false ? Container():Container(padding: EdgeInsets.only(right: MediaQuery.of(context).size.width*0.01),margin: EdgeInsets.only(right: MediaQuery.of(context).size.width*0.05,left:MediaQuery.of(context).size.width*0.05 ),decoration: BoxDecoration(color: Colors.white,border: Border.all(color: Colors.black))
           ,child: TextFormField(controller: visacardnum,validator: paymentlogic.validatecard,style: TextStyle(fontSize: MediaQuery.of(context).size.height* 0.015),keyboardType: TextInputType.number,decoration: InputDecoration(hintText: "ادخل رقم الكارت المكون من 14 رقم",suffixIcon: Icon(Icons.account_balance_wallet_sharp,size:  MediaQuery.of(context).size.height* 0.03,),border: InputBorder.none),),),
       ),
        Directionality(textDirection: TextDirection.rtl,
          child:sectionone == false ? Container(): Container(padding: EdgeInsets.only(right: MediaQuery.of(context).size.width*0.01),margin: EdgeInsets.only(top: MediaQuery.of(context).size.height*0.05,right: MediaQuery.of(context).size.width*0.05,left:MediaQuery.of(context).size.width*0.05 ),decoration: BoxDecoration(color: Colors.white,border: Border.all(color: Colors.black))
            ,child: TextFormField(controller: visacardpassword,validator: paymentlogic.validatepassword,style: TextStyle(fontSize: MediaQuery.of(context).size.height* 0.015),obscureText: true,decoration: InputDecoration(hintText: "أدخل الرقم السري",suffixIcon: Icon(Icons.lock,size:  MediaQuery.of(context).size.height* 0.03,),border: InputBorder.none),),),
        ),Container(child: InkWell(onTap: (){setState(() {
          sectionone =false ; sectiontow = true;
        });},child: ListTile(trailing: Icon(Icons.arrow_left_sharp,color: Colors.blueAccent,size: MediaQuery.of(context).size.height*0.06,),title: Directionality(textDirection: TextDirection.rtl,child: Text("الدفع عن طريق فودافون كاش")),)),),
        Directionality(textDirection: TextDirection.rtl,
          child:sectiontow == false ? Container(): Container(padding: EdgeInsets.only(right: MediaQuery.of(context).size.width*0.01),margin: EdgeInsets.only(right: MediaQuery.of(context).size.width*0.05,left:MediaQuery.of(context).size.width*0.05 ),decoration: BoxDecoration(color: Colors.white,border: Border.all(color: Colors.black))
            ,child: TextFormField(controller: phonenum,validator: paymentlogic.validateMobile,style: TextStyle(fontSize: MediaQuery.of(context).size.height* 0.015),keyboardType: TextInputType.phone,decoration: InputDecoration(hintText: "رقم الهاتف",suffixIcon: Icon(Icons.phone,size:  MediaQuery.of(context).size.height* 0.03,),border: InputBorder.none),),),
        ),
        Directionality(textDirection: TextDirection.rtl,
          child:sectiontow == false ? Container(): Container(padding: EdgeInsets.only(right: MediaQuery.of(context).size.width*0.01),margin: EdgeInsets.only(top: MediaQuery.of(context).size.height*0.05,right: MediaQuery.of(context).size.width*0.05,left:MediaQuery.of(context).size.width*0.05 ),decoration: BoxDecoration(color: Colors.white,border: Border.all(color: Colors.black))
            ,child: TextFormField(controller: phonepassword,validator: paymentlogic.validatepassword,style: TextStyle(fontSize: MediaQuery.of(context).size.height* 0.015),obscureText: true,decoration: InputDecoration(hintText: "أدخل الرقم السري",suffixIcon: Icon(Icons.lock,size:  MediaQuery.of(context).size.height* 0.03,),border: InputBorder.none),),),
        )
        ,InkWell(onTap: (){
          paymentlogic.pay(key,sectionone,sectiontow,visacardnum.text,visacardpassword.text,phonenum.text,phonepassword.text,totalprice,data1,datapay);
        },
          child: Container(margin: EdgeInsets.only(top:MediaQuery.of(context).size.height * 0.07 ,left: MediaQuery.of(context).size.width * 0.25,right:MediaQuery.of(context).size.width * 0.25 ),height: MediaQuery.of(context).size.height * 0.07,decoration: BoxDecoration(color: Colors.blue,borderRadius: BorderRadius.circular(10)),child:Center(
              child: Text("دفع",style: TextStyle(color: Colors.white,fontSize: MediaQuery.of(context).size.height* 0.02)))),
        ),
        Container(child:sectionone||sectiontow?Container(width: MediaQuery.of(context).size.width,margin: EdgeInsets.only(right:MediaQuery.of(context).size.width*0.1,left: MediaQuery.of(context).size.width*0.1 ,top: MediaQuery.of(context).size.height*0.27),height: 10,color: Colors.blue,):
        Container(width: MediaQuery.of(context).size.width,margin: EdgeInsets.only(right:MediaQuery.of(context).size.width*0.1,left: MediaQuery.of(context).size.width*0.1 ,top: MediaQuery.of(context).size.height*0.42),height: 10,color: Colors.blue,))
      ],),
    ),);
  }
}