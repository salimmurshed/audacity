import 'package:audacity/Bloc/NewArrivalsBloc.dart';
import 'package:audacity/Bloc/NewShopsBloc.dart';
import 'package:audacity/Bloc/ProductBloc.dart';
import 'package:audacity/Bloc/TredingSellerBloc.dart';
import 'package:audacity/Bloc/TrendingProductsBloc.dart';
import 'package:audacity/Model/NewArrivalsModel.dart';
import 'package:audacity/Model/NewShopsModel.dart';
import 'package:audacity/Model/ProductsModel.dart';
import 'package:audacity/Model/TredinSellerModel.dart';
import 'package:audacity/Model/TrendingProductsModel.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import 'NewArrivalsPage.dart';
import 'NewShopPage.dart';
import 'ProductPage.dart';
import 'ProductPageRest.dart';
import 'TredinSellerPage.dart';
import 'TrendingProductsPage.dart';

class HomePage extends StatefulWidget {
  @override
  _HomePageState createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {
  @override
  void initState() {
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    final h = MediaQuery.of(context).size.height;
    final w = MediaQuery.of(context).size.width;
    return MaterialApp(
      home: SingleChildScrollView(
        physics: ScrollPhysics(),
        child: Column(
          mainAxisSize: MainAxisSize.min,
          children: [
            Container(
              width: w,
              height: 200,
              child: BlocProvider(
                  create: (context) => TredinSellerBloc(
                      repository: TredinSellersRepositoryImpl()),
                  child: TredinSellerPage()),
            ),
            Container(
              height: 210,
              child: BlocProvider(
                  create: (context) => TrendingProductBloc(
                      repository: TrendingProductsRepositoryImpl()),
                  child: TrendingProductsPage()),
            ),
            Container(
              height: 2900,
              child: BlocProvider(
                  create: (context) =>
                      ProductBloc(repository: ProductRepositoryImpl()),
                  child: ProductPage()),
            ),
            Container(
              height: h,
              child: BlocProvider(
                  create: (context) =>
                      ProductBloc(repository: ProductRepositoryImpl()),
                  child: ProductPageRest()),
            ),
          ],
        ),
      ),
    );
  }
}