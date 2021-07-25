import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:recepies/screens/mealsScreen.dart';

class CategoryItem extends StatelessWidget {
  //this widget is used to create a category item that will be shown on category screen page.
  final String title;
  final Color color;
  final String id;

  const CategoryItem({required this.id,required this.title,required this.color});

  void selectCategory(context){
    Navigator.pushNamed(context, MealsScreen.routeName, arguments: {"id": id, "title": title, "color": color});
    //we can pass data with navigator as arguments, we can pass data as map, list, object etc.
    // Navigator.push(MaterialPageRoute(builder: builder))

  }

  @override
  Widget build(BuildContext context) {
    return InkWell(
      //InkWell is used to get that ripple effect on longTap
      //is also has many features as gesture detector.
      onTap:() => selectCategory(context),
      borderRadius: BorderRadius.circular(15),
      splashColor: Theme.of(context).primaryColor,
      child: Container(
        padding: EdgeInsets.all(15),
        child: Center(child: Text(title, style: Theme.of(context).textTheme.title,)),
        decoration: BoxDecoration(
          gradient: LinearGradient( //we can use gradient to provide gradient color.
            colors: [
              color.withOpacity(0.7),
              color,
            ],
            begin: Alignment.topLeft,
            end: Alignment.bottomRight,
          ),
          borderRadius: BorderRadius.circular(15),
        ),
      ),
    );
  }
}

/*
//passing route as a MaterialPageRoute
Navigator.push(context, MaterialPageRoute(
        builder: (_){
          return CategoryItemScreen();
        }
    ),);
 */