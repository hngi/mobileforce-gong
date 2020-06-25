import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:provider/provider.dart';
import 'package:team_mobileforce_gong/UI/theme_notifier.dart';
import 'package:team_mobileforce_gong/models/category.dart';
import 'package:team_mobileforce_gong/responsiveness/responsiveness.dart';
import 'package:team_mobileforce_gong/styles/color.dart';

class AddTodo extends StatefulWidget {
  @override
  _AddTodoState createState() => _AddTodoState();
}

class _AddTodoState extends State<AddTodo> {
  List<Category> _category = Category.getData();
  List<DropdownMenuItem<Category>> _dropdownMenuItems;
  Category _selectedcategory;
  bool checkedValue = false;

  @override
  void initState() { 
    super.initState();
    _dropdownMenuItems = buildDropdownMenuItems(_category);
  }

  List<DropdownMenuItem<Category>> buildDropdownMenuItems(List category) {
    List <DropdownMenuItem<Category>> items = List();
    for (Category category in category) {
      print(category);
      items.add(
        DropdownMenuItem(
          value: category,
          child: Text(category.name,)
        ),
      );
    }
    return items;
  }

  onChangedDropdownItem(Category selectedcategory) {
    setState(() {
      _selectedcategory = selectedcategory;
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      resizeToAvoidBottomInset: false,
      resizeToAvoidBottomPadding: false,
      body: Container(
        padding: EdgeInsets.only(bottom: 20),
        width: MediaQuery.of(context).size.width,
        height: MediaQuery.of(context).size.height,
        child: Column(
          children: <Widget>[
            Container(
              padding: EdgeInsets.only(left: 25, right: 25, top: 30, bottom: 15),
              width: MediaQuery.of(context).size.width,
              height: SizeConfig().yMargin(context, 15.1),
              color: blue,
              child: Column(
                mainAxisAlignment: MainAxisAlignment.spaceAround,
                crossAxisAlignment: CrossAxisAlignment.start,
                children: <Widget>[
                  GestureDetector(
                    onTap: (){Navigator.pop(context);},
                    child: Container(
                      padding: EdgeInsets.symmetric(vertical: 20, horizontal: 8),
                      child: SvgPicture.asset(
                        'assets/svgs/backarrow.svg',
                        width: 25,
                      ),
                    ),
                  ),
                  Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: <Widget>[
                      Container(
                        child: Text(
                          'New Todo',
                          style: Theme.of(context).textTheme.headline6.copyWith(fontSize: SizeConfig().textSize(context, 2.7), color: Colors.white, fontWeight: FontWeight.w600)
                        ),
                      ),
                      GestureDetector(
                        onTap: (){},
                        child: Container(
                          child: Text(
                            'Save',
                            style: Theme.of(context).textTheme.headline6.copyWith(fontSize: SizeConfig().textSize(context, 2.1), color: Colors.white, fontWeight: FontWeight.w300)
                          ),
                        ),
                      )
                    ],
                  )
                ],
              ),
            ),
            Expanded(
              child: SingleChildScrollView(
                child: Container(
                  padding: EdgeInsets.symmetric(horizontal: 25, vertical: 30),
                  width: MediaQuery.of(context).size.width,
                  child: Column(
                    mainAxisAlignment: MainAxisAlignment.start,
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: <Widget>[
                      Container(
                        margin: EdgeInsets.only(bottom: 30),
                        child: Text(
                          'Create A Todo',
                          style: Theme.of(context).textTheme.headline6.copyWith(fontSize: SizeConfig().yMargin(context, 4.5)),
                        ),
                      ),
                       Container(
                         margin: EdgeInsets.only(bottom: 25),
                        child: DropdownButton(
                          underline: Container(height: 0.9, color: Colors.black.withOpacity(0.4)),
                          isExpanded: true,
                          hint: Text(
                            'Choose Category',
                            style: Theme.of(context).textTheme.headline6.copyWith(fontSize: SizeConfig().textSize(context, 2.1), fontWeight: FontWeight.w200, color: Provider.of<ThemeNotifier>(context, listen: false).isDarkModeOn ? Colors.grey[400] : Colors.grey[500]),
                          ),
                          value: _selectedcategory,
                          items: _dropdownMenuItems,
                          onChanged: onChangedDropdownItem,
                          style: Theme.of(context).textTheme.headline5.copyWith(fontSize: 18, fontWeight: FontWeight.w500),
                        )
                      ),
                      Container(
                        margin: EdgeInsets.only(bottom: 25),
                        child: TextFormField(
                          maxLines: null,
                          maxLengthEnforced: false,
                          keyboardType: TextInputType.multiline,
                          style: TextStyle(fontSize: SizeConfig().textSize(context, 2.1)),
                          decoration: InputDecoration(
                            hintText: 'Enter Title',
                            hintStyle: TextStyle(fontSize: SizeConfig().textSize(context, 2.1), fontWeight: FontWeight.w200, color: Provider.of<ThemeNotifier>(context, listen: false).isDarkModeOn ? Colors.grey[400] : Colors.grey[500]),
                            contentPadding: new EdgeInsets.symmetric(vertical: 1.0, horizontal: 10.0),
                          ),
                        ),
                      ),
                       Container(
                        margin: EdgeInsets.only(bottom: 25),
                        child: DropdownButton(
                          underline: Container(height: 0.9, color: Colors.black.withOpacity(0.4)),
                          isExpanded: true,
                          hint: Text(
                            'Start Date',
                            style: Theme.of(context).textTheme.headline6.copyWith(fontSize: SizeConfig().textSize(context, 2.1), fontWeight: FontWeight.w200, color: Provider.of<ThemeNotifier>(context, listen: false).isDarkModeOn ? Colors.grey[400] : Colors.grey[500]),
                          ),
                          value: _selectedcategory,
                          items: _dropdownMenuItems,
                          onChanged: onChangedDropdownItem,
                          style: Theme.of(context).textTheme.headline5.copyWith(fontSize: 18, fontWeight: FontWeight.w500),
                        )
                      ),
                       Container(
                        margin: EdgeInsets.only(bottom: 25),
                        child: DropdownButton(
                          underline: Container(height: 0.9, color: Colors.black.withOpacity(0.4)),
                          isExpanded: true,
                          hint: Text(
                            'End Date',
                            style: Theme.of(context).textTheme.headline6.copyWith(fontSize: SizeConfig().textSize(context, 2.1), fontWeight: FontWeight.w200, color: Provider.of<ThemeNotifier>(context, listen: false).isDarkModeOn ? Colors.grey[400] : Colors.grey[500]),
                          ),
                          value: _selectedcategory,
                          items: _dropdownMenuItems,
                          onChanged: onChangedDropdownItem,
                          style: Theme.of(context).textTheme.headline5.copyWith(fontSize: 18, fontWeight: FontWeight.w500),
                        )
                      ),
                      Container(
                        margin: EdgeInsets.only(bottom: 25),
                        child: TextFormField(
                          maxLines: null,
                          maxLengthEnforced: false,
                          keyboardType: TextInputType.multiline,
                          style: TextStyle(fontSize: SizeConfig().textSize(context, 2.1)),
                          decoration: InputDecoration(
                            hintText: 'Enter note (optional)',
                            hintStyle: TextStyle(fontSize: SizeConfig().textSize(context, 2.1), fontWeight: FontWeight.w200, color: Provider.of<ThemeNotifier>(context, listen: false).isDarkModeOn ? Colors.grey[400] : Colors.grey[500]),
                            contentPadding: new EdgeInsets.symmetric(vertical: 1.0, horizontal: 10.0),
                          ),
                        ),
                      ),
                      Container(
                        child: CheckboxListTile(
                          title: Text(
                            'Make this To-Do reoccurring'
                          ),
                          value: checkedValue,
                          onChanged: (newValue) { 
                            setState(() {
                              checkedValue = newValue; 
                            }); 
                          },
                        ),
                      )
                    ],
                  ),
                ),
              ),
            )
          ],
        ),
      ),
    );
  }
}