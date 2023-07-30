import 'package:flutter/material.dart';
import 'package:mcb/custom_alert_dialog.dart';
import 'package:mcb/page_routes.dart';
import 'package:mcb/service.dart';
import 'package:shared_preferences/shared_preferences.dart';

class Login extends StatefulWidget {
  const Login({Key? key}) : super(key: key);

  @override
  State<Login> createState() => _LoginState();
}

class _LoginState extends State<Login> {

  @override
  void initState() {
    super.initState();
    
  }

  TextEditingController controllerUsername = TextEditingController();
  TextEditingController controllerPasword = TextEditingController();

  late bool _loading = false;
  String message = "", values = "";
  
  showMyDialog(title,content,backgroundColor,onPressedOks,onPressedNotOKs,textButtonOK,textButtonNotOK,textColor,buttonColorOk,buttonColorNotOK) {
    showDialog<String>(
      context: context,
      builder: (BuildContext context) => CustomAlertDialog(
        title: title, 
        content: content, 
        backgroundColor: backgroundColor, 
        onPressedOk: onPressedOks, 
        onPressedNotOK: onPressedNotOKs, 
        textButtonOK: textButtonOK, 
        textButtonNotOK: textButtonNotOK,
        textColor: textColor,
        buttonColorOk:buttonColorOk,
        buttonColorNotOK:buttonColorNotOK,
      )
    );
  }

  _pageRoutesAfterLogin(){
    PageRoutes.routeToHome(context);
  }

