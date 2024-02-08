import 'package:flutter/material.dart';
import 'package:switch_button/switch_button.dart';

import '../shared.dart';

class NotificationScreen extends StatefulWidget {
  const NotificationScreen({super.key});

  @override
  State<NotificationScreen> createState() => _NotificationScreenState();
}

class _NotificationScreenState extends State<NotificationScreen> {
  List title = [
    "Sound",
    "Vibrate",
    "App updates",
    "Promotion",
    "Payment Request"
  ];
  List allowNotitfi = [
    "ON",
    "OFF"
  ];
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: Text("Notifications"),
      elevation: 0,
      ),
      body:
      Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          SizedBox(height: 10,),
             Container(
               decoration: BoxDecoration(
                   color: Colors.grey.withOpacity(0.5),
                   borderRadius: BorderRadius.circular(30)),
                 child: InkWell(
                     child: SwitchItem(title: "Allow Notification"))),
          SizedBox(height: 10,),
          Padding(
            padding: const EdgeInsets.only(top: 10,left: 10),
            child: Text("Notification Types",style: Theme.of(context).textTheme.titleSmall,),
          ),
          Padding(
            padding: const EdgeInsets.only(right: 260,left: 15),
            child: Divider(height: 2,color: Colors.blue,),
          ),
          ListView.builder(
            itemCount: 5,
              shrinkWrap: true,
              itemBuilder: (context,index){
            return SwitchItem(title:title[index]);
          }),
        ],
      )
    );
  }
}
class SwitchItem extends StatefulWidget {
  final String title;
  const SwitchItem({super.key, required this.title});

  @override
  State<SwitchItem> createState() => _SwitchItemState();
}

class _SwitchItemState extends State<SwitchItem> {
  bool isSelected = false;
  void itemSwitch(bool value){
    setState(() {
      isSelected = !isSelected;
    });
  }
  @override
  Widget build(BuildContext context) {
    return ListTile(
      title: Text(widget.title),
      subtitle: Text(isSelected ? "ON":"OFF"),
      trailing: InkWell(
        onTap: (){
          isSelected
              ? PreferenceUtils.setString(PrefKeys.notification,"ON")
              : PreferenceUtils.setString(PrefKeys.notification,"OFF") ;
        },
        child: Switch(value: isSelected,
            onChanged: itemSwitch,
          activeColor: Colors.blueAccent,
        ),
      ),
    );
  }

}

