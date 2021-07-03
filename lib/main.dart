import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import 'Bloc/ProductBloc.dart';
import 'Model/ProductsModel.dart';
import 'Screen/HomePage.dart';
import 'Screen/ProductPage.dart';

void main() {
  runApp(MaterialApp(
    home: HomePage(),
  ));
}

// class MyApp extends StatelessWidget {
//   // This widget is the root of your application.
//   @override
//   Widget build(BuildContext context) {
//     return MaterialApp(
//       title: 'Flutter Demo',
//       theme: ThemeData(),
//       home: BlocProvider(
//           create: (context) => FoodBloc(repository: FoodRepositoryImpl()),
//           child: HomePage()),
//     );
//   }
// }
