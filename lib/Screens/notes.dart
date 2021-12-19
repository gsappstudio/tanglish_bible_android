import 'package:flutter/material.dart';
import 'package:tanglis_bible_mobileapp/Screens/viewNotes.dart';
import 'package:tanglis_bible_mobileapp/db/database_provider.dart';
import 'package:tanglis_bible_mobileapp/model/note_model.dart';

import 'add_notes.dart';

class Notes extends StatefulWidget {
  const Notes({Key? key}) : super(key: key);

  @override
  _NotesState createState() => _NotesState();
}

class _NotesState extends State<Notes> {
  Future
  getNotes() async{
    final notes = await DatabaseProvider.db.getNotes();
    return notes;
  }
  @override
  Widget build(BuildContext context) {
    return
      Scaffold(
      floatingActionButton: FloatingActionButton(
        onPressed: () {
          Navigator.of(context).push(MaterialPageRoute(builder: (context) => AddNotes()));
        },
        child: Icon(Icons.note_add),
      ),
      backgroundColor: Colors.black87,
      body:Column(
        children: [
          Expanded(
            child: FutureBuilder(
                future: getNotes(),
                builder: (context, noteData) {
                  if(noteData.connectionState == ConnectionState.waiting){
                    return Center(child: CircularProgressIndicator(),);
                  }
                  else{
                    if(noteData.data == Null){
                      //var items = noteData.data as List<NoteModel>;
                      return Center(child:  Text('There is no Notes added yet', style: TextStyle(color: Colors.white),),);
                    }
                    else {
                      var items = noteData.data as List<dynamic>;
                      return
                        ListView.builder(

                        itemCount: items.length,
                          itemBuilder: (context, index){
                          String title = items[index]['title'];
                          int id = items[index]['id'];
                          String body = items[index]['body'];
                          String creation_date = items[index]['creation_date'];
                        return
                          InkWell(
                            onTap: (){
                              Navigator.of(context).push(MaterialPageRoute(builder: (context) => ViewNotes(title: title, body: body, id: id,)));
                            },
                            child:
                            Container(
                              child: Column(
                                children: [
                                  Container(
                                  height: 145,
                                  width: MediaQuery.of(context).size.width-24,
                                  decoration: BoxDecoration(borderRadius: BorderRadius.circular(24), color: Colors.white),
                                  child:
                                  Padding(
                                    padding: const EdgeInsets.symmetric(vertical: 15.0, horizontal: 12),
                                    child: Column(
                                      mainAxisAlignment: MainAxisAlignment.start,
                                      crossAxisAlignment: CrossAxisAlignment.start,
                                      children: [
                                        Text(title, maxLines:1, style: TextStyle(color: Colors.black, fontSize: 18, fontWeight: FontWeight.bold, overflow:TextOverflow.ellipsis),),
                                        SizedBox(height: 10,),
                                        Text(body, maxLines:1, style: TextStyle(color: Colors.black, overflow:TextOverflow.ellipsis, fontSize: 16, ),),

                                        Padding(
                                          padding: const EdgeInsets.symmetric(vertical: 20),
                                          child: Row(
                                            children: [
                                              Icon(Icons.schedule, color: Colors.blue, size: 20,),
                                              SizedBox(width: 8,),
                                              Text(creation_date.substring(0, 16), style: TextStyle(color: Colors.black),),
                                            ],
                                          ),
                                        ),
                                      ],
                                    ),
                                  ),
                        ),
                                  SizedBox(height: 20,)
                                ],
                              ),
                            ),
                          );
                      });
                    }
                  }

            }),
          )
        ],
      ),
    );
  }
}
