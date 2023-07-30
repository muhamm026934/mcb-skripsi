import 'dart:async';
import 'package:flutter/material.dart';
import 'package:mcb/home.dart';
import 'package:mcb/kajian.dart';
import 'package:mcb/login.dart';
import 'package:mcb/user.dart';

class PageRoutes {

  static routeToUser(context) async {
    var duration = const Duration(milliseconds: 10);
    return Timer(duration, (){
      Navigator.of(context).pushReplacement(MaterialPageRoute(builder: (_){
        return const User();
      }));
    });
  }  
  static routeToLogin(context) async {
    var duration = const Duration(milliseconds: 10);
    return Timer(duration, (){
      Navigator.of(context).pushReplacement(MaterialPageRoute(builder: (_){
        return const Login();
      }));
    });
  }   
  static routeToKajian(context) async {
    var duration = const Duration(milliseconds: 10);
    return Timer(duration, (){
      Navigator.of(context).pushReplacement(MaterialPageRoute(builder: (_){
        return const Kanjian(session: '',);
      }));
    });
  }   
  static routeToHome(context) async {
    var duration = const Duration(milliseconds: 10);
    return Timer(duration, (){
      Navigator.of(context).pushReplacement(MaterialPageRoute(builder: (_){
        return const Home();
      }));
    });
  }   
}