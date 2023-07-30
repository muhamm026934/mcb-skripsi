import 'package:flutter/material.dart';

class CustomAlertDialog extends StatelessWidget {
  const CustomAlertDialog({Key? key, 
  required this.title, 
  required this.content, 
  required this.backgroundColor, 
  required this.onPressedOk, 
  required this.onPressedNotOK, 
  required this.textButtonOK, 
  required this.textButtonNotOK, 
  required this.textColor, 
  required this.buttonColorOk, 
  required this.buttonColorNotOK}) : super(key: key);
  
  final String title,content,textButtonOK,textButtonNotOK;
  final Color backgroundColor, textColor, buttonColorOk, buttonColorNotOK;
  final void Function()? onPressedOk,onPressedNotOK;

  @override
  Widget build(BuildContext context) {
    return AlertDialog(
      backgroundColor: backgroundColor,
      title: Text(title,style: TextStyle(color: textColor),),
      content: Text(content,style: TextStyle(color: textColor),),
      actions: <Widget>[
        TextButton(
          onPressed: onPressedNotOK,
          child: Text(textButtonNotOK,style: TextStyle(color: buttonColorNotOK),),
        ),         
        TextButton(
          onPressed: onPressedOk,
          child: Text(textButtonOK,style: TextStyle(color: buttonColorOk),),
        ),       
      ],
    );
  }
}