import 'package:flutter/material.dart';
import 'package:mcb/home.dart';

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