import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:lottie/lottie.dart';
import 'package:text_scroll/text_scroll.dart';

import '../../generated/l10n.dart';
import '../../model/rating.dart';
import '../../model/shared.dart';
import '../../model/place.dart';

class SecoundPage extends StatefulWidget {
  const SecoundPage({super.key});

  @override
  State<SecoundPage> createState() => _SecoundPageState();
}

class _SecoundPageState extends State<SecoundPage> {

 // final firestore = FirebaseFirestore.instance;
  bool isFavorited =false;
List heads = [
  "Hiking",
  "Climbing",
  "Diving",
  "Skydiving",
  "Rafting",
  "Sandboarding",
  "Ziplining",
  "Bridge climbing"
];
List images = [
  "https://i0.wp.com/images-prod.healthline.com/hlcmsresource/images/topic_centers/2019-8/couple-hiking-mountain-climbing-1296x728-header.jpg?w=1155&h=1528",
  "https://images2.goabroad.com/image/upload/images2/program_content/10-totally-fresh-types-of-adventures-for-your-future-travels-6-1510126573.png",
  "https://a.cdn-hotels.com/gdcs/production164/d604/d8e6ce6d-063f-4667-9b0b-7c792bca591e.jpg?impolicy=fcrop&w=800&h=533&q=medium",
  "https://encrypted-tbn0.gstatic.com/images?q=tbn:ANd9GcT460Kds1kPQ3ICWbgAp6wjeCJA6G9EXcsfw_O5vjsUCldoFVpg0teFO5hQHP9uhOhzO24&usqp=CAU",
  "https://cdn.getyourguide.com/img/tour/c0a2fa9b60554a31.jpeg/145.jpg",
  "https://assets3.thrillist.com/v1/image/3156733/1200x600/scale;;webp=auto;jpeg_quality=85.jpg",
 "https://loveoahu.org/wp-content/uploads/climbworks-zipline-banner-image.jpg",
"https://www.livemint.com/rf/Image-621x414/LiveMint/Period2/2017/09/30/Photos/Processed/BridgeClimb2-klRD--621x414@LiveMint.jpg"
];
List location =[
  "Iceland, Japan",
  "Red Rocks, Nevada",
  "Lembeh Strait, Indonesia",
  "Dubai, UAE",
  "Rishikesh, New Zealand",
  "National Park, Colorado",
  "Orocovis, Puerto Rico",
  "Brisbane, Australia",
];
List<double> rate = [
  5,
  4,
  3,
  4,
  5,
  3,
  4,
  5
];
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        elevation: 0,
        title:
      TextScroll(
        S().discriptin,
        // style: TextStyle(color: Colors.green),
        // textAlign: TextAlign.right,
        // selectable: true,
        intervalSpaces: 10,
        velocity: Velocity(pixelsPerSecond: Offset(50, 0)),
        fadedBorder: true,
        numberOfReps: 4,
        fadeBorderVisibility: FadeBorderVisibility.auto,
        fadeBorderSide: FadeBorderSide.both,
      ),
        ),
      body:
          ListView.builder(
            itemCount: heads.length,
            itemBuilder: (context, index) {
              print(index);
              return buildNoteItem(index);
            },
          ),

      );
  }

  Widget buildNoteItem(int index) {
    return
      Padding(
        padding: const EdgeInsets.all(10),
        child: Container(
          decoration: BoxDecoration(
              color: PreferenceUtils.getBool(PrefKeys.darkTheme)
                  ?  Color(0XFFd8f3dc).withOpacity(0.6)
                  :  Colors.grey[200],

              borderRadius: BorderRadius.circular(15)),
          child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Padding(
                  padding: const EdgeInsets.all(8.0),
                  child:
                Stack(
                    alignment: Alignment.topRight,
                    children:[
                SizedBox(
                  width: double.infinity,
                  height: 200,
                  child: ClipRRect(
                      borderRadius: BorderRadius.circular(10),
                      child: Image.network(images[index],
                        fit: BoxFit.fill,)
                  ),
                ),

                Padding(
                  padding: const EdgeInsets.all(10),
                  child: InkWell(
                    onTap: ( ){
                      setState(() => isFavorited = !isFavorited);
                    },
                    child:
                    isFavorited
                    ? Icon(Icons.favorite,color: Colors.red,)
                    :  Icon(Icons.favorite_border,
                      color: Colors.white,
                    ),
                  ),
                ),
                ]),
                ),
                SizedBox(height: 10,),
                Padding(
                  padding: EdgeInsets.only(left: 15),
                  child: Text(
                    //"title",
                     heads[index],
                    style: Theme.of(context).textTheme.titleMedium,
                  ),
                ),
                Padding(
                  padding: EdgeInsets.only(left: 15),
                  child: Row(
                    children: [
                      Icon(Icons.location_on),
                      Text(
                     //   "address",
                        location[index],
                        style: Theme.of(context).textTheme.titleSmall,

                      ),
                    ],
                  ),
                ),
                Padding(
                  padding: EdgeInsets.only(left: 15,bottom: 15),
                  child:  StarRating(
                    rating:rate[index] ,
                    onRatingChanged: (rating) => setState(() => this.rate[index] = rating),
                    color: Colors.yellow,
                  ),
                ),
              ]),
        ),

      );
  }
}
