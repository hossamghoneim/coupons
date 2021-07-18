import 'package:coupons/pages/UIHelper.dart';
import 'package:coupons/pages/widgets/back_button_widget.dart';
import 'package:flutter/material.dart';

class AboutPage extends StatelessWidget{
  
  double height;
  double width;

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

        Padding(
          padding: EdgeInsets.only(left: 0.02*width),
          child: Container(
          width: width,
          height: 0.055*height,
          alignment: Alignment.centerLeft,
          child: MyBackButton(),
        ),
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
          child: Text(mLocal.help,
              style: TextStyle(
                      color: Colors.black,
                      fontSize: 0.07*width,
                      fontFamily: fontBold
              ),
            ),
        ),

        SizedBox(height: 0.024*height,),
        
        Container(
        height: 0.64*height,
        child: ListView(
          scrollDirection: Axis.vertical,
          shrinkWrap: true,
          physics: const AlwaysScrollableScrollPhysics(),
          primary: true,
          children: <Widget>[
            //Question 1
             Padding(
              padding: EdgeInsets.symmetric(horizontal: 0.05*width ,vertical: 0.0025*height),
              child:Text(mLocal.question1,
                        style: TextStyle(
                                color: Colors.black,
                                fontSize: 0.05*width,
                                fontFamily: fontBold
                          ),
                        ),
                ),


            //Answer 1
             Padding(
              padding: EdgeInsets.symmetric(horizontal: 0.05*width ,vertical: 0.0025*height),
              child:Text(mLocal.answer1,
                        style: TextStyle(
                                color: Colors.grey[700],
                                fontSize: 0.045*width,
                                fontFamily: fontReg
                          ),
                        ),
                ),

              Container(height: 0.002*height,width: 0.2*width,color: Colors.grey[200],),
              SizedBox(height: 0.025*height,),
              //////////////////////////////////////
              
              //Question 2
             Padding(
              padding: EdgeInsets.symmetric(horizontal: 0.05*width ,vertical: 0.0025*height),
              child:Text(mLocal.question2,
                        style: TextStyle(
                                color: Colors.black,
                                fontSize: 0.05*width,
                                fontFamily: fontBold
                          ),
                        ),
                ),


            //Answer 2
             Padding(
              padding: EdgeInsets.symmetric(horizontal: 0.05*width ,vertical: 0.0025*height),
              child:Text(mLocal.answer2,
                        style: TextStyle(
                                color: Colors.grey[700],
                                fontSize: 0.045*width,
                                fontFamily: fontReg
                          ),
                        ),
                ),
              Container(height: 0.002*height,width: 0.2*width,color: Colors.grey[200],),
              SizedBox(height: 0.025*height,),
              //////////////////////////////////////
              

              //Question 3
             Padding(
              padding: EdgeInsets.symmetric(horizontal: 0.05*width ,vertical: 0.0025*height),
              child:Text(mLocal.question3,
                        style: TextStyle(
                                color: Colors.black,
                                fontSize: 0.05*width,
                                fontFamily: fontBold
                          ),
                        ),
                ),


            //Answer 3
             Padding(
              padding: EdgeInsets.symmetric(horizontal: 0.05*width ,vertical: 0.0025*height),
              child:Text(mLocal.answer3,
                        style: TextStyle(
                                color: Colors.grey[700],
                                fontSize: 0.045*width,
                                fontFamily: fontReg
                          ),
                        ),
                ),

              Container(height: 0.002*height,width: 0.2*width,color: Colors.grey[200],),
              SizedBox(height: 0.025*height,),
              //////////////////////////////////////
              
              //Question 4
             Padding(
              padding: EdgeInsets.symmetric(horizontal: 0.05*width ,vertical: 0.0025*height),
              child:Text(mLocal.question4,
                        style: TextStyle(
                                color: Colors.black,
                                fontSize: 0.05*width,
                                fontFamily: fontBold
                          ),
                        ),
                ),


            //Answer 4
             Padding(
              padding: EdgeInsets.symmetric(horizontal: 0.05*width ,vertical: 0.0025*height),
              child:Text(mLocal.answer4,
                        style: TextStyle(
                                color: Colors.grey[700],
                                fontSize: 0.045*width,
                                fontFamily: fontReg
                          ),
                        ),
                ),
              Container(height: 0.002*height,width: 0.2*width,color: Colors.grey[200],),
              SizedBox(height: 0.025*height,),
              //////////////////////////////////////
              //Question 5
             Padding(
              padding: EdgeInsets.symmetric(horizontal: 0.05*width ,vertical: 0.0025*height),
              child:Text(mLocal.question5,
                        style: TextStyle(
                                color: Colors.black,
                                fontSize: 0.05*width,
                                fontFamily: fontBold
                          ),
                        ),
                ),


            //Answer 5
             Padding(
              padding: EdgeInsets.symmetric(horizontal: 0.05*width ,vertical: 0.0025*height),
              child:Text(mLocal.answer5,
                        style: TextStyle(
                                color: Colors.grey[700],
                                fontSize: 0.045*width,
                                fontFamily: fontReg
                          ),
                        ),
                ),
              Container(height: 0.002*height,width: 0.2*width,color: Colors.grey[200],),
              SizedBox(height: 0.025*height,),
              //////////////////////////////////////
              //Question 6
             Padding(
              padding: EdgeInsets.symmetric(horizontal: 0.05*width ,vertical: 0.0025*height),
              child:Text(mLocal.question6,
                        style: TextStyle(
                                color: Colors.black,
                                fontSize: 0.05*width,
                                fontFamily: fontBold
                          ),
                        ),
                ),


            //Answer 6
             Padding(
              padding: EdgeInsets.symmetric(horizontal: 0.05*width ,vertical: 0.0025*height),
              child:Text(mLocal.answer6,
                        style: TextStyle(
                                color: Colors.grey[700],
                                fontSize: 0.045*width,
                                fontFamily: fontReg
                          ),
                        ),
                ),
              Container(height: 0.002*height,width: 0.2*width,color: Colors.grey[200],),
              SizedBox(height: 0.025*height,),
              //////////////////////////////////////
              //Question 7
             Padding(
              padding: EdgeInsets.symmetric(horizontal: 0.05*width ,vertical: 0.0025*height),
              child:Text(mLocal.question7,
                        style: TextStyle(
                                color: Colors.black,
                                fontSize: 0.05*width,
                                fontFamily: fontBold
                          ),
                        ),
                ),


            //Answer 7
             Padding(
              padding: EdgeInsets.symmetric(horizontal: 0.05*width ,vertical: 0.0025*height),
              child:Text(mLocal.answer7,
                        style: TextStyle(
                                color: Colors.grey[700],
                                fontSize: 0.045*width,
                                fontFamily: fontReg
                          ),
                        ),
                ),
              Container(height: 0.002*height,width: 0.2*width,color: Colors.grey[200],),
              SizedBox(height: 0.025*height,),
          ],
        ),
        ),
       
        ],


      ),
    );
  
  }




}