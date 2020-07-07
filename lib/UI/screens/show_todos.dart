import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:team_mobileforce_gong/UI/screens/add_todo.dart';
import 'package:team_mobileforce_gong/models/todos.dart';
import 'package:team_mobileforce_gong/services/responsiveness/responsiveness.dart';
import 'package:team_mobileforce_gong/state/authProvider.dart';
import 'package:team_mobileforce_gong/state/todoProvider.dart';
import 'package:team_mobileforce_gong/util/styles/color.dart';

class ShowTodos extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    List<Todos> todos = Provider.of<TodoProvider>(context).todos;
    var model = Provider.of<TodoProvider>(context);
    return WillPopScope(
      onWillPop: ()async {
        if(model.select) {
          model.setSelect();
        }
        return true;
      },
      child: Scaffold(
        body: Container(
          padding: EdgeInsets.symmetric(horizontal: 10),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: <Widget>[
              Expanded(
                child: ListView.builder(
                  itemCount: todos.length,
                  itemBuilder: (context, index) {
                    return Container(
                      padding: index == todos.length -1 ? EdgeInsets.only(bottom: 30) : EdgeInsets.zero,
                      child: GestureDetector(
                        onLongPress: (){
                          model.select ? print('') : model.setSelect();
                        },
                        onLongPressEnd: (details) {
                          if(model.deletes.indexOf(todos[index]) == -1){
                            model.addDelete(todos[index]);
                          } else {
                            if(model.deletes.length == 1) {
                              model.removeDeletes(model.deletes.indexOf(todos[index]));
                              model.setSelect();
                            } else {
                              model.removeDeletes(model.deletes.indexOf(todos[index]));
                            }
                          }
                        },
                        onTap: (){
                          if(model.select){
                            if(model.deletes.indexOf(todos[index]) == -1){
                              model.addDelete(todos[index]);
                            } else {
                              if(model.deletes.length == 1) {
                                model.removeDeletes(model.deletes.indexOf(todos[index]));
                                model.setSelect();
                              } else {
                                model.removeDeletes(model.deletes.indexOf(todos[index]));
                              }
                            }
                          } else{
                            Navigator.of(context).push(MaterialPageRoute(
                                builder: (context) => AddTodo(todos[index])));
                          }
                        },
                        child: Card(
                          elevation: 1,
                          margin: EdgeInsets.only(bottom: 10),
                          shape: RoundedRectangleBorder(
                            borderRadius: BorderRadius.circular(8.0),
                          ),
                          child: Container(
                            padding: EdgeInsets.only(top: 20, left: 25, right: 20, bottom: 5),
                            child: Row(
                              mainAxisAlignment: MainAxisAlignment.spaceBetween,
                              children: <Widget>[
                                Expanded(
                                  child: Row(
                                    children: <Widget>[
                                      model.select ? Container(
                                        margin: EdgeInsets.only(right: 10),
                                        decoration: BoxDecoration(
                                            borderRadius: BorderRadius.circular(50),
                                            border: Border.all(color: blue, width: 1)
                                        ),
                                        width: 15,
                                        height: 15,
                                        child: Center(
                                          child: Container(
                                            decoration: BoxDecoration(
                                                borderRadius: BorderRadius.circular(50),
                                                color: model.deletes.indexOf(todos[index]) == -1 ? Colors.white : blue
                                            ),
                                            width: 10,
                                            height: 10,
                                          ),
                                        ),
                                      ) : SizedBox(),
                                      Flexible(
                                        child: Column(
                                          mainAxisAlignment: MainAxisAlignment.start,
                                          crossAxisAlignment: CrossAxisAlignment.start,
                                          children: <Widget>[
                                            Container(
                                              child: Text(
                                                todos[index].title,
                                                style: Theme.of(context).textTheme.headline6.copyWith(fontSize: SizeConfig().textSize(context, 2.2), color: blue, fontWeight: FontWeight.w500),
                                                maxLines: 1,
                                                overflow: TextOverflow.ellipsis,
                                              ),
                                            ),
                                            todos[index].content == null ? SizedBox() : SizedBox(height: 8,),
                                            todos[index].content == null ? SizedBox() : Text(
                                              todos[index].content,
                                              style: Theme.of(context).textTheme.headline6.copyWith(fontSize: SizeConfig().textSize(context, 2)),
                                              maxLines: 2,
                                              overflow: TextOverflow.ellipsis,
                                            )
                                          ],
                                        ),
                                      ),
                                    ],
                                  ),
                                ),
                                Column(
                                  children: <Widget>[
                                    Theme(
                                      data: ThemeData(unselectedWidgetColor: blue),
                                      child: Checkbox(
                                        checkColor: blue,
                                        activeColor: Colors.transparent,
                                        value: todos[index].isCompleted,
                                        onChanged: (val) {
                                          Provider.of<TodoProvider>(context, listen: false).updateCompleted(
                                              todos[index].title,
                                              todos[index].category,
                                              Provider.of<AuthenticationState>(context, listen: false).uid,
                                              todos[index].content,
                                              todos[index].date,
                                              todos[index].time,
                                              !todos[index].isCompleted,
                                              todos[index]
                                          );
                                        },
                                      ),
                                    ),
                                    // Container(
                                    //   child: Text(
                                    //     todos[index].date,
                                    //     style: Theme.of(context).textTheme.headline6.copyWith(fontSize: SizeConfig().textSize(context, 1.6))
                                    //   ),
                                    // ),
                                  ],
                                )
                              ],
                            ),
                          ),
                        ),
                      ),
                    );
                  },
                ),
              )
            ],
          ),
        ),
      ),
    );
  }
}