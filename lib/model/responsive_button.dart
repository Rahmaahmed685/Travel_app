import 'package:flutter/material.dart';
import 'package:page_transition/page_transition.dart';
import 'package:travel_app/screens/bar_item_pages/main_page.dart';

class ResponsiveButton extends StatelessWidget {
  bool isResponsive;
  double? width;
  ResponsiveButton({this.isResponsive=false ,
    this.width
  }){super.key;}

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: (){
        Navigator.pushReplacement(
          context,
          PageTransition(
              type: PageTransitionType.rightToLeft,
              child: MainPage(),

            duration: Duration(milliseconds: 400)
        ),
        );
      },
      child: Container(
        decoration: BoxDecoration(
            borderRadius: BorderRadius.circular(10),
            border: Border.all(),
            // gradient: LinearGradient(
            //     colors: [
            //       Colors.brown.shade300,
            //       Colors.deepOrange.shade500,
            //     ]),
            shape: BoxShape.rectangle),
        width: 80,
        height: 40,
        child:
        Row(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Icon(Icons.arrow_forward_ios,size: 15,color: Colors.white,),
            Icon(Icons.arrow_forward_ios,size: 20,color: Colors.white,),
            Icon(Icons.arrow_forward_ios,size: 25,color: Colors.white,),
          ],
        ),
      ),
    );
  }
}
