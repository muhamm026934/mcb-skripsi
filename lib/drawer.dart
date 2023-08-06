import 'package:flutter/material.dart';
import 'package:mcb/custom_alert_dialog.dart';
import 'package:mcb/custom_list_tile_enable.dart';
import 'package:mcb/page_routes.dart';
import 'package:mcb/service.dart';
import 'package:shared_preferences/shared_preferences.dart';

class Drawers extends StatefulWidget {
  const Drawers({Key? key}) : super(key: key);


  @override
  State<Drawers> createState() => _DrawersState();
}

class _DrawersState extends State<Drawers> {

  @override
  void initState() {
    super.initState();
    _getPref(); 
  }
  
  late String value = "";
  late String idUsersApp = "";
  late String name = "";
  late String username = "";
  late String password = "";
  late String address = "";
  late String level = "";
  late String email = "";
  late String noTelp = "";
  late String token = "";
  late String nameUser = "";

  Future<void> _getPref() async {
    Service.getPref().then((preferences) {
      setState(() {
        value = preferences.getString('value');
        idUsersApp = preferences.getString('idUsersApp');
        name = preferences.getString('name');
        username = preferences.getString('username');
        password = preferences.getString('password');
        address = preferences.getString('address');
        level = preferences.getString('level');
        email = preferences.getString('email');
        noTelp = preferences.getString('noTelp');
        token = preferences.getString('token');
      });
    });
  }

  _logout() async {
    String values = "";
    String idUsersApps = "";
    String names = "";
    String usernames = "";
    String passwords = "";
    String addresss = ""; 
    String levels = ""; 
    String emails = ""; 
    String noTelps = "";
    String tokens = "";
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
          });     
      _pageRoutesLogin();              
  }
  _pageRoutesLogin(){
    PageRoutes.routeToLogin(context);
    
  }
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

  @override
  Widget build(BuildContext context) {
    return Drawer(
      child: ListView(
        children: [
          DrawerHeader(
            decoration : const BoxDecoration(
              color: Colors.green
            ),
            child:Column(
              children: [
                SizedBox(
                  width: 100,
                  height: 100,
                  child: Image.asset("assets/images/mcb.jpeg")),
                Center(
                  child: Padding(
                    padding: const EdgeInsets.all(8.0),
                    child: Text(name,style: const TextStyle(color: Colors.white,fontWeight: FontWeight.bold),)
                  ),
                ),
                ],
              )
            ),
              GestureDetector(
                onTap: (){
                  PageRoutes.routeToHome(context);
                },
                child: Container(
                  color: Colors.green,
                  child: Card(
                    color: Colors.green,
                    child: CustomListTileEnable(
                    title: "Home", 
                    subtitle: "", 
                    iconLead: Icons.home,
                    iconTrail: Icons.arrow_circle_right, 
                    onTapTrail: (){
                      PageRoutes.routeToHome(context);
                    }, 
                    onTapLead: (){
                      PageRoutes.routeToHome(context);
                    },
                    titles: "Y", 
                    subtitles: "", 
                    leadings: "Y", 
                    trailings: "Y", 
                    textColor: Colors.white,),
                  ),
                ),
              ),    
              level == "admin"                       
              ? GestureDetector(
                onTap: (){
                  PageRoutes.routeToUser(context);
                },
                child: Container(
                  color: Colors.green,
                  child: Card(
                    color: Colors.green,
                    child: CustomListTileEnable(
                    title: "Data User", 
                    subtitle: "", 
                    iconLead: Icons.account_box_outlined,
                    iconTrail: Icons.arrow_circle_right, 
                    onTapTrail: (){
  
                    }, 
                    onTapLead: (){
  
                    },
                    titles: "Y", 
                    subtitles: "", 
                    leadings: "Y", 
                    trailings: "Y", 
                    textColor: Colors.white,),
                  ),
                ),
              ):Container(),  
              level == "admin"  
              ? GestureDetector(
                onTap: (){
                  PageRoutes.routeToKajian(context);
                },
                child: Container(
                  color: Colors.green,
                  child: Card(
                    color: Colors.green,
                    child: CustomListTileEnable(
                    title: "Data Kajian", 
                    subtitle: "", 
                    iconLead: Icons.mosque,
                    iconTrail: Icons.arrow_circle_right, 
                    onTapTrail: (){
                    }, 
                    onTapLead: (){
                    },
                    titles: "Y", 
                    subtitles: "", 
                    leadings: "Y", 
                    trailings: "Y", 
                    textColor: Colors.white,),
                  ),
                ),
              ):Container(),              
              name != ""             
              ? GestureDetector(
                onTap: (){
                  showMyDialog(
                      "Apakah Yakin Akan Keluar Dari Aplikasi ?",
                      "",
                      Colors.red ,
                      (){ Navigator.pop(context, 'Cancel'); },
                      (){ _logout(); },
                      "Batal","Ya",
                      Colors.white,
                      Colors.black,      
                      Colors.black,      
                    ); 
                },
                child: Container(
                  color: Colors.green,
                  child: Card(
                    color: Colors.green,
                    child: CustomListTileEnable(
                    title: "Log Out", 
                    subtitle: "", 
                    iconLead: Icons.logout_outlined,
                    iconTrail: Icons.arrow_circle_right, 
                    onTapTrail: (){
                    showMyDialog(
                      "Apakah Yakin Akan Keluar Dari Aplikasi ?",
                      "",
                      Colors.red ,
                      (){ Navigator.pop(context, 'Cancel'); },
                      (){ _logout(); },
                      "Close","",
                      Colors.white,
                      Colors.black,      
                      Colors.red,      
                    );                       
                      showMyDialog(
                      "Apakah Yakin Akan Keluar Dari Aplikasi ?",
                      "",
                      Colors.red ,
                      (){ Navigator.pop(context, 'Cancel'); },
                      (){ _logout(); },
                      "Close","",
                      Colors.white,
                      Colors.black,      
                      Colors.red,      
                    ); 
                    }, 
                    onTapLead: (){
                      showMyDialog(
                      "Apakah Yakin Akan Keluar Dari Aplikasi ?",
                      "",
                      Colors.red ,
                      (){ Navigator.pop(context, 'Cancel'); },
                      (){ _logout(); },
                      "Close","",
                      Colors.white,
                      Colors.black,      
                      Colors.red,      
                    ); 
                    },
                    titles: "Y", 
                    subtitles: "", 
                    leadings: "Y", 
                    trailings: "Y", 
                    textColor: Colors.white,),
                  ),
                ),
              )
              : GestureDetector(
                onTap: (){
                  PageRoutes.routeToLogin(context);
                },
                child: Container(
                  color: Colors.green,
                  child: Card(
                    color: Colors.green,
                    child: CustomListTileEnable(
                    title: "Log In", 
                    subtitle: "", 
                    iconLead: Icons.logout_outlined,
                    iconTrail: Icons.arrow_circle_right, 
                    onTapTrail: (){
                    }, 
                    onTapLead: (){
                    },
                    titles: "Y", 
                    subtitles: "", 
                    leadings: "Y", 
                    trailings: "Y", 
                    textColor: Colors.white,),
                  ),
                ),
              ),                                                                                                   
        ],
      ),
    );
  }
}