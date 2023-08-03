import 'package:flutter/material.dart';
import 'package:mcb/home.dart';
import 'package:mcb/login.dart';
import 'package:mcb/user.dart';

void main() => runApp(MaterialApp(
  theme: ThemeData(
    primaryColor: Colors.green,
    hoverColor: Colors.green,
    hintColor: Colors.green,
    focusColor: Colors.green,
  ),
  debugShowCheckedModeBanner: false,
  title: "Mualaf Center Balikpapan",
  home: const Home()
));