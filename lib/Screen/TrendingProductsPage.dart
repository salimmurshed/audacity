import 'package:audacity/Bloc/TrendingProductsBloc.dart';
import 'package:audacity/Model/TrendingProductsModel.dart';
import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import '../Utils/Utils.dart';

class TrendingProductsPage extends StatefulWidget {
  @override
  _TrendingProductsPageState createState() => _TrendingProductsPageState();
}

class _TrendingProductsPageState extends State<TrendingProductsPage> {
  TrendingProductBloc trendingProductBloc;

  @override
  void initState() {
    trendingProductBloc = BlocProvider.of<TrendingProductBloc>(context);
    trendingProductBloc.add(FetchTrendingProductEvent());
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Container(
        child: BlocBuilder<TrendingProductBloc, TrendingProductState>(
            builder: (context, state) {
          if (state is TrendingProductInitialState) {
            return Center(child: CircularProgressIndicator());
          } else if (state is TrendingProductLoadingState) {
            return Center(child: CircularProgressIndicator());
          } else if (state is TrendingProductLoadedState) {
            return buildHintsList(state.trendingProduct);
          } else if (state is TrendingProductErrorState) {
            return buildError(state.message);
          }
          return Center(child: CircularProgressIndicator());
        }),
      ),
    );
  }
}

Widget buildError(String message) {
  return Center(
    child: Text(message),
  );
}

Widget buildHintsList(List<TrendingProductsModel> trendingProduct) {
  return Card(
    elevation: 3,
    child: Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Padding(
          padding: EdgeInsets.only(left: 5),
          child: newText('Trending Products'),
        ),
        Center(
          child: Container(
            height: 170,
            child: new ListView.builder(
                scrollDirection: Axis.horizontal,
                itemCount: trendingProduct.length,
                shrinkWrap: true,
                itemBuilder: (context, index) {
                  return Card(
                    elevation: 1,
                    child: Padding(
                      padding: const EdgeInsets.all(4.0),
                      child: Container(
                        height: 190,
                        width: 100,
                        child: Column(
                          children: [
                            Container(
                              height: 80,
                              width: 100,
                              child: trendingProduct[index].productImage == null
                                  ? Image.asset(
                                      "lib/Assets/noimage.jpg",
                                      fit: BoxFit.cover,
                                    )
                                  : CachedNetworkImage(
                                      imageUrl:
                                          trendingProduct[index].productImage,
                                      fit: BoxFit.cover,
                                    ),
                            ),
                            PromoText(
                                trendingProduct[index].productName == null
                                    ? ""
                                    : trendingProduct[index].productName,
                                12.0),
                            PromoText(
                                trendingProduct[index].unitPrice.toString() ==
                                        null
                                    ? ""
                                    : "TK " +
                                        trendingProduct[index]
                                            .unitPrice
                                            .toString(),
                                12.0),
                            GestureDetector(
                                onTap: () {},
                                child: Container(
                                  width: 60,
                                  decoration: BoxDecoration(
                                      border: Border.all(
                                        width: 1,
                                        color: Color(0xff000000),
                                      ),
                                      borderRadius: BorderRadius.circular(5)),
                                  child: Padding(
                                    padding: EdgeInsets.symmetric(
                                        horizontal: 2.0, vertical: 2.0),
                                    child: Center(
                                      child: PromoText('Buy Now', 10.0),
                                    ),
                                  ),
                                ))
                          ],
                        ),
                      ),
                    ),
                  );
                }),
          ),
        ),
      ],
    ),
  );
}

PromoText(text, size) {
  return Text(
    text,
    style: TextStyle(
        color: Color(0xff050404), fontWeight: FontWeight.w500, fontSize: size),
  );
}
