import 'dart:io';
import 'package:file_picker/file_picker.dart';
import 'package:flutter/material.dart';
import 'package:mcb/api.dart';
import 'package:mcb/drawer.dart';
import 'package:mcb/poslist.dart';
import 'package:mcb/service.dart';
import 'package:mcb/web_custom_scroll_behavior.dart';

class Kanjian extends StatefulWidget {
  const Kanjian({Key? key, required this.session}) : super(key: key);
  final String session;

  @override
  State<Kanjian> createState() => _KanjianState();
}

class _KanjianState extends State<Kanjian> {
  
  @override
  void initState() {
    super.initState();
    _getPref();
    _getDataKajian("");
    _loading;
  }

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

  File? filePickerVal;
  String txtFilePicker = "";
  selectFile()async{
    FilePickerResult? result = await FilePicker.platform.pickFiles(
      type: FileType.custom,
      allowedExtensions: ['jpg', 'png', 'jpeg'],
      );
    
    if (result != null) {
        setState(() {
          txtFilePicker = result.files.single.name;
          filePickerVal = File(result.files.single.path.toString());
        });
    } else {
      // User canceled the picker
    }    
  }

  clearFile(){
    setState(() {
      txtFilePicker = "";
    });
  }

  TextStyle _customFont() {
  return const TextStyle(color: Colors.white);
  }

  Color _colorIcon() {
    return Colors.white;
  }

    TextEditingController cSearch = TextEditingController();
    TextEditingController cKajianId = TextEditingController();
    TextEditingController cKajianNm = TextEditingController();
    TextEditingController cKajianFoto = TextEditingController();
    TextEditingController cKajianJamStart = TextEditingController();
    TextEditingController cKajianJamEnd = TextEditingController();
    TextEditingController cKajianTgl = TextEditingController();

  List<PostList?> _listKajian = [];

  _getDataKajian(action) async{
    setState(() {
      _loading = true;
    });
    Service.getDataKajian(action,cKajianId.text,cKajianNm.text,cKajianFoto.text,cKajianJamStart.text,cKajianJamEnd.text,cKajianTgl.text,"").then((value) async {
      setState(() {
        _listKajian = value;
        _loading = false;
        _clearCtext();
      });
    });
  }

 String message = "", values = "";
 List<PostList?> _messageUpload = [];
 _functionUploadDataKajian() async{
  setState(() {
    _loading = true;
  });
  
  Service.functionUploadDataKajian(
    headerText, cKajianId.text ,cKajianNm.text, filePickerVal, txtFilePicker, idUsersApp,cKajianJamStart.text,cKajianJamEnd.text,cKajianTgl.text).then((value) async {
    setState(() {
      _messageUpload = value;
      _loading = false;
      message = _messageUpload[0]!.message.toString();
      values = _messageUpload[0]!.value.toString();   
      print("object $values"); 
      
      if (values == "1") {
        setState(() {
          _commandAlertMessage("", "", false);
          _commandAlertMessageResponse(values, message, true);
          _commandFormUpdateAdd("", false);
          _getDataKajian("");
          txtFilePicker = "";
          filePickerVal = null;
          _messageUpload.clear();
          message ="";
          values ="";
          _clearCtext();
        });
      }else{
        setState(() {
        _commandAlertMessage(headerText, "", true);
        _commandAlertMessageResponse(values, message, true);            
        });
      }
    });
  });
 }

