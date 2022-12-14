import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:google_maps_flutter/google_maps_flutter.dart';
import 'package:flutter_fianl_prj/placedata.dart';

import 'dart:async';
import 'package:flutter_typeahead/flutter_typeahead.dart';


import 'package:flutter_fianl_prj/bdstructure/bd101.dart';
import 'package:flutter_fianl_prj/bdstructure/bd102.dart';
import 'package:flutter_fianl_prj/bdstructure/bd103.dart';
import 'package:flutter_fianl_prj/bdstructure/bd104.dart';
import 'package:flutter_fianl_prj/bdstructure/bd105.dart';
import 'package:flutter_fianl_prj/bdstructure/bd201.dart';
import 'package:flutter_fianl_prj/bdstructure/bd202.dart';
import 'package:flutter_fianl_prj/bdstructure/bd110.dart';
import 'package:flutter_fianl_prj/bdstructure/bd109.dart';
import 'package:flutter_fianl_prj/bdstructure/bd111.dart';
import 'package:flutter_fianl_prj/bdstructure/bd403.dart';
import 'package:flutter_fianl_prj/bdstructure/bd309.dart';
import 'package:flutter_fianl_prj/bdstructure/bd204.dart';
import 'package:flutter_fianl_prj/bdstructure/bd205.dart';
import 'package:flutter_fianl_prj/bdstructure/bd207.dart';
import 'package:flutter_fianl_prj/bdstructure/bd402.dart';
import 'package:flutter_fianl_prj/bdstructure/bd311.dart';

class MapUniv extends StatefulWidget {

  @override
  _MapUnivState createState() => _MapUnivState();
}

class _MapUnivState extends State<MapUniv> {
  static const twilight_blue = const Color(0xff0b4c86);
  Completer<GoogleMapController> _controller=Completer();
  GlobalKey<FormState> _fbkey=GlobalKey<FormState>();
  TextEditingController _typeAheadController = TextEditingController();
  Set<Marker> _markers={};

  List<String> getSuggestion(String query){
    if(query.isEmpty){
      return [];
    }
    List<String> matches=[];

    final bdName=places.map((place)=>place['name']).toList();

    matches.addAll(bdName);

    matches.retainWhere((s) => s.contains(query));

    return matches;
  }

  String _getsubtitle(buildingName){

    final bdName=places.map((place)=>place['name']).toList();
    final bdNum=places.map((place)=>place['_bdnum']).toList();

    Map<dynamic,dynamic> subtitle={};
    for (int i=0;i<places.length;i++){
      subtitle[bdName[i]]=bdNum[i];
    }

    return '???????????? : ${subtitle[buildingName]}'.toString();

  }

  void _search() async{
    GoogleMapController controller = await _controller.future;
    _fbkey.currentState.save();
    final inputValue=_typeAheadController.text;
    final id=inputValue;
    final foundPlace=places.firstWhere(
            (place) => place['name']==id,
        orElse: ()=>null
    );
    var latAS=foundPlace['latitude'];
    var lngAS=foundPlace['longitude'];


    print('$id,$latAS,$lngAS');
    setState(() {
      _markers.clear();

      controller.animateCamera(CameraUpdate.newLatLng(LatLng(double.parse(latAS),double.parse(lngAS))));

        _markers.add(
          Marker(markerId: MarkerId('102'),
            position: LatLng(double.parse(latAS), double.parse(lngAS)),
            infoWindow: InfoWindow(
              title: id,
              snippet: '????????? ????????? ???????????? ???????????????',
              onTap: _showbottomsheet
            ),),
        );
    });

  }

