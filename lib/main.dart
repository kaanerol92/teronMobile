import 'package:flutter/material.dart';
import 'package:flutter_localizations/flutter_localizations.dart';
import 'command/LoginScreenCommand.dart';

void main() {
  runApp(MaterialApp(
      theme: ThemeData(
        brightness: Brightness.light,
      ),
      darkTheme: ThemeData(
        brightness: Brightness.dark,
      ),
      localizationsDelegates: [
        GlobalMaterialLocalizations.delegate,
        GlobalWidgetsLocalizations.delegate,
      ],
      supportedLocales: [
        const Locale('tr'),
      ],
      debugShowCheckedModeBanner: false,
      home: LoginViewCommand()));
}
