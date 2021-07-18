import 'package:coupons/data/Helper.dart';
import 'package:coupons/main.dart';
import 'package:coupons/pages/UIHelper.dart';
import 'package:coupons/pages/auth/login_page.dart';
import 'package:coupons/pages/home_page.dart';
import 'package:coupons/pages/user/add_store.dart';
import 'package:coupons/pages/user/edit_user.dart';
import 'package:coupons/pages/user/favorit_page.dart';
import 'package:coupons/pages/user/user_page.dart';
import 'package:coupons/pages/welcome/about_page.dart';
import 'package:coupons/pages/welcome/polices_page.dart';
import 'package:page_transition/page_transition.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:url_launcher/url_launcher.dart';
import 'package:launch_review/launch_review.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:cloud_firestore/cloud_firestore.dart';

User loggedInUser;
final _firestore = FirebaseFirestore.instance;

class NavigationMenu extends StatelessWidget {
  bool isHome = true;
  bool isUserPage = false;
  bool isFav = false;
  bool isAddStore = false;
  String country;
  String email;
  String firstName;
  String lastName;
  String phone;
  var userData;

  final FirebaseAuth mAuth = FirebaseAuth.instance;
  User user;
  String userId;

  void fetchUserData() async {
    try {
      final user = mAuth.currentUser;
      if (user != null) {
        loggedInUser = user;
        DocumentSnapshot documentSnapshot = await _firestore
            .collection("couponati")
            .doc(loggedInUser.uid)
            .get();
        print(documentSnapshot.data());
        userData = documentSnapshot.data();
        country = userData['country'];
        email = userData['email'];
        firstName = userData['first_name'];
        lastName = userData['last_name'];
        phone = userData['phone'];
      }
    } catch (e) {
      print(e);
    }
  }

  NavigationMenu() {
    fetchUserData();
    user = mAuth.currentUser;
    if (user != null) {
      userId = user.uid;
    }
  }

  NavigationMenu.out() {
    isHome = false;
  }

  NavigationMenu.account() {
    isHome = false;
    isUserPage = true;
  }

  NavigationMenu.favorite() {
    isHome = false;
    isFav = true;
  }

  NavigationMenu.store() {
    isHome = false;
    isAddStore = true;
  }

  double height;
  double width;

