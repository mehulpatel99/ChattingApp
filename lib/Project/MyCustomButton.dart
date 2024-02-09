import 'package:flutter/material.dart';

class MyCustomButton extends StatelessWidget {
  String? textvalue;
  Color? colorname;
  MyCustomButton({
    required this.textvalue,
    required this.colorname
  });

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.all(20.0),
      child: Container(
        height: 60,
        width: 150,
        child: Center(child: Text("$textvalue",style: TextStyle(fontSize: 18,color: Colors.white),)),
        decoration: BoxDecoration(
          color: colorname,
          boxShadow: [BoxShadow(color: Colors.black,offset: Offset(5, 5),blurRadius: 5)]
        ),
      ),
    );
  }
}
