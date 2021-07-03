import 'package:audacity/Bloc/NewArrivalsBloc.dart';
import 'package:audacity/Bloc/NewShopsBloc.dart';
import 'package:audacity/Bloc/ProductBloc.dart';
import 'package:audacity/Model/NewArrivalsModel.dart';
import 'package:audacity/Model/NewShopsModel.dart';
import 'package:audacity/Model/ProductsModel.dart';
import 'package:audacity/Utils/Utils.dart';
import 'package:cached_network_image/cached_network_image.dart';
import 'package:connectivity/connectivity.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

class NewArrivalPage extends StatefulWidget {
  @override
  _NewArrivalPageState createState() => _NewArrivalPageState();
}

class _NewArrivalPageState extends State<NewArrivalPage> {
  NewArrivalBloc newArrivalBloc;

  @override
  void initState() {
    newArrivalBloc = BlocProvider.of<NewArrivalBloc>(context);
    newArrivalBloc.add(FetchNewArrivalEvent());
    super.initState();
    isOnlinex();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Container(
        child: BlocBuilder<NewArrivalBloc, NewArrivalState>(
            builder: (context, state) {
          if (state is NewArrivalInitialState) {
            return CircularProgressIndicator();
          } else if (state is NewArrivalLoadingState) {
            return CircularProgressIndicator();
          } else if (state is NewArrivalLoadedState) {
            return buildHintsList(state.newArrival, setState);
          } else if (state is NewArrivalErrorState) {
            return buildError(state.message);
          }
          return CircularProgressIndicator();
        }),
      ),
    );
  }

  Future<bool> isOnlinex() async {
    final Connectivity _connectivity = Connectivity();
    ConnectivityResult result = await _connectivity.checkConnectivity();
    switch (result) {
      case ConnectivityResult.wifi:
        setState(() {
          isOn = true;
          print(isOn);
        });
        break;
      case ConnectivityResult.mobile:
        setState(() {
          isOn = true;
          print(isOn);
        });
        break;
      case ConnectivityResult.none:
        setState(() {
          isOn = false;
          print(isOn);
        });
        break;
      default:
        setState(() {
          isOn = false;
          print(isOn);
        });
        break;
    }
  }
}

bool isOn;
Widget buildError(String message) {
  return Center(
    child: Text(message),
  );
}

Widget buildHintsList(List<NewArrivalsModel> newArrival, setState) {
  return Card(
    elevation: 3,
    child: Container(
      height: 230,
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Padding(
            padding: EdgeInsets.only(left: 5),
            child: newText('New Arrival'),
          ),
          Container(
            height: 200,
            child: new ListView.builder(
                scrollDirection: Axis.horizontal,
                itemCount: newArrival.length,
                shrinkWrap: true,
                itemBuilder: (context, index) {
                  return Card(
                    elevation: 2,
                    child: Padding(
                      padding: EdgeInsets.all(4.0),
                      child: Container(
                        height: 200,
                        width: 120,
                        child: Column(
                          children: [
                            Container(
                              height: 110,
                              width: 120,
                              child: newArrival[index].productImage == null
                                  ? Image.asset(
                                      "lib/Assets/noimage.jpg",
                                      fit: BoxFit.cover,
                                    )
                                  : CachedNetworkImage(
                                      imageUrl: newArrival[index].productImage,
                                      fit: BoxFit.cover,
                                    ),
                            ),
                            Container(
                              color: Color(0x00000000),
                              width: 120,
                              height: 70,
                              child: Column(
                                mainAxisAlignment: MainAxisAlignment.center,
                                crossAxisAlignment: CrossAxisAlignment.center,
                                children: [
                                  Flexible(
                                    child: Text(
                                      newArrival[index].productName == null
                                          ? ""
                                          : newArrival[index].productName,
                                      style: TextStyle(
                                          color: Color(0xff0c0101),
                                          fontWeight: FontWeight.w600),
                                      maxLines: 1,
                                      softWrap: false,
                                      overflow: TextOverflow.ellipsis,
                                    ),
                                  ),
                                  Text(
                                    newArrival[index].unitPrice.toString() ==
                                            null
                                        ? ""
                                        : "MYR " +
                                            newArrival[index]
                                                .unitPrice
                                                .toString(),
                                    style: TextStyle(
                                        color: Color(0xff000000),
                                        fontWeight: FontWeight.w600),
                                  ),
                                  Text(
                                    newArrival[index]
                                                .availableStock
                                                .toString() ==
                                            null
                                        ? ""
                                        : newArrival[index].availableStock == 0
                                            ? "Out of stock"
                                            : newArrival[index]
                                                    .availableStock
                                                    .toString() +
                                                " Pc's Left",
                                    style: TextStyle(
                                        color: Color(0xff050000),
                                        fontWeight: FontWeight.w600),
                                  ),
                                ],
                              ),
                            )
                          ],
                        ),
                      ),
                    ),
                  );
                }),
          ),
        ],
      ),
    ),
  );
}
