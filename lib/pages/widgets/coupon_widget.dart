import 'package:coupons/data/Helper.dart';
import 'package:coupons/data/model/coupon.dart';
import 'package:coupons/pages/user/edit_coupon.dart';
import 'package:coupons/pages/user/favorit_page.dart';
import 'package:coupons/pages/user/user_page.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:string_validator/string_validator.dart';
import 'package:page_transition/page_transition.dart';
import '../UIHelper.dart';
import 'package:firebase_database/firebase_database.dart';
import 'package:url_launcher/url_launcher.dart';

class CouponWidget extends StatefulWidget {
  double width;
  double height;
  bool isHome;
  bool isFav = false;
  Coupon coupon;
  UserPageState state;
  FavoritPageState favState;

  CouponWidget(Coupon coupon, double width, double height, bool isHome) {
    this.coupon = coupon;
    this.width = width;
    this.height = height;
    this.isHome = isHome;
  }

  CouponWidget.fromUser(Coupon coupon, double width, double height, bool isHome,
      UserPageState state) {
    this.coupon = coupon;
    this.width = width;
    this.height = height;
    this.isHome = isHome;
    this.state = state;
  }

  CouponWidget.fromFav(Coupon coupon, double width, double height, bool isHome,
      FavoritPageState state) {
    this.coupon = coupon;
    this.width = width;
    this.height = height;
    this.isHome = isHome;
    favState = state;
    isFav = true;
  }
  @override
  State<StatefulWidget> createState() {
    return CouponWidgetState();
  }
}

class CouponWidgetState extends State<CouponWidget> {
  double width;
  double height;
  bool isHome;
  Coupon coupon;
  UserPageState state;
  FavoritPageState favState;
  bool isFav;
  bool showCoupon = false;

  IconData favIcon = Icons.favorite_border;

  double favWidth;

