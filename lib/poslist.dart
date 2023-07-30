
class PostList {

  late String idUser;
  late String name;
  late String username;
  late String password;
  late String address;  
  late String level;    
  late String email; 
  late String noTelp;    
  late String token; 

  late String idKajian ;
  late String nmKajian;
  late String fotoKajian;
  late String jamStartKajian;
  late String jamEndKajian;
  late String tglKajian;
  late String tglKajianHelp;

  late String message;
  late String value;  

  PostList({
    required this.idUser,
    required this.name,
    required this.username,
    required this.password,
    required this.address,  
    required this.level,    
    required this.email, 
    required this.noTelp,    
    required this.token, 

    required this.idKajian,
    required this.nmKajian,
    required this.fotoKajian,
    required this.jamStartKajian,
    required this.jamEndKajian,
    required this.tglKajian,
    required this.tglKajianHelp,

    required this.message,
    required this.value,    
  });

  factory PostList.fromJsons(Map<String,dynamic> json){
    return PostList(
       idUser: json['id_user'] ?? "",
      name: json['name'] ?? "", 
      username: json['username'] ?? "",
      password: json['password'] ?? "", 
      address: json['address'] ?? "",
      level: json['level'] ?? "",      
      email: json['email'] ?? "",     
      noTelp: json['no_telp'] ?? "",  
      token: json['token'] ?? "",   

      idKajian:json['id_kajian'] ?? "", 
      nmKajian:json['nm_kajian'] ?? "", 
      fotoKajian:json['foto_kajian'] ?? "", 
      jamStartKajian:json['jam_start_kajian'] ?? "", 
      jamEndKajian:json['jam_end_kajian'] ?? "", 
      tglKajian:json['tgl_kajian'] ?? "", 
      tglKajianHelp:json['tgl_kajian_help'] ?? "", 

      message: json['message'] ?? "", 
      value: json['value'] ?? "",   

      );
  }
  
}