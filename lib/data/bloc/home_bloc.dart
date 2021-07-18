import 'dart:collection';
import 'package:coupons/data/model/company.dart';
import 'package:coupons/data/model/coupon.dart';
import 'package:coupons/data/state/home_state.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:firebase_database/firebase_database.dart';

import '../Helper.dart';

enum HomeEvents { getStores, getCoupons, getFiltredList, searchCoupon }

class HomeBloc extends Bloc<HomeEvents, HomeState> {
  HomeBloc(HomeState initialState) : super(initialState);

  @override
  Stream<HomeState> mapEventToState(HomeEvents event) async* {
    switch (event) {
      case HomeEvents.getStores:
        {
          final ref = FirebaseDatabase.instance.reference().child('stores');
          Map<dynamic, dynamic> stores;
          List<Company> companies = [];

          var snapShot = await ref.once();

          stores = snapShot.value;

          stores.forEach((key, value) {
            var company = Company("name", "logo");

            company.name = key.toString();
            var info = value as LinkedHashMap;

            company.logo = info['img'];
            company.arName = info['ar_name'];
            companies.add(company);
          });

          print("we have ${companies.length} store");

          companiesList = companies;

          var company = Company("name", "logo");
          company.arName = "الكل";
          company.logo =
              "https://encrypted-tbn0.gstatic.com/images?q=tbn%3AANd9GcQNrnXatB6rZmpmqQyAn7cF4Co2pVqRfrLNNg&usqp=CAU";
          company.name = "All";
          companies.insert(0, company);

          HomeState newState = new HomeState();
          newState.companies = companies;
          newState.coupons = state.coupons;

          yield newState;

          break;
        }

      case HomeEvents.getCoupons:
        {
          final ref = FirebaseDatabase.instance.reference().child('coupons');
          Map<dynamic, dynamic> stores;
          List<Coupon> list = [];
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
              coupon.like = int.parse(value['like']);
              coupon.dislike = int.parse(value['dislike']);
              coupon.owner = userId;
              coupon.id = key.toString();
              coupon.showCoupon = false;

              if (coupon.dislike - coupon.like < -40) {
                //del
                FirebaseDatabase.instance
                    .reference()
                    .child('coupons')
                    .child(coupon.id)
                    .remove();
              } else {
                list.add(coupon);
              }
            });
          }

          HomeState newState = new HomeState();
          newState.coupons = list;
          newState.companies = state.companies;

          print("we have ${list.length} coupon");

          yield newState;

          break;
        }

      case HomeEvents.getFiltredList:
        {
          HomeState newState = new HomeState();

          print("size ->" + state.selectedCompanies.length.toString());
          List<Coupon> searchList = [];
          if (state.allCoupons.isNotEmpty) {
            searchList = state.allCoupons;
          } else {
            searchList = state.coupons;
          }
          if (state.selectedCompanies.isNotEmpty &&
              !state.selectedCompanies.contains("All")) {
            List<Coupon> tmpList = [];
            searchList.forEach((element) {
              if (state.selectedCompanies.contains(element.store_name)) {
                tmpList.add(element);
              }
            });

            newState.allCoupons = searchList;
            newState.coupons = tmpList;
            newState.companies = state.companies;
            newState.selectedCompanies = state.selectedCompanies;
          } else {
            newState.coupons = searchList;
            //newState.allCoupons = [];
            newState.companies = state.companies;
          }

          yield newState;

          break;
        }

      case HomeEvents.searchCoupon:
        {
          HomeState newState = new HomeState();
          if (state.query != "") {
            List<Coupon> list = [];
            List<Coupon> tmpList = [];
            if (state.allCoupons.isEmpty) {
              tmpList = state.coupons;
            } else {
              tmpList = state.allCoupons;
            }
            tmpList.forEach((element) {
              if (element.desc.contains(state.query)) {
                list.add(element);
              }
            });

            if (state.allCoupons.isNotEmpty) {
              newState.allCoupons = state.allCoupons;
            } else {
              newState.allCoupons = state.coupons;
            }

            newState.coupons = list;
            newState.companies = state.companies;
          } else {
            newState.coupons = state.allCoupons;
            newState.allCoupons = [];
            newState.companies = state.companies;
          }

          yield newState;

          break;
        }
    }
  }
}
