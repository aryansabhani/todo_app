import 'package:flutter/material.dart';
import 'package:get/get.dart';

class TODOView extends StatefulWidget {
  const TODOView({super.key});

  @override
  State<TODOView> createState() => _TODOViewState();
}

class _TODOViewState extends State<TODOView> {
  var arg = Get.arguments;
  @override
  Widget build(BuildContext context) {
    final s = MediaQuery.of(context).size;
    return Scaffold(
      appBar: AppBar(iconTheme: IconThemeData(color: Colors.white),),
      body: Padding(
        padding: const EdgeInsets.all(20.0),
        child: Column(
          crossAxisAlignment:CrossAxisAlignment.start,
          children: [
            Text("Head Line :",style: TextStyle(
              fontSize: 20,
              fontWeight: FontWeight.w500
            ),),
            SizedBox(height: s.height * 0.01,),
            Text("${arg['head']}",style: TextStyle(
                fontSize: 16,
                // fontWeight: FontWeight.w500
            ),),
            SizedBox(height: s.height * 0.03,),
            Text("Date :",style: TextStyle(
              fontSize: 20,
              fontWeight: FontWeight.w500
            ),),
            SizedBox(height: s.height * 0.01,),
            Text("${arg['date']}",style: TextStyle(
                fontSize: 16,
                // fontWeight: FontWeight.w500
            ),),
            SizedBox(height: s.height * 0.03,),
            Text("Summary :",style: TextStyle(
                fontSize: 20,
                fontWeight: FontWeight.w500
            ),),
            SizedBox(height: s.height * 0.01,),
            Text("${arg['body']}",style: TextStyle(
              fontSize: 16,
              // fontWeight: FontWeight.w500
            ),),


          ],
        ),
      ),
    );
  }
}
