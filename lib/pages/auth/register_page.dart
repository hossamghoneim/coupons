import 'package:coupons/data/Helper.dart';
import 'package:coupons/pages/UIHelper.dart';
import 'package:coupons/pages/home_page.dart';
import 'package:coupons/pages/widgets/back_button_widget.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:string_validator/string_validator.dart';
import 'package:native_progress_hud/native_progress_hud.dart';
import 'package:page_transition/page_transition.dart';
import 'package:cloud_firestore/cloud_firestore.dart';

class RegisterPage extends StatelessWidget {
  double height;
  double width;

  String email;
  String firstName;
  String lastName;
  String phone;
  String country;
  String userPhone;
  String password;
  String r_password;

  final FirebaseAuth mAuth = FirebaseAuth.instance;

  @override
  Widget build(BuildContext context) {
    height = MediaQuery.of(context).size.height -
        MediaQuery.of(context).padding.top -
        MediaQuery.of(context).padding.bottom;
    width = MediaQuery.of(context).size.width;

    return Scaffold(
        resizeToAvoidBottomInset: false,
        body: SingleChildScrollView(
          child: Container(
            child: Column(
              mainAxisAlignment: MainAxisAlignment.start,
              crossAxisAlignment: CrossAxisAlignment.center,
              children: <Widget>[
                //////////IMAGE////////////////////////
                Container(
                  width: double.infinity,
                  height: height * 0.28,
                  child: Stack(
                    alignment: Alignment.topLeft,
                    children: <Widget>[
                      Image.asset(
                        "lib/assets/img/login_bg.jpeg",
                        width: double.infinity,
                        height: height * 0.28,
                        fit: BoxFit.fill,
                      ),
                      Positioned(
                          top: 0.05 * height,
                          left: 0.02 * width,
                          child: MyBackButton())
                    ],
                  ),
                ),

                SizedBox(
                  height: 0.03 * height,
                ),

                ////////////////TEXT//////////////////

                Text(
                  mLocal.sign_up_promo,
                  style: TextStyle(
                    color: Colors.black,
                    fontFamily: fontBold,
                    fontSize: 0.06 * width,
                  ),
                ),

                SizedBox(
                  height: 0.055 * height,
                ),

                //////////////////INPUTES///////////////

                //mail
                Container(
                  height: 0.08 * height,
                  margin: EdgeInsets.symmetric(horizontal: 0.08 * width),
                  padding: EdgeInsets.only(
                      top: 2,
                      left: width * 0.05,
                      right: width * 0.05,
                      bottom: 2),
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
                      email = value;
                    },
                    decoration: InputDecoration(
                        border: InputBorder.none,
                        hintText: mLocal.email,
                        hintStyle: TextStyle(
                            color: Colors.grey[400],
                            fontSize: 0.045 * width,
                            fontFamily: fontBold)),
                  ),
                ),

                SizedBox(
                  height: 0.045 * height,
                ),

                //username
                Container(
                  height: 0.08 * height,
                  margin: EdgeInsets.symmetric(horizontal: 0.08 * width),
                  padding: EdgeInsets.only(
                      top: 2,
                      left: width * 0.05,
                      right: width * 0.05,
                      bottom: 2),
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
                      firstName = value;
                    },
                    decoration: InputDecoration(
                        border: InputBorder.none,
                        hintText: mLocal.firstName,
                        hintStyle: TextStyle(
                            color: Colors.grey[400],
                            fontSize: 0.045 * width,
                            fontFamily: fontBold)),
                  ),
                ),

                SizedBox(
                  height: 0.045 * height,
                ),

                Container(
                  height: 0.08 * height,
                  margin: EdgeInsets.symmetric(horizontal: 0.08 * width),
                  padding: EdgeInsets.only(
                      top: 2,
                      left: width * 0.05,
                      right: width * 0.05,
                      bottom: 2),
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
                      lastName = value;
                    },
                    decoration: InputDecoration(
                        border: InputBorder.none,
                        hintText: mLocal.lastName,
                        hintStyle: TextStyle(
                            color: Colors.grey[400],
                            fontSize: 0.045 * width,
                            fontFamily: fontBold)),
                  ),
                ),

                SizedBox(
                  height: 0.045 * height,
                ),

