import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

String fontBold = "pr_en_bold";
String fontReg = "pr_en_reg";

MyLocal mLocal;

bool isArabic = true;

void singleOptionAlert(BuildContext context) {
  showDialog(
      builder: (context) => CupertinoAlertDialog(
            insetAnimationDuration: Duration(milliseconds: 300),
            title: Text(mLocal.alert,
                style: TextStyle(color: Colors.black, fontFamily: fontBold)),
            content: Text(
              mLocal.add_coupon_alert,
              style: TextStyle(color: Colors.black, fontFamily: fontBold),
            ),
            actions: <Widget>[
              CupertinoDialogAction(
                  isDefaultAction: true,
                  onPressed: () {
                    Navigator.pop(context);
                  },
                  child: Text("ok", style: TextStyle(fontFamily: fontBold))),
            ],
          ),
      context: context);
}

abstract class MyLocal {
  String app_name;

  String search_hint;

  String home_deals;

  String copy;

  String phone;

  String country;

  String shop_link;

  String home;

  String login;

  String favotrite;

  String rate;

  String contact;

  String privacy_policy;

  String terms_of_use;

  String help;

  String email;

  String password;

  String current_password;

  String new_password;

  String register_txt;

  String already_have_acc_txt;

  String login_promo;

  String sign_up_promo;

  String edit_user_text;

  String firstName;

  String lastName;

  String repeat_password;

  String register;

  String edit;

  String hello;

  String empty_coupons;

  String my_account;

  String telegram;

  String instagram;

  String add_coupon_txt;

  String edit_coupon_txt;

  String add_coupon_hint;

  String add_coupon_link_hint;

  String add_coupon_value_hint;

  String add_coupon_desc_hint;

  String add_coupon_info_promo_txt;

  String next;

  String alert;

  String password_alert;

  String add_coupon_alert;

  String wait;

  String url;

  String copied;

  String empty_home_coupons;

  String insta_hint;

  String snap_hint;

  String website_hint;

  String unknown_error;

  String err_login;

  String err_sign_up;

  String thnx_rating;

  String you_cant_rate;

  String add_store;

  String add_store_promo_txt;

  String store_name;

  String store_url;

  String store_email;

  String store_phone;

  String send;

  String add;

  String coupon_added;

  String store_added;

  String question1;

  String answer1;

  String question2;

  String answer2;

  String question3;

  String answer3;

  String question4;

  String answer4;

  String question5;

  String answer5;

  String question6;

  String answer6;

  String question7;

  String answer7;

  String privacy_txt;

  String terms_txt;

  String share;

  String logout;

  String my_coupons;

  String skip;
}
