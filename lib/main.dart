import 'package:flutter/material.dart';

import 'Screen/HomePage.dart';

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
