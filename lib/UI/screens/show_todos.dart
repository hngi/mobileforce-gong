import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:team_mobileforce_gong/UI/screens/add_todo.dart';
import 'package:team_mobileforce_gong/models/todo.dart';
import 'package:team_mobileforce_gong/models/todos.dart';
import 'package:team_mobileforce_gong/services/responsiveness/responsiveness.dart';
import 'package:team_mobileforce_gong/state/todoProvider.dart';
import 'package:team_mobileforce_gong/util/styles/color.dart';

class ShowTodos extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    List<Todos> todos = Provider.of<TodoProvider>(context).todos;
    var model = Provider.of<TodoProvider>(context);
    return Scaffold(
      body: Container(
        padding: EdgeInsets.symmetric(horizontal: 10),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: <Widget>[
            Expanded(
              child: ListView.builder(
                itemCount: todos.length,
                itemBuilder: (context, index) {
                  return InkWell(
                    onTap: (){
                      Navigator.of(context)
                      .push(MaterialPageRoute(builder: (context) =>
                          AddTodo(todos[index])));
                    },
                    child: Card(
                      color: model.getBackgroundColor(todos[index].backgroundColor),
                      elevation: 1,
                      margin: EdgeInsets.only(bottom: 10),
                      shape: RoundedRectangleBorder(
                        borderRadius: BorderRadius.circular(8.0),
                      ),
                      child: ClipRRect(
                        borderRadius: BorderRadius.only(
                          topLeft: Radius.circular(8),
                          bottomLeft: Radius.circular(8),
                        ),
                        child: Container(
                          padding: EdgeInsets.only(top: 15, left: 25, right: 20, bottom: 5),
                          child: Row(
                            mainAxisAlignment: MainAxisAlignment.spaceBetween,
                            children: <Widget>[
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
                                    SizedBox(height: 8,),
                                    Text(
                                      todos[index].date,
                                      style: Theme.of(context).textTheme.headline6.copyWith(fontSize: SizeConfig().textSize(context, 2)),
                                      maxLines: 2,
                                      overflow: TextOverflow.ellipsis,
                                    )
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
                                      value: model.isTodoCompleted(todos[index].completed),
                                      onChanged: (val) {
                                        model.completed(model.isTodoCompleted(todos[index].completed), index);
                                      },
                                    ),
                                  ),
                                  Container(
                                    child: Text(
                                        todos[index].content == null? "": todos[index].date,
                                      style: Theme.of(context).textTheme.headline6.copyWith(fontSize: SizeConfig().textSize(context, 1.6))
                                    ),
                                  ),
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
    );
  }
}