

import 'package:flutter/material.dart';

class SplashPage extends StatefulWidget{
  @override
  State<StatefulWidget> createState() {
    return SplashPageState();
  }

}

class SplashPageState extends State<SplashPage> with SingleTickerProviderStateMixin{
  
  double height;
  double width;

  AnimationController ac;
  Animation animation;

  bool first = true;

  @override
  void initState() {
   
    ac=AnimationController(vsync: this,duration: Duration(milliseconds: 1200));
     animation=Tween<double>(begin:-0.5,end:0).animate(
      CurvedAnimation(parent: ac,curve: Curves.bounceOut)
   );

    animation.addListener((){
     setState(() {});
   });
    
    ac.forward();
    super.initState();
  }
  
   
  @override
  Widget build(BuildContext context) {

  height = MediaQuery.of(context).size.height - MediaQuery.of(context).padding.top- MediaQuery.of(context).padding.bottom;
  width = MediaQuery.of(context).size.width;
    

   return Scaffold(
     //backgroundColor: Colors.grey[100],
     body: Container(
                width: width,
                height:height,
                alignment: Alignment.center,
                
                child: Container(
                  transform: Matrix4.translationValues( 0,height*animation.value, 0),
                  child: Material(
                          elevation: 4,
                          shape:RoundedRectangleBorder(borderRadius:BorderRadius.circular(22.0) ),
                          clipBehavior: Clip.antiAlias,
                          child: Image.asset('lib/assets/img/logo.png',
                                          width: 0.38*width,
                                          height: 0.38*width,
                                          fit: BoxFit.fill,
                            ),
                    ),
                )
                ),
   );
  }


  @override
  void dispose() {
    ac?.dispose();
    super.dispose();
  }

}