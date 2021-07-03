import 'package:audacity/Bloc/NewArrivalsBloc.dart';
import 'package:audacity/Bloc/NewShopsBloc.dart';
import 'package:audacity/Bloc/ProductBloc.dart';
import 'package:audacity/Model/NewArrivalsModel.dart';
import 'package:audacity/Model/NewShopsModel.dart';
import 'package:audacity/Model/ProductsModel.dart';
import 'package:cached_network_image/cached_network_image.dart';
import 'package:connectivity/connectivity.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import 'NewArrivalsPage.dart';
import 'NewShopPage.dart';

class ProductPageRest extends StatefulWidget {
  @override
  _ProductPageRestState createState() => _ProductPageRestState();
}

class _ProductPageRestState extends State<ProductPageRest> {
  ProductBloc productBloc;

  @override
  void initState() {
    productBloc = BlocProvider.of<ProductBloc>(context);
    productBloc.add(FetchProductEvent());
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    final w = MediaQuery.of(context).size.width;
    return Scaffold(
      body: Container(
        child:
            BlocBuilder<ProductBloc, ProductState>(builder: (context, state) {
          if (state is ProductInitialState) {
            return Center(child: CircularProgressIndicator());
          } else if (state is ProductLoadingState) {
            return Center(child: CircularProgressIndicator());
          } else if (state is ProductLoadedState) {
            return buildHintsList(state.prod, w);
          } else if (state is ProductErrorState) {
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

Widget buildHintsList(List<ProductsModel> prod, w) {
  return new ListView.builder(
      physics: NeverScrollableScrollPhysics(),
      itemCount: prod.length - 6,
      shrinkWrap: true,
      itemBuilder: (context, index) {
        return Card(
          elevation: 3,
          child: Padding(
            padding: const EdgeInsets.symmetric(horizontal: 20),
            child: Container(
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Row(
                    children: [
                      Container(
                        height: 40,
                        width: 40,
                        decoration: BoxDecoration(
                            borderRadius: BorderRadius.circular(50)),
                        child: ClipRRect(
                          borderRadius: BorderRadius.circular(50),
                          child: prod[index + 6].shopLogo == null
                              ? Image.asset(
                                  "lib/Assets/noimage.jpg",
                                  fit: BoxFit.cover,
                                )
                              : CachedNetworkImage(
                                  imageUrl: prod[index + 6].shopLogo,
                                  fit: BoxFit.cover,
                                ),
                        ),
                      ),
                      Padding(
                        padding: EdgeInsets.only(left: 8.0),
                        child: Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            Text(
                              prod[index + 6].ezShopName == null
                                  ? ''
                                  : prod[index + 6].ezShopName +
                                      index.toString(),
                              style: TextStyle(
                                  color: Color(0xff030101),
                                  fontWeight: FontWeight.w500,
                                  fontSize: 14.0),
                            ),
                            Text(
                              prod[index + 6].storyTime == null
                                  ? ''
                                  : StringExtension.displayTimeAgoFromTimestamp(
                                      prod[index + 6].storyTime),
                              style: TextStyle(
                                  color: Color(0xff746e6e),
                                  fontWeight: FontWeight.w500,
                                  fontSize: 12.0),
                            )
                          ],
                        ),
                      )
                    ],
                  ),
                  SizedBox(
                    height: 20,
                  ),
                  Text(prod[index + 6].story == null
                      ? ""
                      : prod[index + 6].story),
                  SizedBox(
                    height: 20,
                  ),
                  Container(
                    height: 250,
                    width: w,
                    child: prod[index + 6].storyImage == null
                        ? Image.asset(
                            "lib/Assets/noimage.jpg",
                            fit: BoxFit.cover,
                          )
                        : CachedNetworkImage(
                            imageUrl: prod[index + 6].storyImage,
                            fit: BoxFit.cover,
                          ),
                  ),
                  Padding(
                    padding: EdgeInsets.symmetric(vertical: 8.0),
                    child: Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: [
                        Row(
                          children: [
                            Icon(
                              Icons.card_giftcard,
                              size: 16,
                            ),
                            Text(
                              ' MYR ' + prod[index + 6].unitPrice.toString(),
                              style: TextStyle(fontWeight: FontWeight.w700),
                            )
                          ],
                        ),
                        Row(
                          children: [
                            Icon(
                              Icons.filter_list,
                              size: 16,
                            ),
                            Text(
                              prod[index + 6].availableStock.toString() +
                                  ' Stocks '
                                      'Available',
                              style: TextStyle(fontWeight: FontWeight.w700),
                            )
                          ],
                        ),
                        Row(
                          children: [
                            Icon(
                              Icons.shopping_cart_outlined,
                              size: 16,
                            ),
                            Text(
                              prod[index + 6].orderQty.toString() + ' Order(s)',
                              style: TextStyle(fontWeight: FontWeight.w700),
                            )
                          ],
                        ),
                      ],
                    ),
                  ),
                ],
              ),
            ),
          ),
        );
      });
}

extension StringExtension on String {
  static String displayTimeAgoFromTimestamp(String timestamp) {
    final year = int.parse(timestamp.substring(0, 4));
    final month = int.parse(timestamp.substring(5, 7));
    final day = int.parse(timestamp.substring(8, 10));
    final hour = int.parse(timestamp.substring(11, 13));
    final minute = int.parse(timestamp.substring(14, 16));

    final DateTime videoDate = DateTime(year, month, day, hour, minute);
    final int diffInHours = DateTime.now().difference(videoDate).inHours;

    String timeAgo = '';
    String timeUnit = '';
    int timeValue = 0;

    if (diffInHours < 1) {
      final diffInMinutes = DateTime.now().difference(videoDate).inMinutes;
      timeValue = diffInMinutes;
      timeUnit = 'minute';
    } else if (diffInHours < 24) {
      timeValue = diffInHours;
      timeUnit = 'hour';
    } else if (diffInHours >= 24 && diffInHours < 24 * 7) {
      timeValue = (diffInHours / 24).floor();
      timeUnit = 'day';
    } else if (diffInHours >= 24 * 7 && diffInHours < 24 * 30) {
      timeValue = (diffInHours / (24 * 7)).floor();
      timeUnit = 'week';
    } else if (diffInHours >= 24 * 30 && diffInHours < 24 * 12 * 30) {
      timeValue = (diffInHours / (24 * 30)).floor();
      timeUnit = 'month';
    } else {
      timeValue = (diffInHours / (24 * 365)).floor();
      timeUnit = 'year';
    }

    timeAgo = timeValue.toString() + ' ' + timeUnit;
    timeAgo += timeValue > 1 ? 's' : '';

    return timeAgo + ' ago';
  }
}
