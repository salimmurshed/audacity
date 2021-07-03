import 'package:audacity/Bloc/NewArrivalsBloc.dart';
import 'package:audacity/Bloc/NewShopsBloc.dart';
import 'package:audacity/Bloc/ProductBloc.dart';
import 'package:audacity/Bloc/TredingSellerBloc.dart';
import 'package:audacity/Model/NewArrivalsModel.dart';
import 'package:audacity/Model/NewShopsModel.dart';
import 'package:audacity/Model/ProductsModel.dart';
import 'package:audacity/Model/TredinSellerModel.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import '../Utils.dart';

class TredinSellerPage extends StatefulWidget {
  @override
  _TredinSellerPageState createState() => _TredinSellerPageState();
}

class _TredinSellerPageState extends State<TredinSellerPage> {
  TredinSellerBloc tredinSellerBloc;

  @override
  void initState() {
    tredinSellerBloc = BlocProvider.of<TredinSellerBloc>(context);
    tredinSellerBloc.add(FetchTredinSellerEvent());
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Container(
        child: BlocBuilder<TredinSellerBloc, TredinSellerState>(
            builder: (context, state) {
          if (state is TredinSellerInitialState) {
            return Center(child: CircularProgressIndicator());
          } else if (state is TredinSellerLoadingState) {
            return Center(child: CircularProgressIndicator());
          } else if (state is TredinSellerLoadedState) {
            return buildHintsList(state.tredinSeller);
          } else if (state is TredinSellerErrorState) {
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

Widget buildHintsList(List<TredinSellersModel> tredinSeller) {
  return Card(
    elevation: 3,
    child: Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Padding(
          padding: EdgeInsets.only(left: 5),
          child: newText('Trending Seller'),
        ),
        Container(
          height: 140,
          child: new ListView.builder(
              scrollDirection: Axis.horizontal,
              itemCount: tredinSeller.length,
              shrinkWrap: true,
              itemBuilder: (context, index) {
                return Padding(
                  padding: const EdgeInsets.all(4.0),
                  child: Container(
                    decoration:
                        BoxDecoration(borderRadius: BorderRadius.circular(10)),
                    height: 180,
                    width: 90,
                    child: Stack(
                      children: [
                        Container(
                          decoration: BoxDecoration(
                              borderRadius: BorderRadius.circular(10)),
                          height: 180,
                          width: 90,
                          child: ClipRRect(
                            borderRadius: BorderRadius.circular(10),
                            child: tredinSeller[index].sellerItemPhoto == null
                                ? Image.asset(
                                    "lib/Assets/noimage.jpg",
                                    fit: BoxFit.cover,
                                  )
                                : Image.network(
                                    tredinSeller[index].sellerItemPhoto,
                                    fit: BoxFit.cover,
                                  ),
                          ),
                        ),
                        Positioned(
                            bottom: 0,
                            left: 0,
                            child: Container(
                              decoration: BoxDecoration(
                                  borderRadius: BorderRadius.only(
                                      bottomLeft: Radius.circular(10),
                                      bottomRight: Radius.circular(10)),
                                  color: Color(0xb4000000)),
                              width: 90,
                              height: 60,
                              child: Padding(
                                padding: const EdgeInsets.all(4.0),
                                child: Center(
                                  child: PromoText(
                                      tredinSeller[index].sellerName == null
                                          ? ""
                                          : tredinSeller[index].sellerName),
                                ),
                              ),
                            )),
                        Positioned(
                          top: 5,
                          left: 5,
                          child: Container(
                            decoration: BoxDecoration(
                                border: Border.all(
                                    width: 2, color: Color(0xff5695cd)),
                                borderRadius: BorderRadius.circular(50)),
                            height: 35,
                            width: 35,
                            child: ClipRRect(
                              borderRadius: BorderRadius.circular(50),
                              child: tredinSeller[index].sellerProfilePhoto ==
                                      null
                                  ? Image.asset(
                                      "lib/Assets/noimage.jpg",
                                      fit: BoxFit.cover,
                                    )
                                  : Image.network(
                                      tredinSeller[index].sellerProfilePhoto,
                                      fit: BoxFit.cover,
                                    ),
                            ),
                          ),
                        )
                      ],
                    ),
                  ),
                );
              }),
        ),
      ],
    ),
  );
}

PromoText(text) {
  return Text(
    text,
    style: TextStyle(
        color: Color(0xffffffff), fontWeight: FontWeight.w500, fontSize: 14.0),
  );
}
