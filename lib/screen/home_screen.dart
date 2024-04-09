import 'dart:async';
import 'dart:developer';

import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:todo_app/heloper/helper.dart';
import 'package:todo_app/heloper/themeHelper.dart';

class HomePage extends StatefulWidget {
  const HomePage({super.key});

  @override
  State<HomePage> createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {
  List tdata = [];

  ThemeMode _themeMode = ThemeMode.system;

  void _toggleTheme(ThemeMode themeMode) {
    setState(() {
      _themeMode = themeMode;
    });
  }



  @override
  Widget build(BuildContext context) {
    final s = MediaQuery.of(context).size;
  bool isDarkMode = Theme.of(context).brightness == Brightness.dark;

    return Scaffold(
      bottomSheet: InkWell(
        onTap: () {
          Get.toNamed('/addTodo', arguments: tdata);
        },
        child: Container(
          height: s.height * 0.08,
          width: double.maxFinite,
          alignment: Alignment.center,
          decoration: BoxDecoration(
              // color: Color(0xff5949F0),
              borderRadius: BorderRadius.only(
            topLeft: Radius.circular(15),
            topRight: Radius.circular(15),
          )),
          child: Text(
            "ADD TODO",
            style: TextStyle(
                color: Colors.white, fontSize: 26, fontWeight: FontWeight.w500),
          ),
        ),
      ),
      appBar: AppBar(
        leading: IconButton(onPressed: () {
          showDialog(
              context:
              context,
              builder: (context) =>
                  AlertDialog(
                    // backgroundColor:
                    // const Color(0xff0F0F0F),
                      title: const Text(
                        "Are You sure want to LogOut ?",
                        // style: TextStyle(color: Colors.white),
                      ),
                      actions: [
                        ElevatedButton(
                            style: ButtonStyle(
                              backgroundColor: MaterialStateProperty.all(Colors.red),
                              fixedSize: MaterialStateProperty.all(
                                const Size(100, 50),
                              ),
                            ),
                            onPressed: () {
                              Navigator.of(context).pop();
                            },
                            child: const Icon(
                              Icons.close,
                              color: Colors.white,
                            )),
                        ElevatedButton(
                            style: ButtonStyle(
                              backgroundColor: MaterialStateProperty.all(Colors.green),
                              fixedSize: MaterialStateProperty.all(
                                const Size(100, 50),
                              ),
                            ),
                            onPressed: () async {
                              ApiHelper.apihelper.signOut();
                              Get.offAllNamed('/login');                              // data != null ? removestaus(data: data) : null;
                              // _currentPosition == null ? null : _getCurrentPosition();
                              // await ApiHelper.apiHelper.deleteLead(lang: _currentPosition!.latitude.toString(), long: _currentPosition!.longitude.toString(), id: lead[index]['l_id']);
                              // await ApiHelper.apiHelper.deleteLead(lang: GlobalVari.lati ?? '', long: GlobalVari.longti ?? '', id: lead[index]['l_id']);

                              setState(() {});
                              // getdata(name: '');
                              // Navigator.of(context);
                            },
                            child: const Icon(
                              Icons.done,
                              color: Colors.white,
                            )),
                      ]));
        }, icon: Icon(Icons.logout,color: Colors.white,)),
        title: Text(
          "TODO",
          style: TextStyle(color: Colors.white, fontWeight: FontWeight.bold),
        ),
        centerTitle: true,
        actions: [
          IconButton(
              onPressed: () {
                ThemeHelper.isdark = !ThemeHelper.isdark;
                Get.changeTheme( !ThemeHelper.isdark ? ThemeData(
                    appBarTheme: AppBarTheme(color: Color(0xff5949F0)),
                    bottomSheetTheme:
                    BottomSheetThemeData(backgroundColor: Color(0xff5949F0),),
                    // colorScheme: ColorScheme.fromSeed(seedColor: Colors.deepPurple),

                    useMaterial3: true
                ) : ThemeData.dark());
                setState(() {

                });
              },
              icon: Icon(
                !ThemeHelper.isdark ? Icons.dark_mode_outlined : Icons.sunny,
                color: Colors.white,
              ),),
        ],
        // backgroundColor: Color(0xff5949F0),
      ),
      body: Padding(
        padding: const EdgeInsets.all(20.0),
        child: StreamBuilder<QuerySnapshot>(
            stream: ApiHelper.apihelper.getdata(),
            builder: (context, snapshot) {
              if (snapshot.hasData) {
                List todos = snapshot.data?.docs.toList() as List;
                return todos.length == 0
                    ? Center(
                        child: Text(
                          "No Todos Found",
                          style: TextStyle(
                              // color: Colors.black.withOpacity(0.6),
                              fontSize: 22),
                        ),
                      )
                    : ListView.builder(
                        itemBuilder: (context, index) {
                          return GestureDetector(
                            onTap: () {
                              log('${snapshot.data?.docs[index].reference.id}');
                              Get.toNamed('/tODOView',arguments: todos[index]);
                            },
                            child: Container(
                              margin: EdgeInsets.symmetric(
                                  vertical: s.height * 0.01),
                              width: double.maxFinite,
                              decoration: BoxDecoration(
                                border: Border.all(color: Color(0xff5949F0)),
                                borderRadius: BorderRadius.circular(12),
                                // color: Colors.blue.shade500
                              ),
                              padding: EdgeInsets.all(16),
                              child: Row(
                                children: [

                                  Container(
                                      decoration: BoxDecoration(
                                          shape: BoxShape.circle,
                                          color: Color(0xff5949F0)
                                              .withOpacity(0.5)),
                                      padding: EdgeInsets.all(16),
                                      child: Text("${todos[index]['date']}"
                                          .split('-')[0])),
                                  SizedBox(
                                    width: s.width * 0.05,
                                  ),
                                  SizedBox(
                                    width: s.width * 0.55,
                                    child: Column(
                                        crossAxisAlignment:
                                            CrossAxisAlignment.start,
                                        children: [
                                          Text(
                                            "${todos[index]['head']}",
                                            style: TextStyle(
                                              // color:
                                              //     Colors.black.withOpacity(0.6),
                                              fontWeight: FontWeight.w500,
                                              overflow: TextOverflow.ellipsis,
                                              fontSize: 22,
                                            ),
                                          ),
                                          SizedBox(
                                            height: s.height * 0.01,
                                          ),
                                          Text(
                                            "${todos[index]['date']}",
                                            style: TextStyle(
                                              // color:
                                              //     Colors.black.withOpacity(0.6),
                                              fontSize: 16,
                                            ),
                                          ),
                                        ]),
                                  ),
                                  SizedBox(
                                    width: s.width * 0.10,
                                    child: PopupMenuButton(
                                      onSelected: (value) {
                                        // your logic
                                        if(value == '/upd'){
                                          Get.toNamed('/updtodo',arguments: {
                                            'data': todos[index],
                                            'todoid': "${snapshot.data?.docs[index].reference.id}"
                                          });
                                        }
                                        else{
                                          showDialog(
                                              context:
                                              context,
                                              builder: (context) =>
                                                  AlertDialog(
                                                      // backgroundColor:
                                                      // const Color(0xff0F0F0F),
                                                      title: const Text(
                                                        "Are You sure want to delete ?",
                                                        // style: TextStyle(color: Colors.white),
                                                      ),
                                                      actions: [
                                                        ElevatedButton(
                                                            style: ButtonStyle(
                                                              backgroundColor: MaterialStateProperty.all(Colors.red),
                                                              fixedSize: MaterialStateProperty.all(
                                                                const Size(100, 50),
                                                              ),
                                                            ),
                                                            onPressed: () {
                                                              Navigator.of(context).pop();
                                                            },
                                                            child: const Icon(
                                                              Icons.close,
                                                              color: Colors.white,
                                                            )),
                                                        ElevatedButton(
                                                            style: ButtonStyle(
                                                              backgroundColor: MaterialStateProperty.all(Colors.green),
                                                              fixedSize: MaterialStateProperty.all(
                                                                const Size(100, 50),
                                                              ),
                                                            ),
                                                            onPressed: () async {
                                                              ApiHelper.apihelper.deletetodo(number: '${snapshot.data?.docs[index].reference.id}');
                                                              setState(() {
                                                              });
                                                              Navigator.pop(context);
                                                              // data != null ? removestaus(data: data) : null;
                                                              // _currentPosition == null ? null : _getCurrentPosition();
                                                              // await ApiHelper.apiHelper.deleteLead(lang: _currentPosition!.latitude.toString(), long: _currentPosition!.longitude.toString(), id: lead[index]['l_id']);
                                                              // await ApiHelper.apiHelper.deleteLead(lang: GlobalVari.lati ?? '', long: GlobalVari.longti ?? '', id: lead[index]['l_id']);

                                                              setState(() {});
                                                              // getdata(name: '');
                                                              // Navigator.of(context);
                                                            },
                                                            child: const Icon(
                                                              Icons.done,
                                                              color: Colors.white,
                                                            )),
                                                      ]));
                                        }
                                      },
                                      itemBuilder: (BuildContext bc) {
                                        return  [
                                          PopupMenuItem(
                                            child: Row(
                                              children: [
                                                Icon(Icons.edit,color: Colors.blue,),
                                                SizedBox(width: s.width * 0.005,),
                                                Text("Update",),
                                              ],
                                            ),
                                            value: '/upd',
                                          ),
                                          PopupMenuItem(
                                            child: Row(
                                              children: [
                                                Icon(Icons.delete_outline_outlined,color: Colors.red,),
                                                SizedBox(width: s.width * 0.005,),
                                                Text("Delete",),
                                              ],
                                            ),
                                            value: '/de',
                                          ),

                                        ];
                                      },
                                    ),
                                  ),
                                ],
                              ),
                            ),
                          );
                        },
                        itemCount: todos.length,
                      );
              } else {
                return Center(
                  child: CircularProgressIndicator(),
                );
              }
            }),
      ),
    );
  }
}