  void _showbottomsheet(){
    _fbkey.currentState.save();
    final inputValue=_typeAheadController.text;//_fbkey.currentState.value;??????
    final bd=inputValue;//'???';//inputValue['buildingName'];//??????
    showModalBottomSheet(
        shape: RoundedRectangleBorder(
            borderRadius: BorderRadius.only(
                topLeft:Radius.circular(15),
                topRight: Radius.circular(15)
            )
        ),
        context: context,
        isScrollControlled: true,//modal??? ????????? ?????????
        builder: (context){
          return SingleChildScrollView(//??????????????????
            child: Column(
              mainAxisSize: MainAxisSize.min,
              children: <Widget>[
                Column(
                  children: <Widget>[
                    SizedBox(height: 10,),
                    Row(mainAxisAlignment: MainAxisAlignment.end,
                        children: <Widget>[TextButton(child:Icon(Icons.close_rounded, size:30),onPressed: (){Navigator.of(context).pop();},)]),
                    Row(
                      children: [
                        Padding(
                          padding: const EdgeInsets.symmetric(horizontal: 20),
                          child: Text(bd,style: TextStyle(
                              fontFamily: "Gothic",
                              fontWeight: FontWeight.w700,
                              fontSize: 20,
                              color: twilight_blue,
                              fontStyle: FontStyle.normal),),
                        ),
                      ],
                    ),
                    Padding(
                      padding: const EdgeInsets.symmetric(vertical: 20,horizontal: 30),
                      child: Column(children: [
                        if(bd=='???1?????????')Container(child: Column(
                          children: <Widget>[
                            ListTile(title: Text('1???'),
                              onTap: (){
                                Navigator.push(
                                    context,
                                    MaterialPageRoute(builder: (context) => Bd101_1st()));
                              },),
                            Divider(
                              thickness: 1,
                              color:Colors.blue,
                              height: 3,//divider??? ????????????
                            ),
                            ListTile(title: Text('2???'),
                                onTap: (){
                                  Navigator.push(
                                      context,
                                      MaterialPageRoute(builder: (context) => Bd101_2nd()));
                                }),
                            Divider(
                              thickness: 1,
                              color:Colors.blue,
                              height: 3,//divider??? ????????????
                            ),
                            ListTile(title: Text('3???'),
                                onTap: (){
                                  Navigator.push(
                                      context,
                                      MaterialPageRoute(builder: (context) => Bd101_3rd()));
                                }),
                            Divider(
                              thickness: 1,
                              color:Colors.blue,
                              height: 3,//divider??? ????????????
                            ),
                            ListTile(title: Text('4???'),
                                onTap: (){
                                  Navigator.push(
                                      context,
                                      MaterialPageRoute(builder: (context) => Bd101_4th()));
                                }),
                            Divider(
                              thickness: 1,
                              color:Colors.blue,
                              height: 3,//divider??? ????????????
                            ),
                            ListTile(title: Text('5???'),
                                onTap: (){
                                  Navigator.push(
                                      context,
                                      MaterialPageRoute(builder: (context) => Bd101_5th()));
                                })
                          ],
                        ),),
                        if(bd=='???2?????????')Container(child: Column(
                          children: <Widget>[
                            ListTile(title: Text('1???',style: TextStyle(fontSize: 17),),
                              onTap: (){
                                Navigator.push(
                                    context,
                                    MaterialPageRoute(builder: (context) => Bd102_1st()));
                              },),
                            Divider(
                              thickness: 1,
                              color:Colors.blue,
                              height: 3,//divider??? ????????????
                            ),
                            ListTile(title: Text('2???',style: TextStyle(fontSize: 17),),
                                onTap: (){
                                  Navigator.push(
                                      context,
                                      MaterialPageRoute(builder: (context) => Bd102_2nd()));
                                }),
                            Divider(
                              thickness: 1,
                              color:Colors.blue,
                              height: 3,//divider??? ????????????
                            ),
                            ListTile(title: Text('3???',style: TextStyle(fontSize: 17),),
                                onTap: (){
                                  Navigator.push(
                                      context,
                                      MaterialPageRoute(builder: (context) => Bd102_3rd()));
                                }),
                            Divider(
                              thickness: 1,
                              color:Colors.blue,
                              height: 3,//divider??? ????????????
                            ),
                            ListTile(title: Text('4???',style: TextStyle(fontSize: 17)),
                                onTap: (){
                                  Navigator.push(
                                      context,
                                      MaterialPageRoute(builder: (context) => Bd102_4th()));
                                }),
                            Divider(
                              thickness: 1,
                              color:Colors.blue,
                              height: 3,//divider??? ????????????
                            ),
                            ListTile(title: Text('5???',style: TextStyle(fontSize: 17)),
                                onTap: (){
                                  Navigator.push(
                                      context,
                                      MaterialPageRoute(builder: (context) => Bd102_5th()));
                                })
                          ],
                        )),
                        if(bd=='???3?????????')Container(child:Column(
                          children: <Widget>[
                            ListTile(title: Text('B1???',style: TextStyle(fontSize: 17),),
                              onTap: (){
                                Navigator.push(
                                    context,
                                    MaterialPageRoute(builder: (context) => Bd103_B1st()));
                              },),
                            Divider(
                              thickness: 1,
                              color:Colors.blue,
                              height: 3,//divider??? ????????????
                            ),
                            ListTile(title: Text('1???',style: TextStyle(fontSize: 17),),
                              onTap: (){
                                Navigator.push(
                                    context,
                                    MaterialPageRoute(builder: (context) => Bd103_1st()));
                              },),
                            Divider(
                              thickness: 1,
                              color:Colors.blue,
                              height: 3,//divider??? ????????????
                            ),
                            ListTile(title: Text('2???',style: TextStyle(fontSize: 17),),
                                onTap: (){
                                  Navigator.push(
                                      context,
                                      MaterialPageRoute(builder: (context) => Bd103_2nd()));
                                }),
                            Divider(
                              thickness: 1,
                              color:Colors.blue,
                              height: 3,//divider??? ????????????
                            ),
                            ListTile(title: Text('3???',style: TextStyle(fontSize: 17),),
                                onTap: (){
                                  Navigator.push(
                                      context,
                                      MaterialPageRoute(builder: (context) => Bd103_3rd()));
                                }),
                            Divider(
                              thickness: 1,
                              color:Colors.blue,
                              height: 3,//divider??? ????????????
                            ),
                            ListTile(title: Text('4???',style: TextStyle(fontSize: 17)),
                                onTap: (){
                                  Navigator.push(
                                      context,
                                      MaterialPageRoute(builder: (context) => Bd103_4th()));
                                }),
                            Divider(
                              thickness: 1,
                              color:Colors.blue,
                              height: 3,//divider??? ????????????
                            ),
                            ListTile(title: Text('5???',style: TextStyle(fontSize: 17)),
                                onTap: (){
                                  Navigator.push(
                                      context,
                                      MaterialPageRoute(builder: (context) => Bd103_5th()));
                                })
                          ],
                        )),
                        if(bd=='???4?????????')Container(child:Column(
                          children: <Widget>[
                            ListTile(title: Text('B1???',style: TextStyle(fontSize: 17),),
                              onTap: (){
                                Navigator.push(
                                    context,
                                    MaterialPageRoute(builder: (context) => Bd104_B1st()));
                              },),
                            Divider(
                              thickness: 1,
                              color:Colors.blue,
                              height: 3,//divider??? ????????????
                            ),
                            ListTile(title: Text('1???',style: TextStyle(fontSize: 17),),
                              onTap: (){
                                Navigator.push(
                                    context,
                                    MaterialPageRoute(builder: (context) => Bd104_1st()));
                              },),
                            Divider(
                              thickness: 1,
                              color:Colors.blue,
                              height: 3,//divider??? ????????????
                            ),
                            ListTile(title: Text('2???',style: TextStyle(fontSize: 17),),
                                onTap: (){
                                  Navigator.push(
                                      context,
                                      MaterialPageRoute(builder: (context) => Bd104_2nd()));
                                }),
                            Divider(
                              thickness: 1,
                              color:Colors.blue,
                              height: 3,//divider??? ????????????
                            ),
                            ListTile(title: Text('3???',style: TextStyle(fontSize: 17),),
                                onTap: (){
                                  Navigator.push(
                                      context,
                                      MaterialPageRoute(builder: (context) => Bd104_3rd()));
                                }),
                            Divider(
                              thickness: 1,
                              color:Colors.blue,
                              height: 3,//divider??? ????????????
                            ),
                            ListTile(title: Text('4???',style: TextStyle(fontSize: 17)),
                                onTap: (){
                                  Navigator.push(
                                      context,
                                      MaterialPageRoute(builder: (context) => Bd104_4th()));
                                }),
                            Divider(
                              thickness: 1,
                              color:Colors.blue,
                              height: 3,//divider??? ????????????
                            ),
                            ListTile(title: Text('5???',style: TextStyle(fontSize: 17)),
                                onTap: (){
                                  Navigator.push(
                                      context,
                                      MaterialPageRoute(builder: (context) => Bd104_5th()));
                                })
                          ],
                        ),),
                        if(bd=='???5?????????')Container(child:Column(
                          children: <Widget>[
                            ListTile(title: Text('B1???',style: TextStyle(fontSize: 17),),
                              onTap: (){
                                Navigator.push(
                                    context,
                                    MaterialPageRoute(builder: (context) => Bd105_B1st()));
                              },),
                            Divider(
                              thickness: 1,
                              color:Colors.blue,
                              height: 3,//divider??? ????????????
                            ),
                            ListTile(title: Text('1???',style: TextStyle(fontSize: 17),),
                              onTap: (){
                                Navigator.push(
                                    context,
                                    MaterialPageRoute(builder: (context) => Bd105_1st()));
                              },),
                            Divider(
                              thickness: 1,
                              color:Colors.blue,
                              height: 3,//divider??? ????????????
                            ),
                            ListTile(title: Text('2???',style: TextStyle(fontSize: 17),),
                                onTap: (){
                                  Navigator.push(
                                      context,
                                      MaterialPageRoute(builder: (context) => Bd105_2nd()));
                                }),
                            Divider(
                              thickness: 1,
                              color:Colors.blue,
                              height: 3,//divider??? ????????????
                            ),
                            ListTile(title: Text('3???',style: TextStyle(fontSize: 17),),
                                onTap: (){
                                  Navigator.push(
                                      context,
                                      MaterialPageRoute(builder: (context) => Bd105_3rd()));
                                }),
                            Divider(
                              thickness: 1,
                              color:Colors.blue,
                              height: 3,//divider??? ????????????
                            ),
                            ListTile(title: Text('4???',style: TextStyle(fontSize: 17)),
                                onTap: (){
                                  Navigator.push(
                                      context,
                                      MaterialPageRoute(builder: (context) => Bd105_4th()));
                                }),
                            Divider(
                              thickness: 1,
                              color:Colors.blue,
                              height: 3,//divider??? ????????????
                            ),
                            ListTile(title: Text('5???',style: TextStyle(fontSize: 17)),
                                onTap: (){
                                  Navigator.push(
                                      context,
                                      MaterialPageRoute(builder: (context) => Bd105_5th()));
                                })
                          ],
                        ),),
                        if(bd=='?????????')Container(child:Column(
                          children: <Widget>[
                            ListTile(title: Text('1???',style: TextStyle(fontSize: 17),),
                              onTap: (){
                                Navigator.push(
                                    context,
                                    MaterialPageRoute(builder: (context) => Bd201_1st()));
                              },),
                            Divider(
                              thickness: 1,
                              color:Colors.blue,
                              height: 3,//divider??? ????????????
                            ),
                            ListTile(title: Text('2???',style: TextStyle(fontSize: 17),),
                                onTap: (){
                                  Navigator.push(
                                      context,
                                      MaterialPageRoute(builder: (context) => Bd201_2nd()));
                                }),
                            Divider(
                              thickness: 1,
                              color:Colors.blue,
                              height: 3,//divider??? ????????????
                            ),
                            ListTile(title: Text('3???',style: TextStyle(fontSize: 17),),
                                onTap: (){
                                  Navigator.push(
                                      context,
                                      MaterialPageRoute(builder: (context) => Bd201_3rd()));
                                }),
                            Divider(
                              thickness: 1,
                              color:Colors.blue,
                              height: 3,//divider??? ????????????
                            ),
                            ListTile(title: Text('4???',style: TextStyle(fontSize: 17)),
                                onTap: (){
                                  Navigator.push(
                                      context,
                                      MaterialPageRoute(builder: (context) => Bd201_4th()));
                                }),
                            Divider(
                              thickness: 1,
                              color:Colors.blue,
                              height: 3,//divider??? ????????????
                            ),
                            ListTile(title: Text('5???',style: TextStyle(fontSize: 17)),
                                onTap: (){
                                  Navigator.push(
                                      context,
                                      MaterialPageRoute(builder: (context) => Bd201_5th()));
                                })
                          ],
                        )),
                        if(bd=='???????????????')Container(child:Column(
                          children: <Widget>[
                            ListTile(title: Text('1???',style: TextStyle(fontSize: 17),),
                              onTap: (){
                                Navigator.push(
                                    context,
                                    MaterialPageRoute(builder: (context) => Bd202_1st()));
                              },),
                            Divider(
                              thickness: 1,
                              color:Colors.blue,
                              height: 3,//divider??? ????????????
                            ),
                            ListTile(title: Text('2???',style: TextStyle(fontSize: 17),),
                                onTap: (){
                                  Navigator.push(
                                      context,
                                      MaterialPageRoute(builder: (context) => Bd202_2nd()));
                                }),
                            Divider(
                              thickness: 1,
                              color:Colors.blue,
                              height: 3,//divider??? ????????????
                            ),
                            ListTile(title: Text('3???',style: TextStyle(fontSize: 17),),
                                onTap: (){
                                  Navigator.push(
                                      context,
                                      MaterialPageRoute(builder: (context) => Bd202_3rd()));
                                }),
                            Divider(
                              thickness: 1,
                              color:Colors.blue,
                              height: 3,//divider??? ????????????
                            ),
                            ListTile(title: Text('4???',style: TextStyle(fontSize: 17)),
                                onTap: (){
                                  Navigator.push(
                                      context,
                                      MaterialPageRoute(builder: (context) => Bd202_4th()));
                                }),
                            Divider(
                              thickness: 1,
                              color:Colors.blue,
                              height: 3,//divider??? ????????????
                            ),
                            ListTile(title: Text('5???',style: TextStyle(fontSize: 17)),
                                onTap: (){
                                  Navigator.push(
                                      context,
                                      MaterialPageRoute(builder: (context) => Bd202_5th()));
                                })
                          ],
                        )),
                        if(bd=='??????????????????')Container(child:Column(
                          children: <Widget>[
                            ListTile(title: Text('1???',style: TextStyle(fontSize: 17),),
                              onTap: (){
                                Navigator.push(
                                    context,
                                    MaterialPageRoute(builder: (context) => Bd110_1st()));
                              },),
                            Divider(
                              thickness: 1,
                              color:Colors.blue,
                              height: 3,//divider??? ????????????
                            ),
                            ListTile(title: Text('2???',style: TextStyle(fontSize: 17),),
                                onTap: (){
                                  Navigator.push(
                                      context,
                                      MaterialPageRoute(builder: (context) => Bd110_2nd()));
                                }),
                            Divider(
                              thickness: 1,
                              color:Colors.blue,
                              height: 3,//divider??? ????????????
                            ),
                            ListTile(title: Text('3???',style: TextStyle(fontSize: 17),),
                                onTap: (){
                                  Navigator.push(
                                      context,
                                      MaterialPageRoute(builder: (context) => Bd110_3rd()));
                                }),
                            Divider(
                              thickness: 1,
                              color:Colors.blue,
                              height: 3,//divider??? ????????????
                            ),
                            ListTile(title: Text('4???',style: TextStyle(fontSize: 17)),
                                onTap: (){
                                  Navigator.push(
                                      context,
                                      MaterialPageRoute(builder: (context) => Bd110_4th()));
                                }),
                          ],
                        )),
                        if(bd=='??????????????????')Container(child:Column(
                          children: <Widget>[
                            ListTile(title: Text('1???',style: TextStyle(fontSize: 17),),
                              onTap: (){
                                Navigator.push(
                                    context,
                                    MaterialPageRoute(builder: (context) => Bd109_1st()));
                              },),
                          ],
                        )),
                        if(bd=='??????????????????')Container(child:Column(
                          children: <Widget>[
                            ListTile(title: Text('1???',style: TextStyle(fontSize: 17),),
                              onTap: (){
                                Navigator.push(
                                    context,
                                    MaterialPageRoute(builder: (context) => Bd111_1st()));
                              },),
                            Divider(
                              thickness: 1,
                              color:Colors.blue,
                              height: 3,//divider??? ????????????
                            ),
                            ListTile(title: Text('2???',style: TextStyle(fontSize: 17),),
                                onTap: (){
                                  Navigator.push(
                                      context,
                                      MaterialPageRoute(builder: (context) => Bd111_2nd()));
                                }),
                            Divider(
                              thickness: 1,
                              color:Colors.blue,
                              height: 3,//divider??? ????????????
                            ),
                            ListTile(title: Text('3???',style: TextStyle(fontSize: 17),),
                                onTap: (){
                                  Navigator.push(
                                      context,
                                      MaterialPageRoute(builder: (context) => Bd111_3rd()));
                                }),
                         ],
                        )),
                        if(bd=='???????????????(Muse Hall/?????????)')Container(child:Column(
                          children: <Widget>[
                            ListTile(title: Text('1???',style: TextStyle(fontSize: 17),),
                              onTap: (){
                                Navigator.push(
                                    context,
                                    MaterialPageRoute(builder: (context) => Bd403_1st()));
                              },),
                            Divider(
                              thickness: 1,
                              color:Colors.blue,
                              height: 3,//divider??? ????????????
                            ),
                            ListTile(title: Text('2???',style: TextStyle(fontSize: 17),),
                                onTap: (){
                                  Navigator.push(
                                      context,
                                      MaterialPageRoute(builder: (context) => Bd403_2nd()));
                                }),
                            Divider(
                              thickness: 1,
                              color:Colors.blue,
                              height: 3,//divider??? ????????????
                            ),
                            ListTile(title: Text('3???',style: TextStyle(fontSize: 17),),
                                onTap: (){
                                  Navigator.push(
                                      context,
                                      MaterialPageRoute(builder: (context) => Bd403_3rd()));
                                }),
                          ],
                        )),
                        if(bd=='?????????')Container(child:Column(
                          children: <Widget>[
                            ListTile(title: Text('B1???',style: TextStyle(fontSize: 17),),
                              onTap: (){
                                Navigator.push(
                                    context,
                                    MaterialPageRoute(builder: (context) => Bd309_B1st()));
                              },),
                            Divider(
                              thickness: 1,
                              color:Colors.blue,
                              height: 3,//divider??? ????????????
                            ),
                            ListTile(title: Text('1???',style: TextStyle(fontSize: 17),),
                              onTap: (){
                                Navigator.push(
                                    context,
                                    MaterialPageRoute(builder: (context) => Bd309_1st()));
                              },),
                            Divider(
                              thickness: 1,
                              color:Colors.blue,
                              height: 3,//divider??? ????????????
                            ),
                            ListTile(title: Text('2???',style: TextStyle(fontSize: 17),),
                                onTap: (){
                                  Navigator.push(
                                      context,
                                      MaterialPageRoute(builder: (context) => Bd309_2nd()));
                                }),
                            Divider(
                              thickness: 1,
                              color:Colors.blue,
                              height: 3,//divider??? ????????????
                            ),
                            ListTile(title: Text('3???',style: TextStyle(fontSize: 17),),
                                onTap: (){
                                  Navigator.push(
                                      context,
                                      MaterialPageRoute(builder: (context) => Bd309_3rd()));
                                }),
                            Divider(
                              thickness: 1,
                              color:Colors.blue,
                              height: 3,//divider??? ????????????
                            ),
                            ListTile(title: Text('4???',style: TextStyle(fontSize: 17),),
                              onTap: (){
                                Navigator.push(
                                    context,
                                    MaterialPageRoute(builder: (context) => Bd309_4th()));
                              },),
                          ],
                        )),
                        if(bd=='???????????????')Container(child:Column(
                          children: <Widget>[
                            ListTile(title: Text('B1???',style: TextStyle(fontSize: 17),),
                              onTap: (){
                                Navigator.push(
                                    context,
                                    MaterialPageRoute(builder: (context) => Bd204_B1st()));
                              },),
                            Divider(
                              thickness: 1,
                              color:Colors.blue,
                              height: 3,//divider??? ????????????
                            ),
                            ListTile(title: Text('1???',style: TextStyle(fontSize: 17),),
                              onTap: (){
                                Navigator.push(
                                    context,
                                    MaterialPageRoute(builder: (context) => Bd204_1st()));
                              },),
                            Divider(
                              thickness: 1,
                              color:Colors.blue,
                              height: 3,//divider??? ????????????
                            ),
                            ListTile(title: Text('2???',style: TextStyle(fontSize: 17),),
                                onTap: (){
                                  Navigator.push(
                                      context,
                                      MaterialPageRoute(builder: (context) => Bd204_2nd()));
                                }),
                            Divider(
                              thickness: 1,
                              color:Colors.blue,
                              height: 3,//divider??? ????????????
                            ),
                            ListTile(title: Text('3???',style: TextStyle(fontSize: 17),),
                                onTap: (){
                                  Navigator.push(
                                      context,
                                      MaterialPageRoute(builder: (context) => Bd204_3rd()));
                                }),
                            Divider(
                              thickness: 1,
                              color:Colors.blue,
                              height: 3,//divider??? ????????????
                            ),
                            ListTile(title: Text('4???',style: TextStyle(fontSize: 17),),
                              onTap: (){
                                Navigator.push(
                                    context,
                                    MaterialPageRoute(builder: (context) => Bd204_4th()));
                              },),
                          ],
                        )
                        ),
                        if(bd=='???1???????????????(????????? ?????????)')Container(child:Column(
                          children: <Widget>[
                            ListTile(title: Text('B1???',style: TextStyle(fontSize: 17),),
                              onTap: (){
                                Navigator.push(
                                    context,
                                    MaterialPageRoute(builder: (context) => Bd205_B1st()));
                              },),
                            Divider(
                              thickness: 1,
                              color:Colors.blue,
                              height: 3,//divider??? ????????????
                            ),
                            ListTile(title: Text('1???',style: TextStyle(fontSize: 17),),
                              onTap: (){
                                Navigator.push(
                                    context,
                                    MaterialPageRoute(builder: (context) => Bd205_1st()));
                              },),
                            Divider(
                              thickness: 1,
                              color:Colors.blue,
                              height: 3,//divider??? ????????????
                            ),
                            ListTile(title: Text('2???',style: TextStyle(fontSize: 17),),
                                onTap: (){
                                  Navigator.push(
                                      context,
                                      MaterialPageRoute(builder: (context) => Bd205_2nd()));
                                }),
                            Divider(
                              thickness: 1,
                              color:Colors.blue,
                              height: 3,//divider??? ????????????
                            ),
                            ListTile(title: Text('3???',style: TextStyle(fontSize: 17),),
                                onTap: (){
                                  Navigator.push(
                                      context,
                                      MaterialPageRoute(builder: (context) => Bd205_3rd()));
                                }),
                            Divider(
                              thickness: 1,
                              color:Colors.blue,
                              height: 3,//divider??? ????????????
                            ),
                            ListTile(title: Text('4???',style: TextStyle(fontSize: 17),),
                              onTap: (){Navigator.push(
                                  context,
                                  MaterialPageRoute(builder: (context) => Bd205_4th()));},),
                            Divider(
                              thickness: 1,
                              color:Colors.blue,
                              height: 3,//divider??? ????????????
                            ),
                            ListTile(title: Text('5???',style: TextStyle(fontSize: 17),),
                              onTap: (){
                                Navigator.push(
                                    context,
                                    MaterialPageRoute(builder: (context) => Bd205_5th()));
                              },),
                          ],
                        )),
                        if(bd=='???2???????????????')Container(child:Column(
                          children: <Widget>[
                            ListTile(title: Text('1???',style: TextStyle(fontSize: 17),),
                              onTap: (){
                                Navigator.push(
                                    context,
                                    MaterialPageRoute(builder: (context) => Bd207_1st()));
                              },),
                            Divider(
                              thickness: 1,
                              color:Colors.blue,
                              height: 3,//divider??? ????????????
                            ),
                            ListTile(title: Text('2???',style: TextStyle(fontSize: 17),),
                                onTap: (){
                                  Navigator.push(
                                      context,
                                      MaterialPageRoute(builder: (context) => Bd207_2nd()));
                                }),
                            Divider(
                              thickness: 1,
                              color:Colors.blue,
                              height: 3,//divider??? ????????????
                            ),
                            ListTile(title: Text('3???',style: TextStyle(fontSize: 17),),
                                onTap: (){
                                  Navigator.push(
                                      context,
                                      MaterialPageRoute(builder: (context) => Bd207_3rd()));
                                }),
                            Divider(
                              thickness: 1,
                              color:Colors.blue,
                              height: 3,//divider??? ????????????
                            ),
                            ListTile(title: Text('4???',style: TextStyle(fontSize: 17),),
                              onTap: (){
                                Navigator.push(
                                    context,
                                    MaterialPageRoute(builder: (context) => Bd207_4th()));
                              },),
                            Divider(
                              thickness: 1,
                              color:Colors.blue,
                              height: 3,//divider??? ????????????
                            ),
                            ListTile(title: Text('5???',style: TextStyle(fontSize: 17),),
                              onTap: (){
                                Navigator.push(
                                    context,
                                    MaterialPageRoute(builder: (context) => Bd207_5th()));
                              },),
                            Divider(
                              thickness: 1,
                              color:Colors.blue,
                              height: 3,//divider??? ????????????
                            ),
                            ListTile(title: Text('6???',style: TextStyle(fontSize: 17),),
                              onTap: (){
                                Navigator.push(
                                    context,
                                    MaterialPageRoute(builder: (context) => Bd207_6th()));
                              },)
                          ],
                        )),
                        if(bd=='?????????')Container(child:Column(
                          children: <Widget>[
                            ListTile(title: Text('1???',style: TextStyle(fontSize: 17),),
                              onTap: (){
                                Navigator.push(
                                    context,
                                    MaterialPageRoute(builder: (context) => Bd402_1st()));
                              },),
                            Divider(
                              thickness: 1,
                              color:Colors.blue,
                              height: 3,//divider??? ????????????
                            ),
                            ListTile(title: Text('2???',style: TextStyle(fontSize: 17),),
                                onTap: (){
                                  Navigator.push(
                                      context,
                                      MaterialPageRoute(builder: (context) => Bd402_2nd()));
                                }),
                            Divider(
                              thickness: 1,
                              color:Colors.blue,
                              height: 3,//divider??? ????????????
                            ),
                            ListTile(title: Text('3???',style: TextStyle(fontSize: 17),),
                                onTap: (){
                                  Navigator.push(
                                      context,
                                      MaterialPageRoute(builder: (context) => Bd402_3rd()));
                                }),
                            Divider(
                              thickness: 1,
                              color:Colors.blue,
                              height: 3,//divider??? ????????????
                            ),
                          ],
                        )
                        ),
                        if(bd=='?????????????????????????????????')Container(child:Column(
                          children: <Widget>[
                            ListTile(title: Text('B1???',style: TextStyle(fontSize: 17),),
                              onTap: (){
                                  Navigator.push(
                                  context,
                                  MaterialPageRoute(builder: (context) => Bd311_B1st()));
                              },),
                            Divider(
                              thickness: 1,
                              color:Colors.blue,
                              height: 3,//divider??? ????????????
                            ),
                            ListTile(title: Text('1???',style: TextStyle(fontSize: 17),),
                              onTap: (){
                                  Navigator.push(
                                  context,
                                  MaterialPageRoute(builder: (context) => Bd311_1st()));},),
                            Divider(
                              thickness: 1,
                              color:Colors.blue,
                              height: 3,//divider??? ????????????
                            ),
                            ListTile(title: Text('2???',style: TextStyle(fontSize: 17),),
                                onTap: (){
                                  Navigator.push(
                                      context,
                                      MaterialPageRoute(builder: (context) => Bd311_2nd()));
                                }),
                            Divider(
                              thickness: 1,
                              color:Colors.blue,
                              height: 3,//divider??? ????????????
                            ),
                            ListTile(title: Text('3???',style: TextStyle(fontSize: 17),),
                                onTap: (){
                                  Navigator.push(
                                      context,
                                      MaterialPageRoute(builder: (context) => Bd311_3rd()));
                                }),
                            Divider(
                              thickness: 1,
                              color:Colors.blue,
                              height: 3,//divider??? ????????????
                            ),
                            ListTile(title: Text('4???',style: TextStyle(fontSize: 17),),
                              onTap: (){
                              Navigator.push(
                                  context,
                                  MaterialPageRoute(builder: (context) => Bd311_4th()));
                              },),
                            Divider(
                              thickness: 1,
                              color:Colors.blue,
                              height: 3,//divider??? ????????????
                            ),
                            ListTile(title: Text('5???',style: TextStyle(fontSize: 17),),
                              onTap: (){
                                Navigator.push(
                                    context,
                                    MaterialPageRoute(builder: (context) => Bd311_5th()));
                              },),
                            Divider(
                              thickness: 1,
                              color:Colors.blue,
                              height: 3,//divider??? ????????????
                            ),
                            ListTile(title: Text('6???',style: TextStyle(fontSize: 17),),
                              onTap: (){
                                Navigator.push(
                                    context,
                                    MaterialPageRoute(builder: (context) => Bd311_6th()));
                              },)
                          ],
                        )),
                        if(bd!='???1?????????' && bd!='???2?????????' && bd!='???3?????????' && bd!='???4?????????' && bd!='???5?????????'
                            && bd!='?????????' && bd!='???????????????'&& bd!='??????????????????'&& bd!='??????????????????'
                            && bd!='??????????????????' && bd!='???????????????(Muse Hall/?????????)' && bd!='?????????'
                            && bd!='???????????????' && bd!='???1???????????????(????????? ?????????)' && bd!='???2???????????????'
                            && bd!='?????????'&& bd!='?????????????????????????????????')Text('?????? ???????????? ????????????.')

                      ],)
                    )
                  ],
                ),
                //???????????? ?????? ????????? fbkey??????
                SizedBox(height: 20,),//
              ],
            ),

          );
        }
    );
  }

