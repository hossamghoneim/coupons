
import 'package:coupons/pages/home_page.dart';
import 'package:coupons/pages/user/user_page.dart';
import 'package:flutter/material.dart';
import 'package:page_transition/page_transition.dart';
import '../UIHelper.dart';
import 'package:url_launcher/url_launcher.dart';

class SuccessfullyAdded extends StatelessWidget {
  
  double height;
  double width;
  bool isAdemand = false;

  SuccessfullyAdded(){}

  SuccessfullyAdded.send(){
    isAdemand = true;
  }
  
  @override
  Widget build(BuildContext context) {

    height = MediaQuery.of(context).size.height - MediaQuery.of(context).padding.top- MediaQuery.of(context).padding.bottom - MediaQuery.of(context).viewInsets.top - MediaQuery.of(context).viewInsets.bottom - kToolbarHeight;
    width = MediaQuery.of(context).size.width;


    return Scaffold(

      body: Column(
        mainAxisAlignment: MainAxisAlignment.start,
        crossAxisAlignment: CrossAxisAlignment.center,

        children: <Widget>[

        SizedBox(height: 0.144*height,),

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

          SizedBox(height: 0.065*height,),


          Material(
            elevation: 4,
            shape: CircleBorder(),
            clipBehavior: Clip.antiAlias,
            child: Image.asset("lib/assets/img/checked.png",
                        width: width,
                        height: 0.25*width,
                        
          ),
          ),

          SizedBox(height: 0.045*height,),

          Text(isAdemand ? mLocal.store_added : mLocal.coupon_added,
                     textAlign: TextAlign.center,
                     style: TextStyle(
                             color: Colors.black,
                             fontFamily: fontBold,
                             fontSize: 0.05*width,
                           ),
                   ),

          SizedBox(height: 0.06*height,),

                    //telegram
                    menuElement(
                      "lib/assets/img/telegram.png",
                      mLocal.telegram,
                      ()async{
                        if (await canLaunch("https://t.me/copone0/")) {
                              await launch("https://t.me/copone0/");
                      }
                      }
                    ),

                    //instagram
                    menuElement(
                      "lib/assets/img/insta.png",
                      mLocal.instagram,
                      ()async{
                        if (await canLaunch("https://t.me/copone0/")) {
                              await launch("https://www.instagram.com/coupone0/");
                      }
                      }
                    ),


          SizedBox(height: !isAdemand ? 0.05*height : 0.025*height,),

          GestureDetector(
            onTap: () {
              Navigator.pushReplacement(context, 
                             PageTransition(
                              type: PageTransitionType.rightToLeft,
                              duration: Duration(milliseconds: 300),
                              child:  isAdemand ? HomePage() : UserPage()
                          ));
            },
            child:Container(
            width: width,
            height: 0.08*height,
            color: Colors.black,
            alignment: Alignment.center,
            child: Text(isAdemand ? mLocal.home : mLocal.my_account ,
                     textAlign: TextAlign.center,
                     style: TextStyle(
                             color: Colors.white,
                             fontFamily: fontBold,
                             fontSize: 0.05*width,
                           ),
                   ),
          ),
          ),
              

        ],

      ),
    );

    
  }


Widget menuElement(String img,String title,Function onTap){
    
    double w_width =  0.56*width;
    double w_height = 0.08*height;

    return Material(
      color: Colors.transparent,
      child: InkWell(
      highlightColor: Colors.yellow[200],
      onTap: () {
        onTap();
      },
      child: Container(
      width: w_width,
      height: w_height,
      margin: EdgeInsets.symmetric(vertical: 0.1*w_height,horizontal: 0.05*w_width),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.start,
        crossAxisAlignment: CrossAxisAlignment.center,
        children: <Widget>[

         

          SizedBox(width: 0.05*w_width,),

          Image.asset(img,width: 0.15*w_width,height: 0.15*w_width,),

          SizedBox(width: 0.05*w_width,),

          Text(title,
                style: TextStyle(
                        color: Colors.black,
                        fontSize: 0.08*w_width,
                        fontFamily: fontBold
                ),
          ),

        ],
      ),
    ),
    ),
    );

  }


}