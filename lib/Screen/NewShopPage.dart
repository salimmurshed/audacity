import 'package:audacity/Bloc/NewShopsBloc.dart';
import 'package:audacity/Bloc/ProductBloc.dart';
import 'package:audacity/Model/NewShopsModel.dart';
import 'package:audacity/Model/ProductsModel.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

class NewShopPage extends StatefulWidget {
  @override
  _NewShopPageState createState() => _NewShopPageState();
}

class _NewShopPageState extends State<NewShopPage> {
  NewShopBloc newShopBloc;

  @override
  void initState() {
    newShopBloc = BlocProvider.of<NewShopBloc>(context);
    newShopBloc.add(FetchNewShopEvent());
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Container(
        child:
            BlocBuilder<NewShopBloc, NewShopState>(builder: (context, state) {
          if (state is NewShopInitialState) {
            return Center(child: CircularProgressIndicator());
          } else if (state is NewShopLoadingState) {
            return Center(child: CircularProgressIndicator());
          } else if (state is NewShopLoadedState) {
            return buildHintsList(state.newShop);
          } else if (state is NewShopErrorState) {
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

Widget buildHintsList(List<NewShopsModel> newShop) {
  return Container(
    height: 230,
    child: new ListView.builder(
        scrollDirection: Axis.horizontal,
        itemCount: newShop.length,
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
                      child: newShop[index].sellerProfilePhoto == null
                          ? Image.asset(
                              "lib/Assets/noimage.jpg",
                              fit: BoxFit.cover,
                            )
                          : Image.network(
                              newShop[index].sellerProfilePhoto,
                              fit: BoxFit.cover,
                            ),
                    ),
                    Positioned(
                      bottom: 0,
                      left: 0,
                      child: Container(
                        color: Color(0xA4000000),
                        width: 120,
                        height: 80,
                        child: Column(
                          mainAxisAlignment: MainAxisAlignment.center,
                          crossAxisAlignment: CrossAxisAlignment.center,
                          children: [
                            Flexible(
                              child: Text(
                                newShop[index].ezShopName,
                                style: TextStyle(
                                    color: Color(0xffffffff),
                                    fontWeight: FontWeight.w600),
                                maxLines: 1,
                                softWrap: false,
                                overflow: TextOverflow.ellipsis,
                              ),
                            ),
                            Text(
                              newShop[index].city == null
                                  ? ""
                                  : newShop[index].city.toString(),
                              style: TextStyle(
                                  color: Color(0xffffffff),
                                  fontWeight: FontWeight.w600),
                            ),
                            Text(
                              newShop[index].orderQty.toString() == null
                                  ? ""
                                  : newShop[index].orderQty == 0
                                      ? "No order yet"
                                      : newShop[index].orderQty.toString() +
                                          " Order(s)",
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
// newShop[index]