  void _onMapCreated(GoogleMapController controller){
    _controller.complete(controller);

  }
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Stack(
        children: <Widget>[
          GoogleMap(
          onMapCreated: _onMapCreated,
          markers: _markers,
          initialCameraPosition: CameraPosition
          (target: LatLng(37.298002524247934, 126.83443616279172),
        zoom:17,
        ),

        ),
        Padding(
          padding: const EdgeInsets.only(
              top:15,
              left: 10
          ),
          child: Row(
            children: [
              SizedBox(
                width: (MediaQuery.of(context).size.width)*0.82,
                height: (MediaQuery.of(context).size.height)*0.07,
                child: Padding(
                  padding: const EdgeInsets.only(left: 5.0),
                  child: Stack(
                    children: <Widget>[
                      Form(
                      key: _fbkey,
                      child:TypeAheadField(
                        textFieldConfiguration: TextFieldConfiguration(
                            autofocus: true,
                            style: DefaultTextStyle.of(context).style.copyWith(
                                fontStyle: FontStyle.normal
                            ),
                            controller: this._typeAheadController,
                            decoration: InputDecoration(
                              hintText: '???????????? ?????? ??? ???????????????.',
                              border: OutlineInputBorder(),
                              fillColor: Colors.white,
                              filled: true
                            )
                        ),

                        itemBuilder: (context,suggestion){

                          return ListTile(
                            title:Text(suggestion),
                            subtitle:Text(_getsubtitle(suggestion)),
                            leading: Icon(Icons.location_on_sharp),
                            shape: RoundedRectangleBorder(),
                          );
                        },
                        suggestionsCallback: (pattern){
                          return getSuggestion(pattern);
                        },
                        onSuggestionSelected: (suggestion) async {//search

                            this._typeAheadController.text = suggestion;

                            GoogleMapController controller = await _controller.future;
                            final id=_typeAheadController.text;

                            final foundPlace=places.firstWhere(
                                    (place) => place['name']==id,
                                orElse: ()=>null
                            );
                            var latAS=foundPlace['latitude'];
                            var lngAS=foundPlace['longitude'];
                            setState(() {
                              _markers.clear();

                              controller.animateCamera(CameraUpdate.newLatLng(LatLng(double.parse(latAS),double.parse(lngAS))));

                              _markers.add(
                                Marker(markerId: MarkerId('102'),
                                  position: LatLng(double.parse(latAS), double.parse(lngAS)),
                                  infoWindow: InfoWindow(
                                      title: id,
                                      snippet: '????????? ????????? ???????????? ???????????????',
                                      onTap: _showbottomsheet
                                  ),),
                              );
                            });
                        },


                      )
                    ),
                    Positioned(child: FlatButton(child: Icon(Icons.cancel,size: 20,color: Colors.grey,),
                        onPressed: (){

                          _fbkey.currentState.reset();
                          _typeAheadController.clear();

                        },minWidth:3),right: 0,)]
                  ),
                ),
              ),

              SizedBox(width: 4,),
              Container(
                width: (MediaQuery.of(context).size.height)*0.07,height: (MediaQuery.of(context).size.height)*0.07,
                child: RaisedButton(
                  child:Icon(Icons.search, color: Colors.white,),
                  onPressed: _search,
                  shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.all(Radius.circular(50.0))
                  ),
                  elevation: 8,
                  color: Colors.blue[400],
                ),
              )
            ],
          ),
        )
        ]
      )
    );
  }
}