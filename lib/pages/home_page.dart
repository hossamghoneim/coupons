import 'dart:io';

import 'package:coupons/data/bloc/home_bloc.dart';
import 'package:coupons/data/model/company.dart';
import 'package:coupons/data/model/coupon.dart';
import 'package:coupons/data/state/home_state.dart';
import 'package:coupons/pages/navigation_menu.dart';
import 'package:coupons/pages/widgets/coupon_widget.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter/material.dart';
import 'package:share/share.dart';

import 'UIHelper.dart';

List<String> selectedCompanies = [];
final HomeBloc _bloc = new HomeBloc(HomeState());

HomeState mHomeState;

class HomePage extends StatelessWidget {
  double height;
  double width;

  var scaffoldKey = GlobalKey<ScaffoldState>();

  List<Company> list = [];
  List<Coupon> coupons = [];

  @override
  Widget build(BuildContext context) {
    height = MediaQuery.of(context).size.height -
        MediaQuery.of(context).padding.top -
        MediaQuery.of(context).padding.bottom -
        MediaQuery.of(context).viewInsets.top -
        MediaQuery.of(context).viewInsets.bottom;
    width = MediaQuery.of(context).size.width;

    _bloc.add(HomeEvents.getStores);
    _bloc.add(HomeEvents.getCoupons);

    return BlocBuilder<HomeBloc, HomeState>(
      bloc: _bloc,
      builder: (context, state) {
        mHomeState = state;
        list = state.companies;
        coupons = state.coupons;

        return Scaffold(
            key: scaffoldKey,
            backgroundColor: Colors.white,
            drawer: NavigationMenu(),
            body: Center(
                child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: <Widget>[
                SizedBox(
                  height: 0.045 * height,
                ),

                /////////////////////////////SEARCH BAR //////////////////////////////////////

                Container(
                  width: width,
                  height: height * 0.055,
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    crossAxisAlignment: CrossAxisAlignment.center,
                    mainAxisSize: MainAxisSize.min,
                    children: <Widget>[
                      SizedBox(
                        width: 0.035,
                      ),
                      GestureDetector(
                        child: Image.asset(
                          "lib/assets/img/menu.png",
                          height: 0.03 * height,
                          width: 0.08 * width,
                        ),
                        onTap: () {
                          scaffoldKey.currentState.openDrawer();
                        },
                      ),
                      SizedBox(
                        width: 0.01,
                      ),
                      Container(
                          width: width * 0.7,
                          alignment: Alignment.bottomCenter,
                          padding: EdgeInsets.only(top: 0.022 * height),
                          decoration: BoxDecoration(
                              color: Colors.grey[200],
                              borderRadius: BorderRadius.circular(20)),
                          child: Container(
                            child: TextField(
                              cursorColor: Colors.black,
                              textAlign: TextAlign.center,
                              style: TextStyle(
                                  color: Colors.black,
                                  fontSize: 0.04 * width,
                                  fontFamily: fontReg),
                              onChanged: (value) {
                                mHomeState.query = value;
                                _bloc.add(HomeEvents.searchCoupon);
                              },
                              decoration: InputDecoration.collapsed(
                                border: InputBorder.none,
                                hintText: mLocal.search_hint,
                                hintStyle: TextStyle(
                                    color: Colors.black,
                                    fontSize: 0.04 * width,
                                    fontFamily: fontBold),
                              ),
                            ),
                          )),
                      SizedBox(
                        width: 0.03,
                      ),
                      GestureDetector(
                        onTap: () {
                          Share.share(mLocal.share +
                              '\n https://play.google.com/store/apps/details?id=com.reda_dokkar.coupons \n https://apps.apple.com/app/idXXXXXXXXX');
                        },
                        child: Image.asset(
                          "lib/assets/img/share.png",
                          height: 0.03 * height,
                          width: 0.08 * width,
                        ),
                      ),
                      SizedBox(
                        width: 0.03,
                      ),
                    ],
                  ),
                ),

                SizedBox(
                  height: 0.01 * height,
                ),

                ///////////////////////////COMPANIES////////////////////////////////////////

                SizedBox(
                  height: 0.01 * height,
                ),

                Container(
                  height: 0.12 * height,
                  child: ListView.builder(
                      scrollDirection: Axis.horizontal,
                      itemCount: list.length,
                      itemBuilder: (context, position) {
                        return CompanyWidget(list[position], width, height);
                      }),
                ),

                SizedBox(
                  height: 0.01 * height,
                ),

                Container(
                  height: 0.0035 * height,
                  alignment: Alignment.center,
                  decoration: BoxDecoration(
                      borderRadius: BorderRadius.circular(20),
                      color: Colors.grey[200]),
                ),

                SizedBox(
                  height: 0.015 * height,
                ),

                ////////////////////////////COUPONS AND DEALS///////////////////////////////////////

                SizedBox(
                  height: 0.015 * height,
                ),

                Container(
                  padding: EdgeInsets.symmetric(horizontal: 0.02 * width),
                  child: Text(
                    mLocal.home_deals,
                    style: TextStyle(
                        color: Colors.black,
                        fontSize: 0.06 * width,
                        fontFamily: fontBold),
                    textAlign: TextAlign.start,
                  ),
                ),

                SizedBox(
                  height: 0.015 * height,
                ),
                /////////////////////////COUPONS LIST////////////////////////////////////////

                MediaQuery.removePadding(
                  context: context,
                  removeTop: true,
                  child: Container(
                    height: 0.68 * height,
                    child: ListView.builder(
                        scrollDirection: Axis.vertical,
                        key: Key('matsList'),
                        itemCount: coupons.length,
                        shrinkWrap: true,
                        itemBuilder: (context, position) {
                          return new Container(
                              child: CouponWidget(
                                  coupons[position], width, height, true),
                              key: UniqueKey());
                        }),
                  ),
                ),
              ],
            )));
      },
    );
  }
}

class CompanyWidget extends StatefulWidget {
  Company company;
  double width;
  double height;

  CompanyWidget(Company company, double width, double height) {
    this.company = company;
    this.width = width;
    this.height = height;
  }

  @override
  State<StatefulWidget> createState() {
    return CompanyWidgetState();
  }
}

class CompanyWidgetState extends State<CompanyWidget> {
  Company company;
  double width;
  double height;

  Color txtColor = Colors.black;

  @override
  void initState() {
    width = widget.width;
    height = widget.height;
    company = widget.company;
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Container(
      width: width * 0.18,
      height: height * 0.1,
      margin: EdgeInsets.symmetric(horizontal: 0.04 * width),
      child: Material(
        color: Colors.transparent,
        child: InkWell(
          onTap: () {
            onCompanyClicked();
          },
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
                  fontFamily: fontReg,
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

  void onCompanyClicked() {
    print("clicked ->${company.name}");
    if (txtColor == Colors.black) {
      txtColor = Colors.yellow[900];
      mHomeState.selectedCompanies.add(company.name);
    } else {
      txtColor = Colors.black;
      mHomeState.selectedCompanies.removeWhere((value) {
        return value == company.name;
      });
    }

    _bloc.add(HomeEvents.getFiltredList);

    setState(() {});
  }
}
