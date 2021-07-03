import 'package:http/http.dart' as http;
import 'dart:convert';
import 'dart:convert' as convert;

class NewShopsModel {
  String slNo;
  String sellerName;
  String sellerProfilePhoto;
  String sellerItemPhoto;
  String ezShopName;
  double defaultPushScore;
  String aboutCompany;
  int allowCOD;
  Null division;
  Null subDivision;
  String city;
  String state;
  String zipcode;
  String country;
  String currencyCode;
  int orderQty;
  int orderAmount;
  int salesQty;
  int salesAmount;
  int highestDiscountPercent;
  String lastAddToCart;
  String lastAddToCartThatSold;

  NewShopsModel(
      {this.slNo,
      this.sellerName,
      this.sellerProfilePhoto,
      this.sellerItemPhoto,
      this.ezShopName,
      this.defaultPushScore,
      this.aboutCompany,
      this.allowCOD,
      this.division,
      this.subDivision,
      this.city,
      this.state,
      this.zipcode,
      this.country,
      this.currencyCode,
      this.orderQty,
      this.orderAmount,
      this.salesQty,
      this.salesAmount,
      this.highestDiscountPercent,
      this.lastAddToCart,
      this.lastAddToCartThatSold});

  NewShopsModel.fromJson(Map<String, dynamic> json) {
    slNo = json['slNo'];
    sellerName = json['sellerName'];
    sellerProfilePhoto = json['sellerProfilePhoto'];
    sellerItemPhoto = json['sellerItemPhoto'];
    ezShopName = json['ezShopName'];
    defaultPushScore = json['defaultPushScore'];
    aboutCompany = json['aboutCompany'];
    allowCOD = json['allowCOD'];
    division = json['division'];
    subDivision = json['subDivision'];
    city = json['city'];
    state = json['state'];
    zipcode = json['zipcode'];
    country = json['country'];
    currencyCode = json['currencyCode'];
    orderQty = json['orderQty'];
    orderAmount = json['orderAmount'];
    salesQty = json['salesQty'];
    salesAmount = json['salesAmount'];
    highestDiscountPercent = json['highestDiscountPercent'];
    lastAddToCart = json['lastAddToCart'];
    lastAddToCartThatSold = json['lastAddToCartThatSold'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['slNo'] = this.slNo;
    data['sellerName'] = this.sellerName;
    data['sellerProfilePhoto'] = this.sellerProfilePhoto;
    data['sellerItemPhoto'] = this.sellerItemPhoto;
    data['ezShopName'] = this.ezShopName;
    data['defaultPushScore'] = this.defaultPushScore;
    data['aboutCompany'] = this.aboutCompany;
    data['allowCOD'] = this.allowCOD;
    data['division'] = this.division;
    data['subDivision'] = this.subDivision;
    data['city'] = this.city;
    data['state'] = this.state;
    data['zipcode'] = this.zipcode;
    data['country'] = this.country;
    data['currencyCode'] = this.currencyCode;
    data['orderQty'] = this.orderQty;
    data['orderAmount'] = this.orderAmount;
    data['salesQty'] = this.salesQty;
    data['salesAmount'] = this.salesAmount;
    data['highestDiscountPercent'] = this.highestDiscountPercent;
    data['lastAddToCart'] = this.lastAddToCart;
    data['lastAddToCartThatSold'] = this.lastAddToCartThatSold;
    return data;
  }

  static List<NewShopsModel> fromJsonList(jsonList) {
    return jsonList
        .map<NewShopsModel>((obj) => NewShopsModel.fromJson(obj))
        .toList();
  }
}

abstract class NewShopRepository {
  Future<List<NewShopsModel>> getNewShops();
}

class NewShopRepositoryImpl extends NewShopRepository {
  @override
  Future<List<NewShopsModel>> getNewShops() async {
    var response = await http.get(
        'https://bd.ezassist.me/ws/mpFeed?instanceName=bd.ezassist.me&opt=newShops');
    if (response.statusCode == 200) {
      var data = json.decode(response.body);

      List<NewShopsModel> newShop = NewShopsModel.fromJsonList(data[0]);
      return newShop;
    } else {
      throw Exception('Failed');
    }
  }
}
