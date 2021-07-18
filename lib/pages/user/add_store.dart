import 'package:coupons/pages/home_page.dart';
import 'package:coupons/pages/widgets/back_button_widget.dart';
import 'package:coupons/pages/widgets/successfully_added_widget.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import '../UIHelper.dart';
import 'package:string_validator/string_validator.dart';
import 'package:mailer2/mailer.dart';
import 'package:native_progress_hud/native_progress_hud.dart';
import 'package:page_transition/page_transition.dart';

class AddStore extends StatelessWidget {
  double height;
  double width;

  String storeName = "";

  String storeUrl = "";

  String storeEmail = "";

  String storePhone = "";

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
      body: SingleChildScrollView(
        physics: AlwaysScrollableScrollPhysics(),
        child: Container(
          height: MediaQuery.of(context).size.height,
          child: Column(
            mainAxisAlignment: MainAxisAlignment.start,
            crossAxisAlignment: CrossAxisAlignment.center,
            mainAxisSize: MainAxisSize.max,
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
                    Positioned(
                        top: 0.01 * height,
                        left: 0.02 * width,
                        child: MyBackButton())
                  ],
                ),
              ),

              SizedBox(
                height: 0.02 * height,
              ),

              Text(
                mLocal.add_store_promo_txt,
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
                    storeName = value;
                  },
                  decoration: InputDecoration(
                      isDense: true,
                      contentPadding: EdgeInsets.fromLTRB(5.0, 1.0, 5.0, 1.0),
                      border: InputBorder.none,
                      hintText: mLocal.store_name,
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
                    storeUrl = value;
                  },
                  decoration: InputDecoration(
                      isDense: true,
                      contentPadding: EdgeInsets.fromLTRB(5.0, 1.0, 5.0, 1.0),
                      border: InputBorder.none,
                      hintText: mLocal.store_url,
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
                    storeEmail = value;
                  },
                  decoration: InputDecoration(
                      isDense: true,
                      contentPadding: EdgeInsets.fromLTRB(5.0, 1.0, 5.0, 1.0),
                      border: InputBorder.none,
                      hintText: mLocal.store_email,
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
                    storePhone = value;
                  },
                  decoration: InputDecoration(
                      isDense: true,
                      contentPadding: EdgeInsets.fromLTRB(5.0, 1.0, 5.0, 1.0),
                      border: InputBorder.none,
                      hintText: mLocal.store_phone,
                      hintStyle: TextStyle(
                          color: Colors.grey[400],
                          fontSize: 0.045 * width,
                          fontFamily: fontBold)),
                ),
              ),

              SizedBox(
                height: 0.03 * height,
              ),
              ///////////////////////////Button///////////////////////////
              RawMaterialButton(
                onPressed: () {
                  sendDemand(context);
                },
                elevation: 2.0,
                fillColor: Colors.black,
                child: Icon(
                  Icons.send,
                  textDirection:
                      isArabic ? TextDirection.ltr : TextDirection.rtl,
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
                mLocal.send,
                textAlign: TextAlign.center,
                style: TextStyle(
                  color: Colors.black,
                  fontFamily: fontBold,
                  fontSize: 0.045 * width,
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }

  void sendDemand(BuildContext context) {
    NativeProgressHud.showWaitingWithText(mLocal.wait,
        backgroundColor: "#000000", textColor: "#ffffff");

    if (storeName != "" &&
        isURL(storeUrl.trim()) &&
        isEmail(storeEmail.trim())) {
      var options = new GmailSmtpOptions()
        ..ignoreBadCertificate = true
        ..requiresAuthentication = false
        ..username = 'infocoupone@gmail.com'
        ..password = 'amoor5231';

      var emailTransport = new SmtpTransport(options);

      // Create our mail/envelope.
      var envelope = new Envelope()
        ..from = storeEmail
        ..recipients.add('infocoupone@gmail.com')
        ..subject = '[Add Store Demande]- $storeName'
        ..text =
            'store name :$storeName \n store url :$storeUrl \n store email : $storeEmail \n store phone : $storePhone';

      // Email it.
      emailTransport.send(envelope).then((envelope) {
        NativeProgressHud.hideWaiting();

        Navigator.pushReplacement(
            context,
            PageTransition(
                type: PageTransitionType.rightToLeft,
                duration: Duration(milliseconds: 300),
                child: SuccessfullyAdded.send()));
      }).catchError((e) {
        NativeProgressHud.hideWaiting();
        NativeProgressHud.hideWaiting();
        showDialog(
            builder: (context) => CupertinoAlertDialog(
                  insetAnimationDuration: Duration(milliseconds: 300),
                  title: Text(mLocal.alert,
                      style:
                          TextStyle(color: Colors.black, fontFamily: fontBold)),
                  content: Text(
                    mLocal.unknown_error,
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
      });
    } else {
      NativeProgressHud.hideWaiting();
      singleOptionAlert(context);
    }
  }
}
