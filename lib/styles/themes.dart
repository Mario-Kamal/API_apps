import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:hexcolor/hexcolor.dart';

ThemeData darkTheme = ThemeData(
    primarySwatch: Colors.deepOrange,
    scaffoldBackgroundColor: Colors.black,
    // HexColor("#454545"),
    textTheme: const TextTheme(
      caption: TextStyle(
          color: Colors.white,
          fontSize: 30,
          fontWeight: FontWeight.bold),
      subtitle1: TextStyle(
          color: Colors.white,
          fontSize: 20,
          fontWeight: FontWeight.bold),
      subtitle2: TextStyle(
          color: Colors.white,
          fontSize: 16,
          fontWeight: FontWeight.bold),
    ),
    bottomNavigationBarTheme: BottomNavigationBarThemeData(
        type: BottomNavigationBarType.fixed,
        backgroundColor: Colors.black,
        // HexColor("#454545"),
        unselectedLabelStyle: const TextStyle(fontSize: 1, fontWeight: FontWeight.bold),
        selectedItemColor: Colors.white,
        unselectedItemColor: HexColor("#23E50F"),
        unselectedIconTheme: IconThemeData(size: 30),
        selectedIconTheme: IconThemeData(size: 40),
        selectedLabelStyle:
        const TextStyle(fontSize: 1, fontWeight: FontWeight.bold)),
    appBarTheme: AppBarTheme(
        iconTheme: const IconThemeData(color: Colors.white),
        backgroundColor: Colors.black,
        // HexColor("#454545"),
        titleTextStyle: const TextStyle(
            color: Colors.white,
            fontSize: 30,
            fontWeight: FontWeight.bold),
        elevation: 0.0,
        backwardsCompatibility: false,
        systemOverlayStyle: SystemUiOverlayStyle(
          statusBarColor: Colors.black,
          systemNavigationBarColor: Colors.black,
          statusBarBrightness: Brightness.light,
        )
    ));
ThemeData lightTheme = ThemeData(
  primarySwatch: Colors.green,
  backgroundColor: Colors.white,
    scaffoldBackgroundColor: Colors.white,
    textTheme: const TextTheme(
      caption: TextStyle(
          color: Colors.black,
          fontSize: 30,
          fontWeight: FontWeight.bold),
      subtitle1: TextStyle(
          color: Colors.black,
          fontSize: 20,
          fontWeight: FontWeight.bold),
      subtitle2: TextStyle(
          color: Colors.black,
          fontSize: 16,
          fontWeight: FontWeight.bold),
    ),
    bottomNavigationBarTheme: const BottomNavigationBarThemeData(
        type: BottomNavigationBarType.fixed,
        selectedIconTheme: IconThemeData(size: 40),
        selectedItemColor: Colors.black,
        unselectedItemColor: Colors.deepOrange,
        unselectedLabelStyle: TextStyle(fontSize: 15, fontWeight: FontWeight.bold),
        selectedLabelStyle:
        TextStyle(fontSize: 20, fontWeight: FontWeight.bold)),
    appBarTheme: const AppBarTheme(
        iconTheme: IconThemeData(color: Colors.black),
        backgroundColor: Colors.white,
        titleTextStyle: TextStyle(
            color: Colors.black,
            fontSize: 30,
            fontWeight: FontWeight.bold),
        elevation: 0.0,
        backwardsCompatibility: false,
        systemOverlayStyle: SystemUiOverlayStyle(
          statusBarIconBrightness: Brightness.dark,
          statusBarColor: Colors.white,
        )));