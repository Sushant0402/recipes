import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:recepies/modals/meal.dart';
import 'package:recepies/screens/mealDetailScreen.dart';

class MealItem extends StatelessWidget {
  final String id;
  final String title;
  final String imageUrl;
  final int duration;
  final Complexity complexity;
  final Affordability affordability;
  // final Function removeItem;

  MealItem({
    required this.id,
    required this.title,
    required this.imageUrl,
    required this.duration,
    required this.complexity,
    required this.affordability,
    // required this.removeItem,
  });

  String get complexityText {
    //this method returns a text on the basis of complexity of meal
    //here Complexity is an enum stored in meal.dart
    switch (complexity) {
      case Complexity.Simple:
        return "Simple";
      case Complexity.Challenging:
        return "Challenging";
      case Complexity.Hard:
        return "Hard";
      default:
        return "Unknown";
      //in this switch case we don't need break because we are using return statement
    }
  }

  String get affordabilityText {
    //method to get a string on basis of affordability of meal
    switch (affordability) {
      case Affordability.Affordable:
        return "Affordable";
      case Affordability.Pricey:
        return "Pricey";
      case Affordability.Luxurious:
        return "Luxurious";
      default:
        return "Unknown";
      //in this switch case we don't need break because we are using return statement
    }
  }

  void pushMealDetailPage(context) {
    //this method is used to pushMetalDetailPage using Navigator
    Navigator.pushNamed(
      context,
      MealDetailScreen.routeName,
      arguments: id,
    ).then((value){
      //Navigator return a future object to when the page that we have passed is popped then "then" part will be execute
      //This value we are getting is coming from mealDetailPage
      if(value != null){
        // removeItem(value);
      }
    });
  }

  @override
  Widget build(BuildContext context) {
    return Card(
      elevation: 4, //elevation adds a box shadow.
      shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(15)),
      margin: EdgeInsets.all(10),
      child: InkWell(
        borderRadius: BorderRadius.circular(15),
        splashColor: Theme.of(context).primaryColor,
        onTap: () => pushMealDetailPage(context),
        child: Column(
          children: [
            Stack( //stack store widgets one over another
              //here using stack to put text on image.
              children: [
                ClipRRect( //ClipRRect is used to clip the corner of a widget.
                  borderRadius: BorderRadius.only(
                      topLeft: Radius.circular(15),
                      topRight: Radius.circular(15)),
                  child: Image.network(
                    //Image network is used to fetch image from network
                    imageUrl,
                    height: 250,
                    width: double.infinity,
                    fit: BoxFit.cover,
                  ),
                ),
                Positioned(
                  //as stack store widget one over another we can position the smaller widget
                  //in the area covered with larger widget
                    bottom: 20,
                    right: 0,
                    child: Container(
                      width: 250,
                      padding:
                          EdgeInsets.symmetric(horizontal: 20, vertical: 6),
                      decoration: BoxDecoration(
                        borderRadius: BorderRadius.only(topLeft: Radius.circular(10), bottomLeft: Radius.circular(10)),
                        color: Colors.black54,
                      ),
                      child: Text(
                        title,
                        style: TextStyle(
                          fontSize: 26,
                          color: Colors.white,
                        ),
                        softWrap: true,
                        overflow: TextOverflow.fade,
                      ),
                    ))
              ],
            ),
            Padding(
              //here adding the meal details like affordability, complexity and duration
              padding: const EdgeInsets.all(20.0),
              child: Row(
                mainAxisAlignment: MainAxisAlignment.spaceAround,
                children: [
                  Row(
                    children: [
                      Icon(Icons.schedule),
                      SizedBox(
                        width: 5,
                      ),
                      Text("$duration min")
                    ],
                  ),
                  Row(
                    children: [
                      Icon(Icons.work),
                      SizedBox(
                        width: 5,
                      ),
                      Text(complexityText),
                    ],
                  ),
                  Row(
                    children: [
                      Icon(Icons.attach_money),
                      SizedBox(
                        width: 5,
                      ),
                      Text(affordabilityText)
                    ],
                  )
                ],
              ),
            )
          ],
        ),
      ),
    );
  }
}
