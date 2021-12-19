import 'package:flutter/material.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:tanglis_bible_mobileapp/db/database_provider.dart';
import 'package:tanglis_bible_mobileapp/model/note_model.dart';

class AddNotes extends StatefulWidget {
  const AddNotes({Key? key}) : super(key: key);

  @override
  _AddNotesState createState() => _AddNotesState();
}

class _AddNotesState extends State<AddNotes> {
  String title = '';
  String body= '';

  addNote(NoteModel note){
    DatabaseProvider.db.addNewNote(note);
  }

  TextEditingController _title = TextEditingController();
  TextEditingController _notes = TextEditingController();
  DateTime date = DateTime.now();
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      floatingActionButton: FloatingActionButton.extended(
          onPressed: (){
            setState(() {
              title=_title.text;
              body= _notes.text;
              date=DateTime.now();
            });
            if (title == '' || body == ''){
              Fluttertoast.showToast(
                msg:
                'Enter full details',
                backgroundColor: Colors.white,
                gravity: ToastGravity.CENTER,
              );
            }
            else{
            NoteModel note= NoteModel(id: DateTime.now().minute+DateTime.now().microsecond+DateTime.now().millisecond,
                title: title, body: body,
                creation_date: date);
            addNote(note);
            Navigator.pop(context);
            }
          },
          label: Text('Save Notes'),
        icon: Icon(Icons.save),
      ),
      backgroundColor: Colors.black87,
      body:
      Padding(
        padding: const EdgeInsets.symmetric(vertical: 50.0, horizontal: 20.0),
        child: Center(
          child: Column(
            children: [
              TextField(
                controller: _title,
                cursorColor: Colors.white,
                decoration: InputDecoration(
                  //border: InputBorder.none,
                  hintText: "Enter Title",
                  hintStyle: TextStyle(color: Colors.white),

                ),
                style: TextStyle(color: Colors.white, fontWeight: FontWeight.bold, fontSize: 22),
              ),
              TextField(
                keyboardType: TextInputType.multiline,
                maxLines: null,
                controller: _notes,
                cursorColor: Colors.white,
                decoration: InputDecoration(
                  //border: InputBorder.none,
                  hintText: "Enter Notes",
                  hintStyle: TextStyle(color: Colors.white),

                ),
                style: TextStyle(color: Colors.white, fontWeight: FontWeight.w800, fontSize: 18),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
