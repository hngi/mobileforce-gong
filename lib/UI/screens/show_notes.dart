import 'package:flutter/material.dart';
import 'package:flutter_svg/svg.dart';
import 'package:provider/provider.dart';
import 'package:team_mobileforce_gong/UI/screens/add_note.dart';
import 'package:team_mobileforce_gong/models/note_model.dart';
import 'package:team_mobileforce_gong/services/responsiveness/responsiveness.dart';
import 'package:team_mobileforce_gong/state/notesProvider.dart';
import 'package:team_mobileforce_gong/state/theme_notifier.dart';
import 'package:team_mobileforce_gong/util/styles/color.dart';

class ShowNotes extends StatelessWidget {

  @override
  Widget build(BuildContext context) {
      List<Notes> notes = Provider.of<NotesProvider>(context).notes;

    return Scaffold(
      body: Container(
        padding: EdgeInsets.symmetric(vertical: 10, horizontal: 10),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: <Widget>[
            Container(
              margin: EdgeInsets.only(bottom: 8, left: 5),
              child: Text(
                'Notes',
                style: Theme.of(context).textTheme.headline6.copyWith(fontSize: SizeConfig().textSize(context, 3),)
              ),
            ),
            Expanded(
              child: ListView.builder(
                itemCount: notes.length,
                itemBuilder: (context, index) {
                  return InkWell(
                    onTap: (){
                      Navigator.of(context)
                      .push(MaterialPageRoute(builder: (context) => AddNote(stitle: notes[index].title, scontent: notes[index].content)));
                    },
                    child: Card(
                      shape: RoundedRectangleBorder(
                        borderRadius: BorderRadius.circular(8.0),
                      ),
                      child: ClipRRect(
                        borderRadius: BorderRadius.only(
                          topLeft: Radius.circular(8),
                          bottomLeft: Radius.circular(8),
                        ),
                        child: Container(
                          padding: EdgeInsets.only(top: 20, left: 20, bottom: 8, right: 20),
                          decoration: BoxDecoration(
                            border: Border(
                              left: BorderSide(width: 4.0, color: blue)
                            )
                          ),
                          child: Column(
                            mainAxisAlignment: MainAxisAlignment.start,
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: <Widget>[
                              Container(
                                child: Text(
                                  notes[index].title,
                                  style: Theme.of(context).textTheme.headline6.copyWith(fontSize: SizeConfig().textSize(context, 2.2), color: blue, fontWeight: FontWeight.w500)
                                ),
                              ),
                              SizedBox(height: 8,),
                              Row(
                                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                                children: <Widget>[
                                  Flexible(
                                    child: Text(
                                      notes[index].content,
                                      style: Theme.of(context).textTheme.headline6.copyWith(fontSize: SizeConfig().textSize(context, 2), color: Colors.black.withOpacity(0.6))
                                    ),
                                  ),
                                  Container(
                                    child: Text(
                                      notes[index].date,
                                      style: Theme.of(context).textTheme.headline6.copyWith(fontSize: SizeConfig().textSize(context, 1.6), color: Colors.black.withOpacity(0.4))
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