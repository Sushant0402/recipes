import 'package:flutter/material.dart';
import 'package:recepies/modals/data.dart';
import 'package:recepies/widgets/categoriesItem.dart';

//in this page we are showing the categories of meals

class CategoriesScreen extends StatelessWidget {
  static const routeName = "CategoriesScreen";


  @override
  Widget build(BuildContext context) {
    return GridView(
      //here we are using gridView to show a grid layout to user, which show categories of meals.
        padding: EdgeInsets.all(15),
        gridDelegate: SliverGridDelegateWithMaxCrossAxisExtent(
          //setting grid properties.
          maxCrossAxisExtent: 200,
          childAspectRatio: 3 / 2,
          crossAxisSpacing: 20,
          mainAxisSpacing: 30,
        ),
        children: CATEGORY_LIST.map((category) {
          return CategoryItem(id: category.id, title: category.title, color: category.color);
        }).toList(),
      //iterating over catergory_list and return category item which will be shown in grid layout
      );
  }
}
