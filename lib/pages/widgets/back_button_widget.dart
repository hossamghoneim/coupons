
import 'package:flutter/material.dart';

import '../UIHelper.dart';

class MyBackButton extends StatelessWidget{
   
   double height;
   double width;

  @override
  Widget build(BuildContext context) {
    
    height = MediaQuery.of(context).size.height - MediaQuery.of(context).padding.top- MediaQuery.of(context).padding.bottom;
    width = MediaQuery.of(context).size.width;

    return Material(
            color: Colors.transparent,
            elevation: 0.5,
             shape:RoundedRectangleBorder(borderRadius:BorderRadius.circular(15.0) ),
            clipBehavior: Clip.antiAlias,
            child: InkWell(
                    onTap: () {
                      Navigator.pop(context);
                    },
                    child: Container(
                            height: 0.055*height,
                            width: 0.12*width,
                            alignment: Alignment.center,
                            decoration: BoxDecoration(
                                          color: Colors.grey[200],
                                          borderRadius: BorderRadius.circular(15),

                                        ),
                                        child: Icon(Icons.arrow_back_ios,color: Colors.black,
                                                    textDirection: TextDirection.ltr,
                                                ),
                            ),
                    ),
            );
    
  }


}