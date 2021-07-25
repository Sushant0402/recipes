import 'package:flutter/material.dart';
import 'package:recepies/modals/data.dart';
import 'package:recepies/modals/meal.dart';
import 'package:recepies/screens/categoriesScreen.dart';
import 'package:recepies/screens/filter.dart';
import 'package:recepies/screens/mealDetailScreen.dart';
import 'package:recepies/screens/mealsScreen.dart';
import 'package:recepies/screens/tabBar.dart';

void main() {
  runApp(MyApp());
}

class MyApp extends StatefulWidget {
  const MyApp({Key? key}) : super(key: key);

  @override
  _MyAppState createState() => _MyAppState();
}

class _MyAppState extends State<MyApp> {

  List<Meal> favouriteMeals = [];
  //this list will contain favourite meals

  void toggleFavouriteMeal(String id){
    //this function will check if the item is in favourite meals list,
    //if yes then remove it else add  it
    int existingIndex = favouriteMeals.indexWhere((meal) => meal.id == id);

    setState(() {
      if(existingIndex == -1){
        favouriteMeals.add(MEALS_LIST.firstWhere((meal) => meal.id == id));
      }
      else{
        favouriteMeals.removeAt(existingIndex);
      }
    });

  }

  bool isFavourite(String id){
    //this method return is the meal is in favourite meals list.
    return favouriteMeals.any((meal) => meal.id == id);
  }

  Map<String, bool> _filterData = {
    //this map store the state current state of filter page
    "gluten" : false,
    "lactose" : false,
    "vegetarian": false,
    "vegan": false,
  };


  List<Meal> availableMeals = MEALS_LIST;
  //this list will store the available meals after filtering out meals on basis of filter

  void _setFilterData(Map<String, bool> filterData){
    //this method goes through all the meal present in meal list.
    //and filter meals on basis of filter that is applied by user.
    //the data in this method is coming from filter page.
    setState(() {
      _filterData = filterData;
      //setting filter page data to main page filter data

      availableMeals = MEALS_LIST.where((meal){
        //where method loop on all items of list and if condition provided is true then it will be added to available meals.
        //filtering meals on basis of filterData
        if(_filterData["gluten"]! && !meal.isGlutenFree){
          //here it means that user has selected the "gluten free" meals and the meal
          //that we are currently checking is not "gluten free" then return false.
          return false;
        }
        if(_filterData["lactose"]! && !meal.isLactoseFree){
          return false;
        }
        if(_filterData["vegetarian"]! && !meal.isVegetarian){
          return false;
        }
        if(_filterData["vegan"]! && !meal.isVegan){
          return false;
        }
        return true;
      }).toList();
      //where method return an iterable so we have to convert it to a list.
    });
  }

  @override
  Widget build(BuildContext context) {
    //this is main widget of our app.
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      title: "Recipes",
      theme: ThemeData(
        primarySwatch: Colors.indigo, //primary swatch means the colors around the color provided will be used in app
        accentColor: Colors.deepOrangeAccent,
        fontFamily: "Sans",
        canvasColor: Colors.white.withOpacity(0.9), //setting canvas color
        textTheme: Theme.of(context).textTheme.copyWith(
          title: TextStyle(
            fontSize: 20,
            fontWeight: FontWeight.w100,
            color: Colors.black
          )
        )
      ),
      // home: MyHomePage(),
      initialRoute: "/", //this route will be loaded when app launch
      routes: { //this is routes map and used by flutter to Navigate using named route.
        "/":(ctx) => TabBarScreen(favouriteMeals: favouriteMeals,), //passing favourite meals data to our TabBarScreen and then it will be
        //forward to favourite page.
        CategoriesScreen.routeName: (context) => CategoriesScreen(),
        MealsScreen.routeName: (ctx) => MealsScreen(availableMeals: availableMeals,),//sending available meals to meals screen.
        MealDetailScreen.routeName: (ctx) => MealDetailScreen(toggleFavourite: toggleFavouriteMeal, isFavourite: isFavourite,),
        FilterMealScreen.routeName : (ctx) => FilterMealScreen(setFilterData: _setFilterData, filterData: _filterData,),
        //passing method to theses screen that are required by them, and containing these method is main because
        //from main we can pass data to any page.
      },

      onUnknownRoute: (ctx) => MaterialPageRoute(builder: (ctx) => CategoriesScreen()),
      //onUnknownRoute will be called when the flutter does not know to which page it should be before throwing the error.
    );
  }
}

