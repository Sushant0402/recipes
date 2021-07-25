import 'package:flutter/material.dart';
import 'package:recepies/widgets/drawer.dart';
import '../screens/categoriesScreen.dart';
import '../screens/favourite.dart';
import 'package:recepies/modals/meal.dart';

//this is main screen of this app
//this screen will have two pages to show with the help of tab

class TabBarScreen extends StatefulWidget {

  List<Meal> favouriteMeals;
  TabBarScreen({required this.favouriteMeals});
  //we are getting this favourite meals so we can pass this to favourite page.

  @override
  _TabBarScreenState createState() => _TabBarScreenState();
}

class _TabBarScreenState extends State<TabBarScreen> {
  late List<Map<String, Object>> _pages ;

  int _selectedPageIndex = 0; //_selectedPageIndex represent which tap selected and on basis of it which page to be shown.
  //the body of this page will change on basis of selected index.

  void _changePage(int index){
    //this function will be used to change the selected index, which will change the page in app
    setState(() {
      _selectedPageIndex = index;
    });
  }

  @override
  void initState() {
    //the initState method is called when the this page loads before build

    //we are setting the list of page that we want to show
    _pages = [
      {"page": CategoriesScreen(), "name": "Categories"}, //this is a map which contain page constructor and it's name
      //so we change page and name dynamically on basis of index.
      {"page": Favourite(favouriteMeals: widget.favouriteMeals,), "name": "Your Favourite"},
    ];
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text(_pages[_selectedPageIndex]["name"] as String), //getting page name on basis of page selected.
      ),
      drawer: MyDrawer(), //drawer attribute is used to add a drawer to an scaffold. here we are calling the widget that we are
      //crate as drawer.
      bottomNavigationBar: BottomNavigationBar(
        //bottomNavigationBar is widget, which is used to create a bottom navigation bar/tab
        backgroundColor: Theme.of(context).primaryColor,
        onTap: _changePage, //this onTap method provide an index from flutter side and which we will use to set page and name
        selectedItemColor: Colors.deepOrangeAccent,
        unselectedItemColor: Colors.white,
        currentIndex: _selectedPageIndex,
        items: [
          //in items we can store item that we want to show on bottom navigation bar.
          BottomNavigationBarItem(
            icon: Icon(Icons.category),
            label: "Categories",
          ),
          BottomNavigationBarItem(
            icon: Icon(Icons.star),
            label: "Favourite",
          )
        ],
      ),
      body: _pages[_selectedPageIndex]["page"] as Widget, //when ever we want to convert one type of object to another
      //we can use "as", if possible if will be converted else it will throw an error.
    );
  }
}
