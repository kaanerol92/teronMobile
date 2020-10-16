import 'package:flutter/material.dart';

// ignore: must_be_immutable
class MainMenuScreen extends StatelessWidget {
  var context;

  Map menuMap;
  String titl3;

  MainMenuScreen(Map<String, dynamic> menuMap, String titl3) {
    this.menuMap = menuMap;
    this.titl3 = titl3;
  }

  @override
  Widget build(BuildContext context) {
    this.context = context;
    return Scaffold(
      appBar: AppBar(
        title: Text(titl3),
        centerTitle: true,
        brightness: Brightness.dark,
        elevation: 0.0,
        backgroundColor: Colors.transparent,
        textTheme: Theme.of(context).textTheme,
        iconTheme: Theme.of(context).iconTheme,
      ),
      body: ListView.builder(
          padding: const EdgeInsets.all(10.0),
          itemCount: menuMap.length,
          shrinkWrap: true,
          scrollDirection: Axis.vertical,
          itemBuilder: (context, index) {
            return Align(
              alignment: Alignment.center,
              child: Center(
                child: getMenuItem(menuMap.keys.toList()[index], menuMap.values.toList()[index]),
              ),
            );
          }),
    );
  }

  Widget getMenuItem(String text, var clazz) {
    return GestureDetector(
      child: Center(
        child: Container(
          decoration: BoxDecoration(
              border: Border.all(color: Colors.white, style: BorderStyle.none),
              borderRadius: BorderRadius.only(topLeft: Radius.circular(20), bottomRight: Radius.circular(20)),
              boxShadow: [
                BoxShadow(
                  color: Colors.white,
                  offset: Offset(0, 2),
                ),
              ],
              gradient: RadialGradient(colors: [
                Colors.black,
                Colors.grey
              ], radius: 6)),
          padding: const EdgeInsets.all(20),
          margin: const EdgeInsets.all(20),
          child: Row(
            children: [
              Expanded(
                child: Text(
                  text,
                  style: TextStyle(color: Colors.white, fontSize: 18),
                  textAlign: TextAlign.center,
                ),
              ),
            ],
          ),
        ),
      ),
      onTap: () {
        Navigator.push(context, MaterialPageRoute(builder: (context) {
          return clazz;
        }));
      },
    );
  }
}
