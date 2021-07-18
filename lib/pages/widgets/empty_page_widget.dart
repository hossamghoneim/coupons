import 'package:flutter/material.dart';
import '../UIHelper.dart';

class EmptyPage extends StatelessWidget {

    double width;
    double height;
    String msg;

    EmptyPage(String msg,double width,double height){
        this.msg = msg;
        this.width = width;
        this.height = height;
    }


  @override
  Widget build(BuildContext context) {
    
    return Column(
        children: <Widget>[
          SizedBox(height: 0.05*height,),

          Image.asset("lib/assets/img/empty.jpg"),
          
          
          SizedBox(height: 0.05*height,),

          Text(msg,
                     textAlign: TextAlign.center,
                     style: TextStyle(
                             color: Colors.grey,
                             fontFamily: fontBold,
                             fontSize: 0.04*width,
                           ),
                   )
        ],
      );
  }


  
}