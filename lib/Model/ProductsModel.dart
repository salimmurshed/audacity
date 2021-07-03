import 'package:audacity/Utils/Urls.dart';
import 'package:audacity/Utils/Utils.dart';
import 'package:http/http.dart' as http;
import 'dart:convert';
import 'dart:convert' as convert;

class ProductsModel {
  String storyTime;
  String story;
  String storyType;
  String storyImage;
  String storyAdditionalImages;
  String promoImage;
  int orderQty;
  String lastAddToCart;
  int availableStock;
  String myId;
  String ezShopName;
  String companyName;
  String companyLogo;
  String companyEmail;
  String currencyCode;
  int unitPrice;
  int discountAmount;
  int discountPercent;
  String iMyID;
  String shopName;
  String shopLogo;
  String shopLink;
  String friendlyTimeDiff;
  String slNo;

  ProductsModel(
      {this.storyTime,
      this.story,
      this.storyType,
      this.storyImage,
      this.storyAdditionalImages,
      this.promoImage,
      this.orderQty,
      this.lastAddToCart,
      this.availableStock,
      this.myId,
      this.ezShopName,
      this.companyName,
      this.companyLogo,
      this.companyEmail,
      this.currencyCode,
      this.unitPrice,
      this.discountAmount,
      this.discountPercent,
      this.iMyID,
      this.shopName,
      this.shopLogo,
      this.shopLink,
      this.friendlyTimeDiff,
      this.slNo});

  ProductsModel.fromJson(Map<String, dynamic> json) {
    storyTime = json['storyTime'];
    story = json['story'];
    storyType = json['storyType'];
    storyImage = json['storyImage'];
    storyAdditionalImages = json['storyAdditionalImages'];
    promoImage = json['promoImage'];
    orderQty = json['orderQty'];
    lastAddToCart = json['lastAddToCart'];
    availableStock = json['availableStock'];
    myId = json['myId'];
    ezShopName = json['ezShopName'];
    companyName = json['companyName'];
    companyLogo = json['companyLogo'];
    companyEmail = json['companyEmail'];
    currencyCode = json['currencyCode'];
    unitPrice = json['unitPrice'];
    discountAmount = json['discountAmount'];
    discountPercent = json['discountPercent'];
    iMyID = json['iMyID'];
    shopName = json['shopName'];
    shopLogo = json['shopLogo'];
    shopLink = json['shopLink'];
    friendlyTimeDiff = json['friendlyTimeDiff'];
    slNo = json['slNo'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['storyTime'] = this.storyTime;
    data['story'] = this.story;
    data['storyType'] = this.storyType;
    data['storyImage'] = this.storyImage;
    data['storyAdditionalImages'] = this.storyAdditionalImages;
    data['promoImage'] = this.promoImage;
    data['orderQty'] = this.orderQty;
    data['lastAddToCart'] = this.lastAddToCart;
    data['availableStock'] = this.availableStock;
    data['myId'] = this.myId;
    data['ezShopName'] = this.ezShopName;
    data['companyName'] = this.companyName;
    data['companyLogo'] = this.companyLogo;
    data['companyEmail'] = this.companyEmail;
    data['currencyCode'] = this.currencyCode;
    data['unitPrice'] = this.unitPrice;
    data['discountAmount'] = this.discountAmount;
    data['discountPercent'] = this.discountPercent;
    data['iMyID'] = this.iMyID;
    data['shopName'] = this.shopName;
    data['shopLogo'] = this.shopLogo;
    data['shopLink'] = this.shopLink;
    data['friendlyTimeDiff'] = this.friendlyTimeDiff;
    data['slNo'] = this.slNo;
    return data;
  }

  static List<ProductsModel> fromJsonList(jsonList) {
    return jsonList
        .map<ProductsModel>((obj) => ProductsModel.fromJson(obj))
        .toList();
  }
}

abstract class ProductRepository {
  Future<List<ProductsModel>> getProducts();
}

class ProductRepositoryImpl extends ProductRepository {
  @override
  Future<List<ProductsModel>> getProducts() async {
    bool isOnLine = await isOnline();
    if (isOnLine) {
      var response = await http.get(productRepoURL);
      if (response.statusCode == 200) {
        saveResponse('ProductResponse', response.body);
        var data = json.decode(response.body);

        List<ProductsModel> prod = ProductsModel.fromJsonList(data[0]);
        return prod;
      } else {
        throw Exception('Failed');
      }
    } else {
      String ProductOfflineResponse = await getResponse('ProductResponse');
      if (ProductOfflineResponse == null) {
        throw Exception('No Internet and no cachhe !');
      } else {
        var data = json.decode(ProductOfflineResponse);
        List<ProductsModel> Product = ProductsModel.fromJsonList(data[0]);
        return Product;
      }
    }
  }
}
