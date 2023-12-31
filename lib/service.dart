import 'dart:convert';
import 'package:dio/dio.dart';
import 'package:mcb/api.dart';
import 'package:mcb/poslist.dart';
import 'package:shared_preferences/shared_preferences.dart';

class Service {
    static Future writeSR(
    String value,
    String idUsersApp,
    String name,
    String username,
    String password,
    String address,
    String level,
    String email,
    String noTelp,
    String token) async {
    SharedPreferences prefs = await SharedPreferences.getInstance();
    return prefs;
  }
     
  static Future getPref() async {
    SharedPreferences prefs = await SharedPreferences.getInstance();
    return prefs;
  }

  static Future logins(username,password) async{
    var map = FormData.fromMap({
        'ACTION': 'LOGIN',
        'username': username,
        'password': password,
      });  
    var dio = Dio();
    final response = await dio.post(ApiUrl.login, data: map);

    final listUser  = jsonDecode(response.data);
    print(listUser);
    return listUser;
  } 

  static Future<List<PostList>> getDataUser(action,idUser,name,username,level,noTelp) async{
    var map = FormData.fromMap({
        'ACTION': action,
        'id_user': idUser,
        'name': name,
        'username': username,
        'level': level,
        'no_telp': noTelp,
      });  
    var dio = Dio();
    final response = await dio.post(ApiUrl.viewDataUser, data: map);

    List<PostList> listUser  = parseResponse(response.data);
    return listUser;
  }

  static Future <List<PostList>> functionUploadDataUser(action , cUserId ,cName, cUsername, cPassword1 , cPassword2,
  cAddress ,cLevel,cEmail, cNoTelp, idUsersApp) async{
    var map = FormData.fromMap({
        'ACTION': action,
        'id_user': cUserId.toString(),
        'name': cName.toString(),
        'username': cUsername.toString(),
        'password1': cPassword1.toString(),
        'password2': cPassword2.toString(),
        'address': cAddress.toString(),
        'level': cLevel.toString(),
        'email': cEmail.toString(),
        'no_telp': cNoTelp.toString(),       
      });
    var dio = Dio();
    final response = 
    action == ApiUrl.tambahUserText
    ? await dio.post(ApiUrl.addDataUser, data: map)
    : action == ApiUrl.deleteUserText
    ? await dio.post(ApiUrl.deleteDataUser, data: map)
    : action == ApiUrl.editUserText
    ? await dio.post(ApiUrl.editDataUser, data: map)
    : await dio.post(ApiUrl.user, data: map);

    List<PostList> list  = parseResponse(response.data);
    return list;
  }  

  static Future <List<PostList>> functionUploadDataKajian(action , idKajian, nmKajian, filePaths, fileName, idUser,jamStartKajian,jamEndKajian,tglKajian) async{
    String tglInput = DateTime.now().toString();
    var map = 
    fileName !=""
    ? FormData.fromMap({
        'ACTION': action,
        'id_kajian': idKajian.toString(),
        'nm_kajian': nmKajian.toString(),   
        'jam_start_kajian': jamStartKajian,  
        'jam_end_kajian': jamEndKajian,  
        'tgl_kajian': tglKajian,                           
        'files': MultipartFile.fromFileSync(filePaths.path, filename: fileName),
        'datetime_now': tglInput.toString(), 
      })
      :FormData.fromMap({
        'ACTION': action,
        'id_kajian': idKajian.toString(),
        'nm_kajian': nmKajian.toString(), 
        'jam_start_kajian': jamStartKajian,  
        'jam_end_kajian': jamEndKajian,  
        'tgl_kajian': tglKajian,          
        'datetime_now': tglInput.toString(),       
      });
    var dio = Dio();
    final response = 
    action == ApiUrl.tambahKajianText
    ? await dio.post(ApiUrl.addDataKajian, data: map)
    : action == ApiUrl.deleteKajianText
    ? await dio.post(ApiUrl.deleteDataKajian, data: map)
    : action == ApiUrl.editKajianText
    ? await dio.post(ApiUrl.editDataKajian, data: map)
    : await dio.post(ApiUrl.kajian, data: map);

    List<PostList> list  = parseResponse(response.data);
    return list;
  }   
  
  static Future<List<PostList>> getDataKajian(action,idKajian,nmKajian,fotoKajian,jamStartKajian,jamEndKajian,tglKajian,idUsersApp) async{
    String tglInput = DateTime.now().toString();
    var map = FormData.fromMap({
        'ACTION': action.toString(),
        'id_kajian': idKajian.toString(),
        'nm_kajian': nmKajian.toString(),
        'foto_kajian': fotoKajian.toString(),
        'jam_start_kajian': jamStartKajian.toString(),
        'jam_end_kajian': jamEndKajian.toString(),
        'tgl_kajian': tglKajian.toString(),
        'id_user': idUsersApp.toString(),
        'datetime_now': tglInput.toString(), 
      });  
    var dio = Dio();
    final response = await dio.post(ApiUrl.viewDataKajian, data: map);

    List<PostList> listTeam  = parseResponse(response.data);
    return listTeam;
  }

  static Future <List<PostList>> functionUploadDataAbsensi(action , cIdAbsensi ,cIdKajian, idUsersApp) async{
    String tglInput = DateTime.now().toString();
    var map = FormData.fromMap({
        'ACTION': action,
        'id_absensi': cIdAbsensi.toString(),
        'id_kajian': cIdKajian.toString(),
        'id_user': idUsersApp.toString(),
        'datetime_absen': tglInput.toString(),       
      });
    var dio = Dio();
    final response = 
    action == ApiUrl.tambahAbsenText
    ? await dio.post(ApiUrl.addADatabsensi, data: map)
    : action == ApiUrl.deleteAbsenText
    ? await dio.post(ApiUrl.deleteDataAbsen, data: map)
    : await dio.post(ApiUrl.absensi, data: map);

    List<PostList> list  = parseResponse(response.data);
    return list;
  }  

  static Future<List<PostList>> getDataAbsensi(action,gIdAbsensi ,gIdKajian,idUsersApp,datetimeAbsen,level) async{
    var map = FormData.fromMap({
        'ACTION': action,
        'id_absensi': gIdAbsensi,
        'id_kajian': gIdKajian,
        'id_user': idUsersApp,
        'datetime_absen': datetimeAbsen,
        'level': level,
      });  
    var dio = Dio();
    final response = await dio.post(ApiUrl.detailDataAbsen, data: map);

    List<PostList> listTeam  = parseResponse(response.data);
    return listTeam;
  }

  static List<PostList> parseResponse(String responseBody) {
    final  parsed = jsonDecode(responseBody).cast<Map<String, dynamic>>();
    return parsed.map<PostList>((e) => PostList.fromJsons(e)).toList();
  }  

  
}