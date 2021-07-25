import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:recepies/modals/data.dart';

//This page shows details about meals that is selected by user.
//like ingredients, steps to cook
class MealDetailScreen extends StatelessWidget {
  static const routeName = "MealDetailScreenPage";

  Function toggleFavourite; //this method is used to toggle a meals a favourite
  Function isFavourite;//this method is used to check if a meal is favourite or not.
  //both this method we are getting from main.dart
  MealDetailScreen({required this.toggleFavourite, required this.isFavourite});

  Widget _buildSectionHeader(BuildContext context,String text){
    return Container(
      margin: EdgeInsets.all(10),
      child: Center(
        child: Text(text, style: Theme.of(context).textTheme.title!.copyWith(
          fontSize: 25,
          decoration: TextDecoration.underline,
        ),),
      ),
    );
  }

  Widget _buildSectionContainer({required BuildContext context,required Widget child}){
    //This is a builder method and we are using it to make a section container
    //section means like ingredients/steps
    return Container(
      padding: EdgeInsets.symmetric(horizontal: 5, vertical: 7),
      height: 250,
      width: MediaQuery.of(context).size.width*0.9,
      decoration: BoxDecoration(
          border: Border.all(color: Colors.black, width: 1),
        borderRadius: BorderRadius.circular(15),
        color: Colors.black12,
      ),
      child: child,
    );
  }

  @override
  Widget build(BuildContext context) {
    final mealId = ModalRoute.of(context)!.settings.arguments as String;
    final meal = MEALS_LIST.firstWhere((meal) => meal.id == mealId);
    //this method of list will return first item where meal.id == mealID
    return Scaffold(
      appBar: AppBar(
        title: Text(meal.title),
      ),
      floatingActionButton: FloatingActionButton(
        child: isFavourite(mealId) ? Icon(Icons.star) : Icon(Icons.star_border),
        onPressed: (){
          // Navigator.of(context).pop(mealId);
          toggleFavourite(mealId);
        },
      ),
      body: SingleChildScrollView(
        physics: ScrollPhysics(),
        padding: EdgeInsets.all(10),
        child: Column(
          children: [
            Container(
              height: 300,
              width: double.infinity,
              child: ClipRRect(
                borderRadius: BorderRadius.circular(15),
                child: Image.network(
                  meal.imageUrl,
                  fit: BoxFit.cover,
                ),
              ),
            ),
            _buildSectionHeader(context, "Ingredients"),
            _buildSectionContainer(
                context: context,
                child: ListView.builder(
                    itemBuilder: (context, index){
                      return Container(
                        padding: EdgeInsets.all(10),
                        margin: EdgeInsets.symmetric(horizontal: 10, vertical: 5),
                        decoration: BoxDecoration(
                          color: Colors.teal.withOpacity(0.5),
                          borderRadius: BorderRadius.circular(7),
                        ),
                        child: Text(meal.ingredients[index], style: TextStyle(
                          fontSize: 15,
                        ),),
                      );
                    },
                    itemCount: meal.ingredients.length,
                )
            ),
            _buildSectionHeader(context, "Steps"),
            _buildSectionContainer(
                context: context,
                child: ListView.builder(
                  itemBuilder: (context, index){
                    return Column(
                      children: [
                        Container(
                          child: ListTile(
                            leading: CircleAvatar(
                              child: Text("#${index+1}"),
                            ),
                            title: Text(meal.steps[index]),
                          ),
                        ),
                        Divider(color: Colors.black54,),
                      ],
                    );
                  },
                  itemCount: meal.steps.length,
                )
            ),
          ],
        ),
      ),
    );
  }
}
