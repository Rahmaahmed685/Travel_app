import 'package:flutter/material.dart';
import 'package:toggle_switch/toggle_switch.dart';

import '../generated/l10n.dart';
import '../model/shared.dart';

class NotificationScreen extends StatefulWidget {
  const NotificationScreen({super.key});

  @override
  State<NotificationScreen> createState() => _NotificationScreenState();
}

class _NotificationScreenState extends State<NotificationScreen> {
  List title = [
    S().Sound,
    S().Vibrate,
    S().AppUpdates,
    S().FloatingNotification,
    S().AppIconBadges
  ];
  bool viewVisible = false;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: Text(S().Notifications),
      elevation: 0,
      ),
      body:
      Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
             Center(
               child: Padding(
                 padding: const EdgeInsets.all(8.0),
                 child: Text(S().AllowNotifacation,style: Theme.of(context).textTheme.titleMedium,),
               ),
             ),
             Center(
               child: ToggleSwitch(
                 minWidth: 90.0,
                 cornerRadius: 20.0,
                 activeBgColors: [[Colors.green[800]!], [Colors.red[800]!]],
                 activeFgColor: Colors.white,
                 inactiveBgColor: Colors.grey,
                 inactiveFgColor: Colors.white,
                 initialLabelIndex: 1,
                 totalSwitches: 2,
                 labels: [S().Allowed, S().Blocked],
                 radiusStyle: true,
                 onToggle: (index) {
                   index == 0
                       ? PreferenceUtils.setString(
                     PrefKeys.notification,
                     S().Allowed,)
                   : PreferenceUtils.setString(
                     PrefKeys.notification,
                       S().Blocked);
                   print('switched to: $index');
                 },
               ),
             ),
          SizedBox(height: 10,),
    Padding(
    padding: const EdgeInsets.only(top: 10,left: 10),
    child: Text(S().NotificationTypes,
      style: Theme.of(context).textTheme.titleSmall,),
    ),
    Padding(
    padding: const EdgeInsets.only(right: 260,left: 15),
    child: Divider(height: 2,color: Colors.blue,),
    ),

    ListView.builder(
    itemCount:
    title.length,
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
      subtitle: Text(isSelected ? S().ON:S().OFF),
      trailing: Switch(value: isSelected,
          onChanged: itemSwitch,
        activeColor: Colors.blueAccent,
      ),
    );
  }

}

