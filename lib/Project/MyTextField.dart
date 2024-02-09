import 'package:flutter/material.dart';

class MyTextField extends StatefulWidget {
  TextEditingController? controller;
  String? lable;
  String? hintText;
  Color? color;
  Icon? myicon;
  Icon? icon2;
  MyTextField({
    required this.controller,
    required this.lable,
    required this.hintText,
    this.color = Colors.brown,
    this.myicon,
    this.icon2,

  });

  @override
  State<MyTextField> createState() => _MyTextFieldState();
}

class _MyTextFieldState extends State<MyTextField> {
  bool visible = true;
  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.all(16.0),
      child: Container(
        
        decoration: BoxDecoration(boxShadow: [BoxShadow(color: Colors.black,offset: Offset(5, 5),blurRadius: 5)]),
        child: TextField(
          
          obscureText: widget.lable=="Password" ? visible : false,
          controller: widget.controller,
          readOnly: widget.lable=='user email'?true:false,
          style: TextStyle(color: Colors.teal),
          decoration: InputDecoration(
            prefixIcon:widget.myicon,
            suffixIcon: widget.lable == "Password"  ? IconButton(onPressed: () {
              setState(() {
                visible = !visible;
              });
            }, icon: Icon(!visible ? Icons.visibility : Icons.visibility_off)) : null,
            fillColor: Colors.white,
            filled: true,
              labelText: widget.lable,
              hintText: widget.hintText,
              hintStyle: TextStyle(color: widget.color)),
              
        ),
      ),
    );
  }
}