 _clearCtext(){
  setState(() {
    cKajianId.text = "";
    cKajianNm.text = "";
    cKajianFoto.text = "";
    cKajianJamStart.text = "";
    cKajianJamEnd.text = "";
    cKajianTgl.text = "";
    cSearch.text = "";
  });
 }
  _alertMessage(){
    return Center(
      child: SizedBox(
        width: MediaQuery.of(context).size.width* 0.8,
        height: MediaQuery.of(context).size.height* 0.3,        
        child: Card(
          color: 
            textFormUpdateAdd == ApiUrl.tambahKajianText || headerText == ApiUrl.tambahKajianText 
            ? Colors.green
            :textFormUpdateAdd == ApiUrl.editKajianText || headerText == ApiUrl.editKajianText 
            ? Colors.orange
            :textFormUpdateAdd == ApiUrl.deleteKajianText || headerText == ApiUrl.deleteKajianText
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
                          _functionUploadDataKajian();
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

  bool tampilFormUpdateAdd = false;
  String textFormUpdateAdd = "";

  _commandFormUpdateAdd(textFormUpdateAdds, tampilFormUpdateAdds){
    setState(() {
      textFormUpdateAdd = textFormUpdateAdds;
      tampilFormUpdateAdd = tampilFormUpdateAdds;
      headerText = textFormUpdateAdds;
    });
  }

  String headerText = "";
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

  _editDataKajian(cIdKajians,cNmKajians,cFotoKajians,cJamStartKajian, cJamEndKajian, cTglKajian, headers){
    setState(() {
        cKajianId.text = cIdKajians;
        cKajianNm.text = cNmKajians;
        cKajianFoto.text = cFotoKajians;
        cKajianJamStart.text = cJamStartKajian;
        cKajianJamEnd.text = cJamEndKajian;
        cKajianTgl.text = cTglKajian;        
        _commandFormUpdateAdd(headers, true);
    });
  }

  DateTime selectedDate = DateTime.now();
  TimeOfDay selectedStartTime = TimeOfDay.now();
  TimeOfDay selectedEndTime = TimeOfDay.now();

  _formUpdateAdd(){
    return Center(
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
                          _commandFormUpdateAdd("", false);
                        }, icon: const Icon(Icons.close,size: 20.0,)),
                    ],
                  ),
                ),
                Card(
                  child: Padding(
                    padding: const EdgeInsets.all(2.0),
                    child: Row(
                      children: [
                        IconButton(onPressed: () async{
                          final date = await pickDate();
                          setState(() {
                            if (date == null) {
                              cKajianTgl.text = "";
                            }else{
                              cKajianTgl.text = date.toString().substring(0,10);
                            }                            
                          });
                        }, icon: const Icon(Icons.calendar_today,color: Colors.blue,)),
                        Expanded(
                          child: TextField(
                            enabled: headerText == ApiUrl.detailKajianText ?false : true,
                            controller: cKajianTgl,
                            decoration: const InputDecoration(
                            enabledBorder: OutlineInputBorder(
                            borderSide: BorderSide(color: Colors.blue)
                              ),
                              label: Text("Tanggal Kajian",style: TextStyle(fontSize: 10,color: Colors.blue),),
                            ), 
                          ),
                        ),
                      ],
                    ),
                  ),
                ),  
                Card(
                  child: Padding(
                    padding: const EdgeInsets.all(2.0),
                    child: Row(
                      children: [
                        IconButton(onPressed: ()async{
                          final timeStart = await selectedTimeStart();
                          setState(() {
                            if (timeStart == null) {
                              cKajianJamStart.text = "";
                            }else{
                              cKajianJamStart.text = timeStart.toString().substring(10,15);
                            }                            
                          });                          
                        }, icon: const Icon(Icons.timer,color: Colors.blue,)),
                        Expanded(
                          child: TextField(
                            enabled: headerText == ApiUrl.detailKajianText ?false : true,
                            controller: cKajianJamStart,
                            decoration: const InputDecoration(
                            enabledBorder: OutlineInputBorder(
                            borderSide: BorderSide(color: Colors.blue)
                              ),
                              label: Text("Jam Mulai Kajian",style: TextStyle(fontSize: 10,color: Colors.blue),),
                            ), 
                          ),
                        ),
                      ],
                    ),
                  ),
                ),   
                Card(
                  child: Padding(
                    padding: const EdgeInsets.all(2.0),
                    child: Row(
                      children: [
                        IconButton(onPressed: ()async{
                          final timeEnd = await selectedTimeEnd();
                          setState(() {
                            if (timeEnd == null) {
                              cKajianJamEnd.text = "";
                            }else{
                              cKajianJamEnd.text = timeEnd.toString().substring(10,15);
                            }                            
                          });                             
                        }, icon: const Icon(Icons.timer,color: Colors.blue,)),
                        Expanded(
                          child: TextField(
                            enabled: headerText == ApiUrl.detailKajianText ?false : true,
                            controller: cKajianJamEnd,
                            decoration: const InputDecoration(
                            enabledBorder: OutlineInputBorder(
                            borderSide: BorderSide(color: Colors.blue)
                              ),
                              label: Text("Jam Selesai Kajian",style: TextStyle(fontSize: 10,color: Colors.blue),),
                            ), 
                          ),
                        ),
                      ],
                    ),
                  ),
                ),                                
                Card(
                  child: Padding(
                    padding: const EdgeInsets.all(2.0),
                    child: TextField(
                      enabled: headerText == ApiUrl.detailKajianText ?false : true,
                      controller: cKajianNm,
                      maxLines: 5,
                      decoration: const InputDecoration(
                      enabledBorder: OutlineInputBorder(
                      borderSide: BorderSide(color: Colors.blue)
                        ),
                        label: Text("Nama Kajian",style: TextStyle(fontSize: 10,color: Colors.blue),),
                      ), 
                    ),
                  ),
                ),                                     
                headerText == ApiUrl.detailKajianText 
                ? Container()            
                : Center(
                  child: Padding(
                    padding: const EdgeInsets.only(top:8.0),
                    child: Row(
                      mainAxisAlignment: txtFilePicker != "" ? MainAxisAlignment.spaceEvenly : MainAxisAlignment.center,
                      children: [
                        txtFilePicker == "" && textFormUpdateAdd == ApiUrl.tambahKajianText
                        ? Container()
                        : Card(
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
                              textFormUpdateAdd == ApiUrl.tambahKajianText
                              ?_commandAlertMessage(ApiUrl.tambahKajianText,"Pastikan Data Benar",true)
                              :textFormUpdateAdd == ApiUrl.editKajianText
                              ?_commandAlertMessage(ApiUrl.editKajianText,"Apakah Data Buku Akan Diubah ?",true)
                              :textFormUpdateAdd == ApiUrl.deleteKajianText
                              ?_commandAlertMessage(ApiUrl.deleteKajianText,"Apakah Data Akan Dihapus ?",true)
                              :_commandFormUpdateAdd("", false);
                            },
                          ),
                        ),
                        Card(
                          color: Colors.blue,
                          child: TextButton(
                            style: TextButton.styleFrom(
                            backgroundColor: Colors.transparent,
                            shadowColor: Colors.transparent,
                            surfaceTintColor: Colors.blue,
                            padding: const EdgeInsets.all(10.0),
                            textStyle: const TextStyle(fontSize: 12),
                            ), child: const Text('Foto Kajian',style: TextStyle(color: Colors.white),),
                            onPressed: 
                            (){
                              selectFile();
                            },
                          ), 
                        ),                      
                      ],
                    ),
                  ),
                ),
                cKajianFoto.text == ""
                ? Container()
                : Padding(
                  padding: const EdgeInsets.all(8.0),
                  child: Card(
                    child: Column(
                      children: [
                        const Text("Foto Buku"),
                        Image.network(ApiUrl.viewImageBuku+cKajianFoto.text,
                        width: 100,
                        height: 100,
                        ),
                      ],
                    ),
                  ),
                ),
                txtFilePicker == ""     
                ? Container()
                : Padding(
                  padding: const EdgeInsets.all(8.0),
                  child: Card(
                    child: Image.file(filePickerVal!,
                    width: 100,
                    height: 100,
                    ),
                  ),
                )                                                                             
              ],
            ),
          ),
        ),
      ),
    );
  }
  bool onLongPress = false;
 _onLOngPress(){
  setState(() {
    onLongPress = !onLongPress;
  });
 }


 _dataKajian(){
  return ListView.builder(
    itemCount: _listKajian.length,
    scrollDirection: Axis.vertical,
    itemBuilder: (context,index){
      final listDataKajian = _listKajian[index]; 
      return GestureDetector(
        onLongPress: (){
          _onLOngPress();
        },
        child: Card(
          color: Colors.green,
          child: Column(
            children: [
              ListTile(
                title: Text(listDataKajian!.nmKajian,style: _customFont()),
                subtitle: Card(
                  child: Card(
                    color: Colors.blue,
                    child: Padding(
                      padding: const EdgeInsets.all(8.0),
                      child: Column(
                        children: [
                          Text("Pada Tanggal ${listDataKajian.tglKajianHelp}",style: const TextStyle(color: Colors.white,fontSize: 11)),
                          Text("Dimulai Jam ${listDataKajian.jamStartKajian.substring(0,5)}",style: const TextStyle(color: Colors.white,fontSize: 11)),
                          Text("Selesai Jam ${listDataKajian.jamEndKajian.substring(0,5)}",style: const TextStyle(color: Colors.white,fontSize: 11)),
                        ],
                      ),
                    ),
                  ),
                ),
                leading: 
                listDataKajian.fotoKajian != ""
                ? Image.network(ApiUrl.viewImageBuku+listDataKajian.fotoKajian)
                : Image.asset("assets/images/mcb.png"),
                trailing: IconButton(onPressed: (){
                        _editDataKajian(
                        listDataKajian.idKajian, 
                        listDataKajian.nmKajian,
                        listDataKajian.fotoKajian,
                        listDataKajian.jamStartKajian,
                        listDataKajian.jamEndKajian,
                        listDataKajian.tglKajian,
                        ApiUrl.detailKajianText
                        );                                    
                }, icon: Icon(Icons.remove_red_eye,color: _colorIcon())),
              ),
              onLongPress == true                        
              ? Padding(
                padding: const EdgeInsets.all(8.0),
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    Card(child: IconButton(onPressed: (){
                      setState(() {
                        cKajianId.text = listDataKajian.idKajian;
                      });
                      _commandAlertMessage(ApiUrl.deleteKajianText, listDataKajian.nmKajian, true);
                    }, icon: const Icon(Icons.delete_forever,color: Colors.red))),
                    Card(
                      child: IconButton(onPressed: (){
                      _editDataKajian(
                        listDataKajian.idKajian,
                        listDataKajian.nmKajian,
                        listDataKajian.fotoKajian,
                        listDataKajian.jamStartKajian,
                        listDataKajian.jamEndKajian,
                        listDataKajian.tglKajian,                        
                        ApiUrl.editKajianText
                        );                                  
                      }, icon: const Icon(Icons.edit,color: Colors.orange)),
                    ),                                      
                  ],
                ),
              ):Container()
            ],
          ),
        ),
      );
    }
  );
 }

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
              IconButton(onPressed: (){
                setState(() {
                  cKajianNm.text = cSearch.text;
                });
                _getDataKajian("");
              }, icon: const Icon(Icons.search))
            ],
          ),
        ),
      ),
      body: RefreshIndicator(
        onRefresh: () => _getDataKajian(""),
        child: Padding(
          padding: const EdgeInsets.all(1.0),
          child: Stack(
            children: [
              Padding(
                padding: const EdgeInsets.only(top:1.0,right: 8.0,left: 8.0),
                child: SizedBox(
                  height: MediaQuery.of(context).size.height * 1,
                  child: ScrollConfiguration(
                    behavior: WebCustomScrollBehavior(),
                    child: _dataKajian(),
                  ),
                ),
              ),
              tampilFormUpdateAdd == true
              ? _formUpdateAdd()
              :Container(),
              tampilAlertMessage == true
              ? _alertMessage()
              : Container(),
              tampilAlertMessageResponse == true
              ? _alertMessageResponse()
              : Container(),          
            ],
          ),
        ),
      ),
      floatingActionButton: FloatingActionButton(
        onPressed: (){
          _clearCtext();
          _commandFormUpdateAdd(ApiUrl.tambahKajianText,true);
        },
        backgroundColor: Colors.green,
        child: const Icon(Icons.add),
      ),
    );
  }

  Future<DateTime?> pickDate() => showDatePicker(
    context: context, 
    initialDate: selectedDate, 
    firstDate: DateTime(1900), 
    lastDate: DateTime(2100));  

  Future<TimeOfDay?> selectedTimeStart() => showTimePicker(
    context: context,
    initialTime: TimeOfDay.now(), 
  );
  Future<TimeOfDay?> selectedTimeEnd() => showTimePicker(
    context: context,
    initialTime: TimeOfDay.now(), 
  );

}

