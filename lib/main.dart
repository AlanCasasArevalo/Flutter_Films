import 'package:films/src/pages/home_page.dart';
import 'package:flutter/material.dart';
import 'package:flutter_localizations/flutter_localizations.dart';

void main() => runApp(MyApp());

class MyApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      localizationsDelegates: GlobalMaterialLocalizations.delegates,
      supportedLocales: [
        const Locale('en', 'US'), // American English
        const Locale('es', 'ES'), // Español
      ],
      title: 'Films',
      debugShowCheckedModeBanner: false,
      initialRoute: '/',
      routes: {
        '/' : (BuildContext context) => HomePage()
      },
    );
  }
}