import 'package:coupons/data/model/company.dart';
import 'package:coupons/pages/user/add_coupon_info.dart';
import 'package:coupons/pages/widgets/back_button_widget.dart';
import 'package:string_validator/string_validator.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:page_transition/page_transition.dart';

import '../UIHelper.dart';
import '../../data/Helper.dart';

CompanyRowState selectedWidget;

class AddCoupon extends StatefulWidget {
  @override
  State<StatefulWidget> createState() {
    coupon = "*";
    couponLink = "*";
    value = "*";
    desc = "";
    selectedCompany = null;

    companiesList.removeAt(0); // remove all company

    return AddCouponState();
  }
}

class AddCouponState extends State<AddCoupon> {
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
                mLocal.add_coupon_txt,
                textAlign: TextAlign.center,
                style: TextStyle(
                  color: Colors.black87,
                  fontFamily: fontBold,
                  fontSize: 0.05 * width,
                ),
              ),

              SizedBox(
                height: 0.01 * height,
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
                      hintText: mLocal.add_coupon_hint,
                      hintStyle: TextStyle(
                          color: Colors.grey[400],
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
                      hintText: mLocal.add_coupon_link_hint,
                      hintStyle: TextStyle(
                          color: Colors.grey[400],
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
                  keyboardType: TextInputType.numberWithOptions(decimal: true),
                  inputFormatters: <TextInputFormatter>[
                    WhitelistingTextInputFormatter.digitsOnly
                  ],
                  style: TextStyle(
                      color: Colors.black,
                      fontSize: 0.045 * width,
                      fontFamily: fontBold),
                  cursorColor: Colors.black,
                  decoration: InputDecoration.collapsed(
                      border: InputBorder.none,
                      hintText: mLocal.add_coupon_value_hint,
                      hintStyle: TextStyle(
                          color: Colors.grey[400],
                          fontSize: 0.045 * width,
                          fontFamily: fontBold)),
                  onChanged: (value1) {
                    value = value1;
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
                  autocorrect: false,
                  decoration: InputDecoration.collapsed(
                      border: InputBorder.none,
                      hintText: mLocal.add_coupon_desc_hint,
                      hintStyle: TextStyle(
                          color: Colors.grey[400],
                          fontSize: 0.045 * width,
                          fontFamily: fontBold)),
                  onChanged: (value) {
                    desc = value;
                  },
                ),
              ),

              SizedBox(
                height: 0.03 * height,
              ),

              Container(
                height: 0.12 * height,
                width: width,
                margin:
                    EdgeInsets.only(right: 0.01 * width, left: 0.01 * width),
                child: ListView.builder(
                    scrollDirection: Axis.horizontal,
                    itemCount: companiesList.length,
                    itemBuilder: (context, position) {
                      return CompanyRow(width, height, companiesList[position]);
                    }),
              ),

              SizedBox(
                height: 0.02 * height,
              ),

              ///////////////////////////Button///////////////////////////
              RawMaterialButton(
                onPressed: () {
                  print(coupon);
                  if (value != "*" &&
                      coupon != "*" &&
                      couponLink != "*" &&
                      isURL(couponLink) &&
                      selectedCompany != null) {
                    Navigator.push(
                        context,
                        PageTransition(
                            type: PageTransitionType.rightToLeft,
                            duration: Duration(milliseconds: 300),
                            child: AddCouponExtra()));
                  } else {
                    singleOptionAlert(context);
                    print('coupon ->' + coupon);
                    print('coupon link ->' + couponLink);
                    print('value ->' + value);
                    print('desc ->' + desc);
                    //print('company ->' + selectedCompany.toString());
                  }
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
}

class CompanyRow extends StatefulWidget {
  double width;
  double height;
  Company company;

  CompanyRow(double width, double height, Company company) {
    this.width = width;
    this.height = height;
    this.company = company;
  }
  @override
  State<StatefulWidget> createState() {
    return new CompanyRowState();
  }
}

class CompanyRowState extends State<CompanyRow> {
  double width;
  double height;
  Company company;

  Color txtColor = Colors.black;

  bool first = true;

  @override
  void initState() {
    width = widget.width;
    height = widget.height;
    company = widget.company;
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Material(
      color: Colors.transparent,
      child: InkWell(
        onTap: () {
          select();

          if (selectedWidget != null) {
            selectedWidget.setBlack();
          } else {
            print("it is null");
          }

          selectedWidget = this;
          selectedCompany = company;
        },
        child: Container(
          width: width * 0.18,
          height: height * 0.1,
          margin: EdgeInsets.symmetric(horizontal: 0.04 * width),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.center,
            mainAxisAlignment: MainAxisAlignment.center,
            children: <Widget>[
              Container(
                height: 0.07 * height,
                width: 0.07 * height,
                child: CircleAvatar(
                  radius: 55,
                  backgroundColor: Colors.greenAccent,
                  child: CircleAvatar(
                    radius: 50,
                    backgroundImage: NetworkImage(company.logo),
                  ),
                ),
              ),
              Text(
                isArabic ? company.arName : company.name,
                style: TextStyle(
                  color: txtColor,
                  fontSize: width * 0.035,
                  fontFamily: fontBold,
                ),
                maxLines: 1,
                textAlign: TextAlign.center,
              )
            ],
          ),
        ),
      ),
    );
  }

  void select() {
    if (txtColor == Colors.black) {
      setState(() {
        txtColor = Colors.yellow[800];
      });
    } else {
      setState(() {
        txtColor = Colors.black;
      });
    }
  }

  void setBlack() {
    setState(() {
      txtColor = Colors.black;
    });
  }
}
