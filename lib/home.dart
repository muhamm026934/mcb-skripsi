import 'package:cached_network_image/cached_network_image.dart';
import 'package:carousel_slider/carousel_slider.dart';
import 'package:flutter/material.dart';
import 'package:mcb/api.dart';
import 'package:mcb/drawer.dart';
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
    _getDataKajian("","","","","","","");
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
    Service.getDataKajian(action,idKajian,nmKajian,fotoKajian,jamStartKajian,jamEndKajian,tglKajian).then((value) async {
      setState(() {
        _listKajian = value;
        _loading = false;
      });
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
      body: Stack(
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
                      color: Colors.blue,
                      child: Padding(
                        padding: const EdgeInsets.only(right: 8.0,left: 8.0),
                        child: Column(
                          children: [
                            ListTile(
                              leading: IconButton(onPressed: (){}, icon: const Icon(Icons.delete_forever_rounded,color: Colors.black,)),
                              title: Text(_listKajian[index]!.nmKajian.toString(),textAlign: TextAlign.center,style:const TextStyle(color: Colors.black,fontSize: 12.0)),
                              trailing: IconButton(onPressed: (){}, icon: const Icon(Icons.edit_square,color: Colors.black,)),
                            ),
                            Padding(
                              padding: const EdgeInsets.all(8.0),
                              child: ElevatedButton(
                                onPressed: (){},
                                style: ElevatedButton.styleFrom(
                                  backgroundColor: Colors.orange,
                                  shape: RoundedRectangleBorder(
                                      borderRadius: BorderRadius.circular(50),
                                    )
                                  ), 
                                child:  const Text("Absen",style:TextStyle(color: Colors.black,fontSize: 12.0)),
                                ),
                            ),
                          ],
                        ),
                      ),
                    ),
                  ),
                ),              
              ],
            ),
          ),
        ],
      ),
      floatingActionButton: FloatingActionButton(
        onPressed: (){
        },
        backgroundColor: Colors.green,
        child: const Icon(Icons.add),
      ),      
    );
  }
}

