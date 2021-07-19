import 'package:coupons/pages/user/user_page.dart';
import 'package:coupons/pages/widgets/back_button_widget.dart';
import 'package:string_validator/string_validator.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:native_progress_hud/native_progress_hud.dart';
import 'package:firebase_database/firebase_database.dart';
import 'package:page_transition/page_transition.dart';
import '../UIHelper.dart';
import '../../data/Helper.dart';

class EditCoupon extends StatefulWidget {
  String couponID;
  String couponCode;
  String couponUrl;

  EditCoupon(String couponID, String couponCode, String couponUrl) {
    this.couponID = couponID;
    this.couponCode = couponCode;
    this.couponUrl = couponUrl;
  }

  @override
  State<StatefulWidget> createState() {
    coupon = "*";
    couponLink = "*";

    return EditCouponState();
  }
}

class EditCouponState extends State<EditCoupon> {
  double height;
  double width;

  @override
  Widget build(BuildContext context) {
    height = MediaQuery.of(context).size.height -
        MediaQuery.of(context).padding.top -
        MediaQuery.of(context).padding.bottom -
        MediaQuery.of(context).viewInsets.top -
        MediaQuery.of(context).viewInsets.bottom;
    width = MediaQuery.of(context).size.width;

    return Scaffold(
        backgroundColor: Colors.white,
        resizeToAvoidBottomInset: false,
        body: SingleChildScrollView(
          child: Column(
            mainAxisAlignment: MainAxisAlignment.start,
            crossAxisAlignment: CrossAxisAlignment.center,
            mainAxisSize: MainAxisSize.max,
            children: <Widget>[
              SizedBox(
                height: 0.01 * height,
              ),

              Container(
                width: width,
                height: 0.34 * height,
                child: Stack(
                  children: <Widget>[
                    Image.asset(
                      "lib/assets/img/add_coupon_1.png",
                      width: width,
                      height: 0.34 * height,
                      fit: BoxFit.fill,
                    ),
                    Positioned(
                        top: 0.04 * height,
                        left: 0.02 * width,
                        child: MyBackButton())
                  ],
                ),
              ),

              SizedBox(
                height: 0.01 * height,
              ),

              Text(
                mLocal.edit_coupon_txt,
                textAlign: TextAlign.center,
                style: TextStyle(
                  color: Colors.black87,
                  fontFamily: fontBold,
                  fontSize: 0.05 * width,
                ),
              ),

              SizedBox(
                height: 0.05 * height,
              ),

              //////////////////INPUTES/////////////////////
              Container(
                height: 0.08 * height,
                margin: EdgeInsets.symmetric(horizontal: 0.08 * width),
                padding: EdgeInsets.only(
                    top: 2, left: width * 0.05, right: width * 0.05, bottom: 2),
                decoration: BoxDecoration(
                    borderRadius: BorderRadius.circular(8),
                    color: Colors.grey[200]),
                child: TextField(
                  textAlign: TextAlign.start,
                  style: TextStyle(
                      color: Colors.black,
                      fontSize: 0.045 * width,
                      fontFamily: fontBold),
                  cursorColor: Colors.black,
                  decoration: InputDecoration.collapsed(
                      border: InputBorder.none,
                      hintText: widget.couponCode,
                      hintStyle: TextStyle(
                          color: Colors.black,
                          fontSize: 0.045 * width,
                          fontFamily: fontBold)),
                  onChanged: (value) {
                    coupon = value;
                  },
                ),
              ),

              SizedBox(
                height: 0.03 * height,
              ),

              Container(
                height: 0.08 * height,
                margin: EdgeInsets.symmetric(horizontal: 0.08 * width),
                padding: EdgeInsets.only(
                    top: 2, left: width * 0.05, right: width * 0.05, bottom: 2),
                decoration: BoxDecoration(
                    borderRadius: BorderRadius.circular(8),
                    color: Colors.grey[200]),
                child: TextField(
                  textAlign: TextAlign.start,
                  style: TextStyle(
                      color: Colors.black,
                      fontSize: 0.045 * width,
                      fontFamily: fontBold),
                  cursorColor: Colors.black,
                  decoration: InputDecoration.collapsed(
                      border: InputBorder.none,
                      hintText: widget.couponUrl,
                      hintStyle: TextStyle(
                          color: Colors.black,
                          fontSize: 0.045 * width,
                          fontFamily: fontBold)),
                  onChanged: (value) {
                    couponLink = value;
                  },
                ),
              ),

              SizedBox(
                height: 0.03 * height,
              ),

              ///////////////////////////Button///////////////////////////
              RawMaterialButton(
                onPressed: () {
                  editCoupon();
                },
                elevation: 2.0,
                fillColor: Colors.black,
                child: Icon(
                  Icons.arrow_back_ios,
                  size: 30.0,
                  color: Colors.white,
                ),
                padding: EdgeInsets.all(0.02 * height),
                shape: CircleBorder(),
              ),

              SizedBox(
                height: 0.002 * height,
              ),

              Text(
                mLocal.next,
                textAlign: TextAlign.center,
                style: TextStyle(
                  color: Colors.black,
                  fontFamily: fontBold,
                  fontSize: 0.045 * width,
                ),
              ),
            ],
          ),
        ));
  }

  void editCoupon() async {
    NativeProgressHud.showWaitingWithText(mLocal.wait,
        backgroundColor: "#000000", textColor: "#ffffff");
    // print("couponIDDDDDDDDDDDDDDDDDDDDDDDDDDDDDDDDDDDDDDDDDDDDDDDDDD");
    // print(widget.couponID);
    final ref = FirebaseDatabase.instance.reference();

    ref.child('coupons').child(widget.couponID).update({
      'coupon': coupon != "*" ? coupon : widget.couponCode,
      'link': couponLink != "*" ? couponLink : widget.couponUrl,
    }).whenComplete(() {
      Future.delayed(const Duration(milliseconds: 500), () {
        NativeProgressHud.hideWaiting();

        Navigator.pushReplacement(
            context,
            PageTransition(
                type: PageTransitionType.rightToLeft,
                duration: Duration(milliseconds: 300),
                child: UserPage()));
      });
    });
  }
}
