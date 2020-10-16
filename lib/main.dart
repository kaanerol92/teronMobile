import 'package:flutter/material.dart';
import 'package:flutter_localizations/flutter_localizations.dart';
import 'package:teronmobile/command/MusteriSiparisiScreenCommand.dart';
import 'package:teronmobile/command/StokIslemiScreenCommand.dart';
import 'command/LoginScreenCommand.dart';

void main() {
  LoginScreenCommand lvc = LoginScreenCommand();

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
      initialRoute: '/',
      routes: {
        '/': (context) => lvc,
        '/musterisiparisi': (context) => MusteriSiparisiScreenCommand(lvc.getLsv),
        '/malalim': (context) => StokIslemiScreenCommand(lvc.getLsv, 1),
        '/toptansatis': (context) => StokIslemiScreenCommand(lvc.getLsv, 30),
        '/perakendesatis': (context) => StokIslemiScreenCommand(lvc.getLsv, 31),
        '/uretim': (context) => StokIslemiScreenCommand(lvc.getLsv, 10)
      }));
  // home: LoginViewCommand()));
}