  @override
  Widget build(BuildContext context) {
    height = MediaQuery.of(context)
        .size
        .height; //- MediaQuery.of(context).padding.top- MediaQuery.of(context).padding.bottom;
    width = MediaQuery.of(context).size.width;

    return Scaffold(
        backgroundColor: Colors.transparent,
        body: Row(
          children: <Widget>[
            Container(
                width: 0.6 * width,
                height: height,
                color: Colors.white,
                child: SingleChildScrollView(
                  child: Column(
                    mainAxisSize: MainAxisSize.max,
                    mainAxisAlignment: MainAxisAlignment.start,
                    children: <Widget>[
                      SizedBox(
                        height: 0.06 * height,
                      ),
                      Container(
                        width: width,
                        alignment: Alignment.center,
                        child: Material(
                          elevation: 4,
                          shape: RoundedRectangleBorder(
                              borderRadius: BorderRadius.circular(22.0)),
                          clipBehavior: Clip.antiAlias,
                          child: Image.asset(
                            'lib/assets/img/logo.png',
                            width: 0.28 * width,
                            height: 0.28 * width,
                            fit: BoxFit.fill,
                          ),
                        ),
                      ),

                      Text(
                        mLocal.app_name,
                        style: TextStyle(
                            fontSize: 0.07 * width,
                            color: Colors.black,
                            fontFamily: fontBold),
                      ),

                      ////////////////DVIDER//////////////////

                      Container(
                        height: 0.009 * height,
                        width: 0.2 * width,
                        alignment: Alignment.center,
                        margin: EdgeInsets.symmetric(horizontal: 0.035 * width),
                        decoration: BoxDecoration(
                            borderRadius: BorderRadius.circular(20),
                            color: Colors.white),
                      ),

                      firstName != null && lastName != null && email != null
                          ? Column(
                              crossAxisAlignment: CrossAxisAlignment.start,
                              children: [
                                Row(
                                  children: [
                                    Padding(
                                      padding: EdgeInsets.only(left: 5.2),
                                      child: Text(
                                        firstName + lastName,
                                        style: TextStyle(
                                            fontSize: 0.05 * width,
                                            color: Colors.black,
                                            fontFamily: fontBold),
                                      ),
                                    ),
                                    Spacer(),
                                    Material(
                                        color: Colors.transparent,
                                        child: InkWell(
                                          child: AnimatedContainer(
                                            duration:
                                                Duration(milliseconds: 200),
                                            decoration: BoxDecoration(
                                              color: Colors.white,
                                              borderRadius:
                                                  BorderRadius.circular(4),
                                              boxShadow: [
                                                BoxShadow(
                                                  color: Colors.grey
                                                      .withOpacity(0.5),
                                                  spreadRadius: 0.4,
                                                  blurRadius: 0.5,
                                                  offset: Offset(0,
                                                      1), // changes position of shadow
                                                ),
                                              ],
                                            ),
                                            child: Icon(Icons.edit),
                                          ),
                                          onTap: () {
                                            Navigator.push(
                                                context,
                                                PageTransition(
                                                    type: PageTransitionType
                                                        .rightToLeft,
                                                    duration: Duration(
                                                        milliseconds: 300),
                                                    child: EditUser(
                                                        country,
                                                        firstName,
                                                        lastName,
                                                        email,
                                                        phone)));
                                          },
                                        )),
                                  ],
                                ),
                                Padding(
                                  padding: EdgeInsets.only(left: 5.2),
                                  child: Text(
                                    email,
                                    style: TextStyle(
                                        fontSize: 0.04 * width,
                                        color: Colors.grey,
                                        fontFamily: fontBold),
                                  ),
                                ),
                              ],
                            )
                          : Text(""),

                      ////////////////////ELEMENTS/////////////////////

                      //SizedBox(height: 0.008*height,),

                      //home
                      menuElement("lib/assets/img/home.png", mLocal.home, () {
                        if (isHome) {
                          Navigator.pop(context);
                        } else {
                          Navigator.pop(context);
                          Navigator.push(
                              context,
                              PageTransition(
                                  type: PageTransitionType.rightToLeft,
                                  duration: Duration(milliseconds: 300),
                                  child: HomePage()));
                        }
                      }),

                      //login
                      auth
                          ? Container(
                              width: 0,
                              height: 0,
                            )
                          : menuElement(
                              "lib/assets/img/login.png", mLocal.login, () {
                              Navigator.pop(context);
                              Navigator.push(
                                  context,
                                  PageTransition(
                                      type: PageTransitionType.rightToLeft,
                                      duration: Duration(milliseconds: 300),
                                      child: LoginPage()));
                            }),

                      //my account
                      !auth
                          ? Container(
                              width: 0,
                              height: 0,
                            )
                          : menuElement(
                              "lib/assets/img/login.png", mLocal.my_account,
                              () {
                              Navigator.pop(context);

                              if (isHome || !isUserPage) {
                                Navigator.push(
                                    context,
                                    PageTransition(
                                        type: PageTransitionType.rightToLeft,
                                        duration: Duration(milliseconds: 300),
                                        child: UserPage()));
                              }
                            }),

                      //favorite
                      !auth
                          ? Container(
                              width: 0,
                              height: 0,
                            )
                          : menuElement(
                              "lib/assets/img/favorit.png", mLocal.favotrite,
                              () {
                              Navigator.pop(context);

                              if (isHome || !isFav) {
                                Navigator.push(
                                    context,
                                    PageTransition(
                                        type: PageTransitionType.rightToLeft,
                                        duration: Duration(milliseconds: 300),
                                        child: FavoritPage()));
                              }
                            }),

                      //add store
                      menuElement("lib/assets/img/store.png", mLocal.add_store,
                          () {
                        Navigator.pop(context);
                        if (isHome || !isAddStore) {
                          Navigator.push(
                              context,
                              PageTransition(
                                  type: PageTransitionType.rightToLeft,
                                  duration: Duration(milliseconds: 300),
                                  child: AddStore()));
                        }
                      }),

                      //rate us
                      menuElement("lib/assets/img/rate.png", mLocal.rate, () {
                        LaunchReview.launch(
                            androidAppId: "com.reda_dokkar.coupons",
                            iOSAppId: "585027354");
                      }),

                      //telegram
                      menuElement(
                          "lib/assets/img/telegram.png", mLocal.telegram,
                          () async {
                        await launch("https://t.me/couponee");
                      }),

                      //instagram
                      menuElement("lib/assets/img/insta.png", mLocal.instagram,
                          () async {
                        launch("https://www.instagram.com/coupone0/");
                      }),

                      //contact us
                      menuElement("lib/assets/img/contact.png", mLocal.contact,
                          () {
                        final Uri _emailLaunchUri = Uri(
                            scheme: 'mailto',
                            path: 'infocoupone@gmail.com',
                            queryParameters: {
                              'subject': 'إستفسار | Question',
                              'body':
                                  'اكتب رسالتك هنا  \n write your message here'
                            });

                        launch(_emailLaunchUri.toString());
                      }),

                      //logout
                      !auth
                          ? Container(
                              width: 0,
                              height: 0,
                            )
                          : menuElement(
                              "lib/assets/img/logout.png", mLocal.logout, () {
                              final FirebaseAuth mAuth = FirebaseAuth.instance;
                              mAuth.signOut();
                              auth = false;
                              userId = "";
                              Navigator.pop(context);
                              Navigator.pushReplacement(
                                  context,
                                  PageTransition(
                                      type: PageTransitionType.rightToLeft,
                                      duration: Duration(milliseconds: 300),
                                      child: HomePage()));
                            }),

                      // help
                      menuElement("lib/assets/img/help.png", mLocal.help, () {
                        Navigator.pop(context);

                        Navigator.push(
                            context,
                            PageTransition(
                                type: PageTransitionType.rightToLeft,
                                duration: Duration(milliseconds: 300),
                                child: AboutPage()));
                      }),

                      SizedBox(
                        height: 0.02 * height,
                      ),

                      /////////////////////////LANGUAGE////////////////////////////////////////
                      Container(
                        height: 0.06 * height,
                        width: 0.6 * width,
                        child: Row(
                          mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                          children: <Widget>[
                            Material(
                              color: Colors.transparent,
                              child: InkWell(
                                onTap: () {
                                  SharedPreferences.getInstance().then((value) {
                                    SharedPreferences prefs = value;
                                    prefs.setBool('is_arabic', true);
                                    isArabic = true;
                                    Navigator.pop(context);
                                    //Navigator.popUntil(context, (route) => false);
                                    Navigator.pushReplacement(
                                        context,
                                        PageTransition(
                                            type:
                                                PageTransitionType.rightToLeft,
                                            duration:
                                                Duration(milliseconds: 300),
                                            child: MyApp()));
                                  });
                                },
                                child: Container(
                                    width: width * 0.18,
                                    height: 0.04 * height,
                                    decoration: BoxDecoration(
                                        color: isArabic
                                            ? Colors.yellow
                                            : Colors.white,
                                        borderRadius: BorderRadius.circular(8)),
                                    child: Center(
                                      child: Text(
                                        "عربي",
                                        style: TextStyle(
                                            color: Colors.black,
                                            fontSize: width * 0.04,
                                            fontFamily: "pr_ar_bold"),
                                      ),
                                    )),
                              ),
                            ),
                            SizedBox(
                              width: 0.02 * width,
                            ),
                            Material(
                              color: Colors.transparent,
                              child: InkWell(
                                onTap: () {
                                  SharedPreferences.getInstance().then((value) {
                                    SharedPreferences prefs = value;
                                    prefs.setBool('is_arabic', false);
                                    isArabic = false;
                                    Navigator.pop(context);
                                    //Navigator.popUntil(context, (route) => false);
                                    Navigator.pushReplacement(
                                        context,
                                        PageTransition(
                                            type:
                                                PageTransitionType.rightToLeft,
                                            duration:
                                                Duration(milliseconds: 300),
                                            child: MyApp()));
                                  });
                                },
                                child: Container(
                                    width: width * 0.18,
                                    height: 0.04 * height,
                                    decoration: BoxDecoration(
                                        color: !isArabic
                                            ? Colors.yellow
                                            : Colors.white,
                                        borderRadius: BorderRadius.circular(8)),
                                    child: Center(
                                      child: Text(
                                        "English",
                                        style: TextStyle(
                                            color: Colors.black,
                                            fontSize: width * 0.04,
                                            fontFamily: "pr_en_bold"),
                                      ),
                                    )),
                              ),
                            ),
                          ],
                        ),
                      ),

                      SizedBox(
                        height: 0.04 * height,
                      ),

                      ////////////////PRIVACY /////////////////////////////////////////////
                      Row(
                        mainAxisAlignment: MainAxisAlignment.center,
                        children: <Widget>[
                          GestureDetector(
                            onTap: () {
                              Navigator.pop(context);

                              Navigator.push(
                                  context,
                                  PageTransition(
                                      type: PageTransitionType.rightToLeft,
                                      duration: Duration(milliseconds: 300),
                                      child: PoliciesPage.terms()));
                            },
                            child: Text(
                              mLocal.terms_of_use,
                              style: TextStyle(
                                  color: Colors.grey,
                                  fontSize: width * 0.035,
                                  fontFamily: fontBold),
                            ),
                          ),
                          SizedBox(
                            width: 0.02 * width,
                          ),
                          Text(
                            ".",
                            style: TextStyle(
                                color: Colors.grey,
                                fontSize: width * 0.035,
                                fontFamily: "pr_ar_bold"),
                          ),
                          SizedBox(
                            width: 0.02 * width,
                          ),
                          GestureDetector(
                            onTap: () {
                              Navigator.pop(context);

                              Navigator.push(
                                  context,
                                  PageTransition(
                                      type: PageTransitionType.rightToLeft,
                                      duration: Duration(milliseconds: 300),
                                      child: PoliciesPage.privacy()));
                            },
                            child: Text(
                              mLocal.privacy_policy,
                              style: TextStyle(
                                  color: Colors.grey,
                                  fontSize: width * 0.035,
                                  fontFamily: fontBold),
                            ),
                          ),
                        ],
                      ),

                      SizedBox(
                        height: 0.02 * height,
                      ),
                    ],
                  ),
                )),
            GestureDetector(
              onTap: () {
                Navigator.pop(context);
              },
              child: Container(
                width: 0.4 * width,
                color: Colors.transparent,
              ),
            ),
          ],
        ));
  }

  Widget menuElement(String img, String title, Function onTap) {
    double w_width = 0.56 * width;
    double w_height = 0.05 * height;

    return Material(
      color: Colors.transparent,
      child: InkWell(
        highlightColor: Colors.yellow[200],
        onTap: () {
          onTap();
        },
        child: Container(
          width: w_width,
          height: w_height,
          margin: EdgeInsets.symmetric(
              vertical: 0.3 * w_height, horizontal: 0.05 * w_width),
          child: Row(
            mainAxisAlignment: MainAxisAlignment.start,
            crossAxisAlignment: CrossAxisAlignment.center,
            children: <Widget>[
              Container(
                height: 0.8 * w_height,
                width: 0.04 * w_width,
                color: Colors.yellow,
              ),
              SizedBox(
                width: 0.05 * w_width,
              ),
              Image.asset(
                img,
                width: 0.1 * w_width,
                height: 0.1 * w_width,
              ),
              SizedBox(
                width: 0.05 * w_width,
              ),
              Text(
                title,
                style: TextStyle(
                    color: Colors.black,
                    fontSize: 0.07 * w_width,
                    fontFamily: fontBold),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
