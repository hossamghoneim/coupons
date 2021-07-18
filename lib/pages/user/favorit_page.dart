import 'package:coupons/data/Helper.dart';
import 'package:coupons/data/model/coupon.dart';
import 'package:coupons/pages/navigation_menu.dart';
import 'package:coupons/pages/user/add_coupon.dart';
import 'package:coupons/pages/widgets/coupon_widget.dart';
import 'package:coupons/pages/widgets/empty_page_widget.dart';
import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';
import 'package:page_transition/page_transition.dart';
import 'package:firebase_database/firebase_database.dart';
import '../UIHelper.dart';

class FavoritPage extends StatefulWidget {
  @override
  State<StatefulWidget> createState() {
    return FavoritPageState();
  }
}

class FavoritPageState extends State<FavoritPage> {
  double height;
  double width;

  List<Coupon> list = [];

  @override
  void initState() {
    getUserFavCoupons();
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    height = MediaQuery.of(context).size.height -
        MediaQuery.of(context).padding.top -
        MediaQuery.of(context).padding.bottom -
        MediaQuery.of(context).viewInsets.top -
        MediaQuery.of(context).viewInsets.bottom;
    width = MediaQuery.of(context).size.width;

    var scaffoldKey = GlobalKey<ScaffoldState>();

    return Scaffold(
      backgroundColor: Colors.white,
      drawer: NavigationMenu.favorite(),
      key: scaffoldKey,
      body: Column(
        mainAxisAlignment: MainAxisAlignment.start,
        crossAxisAlignment: CrossAxisAlignment.start,
        children: <Widget>[
          ///////////HEADER/////////////////

          Container(
              width: width,
              height: 0.095 * height,
              padding: EdgeInsets.only(
                  top: 0.035 * height, right: 0.04 * width, left: 0.04 * width),
              decoration: BoxDecoration(
                color: Colors.white,
                borderRadius: BorderRadius.only(
                    bottomLeft: Radius.circular(2),
                    bottomRight: Radius.circular(2)),
                boxShadow: [
                  BoxShadow(
                    color: Colors.grey.withOpacity(0.25),
                    spreadRadius: 0.1,
                    blurRadius: 0.2,
                    offset: Offset(0, 1), // changes position of shadow
                  ),
                ],
              ),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.center,
                mainAxisAlignment: MainAxisAlignment.center,
                children: <Widget>[
                  /////TOP BAR NAME AND ICONS////////
                  Container(
                    width: width,
                    height: 0.06 * height,
                    child: Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      crossAxisAlignment: CrossAxisAlignment.center,
                      children: <Widget>[
                        GestureDetector(
                          onTap: () {
                            scaffoldKey.currentState.openDrawer();
                          },
                          child: Image.asset(
                            "lib/assets/img/menu.png",
                            width: 0.06 * width,
                            height: 0.06 * width,
                          ),
                        ),
                        Container(
                          child: Text(
                            mLocal.app_name,
                            textAlign: TextAlign.center,
                            style: TextStyle(
                              color: Colors.black,
                              fontFamily: fontBold,
                              fontSize: 0.045 * width,
                            ),
                          ),
                        ),
                        GestureDetector(
                          onTap: () {
                            scaffoldKey.currentState.openDrawer();
                          },
                          child: Image.asset(
                            "lib/assets/img/logout.png",
                            width: 0.06 * width,
                            height: 0.06 * width,
                            color: Colors.white,
                          ),
                        ),
                      ],
                    ),
                  ),
                ],
              )),

          /////////COUPONS NB///////////////

          Container(
            padding: EdgeInsets.symmetric(
                vertical: 0.0035 * height, horizontal: width * 0.02),
            child: Text(
              mLocal.favotrite,
              textAlign: TextAlign.center,
              style: TextStyle(
                color: Colors.black87,
                fontFamily: fontBold,
                fontSize: 0.06 * width,
              ),
            ),
          ),

          list.length > 0
              ? fullList(context)
              : EmptyPage(mLocal.empty_coupons, width, height)
        ],
      ),
    );
  }

  Widget emptyList() {
    return EmptyPage(mLocal.empty_coupons, width, height);
  }

  Widget fullList(BuildContext context) {
    return Container(
      child:
          /////////////////////////COUPONS LIST////////////////////////////////////////
          MediaQuery.removePadding(
        context: context,
        removeTop: true,
        child: Container(
          height: 0.88 * height,
          color: Colors.grey[100],
          child: ListView.builder(
              scrollDirection: Axis.vertical,
              itemCount: list.length,
              shrinkWrap: true,
              itemBuilder: (context, position) {
                return CouponWidget.fromFav(
                    list[position], width, height, true, this);
              }),
        ),
      ),
    );
  }

  void getUserFavCoupons() async {
    final ref = FirebaseDatabase.instance
        .reference()
        .child('users')
        .child(userId)
        .child("favorites");
    Map<dynamic, dynamic> stores;

    list.clear();

    var snapShot = await ref.once();

    stores = snapShot.value;

    if (stores != null) {
      stores.forEach((key, value) {
        Coupon coupon = Coupon();

        coupon.code = value['coupon'];
        coupon.link = value['link'];
        coupon.desc = value['desc'];
        coupon.logo = value['store_img'];
        coupon.value = value['value'];
        coupon.store_name = value['store_name'];
        coupon.store_ar_name = value['store_ar_name'];
        coupon.insta = value['insta'];
        coupon.snap = value['snap'];
        coupon.website = value['website'];
        coupon.owner = userId;
        coupon.id = key.toString();

        list.add(coupon);
      });
    }

    setState(() {});
  }
}
