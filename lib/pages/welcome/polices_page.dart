import 'package:coupons/pages/UIHelper.dart';
import 'package:coupons/pages/widgets/back_button_widget.dart';
import 'package:flutter/material.dart';

class PoliciesPage extends StatelessWidget{
  
  double height;
  double width;

  String title;
  String content;

  PoliciesPage.privacy(){
    title = mLocal.privacy_policy;
    content = mLocal.privacy_txt;
  }

  PoliciesPage.terms(){
    title = mLocal.terms_of_use;
    content = mLocal.terms_txt;
  }

  @override
  Widget build(BuildContext context) {

    height = MediaQuery.of(context).size.height - MediaQuery.of(context).padding.top- MediaQuery.of(context).padding.bottom;
    width = MediaQuery.of(context).size.width;

     ScrollController _controller = new ScrollController();

    return Scaffold(

      body: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        mainAxisAlignment: MainAxisAlignment.start,
        mainAxisSize: MainAxisSize.max,
        children: <Widget>[
        
        SizedBox(height: 0.05*height,),

        Container(
          width: width,
          height: 0.055*height,
          padding: EdgeInsets.only(left: 0.02*width),
          alignment: Alignment.centerLeft,
          child: MyBackButton(),
        ),

        SizedBox(height: 0.06*height,),

        Container(
          width: width,
          alignment: Alignment.center,
          child: Material(
          elevation: 4,
          shape:RoundedRectangleBorder(borderRadius:BorderRadius.circular(22.0) ),
          clipBehavior: Clip.antiAlias,
          child: Image.asset('lib/assets/img/logo.png',
                              width: 0.28*width,
                              height: 0.28*width,
                              fit: BoxFit.fill,
                            ),
        ),
        ),

        Container(
          width: width,
          alignment: Alignment.center,
          child: Text(title,
              style: TextStyle(
                      color: Colors.black,
                      fontSize: 0.07*width,
                      fontFamily: fontBold
              ),
            ),
        ),

        SizedBox(height: 0.012*height,),
        
        Container(
        height: 0.65*height,
        child: ListView(
          scrollDirection: Axis.vertical,
          shrinkWrap: true,
          physics: const AlwaysScrollableScrollPhysics(),
          primary: true,
          padding: EdgeInsets.symmetric(horizontal: 0.015*width),
          children: <Widget>[
            
            Text(content,
              textAlign: TextAlign.center,
              style: TextStyle(
                      color: Colors.black,
                      fontSize: 0.045*width,
                      fontFamily: fontReg
              ),
            ),
            
          ],
        ),
        ),
       
        ],


      ),
    );
  
  }




}