import 'package:flutter/material.dart';
import 'package:mcb/api.dart';
import 'package:mcb/drawer.dart';
import 'package:mcb/page_routes.dart';
import 'package:mcb/poslist.dart';
import 'package:mcb/service.dart';


class User extends StatefulWidget {
  const User({Key? key}) : super(key: key);

  @override
  State<User> createState() => _UserState();
}


class _UserState extends State<User> {

  @override
  void initState() {
    super.initState();
    _getPref();
    _getDataUser("","","","","","");
    _loading;
  }

  List<PostList?> _listUser = [];
  bool _loading = false ;

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

  _getDataUser(action,idUsers,names,usernames,levels,noTelps) async{
    setState(() {
      _loading = true;
    });
    Service.getDataUser(action,idUsers,names,usernames,levels,noTelps).then((value) async {
      setState(() {
        _listUser = value;
        _loading = false;
      });
    });
  }
    TextEditingController cSearch = TextEditingController();
    TextEditingController cUserId = TextEditingController();
    TextEditingController cName = TextEditingController();
    TextEditingController cUsername = TextEditingController();
    TextEditingController cPassword1= TextEditingController();
    TextEditingController cPassword2= TextEditingController();
    TextEditingController cAddress = TextEditingController();
    TextEditingController cLevel = TextEditingController();
    TextEditingController cEmail = TextEditingController();
    TextEditingController cNoTelp = TextEditingController();
    TextEditingController cToken = TextEditingController();

  bool tampilFormUpdateAdd = false;
  String textFormUpdateAdd = "", headerText = "";

  _commandFormUpdateAdd(textFormUpdateAdds, tampilFormUpdateAdds){
    setState(() {
      textFormUpdateAdd = textFormUpdateAdds;
      tampilFormUpdateAdd = tampilFormUpdateAdds;
      headerText = textFormUpdateAdds;
    });
  }
 String message = "", values = "";
 List<PostList?> _messageUpload = [];
 _functionUploadDataUser() async{
  setState(() {
    _loading = true;
  });
  
  Service.functionUploadDataUser(
    headerText, cUserId.text ,cName.text, cUsername.text, cPassword1.text ,cPassword2.text
    ,cAddress.text ,cLevel.text,
    cEmail.text, cNoTelp.text, idUsersApp).then((value) async {
    setState(() {
      _messageUpload = value;
      _loading = false;
      message = _messageUpload[0]!.message.toString();
      values = _messageUpload[0]!.value.toString();   
      
      if (values == "1") {
        setState(() {
          _commandAlertMessage("", "", false);
          _commandFormUpdateAdd("", false);
          _commandAlertMessageResponse(values, message, true);
          if (level == "admin") {
          _getDataUser("","","","","","");            
          }else{
          PageRoutes.routeToLogin(context);  
          }

          _messageUpload.clear();
          _clearCtext();    
          message ="";
          values ="";                
        });
      }else{
        setState(() {
        _commandAlertMessageResponse(values, message, true);
        });
      }
    });
  });
 }

 _clearCtext(){
  setState(() {
    cUserId.text = "";
    cName.text = "";
    cUsername.text = "";
    cPassword1.text = "";
    cPassword2.text = "";
    cAddress.text = "";
    cLevel.text = "";
    cEmail.text = "";
    cNoTelp.text = "";
    cToken.text = "";
  });
 }

  _editDataUser(cUserIds,cNames,cUsernames,cPassword1s,cPassword2s,cAddresss,cLevels,cEmails,cNoTelps,cTokens,headers){
    setState(() {
        cUserId.text = cUserIds;
        cName.text = cNames;
        cUsername.text = cUsernames;
        cPassword1.text = cPassword1s;
        cPassword2.text = cPassword2s;
        cAddress.text = cAddresss;
        cLevel.text = cLevels;
        cEmail.text = cEmails;
        cNoTelp.text = cNoTelps;
        cToken.text = cTokens;
        _commandFormUpdateAdd(headers, true);
    });
  }

  String titleText = "";
  bool tampilAlertMessage = false;

  _commandAlertMessage(headers, titles, tampilAlertMessages){
    setState(() {
      textFormUpdateAdd = headers;
      headerText = headers;
      titleText = titles;
      tampilAlertMessage = tampilAlertMessages;
    });
  }

  TextStyle _customFont() {
  return const TextStyle(color: Colors.white);
  }

