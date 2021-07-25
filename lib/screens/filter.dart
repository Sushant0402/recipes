import 'package:flutter/material.dart';
import 'package:recepies/widgets/drawer.dart';

//This is the page where we give user a option to filter meals on basis of 4 data points.
class FilterMealScreen extends StatefulWidget {
  static const routeName = "FiltersScreen";

  final Function setFilterData;
  Map<String, bool> filterData;
  FilterMealScreen({required this.setFilterData, required this.filterData});
  @override
  _FilterMealScreenState createState() => _FilterMealScreenState();
}

class _FilterMealScreenState extends State<FilterMealScreen> {

  //this is the data points through which we are filtering meals.
  bool _isGlutenFree = false;
  bool _isVegan = false;
  bool _isVegetarian = false;
  bool _isLactoseFree = false;



  Widget _buildSwitchListTile(String title, String description, bool currentState, Function onChange) {
    //this method make a widget SwitchListTile which is provided by flutter
    //this provide a switch and title
    return SwitchListTile(
      value: currentState, //value means currentState of toggle button
      onChanged: (val) => onChange(val),
      title: Text(title),
      subtitle: Text(description),
    );
  }

  @override
  void initState() {
    setState(() {
      //when this page loads we are getting the current state of filter to be applied from main.dart
      //and setting it to this page data points, this is necessary so we can know which filters to data has been provided previously
      _isGlutenFree = widget.filterData["gluten"]!;
      _isLactoseFree = widget.filterData["lactose"]!;
      _isVegetarian = widget.filterData["vegetarian"]!;
      _isVegan = widget.filterData["vegan"]!;
    });
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text("Filter"),
        actions: [
          IconButton(icon: Icon(Icons.save), onPressed: (){
            //when a user mark meal a favourite we return the filter to be applied as in from of map to
            //setFilterData function which is present in main, and this function will iterate on all the meals
            //and filter out those meals that support the filter data.
            Map<String, bool> _filterData = {
              "gluten" : _isGlutenFree,
              "lactose" : _isLactoseFree,
              "vegetarian": _isVegetarian,
              "vegan": _isVegan,
            };
            widget.setFilterData(_filterData);
          },)
        ],
      ),
      drawer: MyDrawer(),
      body: Center(
        child: Column(
          children: [
            Container(
              margin: EdgeInsets.all(20),
              child: Center(
                child: Text(
                  "Filter your Recipes Choices",
                  style: TextStyle(
                    fontSize: 22,
                    fontWeight: FontWeight.bold,
                  ),
                ),
              ),
            ),
            Expanded(
              child: Padding(
                padding: const EdgeInsets.all(10.0),
                child: ListView(
                  children: [
                    _buildSwitchListTile("Gluten Free", "select meals that are gluten free", _isGlutenFree, (val){
                      setState(() {
                        _isGlutenFree = val;
                      });
                    }),
                    _buildSwitchListTile("Lactose Free", "select meals that are lactose free", _isLactoseFree, (val){
                      setState(() {
                        _isLactoseFree = val;
                      });
                    }),
                    _buildSwitchListTile("Vegetarian", "select meals that are vegetarian", _isVegetarian, (val){
                      setState(() {
                        _isVegetarian = val;
                      });
                    }),
                    _buildSwitchListTile("Vegan", "select meals that are vegan", _isVegan, (val){
                      setState(() {
                        _isVegan = val;
                      });
                    }),
                  ],
                ),
              ),
            )
          ],
        ),
      ),
    );
  }
}
