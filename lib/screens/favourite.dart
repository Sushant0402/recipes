import 'package:flutter/material.dart';
import 'package:recepies/modals/meal.dart';
import 'package:recepies/widgets/mealItem.dart';

//in this page we are showing the meals that are favourited by user.
class Favourite extends StatelessWidget {

  List<Meal> favouriteMeals;
  Favourite({required this.favouriteMeals});
  //here we are getting the favourite meals and just showing it here.

  @override
  Widget build(BuildContext context) {
    if(favouriteMeals.length == 0){
      return Center(child: Text("You don't have any favourite, start adding soon!!"));
    }
    //here we are using the same logic from mealsScreen to create meal item.
    return ListView.builder(
      itemBuilder: (ctx, index) {
        return MealItem(
          id: favouriteMeals[index].id,
          title: favouriteMeals[index].title,
          imageUrl: favouriteMeals[index].imageUrl,
          duration: favouriteMeals[index].duration,
          complexity: favouriteMeals[index].complexity,
          affordability: favouriteMeals[index].affordability,
          // removeItem: _removeItem,
        );
      },
      itemCount: favouriteMeals.length,
    );
  }
}