  _alertMessage(){
    return Center(
      child: SizedBox(
        width: MediaQuery.of(context).size.width* 0.8,
        height: MediaQuery.of(context).size.height* 0.3,        
        child: Card(
          color: 
            textFormUpdateAdd == ApiUrl.tambahUserText || headerText == ApiUrl.tambahUserText 
            ? Colors.green
            :textFormUpdateAdd == ApiUrl.editUserText || headerText == ApiUrl.editUserText 
            ? Colors.orange
            :textFormUpdateAdd == ApiUrl.deleteUserText || headerText == ApiUrl.deleteUserText
            ? Colors.red
            : Colors.blue,
          child: ListView(
            children: [
              Padding(
                padding: const EdgeInsets.only(top: 18.0,left: 8.0,right: 8.0),
                child: Center(child: Text(headerText, style:_customFont(),textAlign: TextAlign.center,)),
              ),
              Padding(
                padding: const EdgeInsets.all(18.0),
                child: Center(child: Text(titleText, style:_customFont())),
              ),
              Padding(
                padding: const EdgeInsets.only(top :18.0),
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                  children: [
                    Card(
                      color: Colors.blue,
                      child: TextButton(
                        style: TextButton.styleFrom(
                        backgroundColor: Colors.transparent,
                        shadowColor: Colors.transparent,
                        surfaceTintColor: Colors.blue,
                        padding: const EdgeInsets.all(10.0),
                        textStyle: const TextStyle(fontSize: 12),
                        ), child: const Text('OK',style: TextStyle(color: Colors.white),),
                        onPressed: (){
                          _functionUploadDataUser();
                        },
                      ),
                    ),   
                    Card(
                      color: Colors.orangeAccent,
                      child: TextButton(
                        style: TextButton.styleFrom(
                        backgroundColor: Colors.transparent,
                        shadowColor: Colors.transparent,
                        surfaceTintColor: Colors.blue,
                        padding: const EdgeInsets.all(10.0),
                        textStyle: const TextStyle(fontSize: 12),
                        ), child: const Text('Batal',style: TextStyle(color: Colors.white),),
                        onPressed: (){
                          _commandAlertMessage(headerText, "", false);
                        },
                      ),
                    ),                              
                  ],
                ),
              )
            ],
          ),
        ),
      ),
    );
  }

  String valueResponse = "";
  String messageResponse = "";
  bool tampilAlertMessageResponse = false;
  _commandAlertMessageResponse(valueResponses, messageResponses, tampilAlertMessageResponses){
    setState(() {
      valueResponse = valueResponses;
      messageResponse = messageResponses;
      tampilAlertMessageResponse = tampilAlertMessageResponses;
    });
  }

  _alertMessageResponse(){
    return Center(
      child: SizedBox(
        width: MediaQuery.of(context).size.width* 0.8,
        height: MediaQuery.of(context).size.height* 0.3,        
        child: Card(
          color: valueResponse == "1" ? Colors.green: Colors.red,
          child: ListView(
            children: [
              Padding(
                padding: const EdgeInsets.only(top: 18.0,left: 8.0,right: 8.0),
                child: Center(child: Text(messageResponse, style:_customFont(),textAlign: TextAlign.center,)),
              ),
              Padding(
                padding: const EdgeInsets.all(18.0),
                child: Center(child: Text(titleText, style:_customFont())),
              ),
              Padding(
                padding: const EdgeInsets.only(top :18.0),
                child: Card(
                  color: Colors.orangeAccent,
                  child: TextButton(
                    style: TextButton.styleFrom(
                    backgroundColor: Colors.transparent,
                    shadowColor: Colors.transparent,
                    surfaceTintColor: Colors.blue,
                    padding: const EdgeInsets.all(10.0),
                    textStyle: const TextStyle(fontSize: 12),
                    ), child: const Text('Keluar',style: TextStyle(color: Colors.white),),
                    onPressed: (){
                      _commandAlertMessageResponse("", "", false);
                    },
                  ),
                ),
              )
            ],
          ),
        ),
      ),
    );
  }
  
 
  radioButtons(levelUserRadioButtons){
    setState(() {
      cLevel.text = levelUserRadioButtons;
    });
  }

  _formUpdateAdd(){
    return Container(
      color: Colors.black45,
      child: Center(
        child: Card(
          child: Padding(
            padding: const EdgeInsets.all(2.0),
            child: SizedBox(
              width: MediaQuery.of(context).size.width* 0.9,
              height: MediaQuery.of(context).size.height* 0.9,
              child: ListView(
                children:  [
                  Padding(
                    padding: const EdgeInsets.only(left :12.0,right :5.0),
                    child: Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: [
                        Text(textFormUpdateAdd),
                        IconButton(
                          color: Colors.red,
                          onPressed: (){
                            level == "admin"
                            ? _commandFormUpdateAdd("", false)
                            :PageRoutes.routeToLogin(context);
                          }, icon: const Icon(Icons.close,size: 20.0,)),
                      ],
                    ),
                  ),
                  Card(
                    child: Padding(
                      padding: const EdgeInsets.all(2.0),
                      child: TextField(
                        enabled: true,
                        controller: cName,
                        decoration: const InputDecoration(
                        enabledBorder: OutlineInputBorder(
                        borderSide: BorderSide(color: Colors.blue)
                          ),
                          label: Text("Nama",style: TextStyle(fontSize: 10,color: Colors.blue),),
                        ), 
                      ),
                    ),
                  ),
                  Card(
                    child: Padding(
                      padding: const EdgeInsets.all(2.0),
                      child: TextField(
                        enabled: true,
                        controller: cUsername,
                        decoration: const InputDecoration(
                        enabledBorder: OutlineInputBorder(
                        borderSide: BorderSide(color: Colors.blue)
                          ),
                          label: Text("Username",style: TextStyle(fontSize: 10,color: Colors.blue),),
                        ), 
                      ),
                    ),
                  ),  
                  Card(
                    child: Padding(
                      padding: const EdgeInsets.all(2.0),
                      child: TextField(
                        enabled: true,
                        obscureText: true,
                        controller: cPassword1,
                        decoration: const InputDecoration(
                        enabledBorder: OutlineInputBorder(
                        borderSide: BorderSide(color: Colors.blue)
                          ),
                          label: Text("Password",style: TextStyle(fontSize: 10,color: Colors.blue),),
                        ), 
                      ),
                    ),
                  ), 
                  Card(
                    child: Padding(
                      padding: const EdgeInsets.all(2.0),
                      child: TextField(
                        enabled: true,
                        obscureText: true,
                        controller: cPassword2,
                        decoration: const InputDecoration(
                        enabledBorder: OutlineInputBorder(
                        borderSide: BorderSide(color: Colors.blue)
                          ),
                          label: Text("Ketik Ulang Password",style: TextStyle(fontSize: 10,color: Colors.blue),),
                        ), 
                      ),
                    ),
                  ),                  
                  Card(
                    child: Padding(
                      padding: const EdgeInsets.all(2.0),
                      child: TextField(
                        enabled: true,
                        controller: cAddress,
                        decoration: const InputDecoration(
                        enabledBorder: OutlineInputBorder(
                        borderSide: BorderSide(color: Colors.blue)
                          ),
                          label: Text("Alamat",style: TextStyle(fontSize: 10,color: Colors.blue),),
                        ), 
                      ),
                    ),
                  ), 
                  Card(
                    child: Padding(
                      padding: const EdgeInsets.all(2.0),
                      child: TextField(
                        enabled: true,
                        controller: cEmail,
                        maxLines: 2,
                        decoration: const InputDecoration(
                        enabledBorder: OutlineInputBorder(
                        borderSide: BorderSide(color: Colors.blue)
                          ),
                          label: Text("Email",style: TextStyle(fontSize: 10,color: Colors.blue),),
                        ), 
                      ),
                    ),
                  ), 
                  Card(
                    child: Padding(
                      padding: const EdgeInsets.all(2.0),
                      child: TextField(
                        keyboardType: TextInputType.number,                      
                        enabled: true,
                        controller: cNoTelp,
                        maxLines: 2,
                        decoration: const InputDecoration(
                        enabledBorder: OutlineInputBorder(
                        borderSide: BorderSide(color: Colors.blue)
                          ),
                          label: Text("Nomor Telepon",style: TextStyle(fontSize: 10,color: Colors.blue),),
                        ), 
                      ),
                    ),
                  ),
                  level == "admin"        
                  ? TextButton.icon(onPressed: (){
                    radioButtons("admin");
                  }, icon: Icon(cLevel.text =="admin"?Icons.radio_button_on:Icons.radio_button_off), label: const Text("Admin"))
                  :Container(), 
                  level == "admin"  
                  ? TextButton.icon(onPressed: (){
                    radioButtons("user");
                  }, icon: Icon(cLevel.text =="user" || cLevel.text ==""?Icons.radio_button_on:Icons.radio_button_off), label: const Text("User"))
                  :Container(),                                                                         
                  Center(
                    child: Padding(
                      padding: const EdgeInsets.only(top:8.0),
                      child: Row(
                        mainAxisAlignment: MainAxisAlignment.center,
                        children: [
                          Card(
                            color: Colors.green,
                            child: TextButton(
                              style: TextButton.styleFrom(
                              backgroundColor: Colors.transparent,
                              shadowColor: Colors.transparent,
                              surfaceTintColor: Colors.blue,
                              padding: const EdgeInsets.all(10.0),
                              textStyle: const TextStyle(fontSize: 12),
                              ), child: const Text('Simpan Data',style: TextStyle(color: Colors.white),),
                              onPressed: (){
                                textFormUpdateAdd == ApiUrl.tambahUserText
                                ?_commandAlertMessage(ApiUrl.tambahUserText,"Pastikan Data Benar",true)
                                :textFormUpdateAdd == ApiUrl.editUserText
                                ?_commandAlertMessage(ApiUrl.editUserText,"Apakah Data User Akan Diubah ?",true)
                                :textFormUpdateAdd == ApiUrl.deleteUserText
                                ?_commandAlertMessage(ApiUrl.deleteUserText,"Apakah Data User Akan Dihapus ?",true)
                                : level == ""
                                ? _commandAlertMessage(ApiUrl.tambahUserText,"Pastikan Data Benar",true)
                                :_commandFormUpdateAdd("", false);
                              },
                            ),
                          ),                     
                        ],
                      ),
                    ),
                  ),                                                                          
                ],
              ),
            ),
          ),
        ),
      ),
    );
  }

