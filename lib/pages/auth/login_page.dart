import 'package:coupons/data/Helper.dart';
import 'package:coupons/pages/UIHelper.dart';
import 'package:coupons/pages/auth/register_page.dart';
import 'package:coupons/pages/home_page.dart';
import 'package:coupons/pages/widgets/back_button_widget.dart';
import 'package:flutter/cupertino.dart';
import 'package:page_transition/page_transition.dart';
import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:native_progress_hud/native_progress_hud.dart';
import 'package:page_transition/page_transition.dart';
import 'package:google_sign_in/google_sign_in.dart';

class LoginPage extends StatelessWidget {
  double height;
  double width;

  String email;
  String password;
  final FirebaseAuth mAuth = FirebaseAuth.instance;

  //google sign in
  GoogleSignIn _googleAuth = new GoogleSignIn();

  @override
  Widget build(BuildContext context) {
    height = MediaQuery.of(context).size.height -
        MediaQuery.of(context).padding.top -
        MediaQuery.of(context).padding.bottom;
    width = MediaQuery.of(context).size.width;

    return Scaffold(
        //resizeToAvoidBottomInset: false,
        body: SingleChildScrollView(
      child: Container(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.start,
          crossAxisAlignment: CrossAxisAlignment.center,
          children: <Widget>[
            //////////IMAGE////////////////////////
            Container(
              width: double.infinity,
              height: height * 0.45,
              child: Stack(
                alignment: Alignment.topLeft,
                children: <Widget>[
                  Image.asset(
                    "lib/assets/img/login_bg.jpeg",
                    width: double.infinity,
                    height: height * 0.45,
                    fit: BoxFit.fill,
                  ),
                  Positioned(
                      top: 0.05 * height,
                      left: 0.05 * width,
                      child: MyBackButton())
                ],
              ),
            ),

            SizedBox(
              height: 0.025 * height,
            ),

            ////////////////TEXT//////////////////

            Text(
              mLocal.login_promo,
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
                  email = value.trim();
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
                obscureText: true,
                onChanged: (value) {
                  password = value;
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

            ////////Button/////////////////////////////

            Container(
              height: 0.08 * height,
              width: width,
              margin: EdgeInsets.symmetric(horizontal: 0.09 * width),
              padding:
                  EdgeInsets.symmetric(vertical: 2, horizontal: width * 0.05),
              decoration: BoxDecoration(
                borderRadius: BorderRadius.circular(25),
              ),
              child: RaisedButton(
                onPressed: () {
                  login(context);
                },
                color: Colors.yellow,
                child: Text(
                  mLocal.login,
                  style: TextStyle(
                      color: Colors.black,
                      fontFamily: fontBold,
                      fontSize: 0.045 * width),
                ),
              ),
            ),

            SizedBox(
              height: 0.075 * height,
            ),

            ///////////REGISTER/////////////////////

            Material(
              color: Colors.transparent,
              child: InkWell(
                onTap: () {
                  Navigator.push(
                      context,
                      PageTransition(
                          type: PageTransitionType.rightToLeft,
                          duration: Duration(milliseconds: 300),
                          child: RegisterPage()));
                },
                child: Text(
                  mLocal.register_txt,
                  style: TextStyle(
                      color: Colors.black,
                      fontFamily: fontBold,
                      fontSize: 0.045 * width),
                ),
              ),
            ),
            Material(
              color: Colors.transparent,
              child: InkWell(
                onTap: () {
                  _googleAuth.signIn().then((result) {
                    result.authentication.then((googleKey) {
                      FirebaseAuth.instance
                          .signInWithCredential(GoogleAuthProvider.credential(
                        idToken: googleKey.idToken,
                        accessToken: googleKey.accessToken,
                      ))
                          .then((signedInUser) {
                        print(signedInUser.user.displayName);
                        Navigator.push(
                            context,
                            PageTransition(
                                type: PageTransitionType.rightToLeft,
                                duration: Duration(milliseconds: 300),
                                child: HomePage()));
                      }).catchError((e) {
                        print(e);
                      });
                    }).catchError((e) {
                      print(e);
                    });
                  }).catchError((e) {
                    print(e);
                  });
                },
                child: Text(
                  mLocal.already_have_acc_txt,
                  style: TextStyle(
                      color: Colors.black,
                      fontFamily: fontBold,
                      fontSize: 0.038 * width),
                ),
              ),
            ),
          ],
        ),
      ),
    ));
  }

  void login(BuildContext context) async {
    NativeProgressHud.showWaitingWithText(mLocal.wait,
        backgroundColor: "#000000", textColor: "#ffffff");
    print("email -> $email pass -> $password");

    if (password == null || password.isEmpty) password = " ";
    if (email == null || email.isEmpty) email = " ";

    UserCredential result;
    try {
      result = await mAuth.signInWithEmailAndPassword(
          email: email.trim(), password: password);
    } on Exception {}

    if (result != null && result.user != null) {
      NativeProgressHud.hideWaiting();

      User user = result.user;

      userId = user.uid;

      auth = true;

      Navigator.pushReplacement(
          context,
          PageTransition(
              type: PageTransitionType.rightToLeft,
              duration: Duration(milliseconds: 300),
              child: HomePage()));
    } else {
      NativeProgressHud.hideWaiting();
      showDialog(
          builder: (context) => CupertinoAlertDialog(
                insetAnimationDuration: Duration(milliseconds: 300),
                title: Text(mLocal.alert,
                    style:
                        TextStyle(color: Colors.black, fontFamily: fontBold)),
                content: Text(
                  mLocal.err_login,
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
