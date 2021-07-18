import 'package:coupons/pages/user/user_page.dart';
import 'package:coupons/pages/widgets/back_button_widget.dart';
import 'package:coupons/pages/widgets/successfully_added_widget.dart';
import 'package:flutter/material.dart';
import 'package:coupons/data/Helper.dart';
import '../UIHelper.dart';
import 'package:firebase_database/firebase_database.dart';
import 'package:native_progress_hud/native_progress_hud.dart';
import 'package:page_transition/page_transition.dart';

class AddCouponExtra extends StatefulWidget {
  @override
  State<StatefulWidget> createState() {
    insta_user = "";

    snap_user = "";

    website_url = "";

    return AddCouponExtraState();
  }
}

class AddCouponExtraState extends State<AddCouponExtra> {
  double height;
  double width;

  @override
  Widget build(BuildContext context) {
    height = MediaQuery.of(context).size.height -
        MediaQuery.of(context).padding.top -
        MediaQuery.of(context).padding.bottom -
        MediaQuery.of(context).viewInsets.top -
        MediaQuery.of(context).viewInsets.bottom -
        kToolbarHeight;
    width = MediaQuery.of(context).size.width;

    return Scaffold(
        backgroundColor: Colors.white,
        resizeToAvoidBottomInset: false,
        body: SingleChildScrollView(
          child: Column(
            mainAxisAlignment: MainAxisAlignment.start,
            crossAxisAlignment: CrossAxisAlignment.center,
            children: <Widget>[
              SizedBox(
                height: 0.04 * height,
              ),

              Container(
                height: 0.3 * height,
                child: Stack(
                  children: <Widget>[
                    Image.asset(
                      "lib/assets/img/add_coupon_extra.png",
                      width: width,
                      height: 0.3 * height,
                      fit: BoxFit.fitWidth,
                    ),
                    Padding(
                      padding: EdgeInsets.symmetric(
                          horizontal: 0.05 * width, vertical: 0.007 * height),
                      child: Container(
                        width: width,
                        height: 0.1 * height,
                        child: Row(
                          mainAxisAlignment: MainAxisAlignment.spaceBetween,
                          crossAxisAlignment: CrossAxisAlignment.start,
                          textDirection: TextDirection.rtl,
                          children: <Widget>[
                            GestureDetector(
                              onTap: () {
                                addCoupon();
                              },
                              child: Text(
                                mLocal.skip,
                                textAlign: TextAlign.center,
                                style: TextStyle(
                                  color: Colors.black87,
                                  fontFamily: fontBold,
                                  fontSize: 0.055 * width,
                                ),
                              ),
                            ),
                            MyBackButton()
                          ],
                        ),
                      ),
                    )
                  ],
                ),
              ),

              /*

              */

              SizedBox(
                height: 0.02 * height,
              ),

              Text(
                mLocal.add_coupon_info_promo_txt,
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
                  onChanged: (value) {
                    snap_user = value;
                  },
                  decoration: InputDecoration.collapsed(
                      border: InputBorder.none,
                      hintText: mLocal.snap_hint,
                      hintStyle: TextStyle(
                          color: Colors.grey[400],
                          fontSize: 0.045 * width,
                          fontFamily: fontBold)),
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
                  onChanged: (value) {
                    insta_user = value;
                  },
                  decoration: InputDecoration.collapsed(
                      border: InputBorder.none,
                      hintText: mLocal.insta_hint,
                      hintStyle: TextStyle(
                          color: Colors.grey[400],
                          fontSize: 0.045 * width,
                          fontFamily: fontBold)),
                ),
              ),

              SizedBox(
                height: 0.03 * height,
              ),

              SizedBox(
                height: 0.03 * height,
              ),
              ///////////////////////////Button///////////////////////////
              RawMaterialButton(
                onPressed: () {
                  addCoupon();
                },
                elevation: 2.0,
                fillColor: Colors.black,
                child: Icon(
                  Icons.add,
                  size: 30.0,
                  color: Colors.white,
                ),
                padding: EdgeInsets.all(0.02 * height),
                shape: CircleBorder(),
              ),

              SizedBox(
                height: 0.01 * height,
              ),

              Text(
                mLocal.add,
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

  void addCoupon() {
    NativeProgressHud.showWaitingWithText(mLocal.wait,
        backgroundColor: "#000000", textColor: "#ffffff");
    final ref = FirebaseDatabase.instance.reference().child('coupons');

    ref.push().set(<String, String>{
      'coupon': coupon,
      'link': couponLink,
      'desc': desc,
      'value': value,
      'store_img': selectedCompany.logo,
      'store_name': selectedCompany.name,
      'store_ar_name': selectedCompany.arName,
      'insta': insta_user.trim(),
      'snap': snap_user.trim(),
      'website': website_url.trim(),
      'like': "0",
      'dislike': "0",
      'owner': userId
    }).whenComplete(() {
      Future.delayed(const Duration(milliseconds: 500), () {
        NativeProgressHud.hideWaiting();

        Navigator.pushReplacement(
            context,
            PageTransition(
                type: PageTransitionType.rightToLeft,
                duration: Duration(milliseconds: 300),
                child: SuccessfullyAdded()));
      });
    });
  }
}
