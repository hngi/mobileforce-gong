import 'package:flutter/material.dart';
import 'package:flutter_svg/svg.dart';
import 'package:get/get.dart';
import 'package:provider/provider.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:team_mobileforce_gong/UI/screens/add_note.dart';
import 'package:team_mobileforce_gong/models/note_model.dart';
import 'package:team_mobileforce_gong/UI/screens/add_todo.dart';
import 'package:team_mobileforce_gong/services/localAuth/lockNotes.dart';
import 'package:team_mobileforce_gong/services/navigation/app_navigation/navigation.dart';
import 'package:team_mobileforce_gong/state/theme_notifier.dart';
import 'package:team_mobileforce_gong/services/responsiveness/responsiveness.dart';
import 'package:team_mobileforce_gong/state/notesProvider.dart';
import 'package:team_mobileforce_gong/state/theme_notifier.dart';
import 'package:team_mobileforce_gong/util/styles/color.dart';

import '../../main.dart';
import 'home_page.dart';

class ShowNotes extends StatefulWidget {
  @override
  _ShowNotesState createState() => _ShowNotesState();
}

class _ShowNotesState extends State<ShowNotes> {
  final scaffoldKey = GlobalKey<ScaffoldState>();

  @override
  Widget build(BuildContext context) {
    List<Notes> notes = Provider.of<NotesProvider>(context).notes;
    var model = Provider.of<NotesProvider>(context);
    final state = Provider.of<LocalAuth>(context);

    return WillPopScope(
      onWillPop: () async {
        if (model.select) {
          model.setSelect();
        }
        return true;
      },
      child: Scaffold(
        
        key: scaffoldKey,
        body: Container(
          padding: EdgeInsets.symmetric(horizontal: 10),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: <Widget>[
              Expanded(
                child: ListView.builder(
                  itemCount: notes.length,
                  itemBuilder: (context, index) {
                    return GestureDetector(
                      onLongPress: () {
                        model.select ? print('') : model.setSelect();
                      },
                      onLongPressEnd: (details) {
                        if (model.deletes.indexOf(notes[index]) == -1) {
                          model.addDelete(notes[index]);
                        } else {
                          if (model.deletes.length == 1) {
                            model.removeDeletes(
                                model.deletes.indexOf(notes[index]));
                            model.setSelect();
                          } else {
                            model.removeDeletes(
                                model.deletes.indexOf(notes[index]));
                          }
                        }
                      },
                      onTap: () async {
                        print('I was tapped');
                        if (model.select) {
                          if (model.deletes.indexOf(notes[index]) == -1) {
                            model.addDelete(notes[index]);
                          } else {
                            if (model.deletes.length == 1) {
                              model.removeDeletes(
                                  model.deletes.indexOf(notes[index]));
                              model.setSelect();
                            } else {
                              model.removeDeletes(
                                  model.deletes.indexOf(notes[index]));
                            }
                          }
                        } else {
                          final prefs = await SharedPreferences.getInstance();
                          bool locked = prefs.getBool(notes[index].sId);
                          print(locked);
                          print(notes[index].userID);
                          if (locked == true) {
                            await state.authenticate();
                            String status = state.successful;
                            if (status == 'Successful') {
                              Get.to(AddNote(
                                    stitle: notes[index].title,
                                    scontent: notes[index].content,
                                    snote: notes[index],
                                    simportant: notes[index].important,
                                    noteID: notes[index].sId,
                                  ));
                            } else {
                              scaffoldKey.currentState.showSnackBar(SnackBar(
                                  backgroundColor: Colors.red,
                                  content: Text('Authorization Failed')));
                            }
                          } else {
                            Get.to(AddNote(
                                    stitle: notes[index].title,
                                    scontent: notes[index].content,
                                    snote: notes[index],
                                    simportant: notes[index].important,
                                    noteID: notes[index].sId,
                                  ));
                          }
                          
                        }
                      },
                      child: Container(
                        padding: index == notes.length - 1
                            ? EdgeInsets.only(bottom: 30)
                            : EdgeInsets.zero,
                        child: Card(
                          elevation: 0,
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
                              padding: EdgeInsets.only(
                                  top: 20, left: 20, bottom: 8, right: 20),
                              decoration: BoxDecoration(
                                  border: Border(
                                      left:
                                          BorderSide(width: 5.0, color: blue))),
                              child: Row(
                                children: <Widget>[
                                  model.select
                                      ? Container(
                                          margin: EdgeInsets.only(right: 10),
                                          decoration: BoxDecoration(
                                              borderRadius:
                                                  BorderRadius.circular(50),
                                              border: Border.all(
                                                  color: blue, width: 1)),
                                          width: 15,
                                          height: 15,
                                          child: Center(
                                            child: Container(
                                              decoration: BoxDecoration(
                                                  borderRadius:
                                                      BorderRadius.circular(50),
                                                  color: model.deletes.indexOf(
                                                              notes[index]) ==
                                                          -1
                                                      ? Colors.white
                                                      : blue),
                                              width: 10,
                                              height: 10,
                                            ),
                                          ),
                                        )
                                      : SizedBox(),
                                  Expanded(
                                    child: Column(
                                      mainAxisAlignment:
                                          MainAxisAlignment.start,
                                      crossAxisAlignment:
                                          CrossAxisAlignment.start,
                                      children: <Widget>[
                                        Container(
                                          child: Text(
                                            notes[index].title ?? '',
                                            style: Theme.of(context)
                                                .textTheme
                                                .headline6
                                                .copyWith(
                                                    fontSize: SizeConfig()
                                                        .textSize(context, 2.5),
                                                    color: blue,
                                                    fontWeight:
                                                        FontWeight.w500),
                                            maxLines: 1,
                                            overflow: TextOverflow.ellipsis,
                                          ),
                                        ),
                                        SizedBox(
                                          height: 8,
                                        ),
                                        Row(
                                          mainAxisAlignment:
                                              MainAxisAlignment.spaceBetween,
                                          crossAxisAlignment:
                                              CrossAxisAlignment.end,
                                          children: <Widget>[
                                            Flexible(
                                              child: Text(
                                                notes[index].content ?? '',
                                                style: Theme.of(context)
                                                    .textTheme
                                                    .headline6
                                                    .copyWith(
                                                      fontSize: SizeConfig()
                                                          .textSize(
                                                              context, 2.2),
                                                    ),
                                                maxLines: 2,
                                                overflow: TextOverflow.ellipsis,
                                              ),
                                            ),
                                            Container(
                                              child: Text(
                                                  notes[index].date ?? '',
                                                  style: Theme.of(context)
                                                      .textTheme
                                                      .headline6
                                                      .copyWith(
                                                          fontSize: SizeConfig()
                                                              .textSize(context,
                                                                  1.6))),
                                            ),
                                          ],
                                        )
                                      ],
                                    ),
                                  ),
                                ],
                              ),
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
