import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/material.dart';
import 'package:webadmincircular/AdminScreen/LoginScreen.dart';
import 'package:webadmincircular/AdminScreen/MainScreen.dart';
import 'package:webadmincircular/AdminScreen/ManageCategoryScreen.dart';
import 'package:webadmincircular/AdminScreen/ManageOrderScreem.dart';
import 'package:webadmincircular/DeliveryScreen/DeliveryMainScreen.dart';
import 'package:webadmincircular/firebase_options.dart';

Future<void> main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await Firebase.initializeApp(
    options: DefaultFirebaseOptions.currentPlatform,
  );
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Flutter Demo',
      theme: ThemeData(
        fontFamily: 'Kanit-Bold',
        colorScheme: ColorScheme.fromSeed(seedColor: Colors.deepPurple),
        useMaterial3: true,
      ),
      home: MainScreenWidget(),
    );
  }
}