  @override
  void initState() {
    width = widget.width;
    height = widget.height;
    isHome = widget.isHome;
    coupon = widget.coupon;
    state = widget.state;
    favState = widget.favState;
    isFav = widget.isFav;

    if (isFav) {
      favIcon = Icons.favorite;
    }

    favWidth = 0.12 * 0.9 * width;
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    //bool isUrl = isURL(coupon.code);

    final double w_width = 0.9 * width;
    double w_height = 0.33 * height;

    bool hasSnap = coupon.snap != "";
    bool hasInsta = coupon.insta != "";
    bool haswebsite = coupon.website != "";

    if (!hasInsta) w_height -= 0.0425 * height;

    if (!hasSnap) w_height -= 0.0425 * height;

    if (!haswebsite) w_height -= 0.041 * height;

    if (isHome) w_height += 0.041 * height;

    if (!isHome) w_height += 0.041 * height;

    return Container(
      key: UniqueKey(),
      height: w_height,
      margin: EdgeInsets.symmetric(
          vertical: height * 0.01, horizontal: 0.05 * width),
      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.circular(8),
        boxShadow: [
          BoxShadow(
            color: Colors.grey.withOpacity(0.5),
            spreadRadius: 1,
            blurRadius: 1,
            offset: Offset(0, 1), // changes position of shadow
          ),
        ],
      ),
      child: Row(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: <Widget>[
          Column(
            mainAxisSize: MainAxisSize.min,
            children: <Widget>[
              Container(
                  height: 0.2 * w_width,
                  width: 0.3 * w_width,
                  padding: EdgeInsets.symmetric(horizontal: 0.05 * w_width),
                  margin: EdgeInsets.symmetric(vertical: 0.1 * w_height),
                  child: CircleAvatar(
                    radius: 20,
                    backgroundImage: NetworkImage(coupon.logo),
                  )),
              Text(
                "-%" + coupon.value,
                textAlign: TextAlign.start,
                textDirection: isArabic ? TextDirection.rtl : TextDirection.ltr,
                style: TextStyle(
                    color: Colors.red,
                    fontSize: 0.03 * height,
                    fontFamily: fontBold),
                maxLines: 1,
                overflow: TextOverflow.ellipsis,
              ),
              SizedBox(
                height: w_height * 0.02,
              ),
              !isHome
                  ? Container()
                  : Row(
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: <Widget>[
                        Material(
                          color: Colors.transparent,
                          child: InkWell(
                            onTap: () {
                              like();
                            },
                            child: Image.asset(
                              "lib/assets/img/like.png",
                              height: 0.08 * w_height,
                              width: 0.08 * w_height,
                              color: Colors.green,
                            ),
                          ),
                        ),
                        SizedBox(
                          width: 0.08 * w_width,
                        ),
                        Container(
                          margin: EdgeInsets.only(top: 0.05 * w_height),
                          child: Material(
                            color: Colors.transparent,
                            child: InkWell(
                              onTap: () {
                                dislike();
                              },
                              child: Image.asset(
                                "lib/assets/img/dislike.png",
                                height: 0.08 * w_height,
                                width: 0.08 * w_height,
                                color: Colors.red,
                              ),
                            ),
                          ),
                        ),
                      ],
                    ),
            ],
          ),
          ///////////////////////DASHES /////////////////////////////

          Column(
            children: <Widget>[
              SizedBox(
                height: w_height * 0.05,
              ),
              Container(
                height: 0.1 * w_height,
                width: 0.02 * w_width,
                decoration: BoxDecoration(
                    borderRadius: BorderRadius.circular(12),
                    color: Colors.grey[300]),
              ),
              SizedBox(
                height: w_height * 0.05,
              ),
              SizedBox(
                height: w_height * 0.05,
              ),
              Container(
                height: 0.1 * w_height,
                width: 0.02 * w_width,
                decoration: BoxDecoration(
                    borderRadius: BorderRadius.circular(12),
                    color: Colors.grey[300]),
              ),
              SizedBox(
                height: w_height * 0.05,
              ),
              SizedBox(
                height: w_height * 0.05,
              ),
              Container(
                height: 0.1 * w_height,
                width: 0.02 * w_width,
                decoration: BoxDecoration(
                    borderRadius: BorderRadius.circular(12),
                    color: Colors.grey[300]),
              ),
              SizedBox(
                height: w_height * 0.05,
              ),
              SizedBox(
                height: w_height * 0.05,
              ),
              Container(
                height: 0.1 * w_height,
                width: 0.02 * w_width,
                decoration: BoxDecoration(
                    borderRadius: BorderRadius.circular(12),
                    color: Colors.grey[300]),
              ),
              SizedBox(
                height: w_height * 0.05,
              ),
              SizedBox(
                height: w_height * 0.05,
              ),
              Container(
                height: 0.1 * w_height,
                width: 0.02 * w_width,
                decoration: BoxDecoration(
                    borderRadius: BorderRadius.circular(12),
                    color: Colors.grey[300]),
              ),
              SizedBox(
                height: w_height * 0.05,
              ),
            ],
          ),

          SizedBox(width: 0.05 * w_width),

          Column(
            children: <Widget>[
              ///////////////////TEXT////////////////////////////////
              Text(
                isArabic
                    ? coupon.store_ar_name
                    : coupon.store_name, //store name
                style: TextStyle(
                    color: Colors.green,
                    fontSize: 0.02 * height,
                    fontFamily: fontBold),
                maxLines: 1,
                overflow: TextOverflow.ellipsis,
              ),
              Container(
                width: 0.6 * w_width,
                child: Text(
                  coupon.desc, // descreption
                  style: TextStyle(
                      color: Colors.black,
                      fontSize: 0.02 * height,
                      fontFamily: fontBold),
                  maxLines: 3,
                  overflow: TextOverflow.ellipsis,
                ),
              ),

              //////////////SOCIAL MEDIA ROW////////////////////
              hasSnap ? SizedBox(height: w_height * 0.01) : Container(),

              //SNAP
              !hasSnap
                  ? Container(
                      height: 0,
                      width: 0,
                    )
                  : Container(
                      height: 0.087 * w_height,
                      width: 0.6 * w_width,
                      padding: EdgeInsets.symmetric(horizontal: 0.02 * w_width),
                      child: InkWell(
                        onTap: () async {
                          await launch(
                              "https://www.snapchat.com/add/${coupon.snap}");
                        },
                        child: Row(
                          mainAxisAlignment: MainAxisAlignment.start,
                          children: <Widget>[
                            Container(
                              width: w_height * 0.06,
                              height: w_height * 0.06,
                              alignment: Alignment.center,
                              padding: EdgeInsets.only(top: 0.01 * w_height),
                              child: Image.asset(
                                "lib/assets/img/snap.png",
                              ),
                            ),
                            SizedBox(
                              width: 0.02 * w_width,
                            ),
                            Container(
                              height: 0.1 * w_height,
                              alignment: Alignment.center,
                              child: Text(
                                coupon.snap,
                                style: TextStyle(
                                    color: Colors.blueAccent[900],
                                    fontSize: 0.058 * w_height,
                                    fontFamily: fontReg),
                              ),
                            )
                          ],
                        ),
                      )),

              hasInsta ? SizedBox(height: w_height * 0.01) : Container(),

              //INSTA
              !hasInsta
                  ? Container(
                      height: 0,
                      width: 0,
                    )
                  : Container(
                      height: 0.089 * w_height,
                      width: 0.6 * w_width,
                      padding: EdgeInsets.symmetric(horizontal: 0.02 * w_width),
                      child: InkWell(
                        onTap: () async {
                          launch(
                              "https://www.instagram.com/${coupon.insta}/?hl=en");
                        },
                        child: Row(
                          mainAxisAlignment: MainAxisAlignment.start,
                          children: <Widget>[
                            Container(
                              width: w_height * 0.06,
                              height: w_height * 0.06,
                              alignment: Alignment.center,
                              padding: EdgeInsets.only(top: 0.01 * w_height),
                              child: Image.asset(
                                "lib/assets/img/insta.png",
                              ),
                            ),
                            SizedBox(
                              width: 0.02 * w_width,
                            ),
                            Container(
                              height: 0.1 * w_height,
                              alignment: Alignment.center,
                              child: Text(
                                coupon.insta,
                                style: TextStyle(
                                    color: Colors.blueAccent[900],
                                    fontSize: 0.058 * w_height,
                                    fontFamily: fontReg),
                              ),
                            )
                          ],
                        ),
                      )),

              haswebsite ? SizedBox(height: w_height * 0.01) : Container(),

              //WEBSITE
              !haswebsite
                  ? Container(
                      height: 0,
                      width: 0,
                    )
                  : Container(
                      height: 0.089 * w_height,
                      width: 0.6 * w_width,
                      padding: EdgeInsets.symmetric(horizontal: 0.02 * w_width),
                      child: InkWell(
                        onTap: () {
                          openLink(coupon.website);
                        },
                        child: Row(
                          mainAxisAlignment: MainAxisAlignment.start,
                          children: <Widget>[
                            Container(
                              width: w_height * 0.06,
                              height: w_height * 0.06,
                              alignment: Alignment.center,
                              padding: EdgeInsets.only(top: 0.01 * w_height),
                              child: Image.asset(
                                "lib/assets/img/url.png",
                              ),
                            ),
                            SizedBox(
                              width: 0.02 * w_width,
                            ),
                            Container(
                              height: 0.1 * w_height,
                              alignment: Alignment.center,
                              child: Text(
                                mLocal.url,
                                style: TextStyle(
                                    color: Colors.blueAccent[900],
                                    fontSize: 0.058 * w_height,
                                    fontFamily: fontReg),
                              ),
                            )
                          ],
                        ),
                      ),
                    ),

              SizedBox(
                width: 0.02 * height,
              ),

              //Buttons
              Container(
                height: 0.3 * w_height,
                width: 0.6 * w_width,
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: <Widget>[
                    //fav button
                    Material(
                        color: Colors.transparent,
                        child: InkWell(
                          child: AnimatedContainer(
                            width: favWidth,
                            height: favWidth,
                            duration: Duration(milliseconds: 200),
                            decoration: BoxDecoration(
                              color: Colors.white,
                              borderRadius: BorderRadius.circular(4),
                              boxShadow: [
                                BoxShadow(
                                  color: Colors.grey.withOpacity(0.5),
                                  spreadRadius: 0.4,
                                  blurRadius: 0.5,
                                  offset: Offset(
                                      0, 1), // changes position of shadow
                                ),
                              ],
                            ),
                            child: !isHome
                                ? Icon(Icons.delete_outline)
                                : Icon(favIcon),
                          ),
                          onTap: () {
                            favClicked();
                          },
                        )),
                    SizedBox(width: 0.02 * w_width),
                    !isHome && !isFav
                        ? Material(
                            color: Colors.transparent,
                            child: InkWell(
                              child: AnimatedContainer(
                                width: favWidth,
                                height: favWidth,
                                duration: Duration(milliseconds: 200),
                                decoration: BoxDecoration(
                                  color: Colors.white,
                                  borderRadius: BorderRadius.circular(4),
                                  boxShadow: [
                                    BoxShadow(
                                      color: Colors.grey.withOpacity(0.5),
                                      spreadRadius: 0.4,
                                      blurRadius: 0.5,
                                      offset: Offset(
                                          0, 1), // changes position of shadow
                                    ),
                                  ],
                                ),
                                child: Icon(Icons.edit),
                              ),
                              onTap: () {
                                Navigator.push(
                                    context,
                                    PageTransition(
                                        type: PageTransitionType.rightToLeft,
                                        duration: Duration(milliseconds: 300),
                                        child: EditCoupon(coupon.id)));
                              },
                            ))
                        : Text(""),

                    SizedBox(width: 0.05 * w_width),

                    //copy button
                    Container(
                      width: 0.28 * w_width,
                      height: 0.12 * w_width,
                      child: RaisedButton(
                          color: Colors.yellow,
                          child: !coupon.showCoupon
                              ? Text(
                                  mLocal.copy,
                                  style: TextStyle(fontFamily: fontBold),
                                )
                              : Text(
                                  coupon.code,
                                  style: TextStyle(fontFamily: fontBold),
                                ),
                          onPressed: () {
                            setState(() {
                              coupon.showCoupon = true;
                            });
                            Clipboard.setData(ClipboardData(text: coupon.code));
                            Scaffold.of(context).showSnackBar(SnackBar(
                              content: Text(
                                mLocal.copied,
                                textAlign: TextAlign.center,
                                style: TextStyle(
                                    color: Colors.white,
                                    fontSize: w_width * 0.04,
                                    fontFamily: fontBold),
                              ),
                              backgroundColor: Colors.black,
                              duration: Duration(milliseconds: 550),
                            ));
                          }),
                    ),
                  ],
                ),
              ),

              Container(
                width: 0.6 * w_width,
                height: 0.12 * w_width,
                child: RaisedButton(
                  color: Colors.blue,
                  child: Text(
                    mLocal.shop_link,
                    style: TextStyle(fontFamily: fontBold),
                  ),
                  onPressed: () {
                    print(coupon.link);
                    launch(coupon.link);
                  },
                ),
              ),
            ],
          ),
        ],
      ),
    );
  }

  void favClicked() {
    if (isHome) {
      // favorite button

      if (favIcon == Icons.favorite_border) {
        // not a fav item

        final ref = FirebaseDatabase.instance
            .reference()
            .child('users')
            .child(userId)
            .child("favorites")
            .child(coupon.id);

        print("url : ${coupon.logo}");
        ref.set(<String, String>{
          'store_img': coupon.logo,
          'coupon': coupon.code,
          'link': coupon.link,
          'desc': coupon.desc,
          'value': coupon.value,
          'store_name': coupon.store_name,
          'store_ar_name': coupon.store_ar_name,
          'insta': coupon.insta,
          'snap': coupon.snap,
          'website': coupon.website,
        });

        setState(() {
          favIcon = Icons.favorite;
          favWidth = 0.14 * 0.9 * width;
        });
      } else {
        // a fav item

        final ref = FirebaseDatabase.instance
            .reference()
            .child('users')
            .child(userId)
            .child("favorites")
            .child(coupon.id);

        ref.remove().whenComplete(() {
          setState(() {
            favIcon = Icons.favorite_border;
            favWidth = 0.12 * 0.9 * width;

            if (isFav) {
              favState.getUserFavCoupons();
            }
          });
        });
      }
    } else {
      // it's user page so we need to delete this coupon

      final ref = FirebaseDatabase.instance
          .reference()
          .child('coupons')
          .child(coupon.id);

      ref.remove().whenComplete(() {});

      state.getUserCoupons();
    }
  }

  void openLink(String url) async {
    if (await canLaunch(url)) {
      await launch(url);
    } else {
      print("invalide link $url");
      //throw 'Could not launch $url';
    }
  }

  void like() {
    final ref =
        FirebaseDatabase.instance.reference().child('coupons').child(coupon.id);
    if (!coupon.reactedTo) {
      ref.child('like').set((coupon.like + 1).toString());
      coupon.reactedTo = true;

      Scaffold.of(context).showSnackBar(SnackBar(
        content: Text(
          mLocal.thnx_rating,
          textAlign: TextAlign.center,
          style: TextStyle(
              color: Colors.white,
              fontSize: width * 0.04,
              fontFamily: fontBold),
        ),
        backgroundColor: Colors.black,
        duration: Duration(milliseconds: 550),
      ));
    } else {
      Scaffold.of(context).showSnackBar(SnackBar(
        content: Text(
          mLocal.you_cant_rate,
          textAlign: TextAlign.center,
          style: TextStyle(
              color: Colors.white,
              fontSize: width * 0.04,
              fontFamily: fontBold),
        ),
        backgroundColor: Colors.black,
        duration: Duration(milliseconds: 550),
      ));
    }
  }

  void dislike() {
    final ref =
        FirebaseDatabase.instance.reference().child('coupons').child(coupon.id);
    if (!coupon.reactedTo) {
      ref.child('dislike').set((coupon.dislike + 1).toString());
      coupon.reactedTo = true;

      Scaffold.of(context).showSnackBar(SnackBar(
        content: Text(
          mLocal.thnx_rating,
          textAlign: TextAlign.center,
          style: TextStyle(
              color: Colors.white,
              fontSize: width * 0.04,
              fontFamily: fontBold),
        ),
        backgroundColor: Colors.black,
        duration: Duration(milliseconds: 550),
      ));
    } else {
      Scaffold.of(context).showSnackBar(SnackBar(
        content: Text(
          mLocal.you_cant_rate,
          textAlign: TextAlign.center,
          style: TextStyle(
              color: Colors.white,
              fontSize: width * 0.04,
              fontFamily: fontBold),
        ),
        backgroundColor: Colors.black,
        duration: Duration(milliseconds: 550),
      ));
    }
  }
}