  _logins() async{
    setState(() {
      _loading = true;
    });
    Service.logins(controllerUsername.text,controllerPasword.text).then((valueUser) async {
      setState(() {
        message = valueUser['message'];
        values = valueUser['value'];
              
        print(message.toString());                     
      });
      switch (values) {
        case "1":
          String values = valueUser['value'].toString();
          String idUsersApps = valueUser['id_user'].toString();
          String names = valueUser['name'].toString();
          String usernames = valueUser['username'].toString();
          String passwords = valueUser['password'].toString();
          String addresss = valueUser['address'].toString();
          String levels = valueUser['level'].toString();
          String emails = valueUser['email'].toString();
          String noTelps = valueUser['no_telp'].toString();
          String tokens = valueUser['token'].toString();
          SharedPreferences prefs = await SharedPreferences.getInstance();
          prefs.setString('value', values);
          prefs.setString('idUsersApp', idUsersApps);
          prefs.setString('name', names);           
          prefs.setString('username', usernames);
          prefs.setString('password', passwords);
          prefs.setString('address', addresss);
          prefs.setString('level', levels);
          prefs.setString('email', emails);
          prefs.setString('noTelp', noTelps);
          prefs.setString('token', tokens);  
          Service.writeSR(
            values, 
            idUsersApps, 
            names, 
            usernames, 
            passwords,
            addresss, 
            levels, 
            emails, 
            noTelps, 
            tokens).then((prefs) {
          prefs.setString('value', values);
          prefs.setString('idUsersApp', idUsersApps);
          prefs.setString('name', names);           
          prefs.setString('username', usernames);
          prefs.setString('password', passwords);
          prefs.setString('address', addresss);
          prefs.setString('level', levels);
          prefs.setString('email', emails);
          prefs.setString('noTelp', noTelps);
          prefs.setString('token', tokens);  

          _pageRoutesAfterLogin();
          _loading = false;  
             });          
          break;          
        default:
          showMyDialog(
            "",
            message,
            values == "1"? Colors.greenAccent : Colors.red ,
            (){ Navigator.pop(context, 'Cancel'); },
            (){ Navigator.pop(context, 'Cancel'); },
            "Close","",
            Colors.white,
            Colors.black,      
            Colors.red,      
          );                
      }  
    });
  } 

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Stack(
        children: [
          Padding(
            padding: const EdgeInsets.all(8.0),
            child: Card(
              color: Colors.green,
              child: ListView(
                children: [
                SizedBox(
                  width: 200,
                  height: 200,
                  child: Image.asset("assets/images/mcb.png")),   
                  const Padding(
                    padding: EdgeInsets.all(8.0),
                    child: Card(
                      color: Colors.green,
                      child: Padding(
                        padding: EdgeInsets.only(top:18.0,bottom: 18.0),
                        child: Center(child: Text('Login',style: TextStyle(color: Colors.white,fontWeight: FontWeight.bold,fontSize: 30)),),
                      )),
                  ),               
                  Padding(
                    padding: const EdgeInsets.all(8.0),
                    child: Row(
                      children: [
                        const Padding(
                          padding: EdgeInsets.only(right :18.0),
                          child: Text('Username',style: TextStyle(color: Colors.white)),
                        ),
                        Expanded(
                          child: Card(
                            color: Colors.green,
                            child: TextField(
                              cursorColor: Colors.white,
                              controller: controllerUsername,
                              obscureText: false,
                              decoration: const InputDecoration(
                                fillColor: Colors.white,
                                   enabledBorder: OutlineInputBorder(
                                    borderRadius: BorderRadius.all(Radius.circular(4)),
                                    borderSide: BorderSide(width: 1,color: Colors.white),),
                                    focusedBorder: OutlineInputBorder(
                                      borderRadius: BorderRadius.all(Radius.circular(4)),
                                      borderSide: BorderSide(width: 1,color: Colors.black),
                                    ),                                  
                                border: OutlineInputBorder(
                                  borderSide: BorderSide(color: Colors.white)
                                ),
                                prefixIcon: Icon(
                                  Icons.person,
                                  color: Colors.white,
                                ),                              
                                label: Text('Username'),
                              ),
                            ),
                          ),
                        ),
                      ],
                    ),
                  ),
                  Padding(
                    padding: const EdgeInsets.all(8.0),
                    child: Row(
                      children: [
                        const Padding(
                          padding: EdgeInsets.only(right :18.0),
                          child: Text('Username',style: TextStyle(color: Colors.white)),
                        ),
                        Expanded(
                          child: Card(
                            color: Colors.green,
                            child: TextField(
                              cursorColor: Colors.white,
                              controller: controllerPasword,
                              obscureText: false,
                              decoration: const InputDecoration(
                                fillColor: Colors.white,
                                   enabledBorder: OutlineInputBorder(
                                    borderRadius: BorderRadius.all(Radius.circular(4)),
                                    borderSide: BorderSide(width: 1,color: Colors.white),),
                                    focusedBorder: OutlineInputBorder(
                                      borderRadius: BorderRadius.all(Radius.circular(4)),
                                      borderSide: BorderSide(width: 1,color: Colors.black),
                                    ),                                  
                                border: OutlineInputBorder(
                                  borderSide: BorderSide(color: Colors.white)
                                ),
                                prefixIcon: Icon(
                                  Icons.lock,
                                  color: Colors.white,
                                ),                              
                                label: Text('Password'),
                              ),
                            ),
                          ),
                        ),
                      ],
                    ),
                  ), 
                  GestureDetector(
                    onTap: (){_logins();},
                    child: Padding(
                      padding: const EdgeInsets.only(top:20.0,right: 8.0,left: 8.0),
                      child: Stack(
                        children: [
                          Center(
                            child: TextButton(
                              style: TextButton.styleFrom(
                              shape: RoundedRectangleBorder(
                                borderRadius: BorderRadius.circular(20)
                              ),
                              backgroundColor: Colors.orange,
                              shadowColor: Colors.orange,
                              surfaceTintColor: Colors.blue,
                              padding: const EdgeInsets.only(top:5.0,bottom:5.0,right:30.0,left:30.0),
                              textStyle: const TextStyle(fontSize: 15),
                              ), child: const Text('Masuk',style: TextStyle(color: Colors.white),),
                              onPressed: (){
                                _logins();
                              },
                            ),
                          ),
                        ],
                      ),
                    ),
                  ),
                  const Padding(
                          padding: EdgeInsets.all(18.0),
                          child: Center(child: Text('Apakah Anda Belum Punya Akun ?',style: TextStyle(color: Colors.black))),
                        ),
                  Center(
                    child: TextButton(
                      style: TextButton.styleFrom(
                      shape: RoundedRectangleBorder(
                        borderRadius: BorderRadius.circular(20)
                      ),                        
                      backgroundColor: Colors.blue,
                      shadowColor: Colors.blue,
                      surfaceTintColor: Colors.blue,
                      padding: const EdgeInsets.only(top:5.0,bottom:5.0,right:30.0,left:30.0),
                      textStyle: const TextStyle(fontSize: 15),
                      ), child: const Text('Daftar',style: TextStyle(color: Colors.white),),
                      onPressed: (){
                      },
                    ),
                  ),                               
                ],
              ),
            ),
          ),
        ],
      ),
    );
  }
}