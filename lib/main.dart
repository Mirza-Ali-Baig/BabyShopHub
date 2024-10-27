import 'package:baby_shop_hub/Core/Theme/my_theme.dart';
import 'package:baby_shop_hub/firebase_options.dart';
import 'package:baby_shop_hub/presentation/admin/screens/products_screen.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/material.dart';


// import 'presentation/admin/screens/products_screen.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await Firebase.initializeApp(options: DefaultFirebaseOptions.currentPlatform);
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      title: 'Baby Shop Hub',
      darkTheme: MyTheme.dark(),
      theme: MyTheme.light(),
      themeMode: ThemeMode.system,
      home: const ProductsScreen()  ,
    );
  }
}
