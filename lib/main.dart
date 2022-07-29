import 'dart:developer';

import 'package:firebase_auth/firebase_auth.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/material.dart';
import 'package:loginfirebase/Controller/recycler_list_controller.dart';
import 'package:loginfirebase/Screens/home_page.dart';
import 'package:loginfirebase/Screens/recycler_view.dart';
import 'package:loginfirebase/firebase_options.dart';
import 'package:provider/provider.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();

  await Firebase.initializeApp(
    options: DefaultFirebaseOptions.currentPlatform,
  );

  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return ChangeNotifierProvider<RecyclerListController>(
      create: (context) => RecyclerListController(),
      child: MaterialApp(
        title: 'Flutter Demo',
        theme: ThemeData(
          primarySwatch: Colors.blue,
        ),
        routes: {
          HomePage.route: (context) => HomePage(),
          RecyclerView.route: (context) => RecyclerView(),
        },
      ),
    );
  }
}
