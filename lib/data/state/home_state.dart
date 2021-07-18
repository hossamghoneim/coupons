import 'package:coupons/data/model/company.dart';
import 'package:coupons/data/model/coupon.dart';
class HomeState {
  List<Company> companies = [];

  List<Coupon> coupons = [];

  List<Coupon> allCoupons = [];

  List<String> selectedCompanies = [];

  String query = "";
  
}