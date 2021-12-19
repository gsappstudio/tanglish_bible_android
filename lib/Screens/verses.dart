import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:flutter/services.dart' as rootBundle;
import 'package:clipboard/clipboard.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:share/share.dart';
import 'package:flutter_share/flutter_share.dart';
import 'package:tanglis_bible_mobileapp/Screens/notes.dart';

import '../db/database_provider.dart';
//
import '../db/bdatabase_provider.dart';
import '../model/note_model.dart';
import '../model/bookmark_model.dart';

class Verse extends StatelessWidget {
  const Verse({Key? key, required this.chapter}) : super(key: key);
  final chapter;
  @override
  Widget build(BuildContext context) {

    Future<List<Books>> ReadJsonData() async {
      final jsondata = await rootBundle.rootBundle
          .loadString('assets/json/$chapter.json'.replaceAll(' ', ''));
      final list = json.decode(jsondata) as List<dynamic>;
      return list.map((e) => Books.fromJson(e)).toList();
    }
    addNote(NoteModel note){
      DatabaseProvider.db.addNewNote(note);
    }

    return Scaffold(

      backgroundColor: Colors.black87,
      body: Center(
          child: Column(
        children: [
          SizedBox(
            height: 35,
          ),
          Container(
            alignment: Alignment.center,
            child: Padding(
              padding: const EdgeInsets.fromLTRB(0.0, 15.0, 0.0, 0.0),
              child: Text(
                '$chapter',
                style: TextStyle(
                    color: Colors.white,
                    fontSize: 20,
                    fontWeight: FontWeight.bold),
              ),
            ),
          ),
          Expanded(
            child: FutureBuilder(
              future: ReadJsonData(),
              builder: (BuildContext context, data) {
                if (data.hasError) {
                  return Center(
                    child: Text("${data.error}",
                        style: TextStyle(color: Colors.white)),
                  );
                } else if (data.hasData) {
                  var items = data.data as List<Books>;
                  return ListView.builder(
                      itemCount: items.length,
                      itemBuilder: (context, index) {
                        return Column(
                          children: [
                            ListTile(
                              onLongPress: () {
                                showModalBottomSheet(
                                    shape: RoundedRectangleBorder(
                                      borderRadius: BorderRadius.only(
                                          topRight: Radius.circular(20),
                                          topLeft: Radius.circular(20)),
                                    ),
                                    context: context,
                                    builder: (context) {
                                      return Column(
                                        children: [
                                          ListTile(
                                            title: Text(
                                              "COPY",
                                              style: TextStyle(
                                                  color: Colors.grey[800],
                                                  fontWeight: FontWeight.bold),
                                            ),
                                            leading: Icon(Icons.copy),
                                            onTap: () {
                                              Fluttertoast.showToast(
                                                msg:
                                                    'Verse Copied to Clipboard',

                                              );
                                              FlutterClipboard.copy(items[index]
                                                          .tBook
                                                          .toString()
                                                          .toUpperCase() +
                                                      '$chapter')
                                                  .then(
                                                (value) =>
                                                    Navigator.pop(context),
                                              );
                                            },
                                          ),
                                          Divider(),
                                          ListTile(
                                            title: Text(
                                              "Share",
                                              style: TextStyle(
                                                  color: Colors.grey[800],
                                                  fontWeight: FontWeight.bold),
                                            ),
                                            leading: Icon(Icons.share),
                                            onTap: () {
                                              FlutterShare.share(
                                                title:
                                                    'Shared from Tanglish Bible',
                                                text: items[index]
                                                        .tBook
                                                        .toString()
                                                        .toUpperCase() +
                                                    '$chapter',
                                                linkUrl:
                                                    'http://tanglishbible.com/#/',
                                                //chooserTitle: 'Example Chooser Title'
                                              );

                                              Navigator.pop(context);
                                            },
                                          ),
                                          Divider(),
                                          ListTile(
                                            title: Text(
                                              "Add to Notes",
                                              style: TextStyle(
                                                  color: Colors.grey[800],
                                                  fontWeight: FontWeight.bold),
                                            ),
                                            leading: Icon(Icons.note_add),
                                            onTap: () {

                                              var note= NoteModel(id: DateTime.now().minute+DateTime.now().microsecond+DateTime.now().millisecond,
                                                  title: '$chapter', body: items[index].tBook.toString().toUpperCase(), creation_date: DateTime.now());
                                              DatabaseProvider.db.addNewNote(note);
                                              Fluttertoast.showToast(
                                                msg:
                                                'Added to Notes Successfully',

                                              );
                                              Navigator.pop(context);

                                            },
                                          ),
                                          Divider(),
                                          ListTile(
                                            title: Text(
                                              "Bookmark",
                                              style: TextStyle(
                                                  color: Colors.grey[800],
                                                  fontWeight: FontWeight.bold),
                                            ),
                                            leading: Icon(Icons.bookmark),
                                            onTap: () {
                                              try{
                                                var bnote=BookmarkModel(
                                                    bid: DateTime.now().minute+DateTime.now().microsecond+DateTime.now().millisecond,
                                                    btitle: '$chapter',
                                                    bbody: items[index].tBook.toString().toUpperCase());
                                                bDatabaseProvider.bdb.addNewBookmark(bnote);
                                              }
                                              catch(e){
                                                print(e.toString());
                                              }
                                                  Fluttertoast.showToast(
                                              msg:
                                              'Verse Bookmarked Successfully',

                                              );
                                              Navigator.pop(context);


                                            },
                                          ),
                                        ],
                                      );
                                    });
                              },
                              title: Text(
                                items[index].tBook.toString().toUpperCase(),
                                style: TextStyle(
                                    color: Colors.white,
                                    fontWeight: FontWeight.w500,
                                    fontSize: 18),
                              ),
                            ),
                            Divider(
                              color: Colors.white,
                              indent: 15,
                              endIndent: 15,
                            )
                          ],
                        );
                      });
                } else {
                  return Center(
                    child: CircularProgressIndicator(),
                  );
                }
              },
            ),
          ),
        ],
      )),
    );
  }
}


class Books {
  String? tBook;
  String? eBook;
  String? id;

  Books(this.tBook, this.eBook, this.id);
  Books.fromJson(Map<String, dynamic> json) {
    id = json['Ebook'];
    tBook = json['Verses'];
    eBook == json['Ebook'];
  }
}

