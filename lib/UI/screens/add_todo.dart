import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:intl/intl.dart';
import 'package:provider/provider.dart';
import 'package:team_mobileforce_gong/models/todos.dart';
import 'package:team_mobileforce_gong/state/authProvider.dart';
import 'package:team_mobileforce_gong/state/theme_notifier.dart';
import 'package:team_mobileforce_gong/models/category.dart';
import 'package:team_mobileforce_gong/services/responsiveness/responsiveness.dart';
import 'package:team_mobileforce_gong/state/todoProvider.dart';
import 'package:team_mobileforce_gong/util/styles/color.dart';

class AddTodo extends StatefulWidget {

  final Todos stodo;

AddTodo(this.stodo);

  @override
  _AddTodoState createState() => _AddTodoState(stodo);
}

class _AddTodoState extends State<AddTodo> {
  Todos stodo;
  _AddTodoState(this.stodo);
  List<Category> _category = Category.getData();
  List<DropdownMenuItem<Category>> _dropdownMenuItems;
  Category _selectedcategory;
  bool checkedValue = false;
  String _stitle;
  String _scontent;
  DateTime _sdate;
  TimeOfDay _stime;

  @override
  Widget build(BuildContext context) {
    var model = Provider.of<TodoProvider>(context);
    return WillPopScope(
      onWillPop: () async {
        if(stodo.title != null || stodo.content != null) {
          if(_stitle ==null && _scontent == null) {
            Navigator.pop(context);
          } else {
            Provider.of<TodoProvider>(context, listen: false).updateTodo(
                _stitle ?? stodo.title,
                _selectedcategory == null ? stodo.category : _selectedcategory.name,
                Provider.of<AuthenticationState>(context, listen: false).uid,
                _scontent ?? stodo.content,
                _sdate ?? stodo.date,
                _stime ?? stodo.time,
                stodo
            );
            Navigator.pop(context);
          }
        } else if(_stitle ==null && _scontent == null) {
          Navigator.pop(context);
        } else {
          Provider.of<TodoProvider>(context, listen: false).createTodo(
              _stitle,
              _selectedcategory == null ? null : _selectedcategory.name,
              Provider.of<AuthenticationState>(context, listen: false).uid,
              _scontent,
              _sdate,
              _stime
          );
          Navigator.pop(context);
        }
        return true;
      },
      child: Scaffold(
        resizeToAvoidBottomInset: false,
        resizeToAvoidBottomPadding: false,
        body: Container(
          padding: EdgeInsets.only(bottom: 20),
          width: MediaQuery.of(context).size.width,
          height: MediaQuery.of(context).size.height,
          child: Column(
            children: <Widget>[
              Container(
                padding: EdgeInsets.only(left: SizeConfig().xMargin(context, 5.9), right: SizeConfig().xMargin(context, 5.9), top: SizeConfig().yMargin(context, 3.0), bottom: SizeConfig().yMargin(context, 1.6)),
                width: MediaQuery.of(context).size.width,
                height: SizeConfig().yMargin(context, 18),
                color: blue,
                child: Column(
                  mainAxisAlignment: MainAxisAlignment.spaceAround,
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: <Widget>[
                    GestureDetector(
                      onTap: () {
                        Navigator.pop(context);
                      },
                      child: Container(
                        padding: EdgeInsets.symmetric(vertical: SizeConfig().yMargin(context, 2.1), horizontal: SizeConfig().xMargin(context, 1.9)),
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
                          child: Text(stodo.title != null ? 'Edit Todo' : 'New Todo',
                              style: Theme.of(context)
                                  .textTheme
                                  .headline6
                                  .copyWith(
                                  fontSize:
                                  SizeConfig().textSize(context, 2.7),
                                  color: Colors.white,
                                  fontWeight: FontWeight.w600)),
                        ),
                        GestureDetector(
                          onTap: () {
                            stodo.title = _stitle;
                            stodo.content = _scontent;
                            stodo.time =  _stime.hour.toString()+':'+_stime.minute.toString();
                            stodo.date = model.dformat.format(_sdate).toString();
                            model.save(stodo);
                            if(stodo.title != null || stodo.content != null) {
                              if(_stitle ==null && _scontent == null) {
                                Navigator.pop(context);
                              } else {
                                Provider.of<TodoProvider>(context, listen: false).updateTodo(
                                    _stitle ?? stodo.title,
                                    _selectedcategory == null ? stodo.category : _selectedcategory.name,
                                    Provider.of<AuthenticationState>(context, listen: false).uid,
                                    _scontent ?? stodo.content,
                                    _sdate ?? stodo.date,
                                    _stime ?? stodo.time,
                                    stodo
                                );
                                Navigator.pop(context);
                              }
                            } else if(_stitle ==null && _scontent == null) {
                              Navigator.pop(context);
                            } else {
                              Provider.of<TodoProvider>(context, listen: false).createTodo(
                                  _stitle,
                                  _selectedcategory == null ? null : _selectedcategory.name,
                                  Provider.of<AuthenticationState>(context, listen: false).uid,
                                  _scontent,
                                  _sdate,
                                  _stime
                              );
                              Navigator.pop(context);
                            }
                          },
                          child: Container(
                            padding: EdgeInsets.symmetric(horizontal: 10, vertical: 10),
                            child: Text('Save',
                                style: Theme.of(context)
                                    .textTheme
                                    .headline6
                                    .copyWith(
                                    fontSize:
                                    SizeConfig().textSize(context, 2.3),
                                    color: Colors.white,
                                    fontWeight: FontWeight.w600)),
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
                        stodo.title != null ? SizedBox() : Container(
                          margin: EdgeInsets.only(bottom: 30),
                          child: Text(
                            'Create A Todo',
                            style: Theme.of(context).textTheme.headline6.copyWith(
                                fontSize: SizeConfig().yMargin(context, 4.5)),
                          ),
                        ),
                        Container(
                            margin: EdgeInsets.only(bottom: 25),
                            child: DropdownButton(
                              underline: Container(height: 0.9, color: Colors.black.withOpacity(0.4)),
                              isExpanded: true,
                              hint: stodo.category != null ? Text(
                                stodo.category,
                                style: Theme.of(context).textTheme.headline5.copyWith(fontSize: SizeConfig().textSize(context, 2.4),),
                              ) :  Text(
                                'Choose Category',
                                style: Theme.of(context).textTheme.headline6.copyWith(fontSize: SizeConfig().textSize(context, 2.4), fontWeight: FontWeight.w200, color: Provider.of<ThemeNotifier>(context, listen: false).isDarkModeOn ? Colors.grey[400] : Colors.grey[500]),
                              ),
                              value: _selectedcategory,
                              items: _dropdownMenuItems,
                              onChanged: onChangedDropdownItem,
                              style: Theme.of(context).textTheme.headline5.copyWith(fontSize: SizeConfig().textSize(context, 2.4),),
                            )
                        ),
                        Container(
                          margin: EdgeInsets.only(bottom: 25),
                          child: TextFormField(
                            maxLines: null,
                            maxLengthEnforced: false,
                            keyboardType: TextInputType.multiline,
                            style: TextStyle(
                                fontSize: SizeConfig().textSize(context, 2.4)),
                            initialValue: stodo.title.isEmpty ? "" : stodo.title,
                            decoration: InputDecoration(
                              hintText: 'Enter Title',
                              hintStyle: TextStyle(
                                  fontSize: SizeConfig().textSize(context, 2.4),
                                  fontWeight: FontWeight.w200,
                                  color: Provider.of<ThemeNotifier>(context,
                                      listen: false)
                                      .isDarkModeOn
                                      ? Colors.grey[400]
                                      : Colors.grey[500]),
                              contentPadding: new EdgeInsets.symmetric(
                                  vertical: 1.0, horizontal: 10.0),
                            ),
                            onChanged: (val) {
                              _stitle = val;
                            },
                          ),
                        ),
                        Container(
                          margin: EdgeInsets.only(bottom: 25),
                          child: TextFormField(
                            maxLines: null,
                            maxLengthEnforced: false,
                            keyboardType: TextInputType.multiline,
                            style: TextStyle(
                                fontSize: SizeConfig().textSize(context, 2.4)),
                            initialValue: stodo.content == null ? null : stodo.content,
                            decoration: InputDecoration(
                              hintText: 'Enter note (optional)',
                              hintStyle: TextStyle(
                                  fontSize: SizeConfig().textSize(context, 2.4) ,
                                  fontWeight: FontWeight.w200,
                                  color: Provider.of<ThemeNotifier>(context,
                                      listen: false)
                                      .isDarkModeOn
                                      ? Colors.grey[400]
                                      : Colors.grey[500]),
                              contentPadding: new EdgeInsets.symmetric(
                                  vertical: 1.0, horizontal: 10.0),
                            ),
                            onChanged: (val) {
                              _scontent = val;
                            },
                          ),
                        ),
                        Container(
                            margin: EdgeInsets.only(bottom: 25),
                            child: DropdownButton<String>(
                              underline: Container(
                                  height: 0.9,
                                  color: Colors.black.withOpacity(0.4)),
                              isExpanded: true,
                              hint: stodo.date != null && stodo.time != null ?
                              model.dformat.format(DateTime.now()).toString() == stodo.date ?
                              Text(
                                'Remind me at '+stodo.time,
                                style: Theme.of(context)
                                    .textTheme
                                    .headline5
                                    .copyWith(
                                    fontSize: SizeConfig().textSize(context, 2.4), fontWeight: FontWeight.w400),
                              )
                                  :
                              Text(
                                'Reminder for '+stodo.date+' '+stodo.time,
                                style: Theme.of(context)
                                    .textTheme
                                    .headline5
                                    .copyWith(
                                    fontSize: SizeConfig().textSize(context, 2.4), fontWeight: FontWeight.w400),
                              )
                                  :
                              model.hValue == null ? Text(
                                'Set Reminder',
                                style: Theme.of(context)
                                    .textTheme
                                    .headline6
                                    .copyWith(
                                    fontSize:
                                    SizeConfig().textSize(context, 2.4),
                                    fontWeight: FontWeight.w200,
                                    color: Provider.of<ThemeNotifier>(context,
                                        listen: false)
                                        .isDarkModeOn
                                        ? Colors.grey[400]
                                        : Colors.grey[500]),
                              ) : Text(
                                model.hValue,
                                style: Theme.of(context)
                                    .textTheme
                                    .headline5
                                    .copyWith(
                                    fontSize: SizeConfig().textSize(context, 2.4), fontWeight: FontWeight.w400),
                              ),
                              value: model.value,
                              items: model.drop.map<DropdownMenuItem<String>>((String value) {
                                return DropdownMenuItem<String>(
                                  value: value,
                                  child: Text(
                                    value,
                                  ),
                                );
                              })
                                  .toList(),
                              onChanged: (value) async{
                                if(value == 'Custom Reminder') {
                                  await showDatePicker(
                                      context: context,
                                      initialDate: DateTime.now(),
                                      firstDate: DateTime(int.parse(DateFormat('yyyy').format(DateTime.now())), int.parse(DateFormat('MM').format(DateTime.now())), int.parse(DateFormat('dd').format(DateTime.now()))),
                                      lastDate: DateTime(2025)
                                  ).then((value) async{
                                    await showTimePicker(
                                      context: context,
                                      initialTime: TimeOfDay.now(),
                                    ).then((val) {
                                      setState(() {
                                        print(value);
                                        _sdate = value;
                                        _stime = val;
                                      });
                                      model.setValue(value, val, context);
                                    });
                                  });
                                } else if(value == 'Next 10 mins'){
                                  setState(() {
                                    print(value);
                                    _sdate = DateTime.now();
                                    _stime = TimeOfDay.fromDateTime(DateTime.now().add(Duration(minutes: 10)));
                                  });
                                  model.setValue(DateTime.now(), TimeOfDay.fromDateTime(DateTime.now().add(Duration(minutes: 10))), context);
                                }else if(value == 'Next 30 mins'){
                                  setState(() {
                                    print(value);
                                    _sdate = DateTime.now();
                                    _stime = TimeOfDay.fromDateTime(DateTime.now().add(Duration(minutes: 30)));
                                  });
                                  model.setValue(DateTime.now(), TimeOfDay.fromDateTime(DateTime.now().add(Duration(minutes: 30))), context);
                                }else if(value == 'Next 1 hour'){
                                  setState(() {
                                    print(value);
                                    _sdate = DateTime.now();
                                    _stime = TimeOfDay.fromDateTime(DateTime.now().add(Duration(hours: 1)));
                                  });
                                  model.setValue(DateTime.now(), TimeOfDay.fromDateTime(DateTime.now().add(Duration(hours: 1))), context);
                                } else {
                                  setState(() {
                                    print(value);
                                    _sdate = DateTime.now();
                                    _stime = null;
                                  });
                                  model.setVal(value);
                                }
                              },
                              style: Theme.of(context)
                                  .textTheme
                                  .headline5
                                  .copyWith(
                                  fontSize: SizeConfig().textSize(context, 2.4), fontWeight: FontWeight.w400),
                            )
                        ),
                        // Container(
                        //   child: CheckboxListTile(
                        //     title: Text('Make this To-Do reoccurring'),
                        //     value: checkedValue,
                        //     onChanged: (newValue) {
                        //       setState(() {
                        //         checkedValue = newValue;
                        //       });
                        //     },
                        //   ),
                        // )
                      ],
                    ),
                  ),
                ),
              )
            ],
          ),
        ),
      ),
    );
  }

  @override
  void initState() {
    super.initState();
    _dropdownMenuItems = buildDropdownMenuItems(_category);
    // if(widget.scategory != null) {
    //   _selectedcategory = Category(widget.scategory, widget.scategory);
    // }
  }

  List<DropdownMenuItem<Category>> buildDropdownMenuItems(List category) {
    List<DropdownMenuItem<Category>> items = List();
    for (Category category in category) {
      print(category);
      items.add(
        DropdownMenuItem(
            value: category,
            child: Text(
              category.name,
            )
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

  Color getBackgroundColor(int backgroundColor) {
    switch (backgroundColor) {
      case 1:
        return Colors.white;
        break;
      case 2:
        return Colors.red;
        break;
      case 3:
        return Colors.yellow;
        break;
      case 4:
        return Colors.lightBlue;
        break;
      default:
        return Colors.white;
    }
  }

/*  void changeColor(int value) {
    setState(() {
      todo.backgroundColor = value;
    });
    if (todo.id != null) {
      helper.updateTodo(todo);
    }
    else {
      helper.insertTodo(todo);
    }

  }*/
}
