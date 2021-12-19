import 'package:flutter/material.dart';
import 'package:tanglis_bible_mobileapp/db/database_provider.dart';

class ViewNotes extends StatelessWidget {
  const ViewNotes({Key? key,required this.title,required this.body,required this.id}) : super(key: key);
  final title;
  final body;
  final id;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      floatingActionButton:
      FloatingActionButton.extended(
          onPressed: (){
            DatabaseProvider.db.deleteNote(id);
            Navigator.pop(context);
          },
          label: Text('Delete Notes'),
        icon: Icon(Icons.delete),
      ),
      backgroundColor: Colors.black87,
      body: Container(
        child:
        Padding(
          padding: const EdgeInsets.all(25.0),
          child: Column(
            children: [
              SizedBox(height: 30,),
              Text('$title', style: TextStyle(color: Colors.white, fontSize: 18, fontWeight: FontWeight.bold),),
              SizedBox(height: 20,),
              Text('$body', style: TextStyle(color: Colors.white, fontSize: 16, fontWeight: FontWeight.w600),),
            ],
          ),
        ),
      ),
    );
  }
}