                Container(
                  height: 0.08 * height,
                  margin: EdgeInsets.symmetric(horizontal: 0.08 * width),
                  padding: EdgeInsets.only(
                      top: 2,
                      left: width * 0.05,
                      right: width * 0.05,
                      bottom: 2),
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
                      country = value;
                    },
                    decoration: InputDecoration(
                        border: InputBorder.none,
                        hintText: mLocal.country,
                        hintStyle: TextStyle(
                            color: Colors.grey[400],
                            fontSize: 0.045 * width,
                            fontFamily: fontBold)),
                  ),
                ),

                SizedBox(
                  height: 0.045 * height,
                ),

                Container(
                  height: 0.08 * height,
                  margin: EdgeInsets.symmetric(horizontal: 0.08 * width),
                  padding: EdgeInsets.only(
                      top: 2,
                      left: width * 0.05,
                      right: width * 0.05,
                      bottom: 2),
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
                      phone = value;
                    },
                    decoration: InputDecoration(
                        border: InputBorder.none,
                        hintText: mLocal.phone,
                        hintStyle: TextStyle(
                            color: Colors.grey[400],
                            fontSize: 0.045 * width,
                            fontFamily: fontBold)),
                  ),
                ),

                SizedBox(
                  height: 0.045 * height,
                ),

                // password
                Container(
                  height: 0.08 * height,
                  margin: EdgeInsets.symmetric(horizontal: 0.08 * width),
                  padding: EdgeInsets.only(
                      top: 2,
                      left: width * 0.05,
                      right: width * 0.05,
                      bottom: 2),
                  decoration: BoxDecoration(
                      borderRadius: BorderRadius.circular(8),
                      color: Colors.grey[200]),
                  child: TextField(
                    textAlign: TextAlign.start,
                    obscureText: true,
                    style: TextStyle(
                        color: Colors.black,
                        fontSize: 0.045 * width,
                        fontFamily: fontBold),
                    cursorColor: Colors.black,
                    onChanged: (v) {
                      password = v;
                    },
                    decoration: InputDecoration(
                        border: InputBorder.none,
                        hintText: mLocal.password,
                        hintStyle: TextStyle(
                            color: Colors.grey[400],
                            fontSize: 0.045 * width,
                            fontFamily: fontBold)),
                  ),
                ),

                SizedBox(
                  height: 0.045 * height,
                ),

                // repeat password
                Container(
                  height: 0.08 * height,
                  margin: EdgeInsets.symmetric(horizontal: 0.08 * width),
                  padding: EdgeInsets.only(
                      top: 2,
                      left: width * 0.05,
                      right: width * 0.05,
                      bottom: 2),
                  decoration: BoxDecoration(
                      borderRadius: BorderRadius.circular(8),
                      color: Colors.grey[200]),
                  child: TextField(
                    textAlign: TextAlign.start,
                    obscureText: true,
                    style: TextStyle(
                        color: Colors.black,
                        fontSize: 0.045 * width,
                        fontFamily: fontBold),
                    cursorColor: Colors.black,
                    onChanged: (v) {
                      r_password = v;
                    },
                    decoration: InputDecoration(
                        border: InputBorder.none,
                        hintText: mLocal.repeat_password,
                        hintStyle: TextStyle(
                            color: Colors.grey[400],
                            fontSize: 0.045 * width,
                            fontFamily: fontBold)),
                  ),
                ),

                SizedBox(
                  height: 0.045 * height,
                ),

                ////////Button/////////////////////////////

                Container(
                  height: 0.075 * height,
                  width: width,
                  margin: EdgeInsets.symmetric(horizontal: 0.09 * width),
                  padding: EdgeInsets.symmetric(
                      vertical: 2, horizontal: width * 0.05),
                  decoration: BoxDecoration(
                    borderRadius: BorderRadius.circular(25),
                  ),
                  child: RaisedButton(
                    onPressed: () {
                      onSignUp(context);
                    },
                    color: Colors.yellow,
                    child: Text(
                      mLocal.register,
                      style: TextStyle(
                          color: Colors.black,
                          fontFamily: fontBold,
                          fontSize: 0.055 * width),
                    ),
                  ),
                ),

                SizedBox(
                  height: 0.075 * height,
                ),

                ///////////REGISTER/////////////////////
              ],
            ),
          ),
        ));
  }

  void onSignUp(BuildContext context) {
    NativeProgressHud.showWaitingWithText(mLocal.wait,
        backgroundColor: "#000000", textColor: "#ffffff");

    if (email != null && isEmail(email) && password != "" && r_password != "") {
      mAuth
          .createUserWithEmailAndPassword(email: email, password: password)
          .then((value) {
        NativeProgressHud.hideWaiting();

        print(value.user);
        if (value.user != null) {
          userId = value.user.uid;

          FirebaseFirestore.instance.collection('couponati').doc(userId).set({
            'email': email,
            'first_name': firstName,
            'last_name': lastName,
            'country': country,
            'phone': phone,
          });

          auth = true;

          Navigator.pushReplacement(
              context,
              PageTransition(
                  type: PageTransitionType.rightToLeft,
                  duration: Duration(milliseconds: 300),
                  child: HomePage()));
        } else {
          showDialog(
              builder: (context) => CupertinoAlertDialog(
                    insetAnimationDuration: Duration(milliseconds: 300),
                    title: Text(mLocal.alert,
                        style: TextStyle(
                            color: Colors.black, fontFamily: fontBold)),
                    content: Text(
                      mLocal.unknown_error,
                      style:
                          TextStyle(color: Colors.black, fontFamily: fontBold),
                    ),
                    actions: <Widget>[
                      CupertinoDialogAction(
                          isDefaultAction: true,
                          onPressed: () {
                            Navigator.pop(context);
                          },
                          child: Text("ok",
                              style: TextStyle(fontFamily: fontBold))),
                    ],
                  ),
              context: context);
        }
      });
    } else {
      NativeProgressHud.hideWaiting();

      showDialog(
          builder: (context) => CupertinoAlertDialog(
                insetAnimationDuration: Duration(milliseconds: 300),
                title: Text(mLocal.alert,
                    style:
                        TextStyle(color: Colors.black, fontFamily: fontBold)),
                content: Text(
                  mLocal.err_sign_up,
                  style: TextStyle(color: Colors.black, fontFamily: fontBold),
                ),
                actions: <Widget>[
                  CupertinoDialogAction(
                      isDefaultAction: true,
                      onPressed: () {
                        Navigator.pop(context);
                      },
                      child:
                          Text("ok", style: TextStyle(fontFamily: fontBold))),
                ],
              ),
          context: context);
    }
  }
}
