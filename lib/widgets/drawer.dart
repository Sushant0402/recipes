import 'package:flutter/material.dart';
import 'package:recepies/screens/filter.dart';

class MyDrawer extends StatelessWidget {
  Widget _buildContainer(
      //this widget is used to create a item of drawer
      {
    required BuildContext context,
    required String text,
    required IconData icon,
    required Function onTapHandler,
  }) {
    return Container(
      margin: EdgeInsets.all(10),
      decoration: BoxDecoration(
        borderRadius: BorderRadius.circular(10),
        color: Colors.teal.withOpacity(0.8),
      ),
      child: Material(
        //it background have a fixed color then inkWell does not show the ripple effect
        // to get the ripple effect back we can use Material widget and given it a white color with opacity 0
        //and then we will be able to see the ripple effect.
        color: Colors.white.withOpacity(0),
        child: InkWell(
          splashColor: Color(0xff2193b0),
          borderRadius: BorderRadius.circular(10),
          onTap: () => onTapHandler(),
          child: Padding(
            padding: const EdgeInsets.all(10.0),
            child: ListTile(
              leading: Icon(
                icon,
                size: 30,
                color: Colors.white,
              ),
              title: Text(
                text,
                style: Theme.of(context) //we can use the theme that we have set using theme.of(context)
                    .textTheme
                    .title!
                    .copyWith(color: Colors.white),
              ),
            ),
          ),
        ),
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    return Drawer(
        //Drawer is default widget given by flutter to make a drawer/ side navigation menu
        child: Container(
      color: Theme.of(context).primaryColor,
      padding: EdgeInsets.all(20),
      child: SafeArea(
        child: Column(
          children: [
            Container(
              height: 100,
              width: MediaQuery.of(context).size.width * 0.8,
              padding: EdgeInsets.all(20),
              decoration: BoxDecoration(
                  gradient: LinearGradient(colors: [
                    Color(0xff2193b0),
                    Color(0xff6dd5ed),
                  ], begin: Alignment.topLeft, end: Alignment.bottomRight),
                  borderRadius: BorderRadius.circular(10)),
              child: Center(
                child: Text(
                  "Recipes",
                  style: TextStyle(fontWeight: FontWeight.bold, fontSize: 40),
                ),
              ),
            ),
            SizedBox(
              height: 10,
            ),
            _buildContainer(
                //when we have to build somewhat similar widget we can use a builder to minimize the codes
                //also if widget is very large we can build a separate widget.
                context: context,
                text: "Meals",
                icon: Icons.restaurant_menu,
                onTapHandler: () {
                  Navigator.pushReplacementNamed(context, "/");
                  //pushReplacementNamed means all the pages on the stack will be removed and this page will be added on the stack.
                }),
            _buildContainer(
                context: context,
                text: "Filter",
                icon: Icons.auto_awesome,
                onTapHandler: () {
                  Navigator.pushReplacementNamed(
                      context, FilterMealScreen.routeName);
                }),
          ],
        ),
      ),
    ));
  }
}
