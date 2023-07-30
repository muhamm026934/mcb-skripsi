import 'package:flutter/material.dart';

class CustomListTileEnable extends StatelessWidget {
  const CustomListTileEnable({Key? key, 
  required this.title, 
  required this.subtitle, 
  required this.iconLead, 
  required this.iconTrail, 
  required this.onTapTrail, 
  required this.onTapLead, 
  required this.titles, 
  required this.subtitles, 
  required this.leadings, 
  required this.trailings, 
  required this.textColor}) : super(key: key);

  final String title, subtitle;
  final String titles, subtitles, leadings, trailings;
  final IconData iconLead, iconTrail;
  final void Function()? onTapTrail,onTapLead;
  final Color textColor;
  
  @override
  Widget build(BuildContext context) {
    return 
    titles == "Y" && subtitles == "Y" && leadings == "Y"  && trailings == "Y"  
    ? ListTile(
      title: Text(title),
      textColor: textColor,      
      subtitle: Text(subtitle),
      leading: GestureDetector(
        onTap: onTapLead,
        child: Icon(iconLead,color: textColor)),
      trailing: GestureDetector(
        onTap: onTapTrail,
        child: Icon(iconTrail,color: textColor)),
    )
    : titles == "Y" && subtitles == "Y" && leadings == "Y"  && trailings == ""  
    ? ListTile(
      title: Text(title),
      textColor: textColor,
      subtitle: Text(subtitle),
      leading: GestureDetector(
        onTap: onTapLead,
        child: Icon(iconLead,color: textColor,))
    )
    : titles == "Y" && subtitles == "Y" && leadings == ""  && trailings == "" 
    ? ListTile(
      title: Text(title),
      textColor: textColor,
      subtitle: Text(subtitle))
    : titles == "Y" && subtitles == "" && leadings == ""  && trailings == "" 
    ? ListTile(
      title: Text(title),
      textColor: textColor,)
    : titles == "Y" && subtitles == "" && leadings == "Y" && trailings == "Y"  
    ? ListTile(
      title: Text(title),
      textColor: textColor,
      leading: GestureDetector(
        onTap: onTapLead,
        child: Icon(iconLead,color: textColor)), 
      trailing: GestureDetector(
        onTap: onTapTrail,
        child: Icon(iconTrail,color: textColor)),             
      )
    : Container();
  }
}