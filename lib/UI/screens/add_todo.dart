import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:intl/intl.dart';
import 'package:provider/provider.dart';
import 'package:team_mobileforce_gong/state/authProvider.dart';
import 'package:team_mobileforce_gong/state/theme_notifier.dart';
import 'package:team_mobileforce_gong/models/category.dart';
import 'package:team_mobileforce_gong/services/responsiveness/responsiveness.dart';
import 'package:team_mobileforce_gong/state/todoProvider.dart';
import 'package:team_mobileforce_gong/util/styles/color.dart';
import 'package:team_mobileforce_gong/models/todos.dart';

class AddTodo extends StatefulWidget {
final Todos todo;

  const AddTodo(this.todo);

  @override
  _AddTodoState createState() => _AddTodoState(todo);
}

class _AddTodoState extends State<AddTodo> {
  Todos todo;
  _AddTodoState(this.todo);

  List<Category> _category = Category.getData();
  List<DropdownMenuItem<Category>> _dropdownMenuItems;
  Category _selectedcategory;
  bool checkedValue = false;
  String _stitle ;
  String _scontent ;
  DateTime _sdate;
  TimeOfDay _stime;

  @override
  Widget build(BuildContext context) {
    var model = Provider.of<TodoProvider>(context);
    return WillPopScope(
      onWillPop: () async {
        if(todo.title != null || todo.description != null) {
          if(_stitle ==null && _scontent == null) {
            Navigator.pop(context);
          } else {
           /* Provider.of<TodoProvider>(context, listen: false).updateTodo(
                _stitle ?? widget.stitle,
                _selectedcategory == null ? widget.scategory : _selectedcategory.name,
                Provider.of<AuthenticationState>(context, listen: false).uid,
                _scontent ?? widget.scontent,
                _sdate ?? DateFormat("dd/MM/yy").parse(widget.sdate),
                _stime ?? TimeOfDay(hour:int.parse(widget.sdate.split(":")[0]),minute: int.parse(widget.sdate.split(":")[1])),
                widget.stodo
            );*/
           todo.title = _stitle;
           todo.description = _scontent;
           print(todo.title + "this is the title and desc :" + todo.description) ;

           Provider.of<TodoProvider>(context,listen: false).save(todo);
            Navigator.pop(context);
          }
        } else if(_stitle ==null && _scontent == null) {
          Navigator.pop(context);
        } else {
         /* Provider.of<TodoProvider>(context, listen: false).createTodo(
              _stitle,
              _selectedcategory == null ? null : _selectedcategory.name,
              Provider.of<AuthenticationState>(context, listen: false).uid,
              _scontent,
              _sdate,
              _stime
          );*/

         Provider.of<TodoProvider>(context,listen: false).save(todo);
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
                          child: Text(todo.title.isNotEmpty ? 'Edit Todo' : 'New Todo',
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
                            if(todo.title != null || todo.description != null) {
                              if(_stitle ==null && _scontent == null) {
                                Navigator.pop(context);
                              } else {
                                /*Provider.of<TodoProvider>(context, listen: false).updateTodo(
                                    _stitle ?? widget.stitle,
                                    _selectedcategory == null ? widget.scategory : _selectedcategory.name,
                                    Provider.of<AuthenticationState>(context, listen: false).uid,
                                    _scontent ?? widget.scontent,
                                    _sdate ?? DateFormat("dd/MM/yy").parse(widget.sdate),
                                    _stime ?? TimeOfDay(hour:int.parse(widget.sdate.split(":")[0]),minute: int.parse(widget.sdate.split(":")[1])),
                                    widget.stodo
                                );*/
                                todo.title = _stitle;
                                todo.description = _scontent;
                                print(todo.title + "this is the title and desc :" + todo.description) ;
                                Provider.of<TodoProvider>(context,listen: false).save(todo);
                                Navigator.pop(context);
                              }
                            } else if(_stitle ==null && _scontent == null) {
                              Navigator.pop(context);
                            } else {
                              /*Provider.of<TodoProvider>(context, listen: false).createTodo(
                                  _stitle,
                                  _selectedcategory == null ? null : _selectedcategory.name,
                                  Provider.of<AuthenticationState>(context, listen: false).uid,
                                  _scontent,
                                  _sdate,
                                  _stime
                              );*/
                              todo.title = _stitle;
                              todo.description = _scontent;
                              print(todo.title + "this is the title and desc :" + todo.description) ;
                              Provider.of<TodoProvider>(context,listen: false).save(todo);
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
                        todo.title != null ? SizedBox() : Container(
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
                              hint: todo.category != null ? Text(
                                todo.category,
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
                            initialValue: todo.title == null ? null : todo.title,
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
                            initialValue: todo.description == null ? null : todo.description,
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
                              hint: todo.date != null && todo.time != null ?
                              model.dformat.format(DateTime.now()).toString() == todo.date ?
                              Text(
                                'Remind me at '+todo.time,
                                style: Theme.of(context)
                                    .textTheme
                                    .headline5
                                    .copyWith(
                                    fontSize: SizeConfig().textSize(context, 2.4), fontWeight: FontWeight.w400),
                              )
                                  :
                              Text(
                                'Reminder for '+todo.date+' '+todo.time,
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



}