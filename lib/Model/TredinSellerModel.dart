import 'package:audacity/Utils/Urls.dart';
import 'package:audacity/Utils/Utils.dart';
import 'package:http/http.dart' as http;
import 'dart:convert';
import 'dart:convert' as convert;

class TredinSellersModel {
  String slNo;
  String sellerName;
  String sellerProfilePhoto;
  String sellerItemPhoto;
  String ezShopName;
  var defaultPushScore;
  String aboutCompany;
  var allowCOD;
  String division;
  String subDivision;
  String city;
  String state;
  String zipcode;
  String country;
  String currencyCode;
  var orderQty;
  var orderAmount;
  var salesQty;
  var salesAmount;
  var highestDiscountPercent;
  String lastAddToCart;
  String lastAddToCartThatSold;

  TredinSellersModel(
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

  TredinSellersModel.fromJson(Map<String, dynamic> json) {
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

  static List<TredinSellersModel> fromJsonList(jsonList) {
    return jsonList
        .map<TredinSellersModel>((obj) => TredinSellersModel.fromJson(obj))
        .toList();
  }
}

abstract class TredinSellersRepository {
  Future<List<TredinSellersModel>> getTredinSellerss();
}

class TredinSellersRepositoryImpl extends TredinSellersRepository {
  @override
  Future<List<TredinSellersModel>> getTredinSellerss() async {
    bool isOnLine = await isOnline();
    if (isOnLine) {
      var response = await http.get(tredingSellerURL);
      if (response.statusCode == 200) {
        saveResponse('TredinSellerResponse', response.body);
        var data = json.decode(response.body);

        List<TredinSellersModel> tredinSeller =
            TredinSellersModel.fromJsonList(data[0]);
        return tredinSeller;
      } else {
        throw Exception('Failed');
      }
    } else {
      String TredinSellerOfflineResponse =
          await getResponse('TredinSellerResponse');
      if (TredinSellerOfflineResponse == null) {
        throw Exception('No Internet and no cachhe !');
      } else {
        var data = json.decode(TredinSellerOfflineResponse);
        List<TredinSellersModel> TredinSeller =
            TredinSellersModel.fromJsonList(data[0]);
        return TredinSeller;
      }
    }
  }
}