bool appBarf = false;
 _appBarF(){
  setState(() {
    appBarf = !appBarf;
  });
 }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      drawer: const Drawers(),
        appBar: AppBar(
          backgroundColor: Colors.green,
          foregroundColor: Colors.white,
          shadowColor: Colors.blue,
        title: 
        level != "" 
        ? Padding(
          padding: const EdgeInsets.all(8.0),
          child: Row(
            children: [
              Expanded(
                child: TextField(
                  controller: cSearch,
                  decoration: const InputDecoration(
                    enabledBorder: OutlineInputBorder(
                      borderSide: BorderSide(color: Colors.white)
                    ),
                    label: Text("Pencarian User",style: TextStyle(fontSize: 10,color: Colors.white),),
                  ),                
                ),
              ),
              appBarf == false 
              ? IconButton(onPressed: (){
                _appBarF();
                _getDataUser("","",cSearch.text,"","","");
              }, icon: const Icon(Icons.search,size: 20.0))
              : IconButton(onPressed: (){
                _appBarF();
                _getDataUser("","","","","","");
                setState(() {
                  cSearch.text = "";
                });
              }, icon: const Icon(Icons.close,size: 20.0))
            ],
          ),
        )
        :Container(
          color: Colors.transparent,
          child: const Text("Daftar Akun"),
        ),
      ),
      body: RefreshIndicator(
        onRefresh: () =>_getDataUser("","","","","",""),
        child: Stack(
          children: [
            level == "admin"
            ? ListView.builder(
              itemCount: _listUser.length,
              itemBuilder: (context,index){
                final listDataUser = _listUser[index]; 
                return Card(
                  color: Colors.green,
                  child: ListTile(
                    title: Text(listDataUser!.name),
                    subtitle: Text(listDataUser.username),
                    leading: IconButton(onPressed: (){
                      setState(() {
                        cUserId.text = listDataUser.idUser;
                      });
                      _commandAlertMessage(ApiUrl.deleteUserText, listDataUser.name, true);
                    }, icon: const Icon(Icons.delete,color: Colors.white,)),
                    trailing: IconButton(onPressed: (){
                      _editDataUser(
                        listDataUser.idUser,
                        listDataUser.name,
                        listDataUser.username,
                        listDataUser.password,
                        listDataUser.password,
                        listDataUser.address,
                        listDataUser.level,
                        listDataUser.email,
                        listDataUser.noTelp,
                        listDataUser.token,
                        ApiUrl.editUserText);
                    }, icon: const Icon(Icons.edit,color: Colors.white)),
                  ),
                );
              }
            ):Container(),
              tampilFormUpdateAdd == true || level == ""
              ? _formUpdateAdd()
              : Container(),
              tampilAlertMessage == true
              ? _alertMessage()
              : Container(),         
              tampilAlertMessageResponse == true
              ? _alertMessageResponse()
              : Container(),            
          ],
        ),
      ),
      floatingActionButton: 
      level != ""
      ? FloatingActionButton(
        onPressed: (){
          _clearCtext();
          _commandFormUpdateAdd(ApiUrl.tambahUserText, true);
        },
        backgroundColor: Colors.green,
        child: const Icon(Icons.add),
      )
      :Container(),      
    );
  }
}