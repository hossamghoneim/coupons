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

User loggedInUser;
final _firestore = FirebaseFirestore.instance;

class EditUser extends StatefulWidget {
  String email;
  String firstName;
  String lastName;
  String phone;
  String country;
  EditUser(String country, String firstName, String lastName, String email,
      String phone) {
    this.country = country;
    this.firstName = firstName;
    this.lastName = lastName;
    this.email = email;
    this.phone = phone;
  }

  @override
  _EditUserState createState() => _EditUserState();
}

class _EditUserState extends State<EditUser> {
  double height;

  double width;

  String userPhone;

  String currentPassword;

  String newPassword;

  String emailTxtField;

  String firstNameTxtField;

  String lastNameTxtField;

  String phoneTxtField;

  String countryTxtField;

  User user;

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
                  mLocal.edit_user_text,
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
                      emailTxtField = value;
                    },
                    decoration: InputDecoration(
                      border: InputBorder.none,
                      hintText: widget.email,
                      hintStyle: TextStyle(
                          color: Colors.black,
                          fontSize: 0.045 * width,
                          fontFamily: fontBold),
                    ),
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
                      firstNameTxtField = value;
                    },
                    decoration: InputDecoration(
                      border: InputBorder.none,
                      hintText: widget.firstName,
                      hintStyle: TextStyle(
                          color: Colors.black,
                          fontSize: 0.045 * width,
                          fontFamily: fontBold),
                    ),
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
                      lastNameTxtField = value;
                    },
                    decoration: InputDecoration(
                      border: InputBorder.none,
                      hintText: widget.lastName,
                      hintStyle: TextStyle(
                          color: Colors.black,
                          fontSize: 0.045 * width,
                          fontFamily: fontBold),
                    ),
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
                      countryTxtField = value;
                    },
                    decoration: InputDecoration(
                      border: InputBorder.none,
                      hintText: widget.country,
                      hintStyle: TextStyle(
                          color: Colors.black,
                          fontSize: 0.045 * width,
                          fontFamily: fontBold),
                    ),
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
                      phoneTxtField = value;
                    },
                    decoration: InputDecoration(
                      border: InputBorder.none,
                      hintText: widget.phone,
                      hintStyle: TextStyle(
                          color: Colors.black,
                          fontSize: 0.045 * width,
                          fontFamily: fontBold),
                    ),
                  ),
                ),

                SizedBox(
                  height: 0.045 * height,
                ),

                // old password
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
                      currentPassword = v;
                    },
                    decoration: InputDecoration(
                        border: InputBorder.none,
                        hintText: mLocal.current_password,
                        hintStyle: TextStyle(
                            color: Colors.grey[400],
                            fontSize: 0.045 * width,
                            fontFamily: fontBold)),
                  ),
                ),

                SizedBox(
                  height: 0.045 * height,
                ),

                //new password
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
                      newPassword = v;
                    },
                    decoration: InputDecoration(
                        border: InputBorder.none,
                        hintText: mLocal.new_password,
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
                    onPressed: () async {
                      NativeProgressHud.showWaitingWithText(mLocal.wait,
                          backgroundColor: "#000000", textColor: "#ffffff");
                      if (currentPassword == null) {
                        print("hhhhhhhhhhhhhhhhhhhh");
                        NativeProgressHud.hideWaiting();
                        showDialog(
                            builder: (context) => CupertinoAlertDialog(
                                  insetAnimationDuration:
                                      Duration(milliseconds: 300),
                                  title: Text(mLocal.alert,
                                      style: TextStyle(
                                          color: Colors.black,
                                          fontFamily: fontBold)),
                                  content: Text(
                                    mLocal.password_alert,
                                    style: TextStyle(
                                        color: Colors.black,
                                        fontFamily: fontBold),
                                  ),
                                  actions: <Widget>[
                                    CupertinoDialogAction(
                                        isDefaultAction: true,
                                        onPressed: () {
                                          Navigator.pop(context);
                                        },
                                        child: Text("ok",
                                            style: TextStyle(
                                                fontFamily: fontBold))),
                                  ],
                                ),
                            context: context);
                      }
                      user = mAuth.currentUser;
                      UserCredential authResult =
                          await user.reauthenticateWithCredential(
                        EmailAuthProvider.credential(
                          email: user.email,
                          password: currentPassword,
                        ),
                      );
                      authResult.user
                          .updateEmail(emailTxtField)
                          .then((signedInUser) {
                        print("email successfully updated");
                      }).catchError((error) {
                        print(error);
                      });
                      authResult.user
                          .updatePassword(newPassword)
                          .then((signedInUser) {
                        print("password successfully updated");
                      }).catchError((error) {
                        print(error);
                      });
                      if (user != null) {
                        print(countryTxtField);
                        loggedInUser = user;
                        _firestore
                            .collection("couponati")
                            .doc(loggedInUser.uid)
                            .update({
                          'country': countryTxtField == null
                              ? widget.country
                              : countryTxtField,
                          'email': emailTxtField == null
                              ? widget.email
                              : emailTxtField,
                          'first_name': firstNameTxtField == null
                              ? widget.firstName
                              : firstNameTxtField,
                          'last_name': lastNameTxtField == null
                              ? widget.lastName
                              : lastNameTxtField,
                          'phone': phoneTxtField == null
                              ? widget.phone
                              : phoneTxtField,
                        });
                        NativeProgressHud.hideWaiting();
                        Navigator.push(
                            context,
                            PageTransition(
                                type: PageTransitionType.rightToLeft,
                                duration: Duration(milliseconds: 300),
                                child: HomePage()));
                      }
                    },
                    color: Colors.yellow,
                    child: Text(
                      mLocal.edit,
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
}
