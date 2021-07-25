import 'package:flutter/material.dart';
import 'package:recepies/modals/meal.dart';
import 'package:recepies/widgets/mealItem.dart';

//this page will show all the meals that is available for selected category
class MealsScreen extends StatefulWidget {
  static const routeName = "CategoryItemScreen";

  List<Meal> availableMeals;
  MealsScreen({required this.availableMeals});
  //here we are accepting the available meals that is filtered out on basis of user filter data

  @override
  _MealsScreenState createState() => _MealsScreenState();
}

class _MealsScreenState extends State<MealsScreen> {
  late String categoryTitle; //this is title of category
  List<Meal> displayedMeal = []; //this meals will be displayed
  var initData = false;
  
  @override
  void didChangeDependencies() {
    //this is a lifeCycle method and it is safe to use BuildContext,
    //here basically we want to load our data once and use that data to go to MealDetailPage
    //if user have remove that item from the list so we should also remove that item from the list.
    if(!initData){
      final routeArgs =
      ModalRoute.of(context)!.settings.arguments as Map<String, Object>;
       //the data passed from category item through pushNamed as arguments, we can extract that data using ModalRoute
      //context, context means from where this page is pushed, then we can tap into setting.arguments to get the data
      //here data comes in from of an object so we are converting that data to Map , here we need context that why we
      //are using didChangeDependencies else we would have used initState to set data or fetch data.

      categoryTitle = routeArgs["title"] as String; //setting category title from map we get

      //when ever we use stateful widget, and if we want to fetch
      //data of that class in it's state we can use widget.attributeName

      //we are iterating over available meals which is filter meals and checking if meals belongs to this category
      //and if yes then we are putting that into displayed meal,
      //every meal have a list of category to which it belongs to and some properties on the basis of that it can be filtered out.
      displayedMeal = widget.availableMeals.where((meal) {
        return meal.categories.contains(routeArgs["id"] as String);
        //contains method returns true of false
      }).toList();

      initData = true; //we are setting initData to true so when user goes back from MealDetailScreen page, we should not
      //load all the meals that should be displayed again from available meals.

    }
    super.didChangeDependencies();
  }

  // void _removeItem(String mealId){
  //   //this method will remove the item user wanted to remove from the list.
  //   setState(() {
  //     displayedMeal.removeWhere((meal) => meal.id == mealId);
  //   });
  // }

  //we are not removing data for now

  @override
  Widget build(BuildContext context) {

    return Scaffold(
      appBar: AppBar(
        title: Text(categoryTitle),
      ),
      body: ListView.builder(
        //ListView builder method will create a list by using itemBuilder
        //itemBuilder will loop as many time as itemCount provided and
        //and the widget to ListView that is returned by builder
        //builder method provide a context and index that we can use to build widget with different data from list of data
        //available to us
        itemBuilder: (ctx, index) {
          return MealItem(
              id: displayedMeal[index].id,
              title: displayedMeal[index].title,
              imageUrl: displayedMeal[index].imageUrl,
              duration: displayedMeal[index].duration,
              complexity: displayedMeal[index].complexity,
              affordability: displayedMeal[index].affordability,
              // removeItem: _removeItem,
          );
        },
        itemCount: displayedMeal.length,
      ),
    );
  }
}
