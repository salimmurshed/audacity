import 'package:audacity/Bloc/NewArrivalsBloc.dart';
import 'package:audacity/Bloc/NewShopsBloc.dart';
import 'package:audacity/Bloc/ProductBloc.dart';
import 'package:audacity/Model/NewArrivalsModel.dart';
import 'package:audacity/Model/NewShopsModel.dart';
import 'package:audacity/Model/ProductsModel.dart';
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
            return buildHintsList(state.newArrival);
          } else if (state is NewArrivalErrorState) {
            return buildError(state.message);
          }
          return CircularProgressIndicator();
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

Widget buildHintsList(List<NewArrivalsModel> newArrival) {
  return Container(
    height: 230,
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
                height: 230,
                width: 120,
                child: Stack(
                  children: [
                    Container(
                      height: 230,
                      width: 120,
                      child: newArrival[index].productImage == null
                          ? Image.asset(
                              "lib/Assets/noimage.jpg",
                              fit: BoxFit.cover,
                            )
                          : Image.network(
                              newArrival[index].productImage,
                              fit: BoxFit.cover,
                            ),
                    ),
                    Positioned(
                      bottom: 0,
                      left: 0,
                      child: Container(
                        color: Color(0xA4000000),
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
                                    color: Color(0xffffffff),
                                    fontWeight: FontWeight.w600),
                                maxLines: 1,
                                softWrap: false,
                                overflow: TextOverflow.ellipsis,
                              ),
                            ),
                            Text(
                              newArrival[index].unitPrice.toString() == null
                                  ? ""
                                  : "MYR " +
                                      newArrival[index].unitPrice.toString(),
                              style: TextStyle(
                                  color: Color(0xffffffff),
                                  fontWeight: FontWeight.w600),
                            ),
                            Text(
                              newArrival[index].availableStock.toString() ==
                                      null
                                  ? ""
                                  : newArrival[index].availableStock == 0
                                      ? "Out of stock"
                                      : newArrival[index]
                                              .availableStock
                                              .toString() +
                                          " Pc's Left",
                              style: TextStyle(
                                  color: Color(0xffffffff),
                                  fontWeight: FontWeight.w600),
                            ),
                          ],
                        ),
                      ),
                    )
                  ],
                ),
              ),
            ),
          );
        }),
  );
}
