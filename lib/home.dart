import 'package:cached_network_image/cached_network_image.dart';
import 'package:carousel_slider/carousel_slider.dart';
import 'package:flutter/material.dart';
import 'package:mcb/api.dart';
import 'package:mcb/drawer.dart';
import 'package:mcb/page_routes.dart';
import 'package:mcb/poslist.dart';
import 'package:mcb/service.dart';

class Home extends StatefulWidget {
  const Home({Key? key}) : super(key: key);

  @override
  State<Home> createState() => _HomeState(); 
  
}

class _HomeState extends State<Home> {
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

        _getDataKajian("","","","","","","");
      });
    });
  }


  TextEditingController cSearch = TextEditingController();
  int _current = 0;
  final CarouselController _controller = CarouselController();
  List<PostList?> _listKajian = [];
  bool _loading = false;
  _getDataKajian(action,idKajian,nmKajian,fotoKajian,jamStartKajian,jamEndKajian,tglKajian) async{
    setState(() {
      _loading = true;
    });
    Service.getDataKajian(action,idKajian,nmKajian,fotoKajian,jamStartKajian,jamEndKajian,tglKajian,idUsersApp).then((value) async {
      setState(() {
        _listKajian = value;
        _loading = false;

            print(_listKajian.toList());
      });
    });
  }

  TextStyle _customFont() {
  return const TextStyle(color: Colors.white);
  }

  String headerText = "";
  String titleText = "";
  bool tampilAlertMessage = false;
  String idAbsensis = "";

  _commandAlertMessage(headers, titles, tampilAlertMessages){
    setState(() {
      headerText = headers;
      titleText = titles;
      tampilAlertMessage = tampilAlertMessages;
    });
  } 

  _alertMessage(){
    return Container(
      color: Colors.black45,
      child: Center(
        child: SizedBox(
          width: MediaQuery.of(context).size.width* 0.8,
          height: MediaQuery.of(context).size.height* 0.3,        
          child: Card(
            color:titleText == ApiUrl.confimAbsen ? Colors.green : Colors.red,
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
                          ), child: const Text("Iya",style: TextStyle(color: Colors.white),),
                          onPressed: (){
                            _functionUploadDataAbsensi(
                              titleText == ApiUrl.confimAbsen ? ApiUrl.tambahAbsenText : ApiUrl.deleteAbsenText,
                              idAbsensis,idKajians);
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
                          ), child: const Text('Keluar',style: TextStyle(color: Colors.white),),
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
      ),
    );
  }

 
 String message = "", values = "";
 List<PostList?> _messageUpload = [];
 _functionUploadDataAbsensi(action,cIdAbsensi,cIdKajian) async{
  setState(() {
    _loading = true;
  });
  
  Service.functionUploadDataAbsensi(action , cIdAbsensi ,cIdKajian, idUsersApp.toString()).then((value) async {
    setState(() {
      _messageUpload = value;
      _loading = false;
      message = _messageUpload[0]!.message.toString();
      values = _messageUpload[0]!.value.toString();    
      
      if (values == "1") {
        setState(() {
          _commandAlertMessage("", "", false);
          _commandAlertMessageResponse(values, message, true);
          _getDataKajian("",cIdKajian,"","","","","");
          _messageUpload.clear();
          message ="";
          values ="";
        });
      }else{
        setState(() {
        _commandAlertMessage("", "", false);
        _commandAlertMessageResponse(values, message, true);          
        });
      }
    });
  });
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

  String idKajians = "";

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      drawer: const Drawers(),
      appBar: AppBar(
        backgroundColor: Colors.green,
        foregroundColor: Colors.white,
        shadowColor: Colors.blue,        
        title: Padding(
          padding: const EdgeInsets.all(8.0),
          child: Row(
            children: [
              Expanded(
                child: Card(
                  color: Colors.blue,
                  child: TextField(
                    controller: cSearch,
                    decoration: const InputDecoration(
                      enabledBorder: OutlineInputBorder(
                        borderSide: BorderSide(color: Colors.white)
                      ),
                      label: Text("Pencarian Kajian",style: TextStyle(fontSize: 10,color: Colors.white),),
                    ),                
                  ),
                ),
              ),
              IconButton(onPressed: (){
                
              }, icon: const Icon(Icons.search))
            ],
          ),
        ),
      ),
      body: RefreshIndicator(
        onRefresh: ()=> PageRoutes.routeToHome(context),
        child: Stack(
          children: [
            Card(
              color: Colors.green,
              child: Column(
                children: [
                  CarouselSlider(
                    carouselController: _controller,
                    options: CarouselOptions(
                        height: 250,
                        aspectRatio: 2.0,
                        viewportFraction: 0.8,
                        initialPage: 0,
                        enableInfiniteScroll: true,
                        reverse: false,
                        autoPlay: true,
                        autoPlayInterval: const Duration(seconds: 5),
                        autoPlayAnimationDuration: const Duration(milliseconds: 800),
                        autoPlayCurve: Curves.fastOutSlowIn,
                        enlargeCenterPage: true,
                        enlargeFactor: 0.3,
                        scrollDirection: Axis.horizontal,
                        onPageChanged: (index, reason){
                          setState(() {
                            _current = index;
                          });
                        }
                    ),
                    items: _listKajian.map((index) {
                      return Builder(
                        builder: (BuildContext context) {
                          return Card(
                            child: Padding(
                              padding: const EdgeInsets.all(2.0),
                              child: Container(
                                width: MediaQuery.of(context).size.width,                                    
                                decoration: const BoxDecoration(
                                  color: Colors.blue
                                ),
                                child: 
                                Column(
                                  mainAxisAlignment: MainAxisAlignment.center,
                                  children: [
                                    Expanded(child: Padding(
                                      padding: const EdgeInsets.only(top:8.0),
                                      child: CachedNetworkImage(
                                        progressIndicatorBuilder: (context, url, progress) => Center(
                                          child: CircularProgressIndicator(
                                            value: progress.progress,
                                          ),
                                        ),
                                        imageUrl:
                                            ApiUrl.viewImageKajian+index!.fotoKajian,
                                      ),
                                    )),
                                    Align(
                                      child: Text(index.nmKajian.toString(),textAlign: TextAlign.center, style:  const TextStyle(fontSize: 13.0,color: Colors.white),),
                                    ),
                                    Padding(
                                      padding: const EdgeInsets.all(8.0),
                                      child: Text("Pada ${index.tglKajianHelp} Pukul ${index.jamStartKajian.substring(0,5)} s/d ${index.jamEndKajian.substring(0,5)}", style:  const TextStyle(fontSize: 13.0,color: Colors.white)),
                                    ),
                                  ],
                                )
                              ),
                            ),
                          );
                        },
                      );
                    }).toList(),
                  ),
                  Row(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: _listKajian.asMap().entries.map((entry) {
                    return Expanded(
                      child: GestureDetector(
                        onTap: () => _controller.animateToPage(entry.key),
                        child: Expanded(
                          flex: 1,
                          child: Container(
                            width: 10.0,
                            height: 10.0,
                            margin: const EdgeInsets.symmetric(vertical: 8.0, horizontal: 4.0),
                            decoration: BoxDecoration(
                                shape: BoxShape.circle,
                                color: (Theme.of(context).brightness == Brightness.dark
                                        ? Colors.white
                                        : Colors.black)
                                    .withOpacity(_current == entry.key ? 0.9 : 0.4)),
                          ),
                        ),
                      ),
                    );
                  }).toList(),
                  ),
                  Expanded(
                    child: ListView.builder(
                      itemCount: _listKajian.length,
                      itemBuilder: (context,index)=> 
                      Card(
                        color: Colors.white,
                        child: Card(
                          color: _listKajian[index]!.idAbsensi.toString() == "" ? Colors.blue : Colors.green,
                          child: Padding(
                            padding: const EdgeInsets.only(right: 8.0,left: 8.0),
                            child: Column(
                              children: [
                                ListTile(
                                  leading: IconButton(onPressed: (){}, icon: const Icon(Icons.download,color: Colors.black,)),
                                  title: Text(_listKajian[index]!.nmKajian.toString(),textAlign: TextAlign.center,style:const TextStyle(color: Colors.black,fontSize: 12.0)),
                                  trailing: IconButton(onPressed: (){}, icon: const Icon(Icons.list,color: Colors.black,)),
                                  subtitle: Card(
                                    color: _listKajian[index]!.idAbsensi.toString() == "" ? Colors.blue : Colors.green,
                                    child: Padding(
                                    padding: const EdgeInsets.all(8.0),
                                    child: Text("Pada ${_listKajian[index]!.tglKajianHelp} Pukul ${_listKajian[index]!.jamStartKajian.substring(0,5)} s/d ${_listKajian[index]!.jamEndKajian.substring(0,5)}"),
                                  )),
                                ),
                                Padding(
                                  padding: const EdgeInsets.all(8.0),
                                  child: ElevatedButton(
                                    onPressed: (){
                                      setState(() {
                                        idKajians = _listKajian[index]!.idKajian;
                                        idAbsensis = _listKajian[index]!.idAbsensi;
                                      });
                                      _commandAlertMessage(_listKajian[index]!.nmKajian.toString(), 
                                      _listKajian[index]!.idAbsensi.toString() == "" ? ApiUrl.confimAbsen : ApiUrl.cancelAbsen, true);
                                    },
                                    style: ElevatedButton.styleFrom(
                                      backgroundColor: _listKajian[index]!.idAbsensi.toString() == "" ?Colors.orange:Colors.blue,
                                      shape: RoundedRectangleBorder(
                                          borderRadius: BorderRadius.circular(50),
                                        )
                                      ), 
                                    child:  Text(
                                      _listKajian[index]!.idAbsensi.toString() == ""
                                      ? "Silahkan Absen ${_listKajian[index]!.idAbsensi.toString()}"
                                      :"Anda Sudah Absen"
                                      ,style:const TextStyle(color: Colors.black,fontSize: 12.0)),
                                    ),
                                ),
                              ],
                            ),
                          ),
                        ),
                      ),
                    ),
                  ),              
                ],
              ),
            ),
            tampilAlertMessage == true
            ? _alertMessage()
            : Container(),
            tampilAlertMessageResponse == true
            ? _alertMessageResponse()
            : Container(),                
          ],
        ),
      ),
      // floatingActionButton: FloatingActionButton(
      //   onPressed: (){
      //   },
      //   backgroundColor: Colors.green,
      //   child: const Icon(Icons.menu),
      // ),      
    );
  }
}

