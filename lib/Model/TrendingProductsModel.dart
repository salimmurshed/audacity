import 'package:http/http.dart' as http;
import 'dart:convert';
import 'dart:convert' as convert;

class TrendingProductsModel {
  String slNo;
  String productName;
  String shortDetails;
  String productDescription;
  int availableStock;
  int orderQty;
  int salesQty;
  int orderAmount;
  int salesAmount;
  int discountPercent;
  int discountAmount;
  int unitPrice;
  String productImage;
  String sellerName;
  String sellerProfilePhoto;
  String sellerCoverPhoto;
  String ezShopName;
  int defaultPushScore;
  String myProductVarId;

  TrendingProductsModel(
      {this.slNo,
      this.productName,
      this.shortDetails,
      this.productDescription,
      this.availableStock,
      this.orderQty,
      this.salesQty,
      this.orderAmount,
      this.salesAmount,
      this.discountPercent,
      this.discountAmount,
      this.unitPrice,
      this.productImage,
      this.sellerName,
      this.sellerProfilePhoto,
      this.sellerCoverPhoto,
      this.ezShopName,
      this.defaultPushScore,
      this.myProductVarId});

  TrendingProductsModel.fromJson(Map<String, dynamic> json) {
    slNo = json['slNo'];
    productName = json['productName'];
    shortDetails = json['shortDetails'];
    productDescription = json['productDescription'];
    availableStock = json['availableStock'];
    orderQty = json['orderQty'];
    salesQty = json['salesQty'];
    orderAmount = json['orderAmount'];
    salesAmount = json['salesAmount'];
    discountPercent = json['discountPercent'];
    discountAmount = json['discountAmount'];
    unitPrice = json['unitPrice'];
    productImage = json['productImage'];
    sellerName = json['sellerName'];
    sellerProfilePhoto = json['sellerProfilePhoto'];
    sellerCoverPhoto = json['sellerCoverPhoto'];
    ezShopName = json['ezShopName'];
    defaultPushScore = json['defaultPushScore'];
    myProductVarId = json['myProductVarId'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['slNo'] = this.slNo;
    data['productName'] = this.productName;
    data['shortDetails'] = this.shortDetails;
    data['productDescription'] = this.productDescription;
    data['availableStock'] = this.availableStock;
    data['orderQty'] = this.orderQty;
    data['salesQty'] = this.salesQty;
    data['orderAmount'] = this.orderAmount;
    data['salesAmount'] = this.salesAmount;
    data['discountPercent'] = this.discountPercent;
    data['discountAmount'] = this.discountAmount;
    data['unitPrice'] = this.unitPrice;
    data['productImage'] = this.productImage;
    data['sellerName'] = this.sellerName;
    data['sellerProfilePhoto'] = this.sellerProfilePhoto;
    data['sellerCoverPhoto'] = this.sellerCoverPhoto;
    data['ezShopName'] = this.ezShopName;
    data['defaultPushScore'] = this.defaultPushScore;
    data['myProductVarId'] = this.myProductVarId;
    return data;
  }

  static List<TrendingProductsModel> fromJsonList(jsonList) {
    return jsonList
        .map<TrendingProductsModel>(
            (obj) => TrendingProductsModel.fromJson(obj))
        .toList();
  }
}

abstract class TrendingProductsRepository {
  Future<List<TrendingProductsModel>> getTrendingProductss();
}

class TrendingProductsRepositoryImpl extends TrendingProductsRepository {
  @override
  Future<List<TrendingProductsModel>> getTrendingProductss() async {
    var response = await http.get(
        'https://bd.ezassist.me/ws/mpFeed?instanceName=bd.ezassist.me&opt=trendingProducts');
    if (response.statusCode == 200) {
      var data = json.decode(response.body);

      List<TrendingProductsModel> trendingProduct =
          TrendingProductsModel.fromJsonList(data[0]);
      return trendingProduct;
    } else {
      throw Exception('Failed');
    }
  }
}
