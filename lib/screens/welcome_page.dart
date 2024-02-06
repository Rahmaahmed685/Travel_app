import 'package:flutter/material.dart';
import 'package:smooth_page_indicator/smooth_page_indicator.dart';
import 'package:travel_app/widgets/app_header_text.dart';
import 'package:travel_app/widgets/app_text.dart';
import 'package:travel_app/widgets/responsive_button.dart';

class WelcomePage extends StatefulWidget {
  const WelcomePage({super.key});

  @override
  State<WelcomePage> createState() => _WelcomePageState();
}

class _WelcomePageState extends State<WelcomePage> {
  List images = [
    "assets/images/welcome_one.png",
    "assets/images/mountain.png",
    "assets/images/welcome_three.png",
  ];
  List headers = [
    "Travelling",
    "Mountains",
    "Summer",
  ];
  List contents = [
    "Gives you an opportunity\nto discover the world.",
    "You'll easily find yourself surrounded\nby absolute silence and miles of\nuntouched natural beauty \nfurther than you can see.",
    "A breath of fresh sea air they also naturally\nincrease your levels of serotonin that\nstabilizes your mood, feelings of\nwell-being, and happiness.",
  ];
  final controller = PageController(keepPage: true);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        body: PageView.builder(
            controller: controller,
            scrollDirection: Axis.vertical,
            itemCount: images.length,
            itemBuilder: (_, index) {
              return Container(
                width: double.maxFinite,
                height: double.maxFinite,
                decoration: BoxDecoration(
                  image: DecorationImage(
                      image: AssetImage(images[index]),
                      fit: BoxFit.fill
                  ),
                ),

                child: Container(
                  margin: EdgeInsets.only(top: 150, left: 20, right: 20),
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          Text(headers[index],
                            style: TextStyle(
                                color: Colors.white70,
                            fontWeight: FontWeight.bold,
                              fontSize: 30
                            ),
                          ),
                          SizedBox(height: 5,),
                          Text(contents[index],
                            style: TextStyle(
                                color: Colors.black54,
                                fontSize: 15
                            ),
                          ),
                          SizedBox(height: 20,),

                          index == images.length - 1
                              ? ResponsiveButton()
                              : SizedBox(),
                        ],),

                      Column(
                          children: [
                            SmoothPageIndicator(
                                axisDirection: Axis.vertical,
                                controller: controller,
                                count: images.length,
                                effect: ExpandingDotsEffect(
                                  activeDotColor: Colors.white,
                                  dotColor: Colors.white54,
                                  radius: 8,
                                  spacing: 10,
                                  dotHeight: 12,
                                  dotWidth: 12,
                                )),
                          ]
                      )
                    ],),
                ),
              );
            }
        )
    );
  }
  // !myStory[index -1 ].shown?
  // BoxDecoration() :


}