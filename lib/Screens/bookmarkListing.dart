import 'package:clipboard/clipboard.dart';
import 'package:flutter/material.dart';
import 'package:flutter_share/flutter_share.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:tanglis_bible_mobileapp/Screens/moreMenu.dart';
import 'package:tanglis_bible_mobileapp/Screens/verses.dart';
import 'package:tanglis_bible_mobileapp/db/bdatabase_provider.dart';
import 'package:tanglis_bible_mobileapp/main.dart';
import 'package:tanglis_bible_mobileapp/model/bookmark_model.dart';

import 'add_notes.dart';

class BookMarkListing extends StatefulWidget {
  const BookMarkListing({Key? key}) : super(key: key);

  @override
  _BookMarkListingState createState() => _BookMarkListingState();
}

class _BookMarkListingState extends State<BookMarkListing> {
  getBookmark() async{
    final notes = await bDatabaseProvider.bdb.getBookmark();
    return notes;
  }

  @override
  Widget build(BuildContext context) {
    return
       Scaffold(

        backgroundColor: Colors.black87,
        body:Column(
          children: [
            Expanded(
              child: FutureBuilder(
                  future: getBookmark(),
                  builder: (context, noteData) {
                    if(noteData.connectionState == ConnectionState.waiting){
                      return Center(child: CircularProgressIndicator(),);
                    }
                    else{
                      if(noteData.data == Null){
                        //var items = noteData.data as List<NoteModel>;
                        return Center(child:  Text('There is no Bookmark added yet', style: TextStyle(color: Colors.white),),);
                      }
                      else {
                        var items = noteData.data as List<dynamic>;
                        return
                         Padding(
                           padding: const EdgeInsets.all(8.0),
                           child: ListView.builder(
                             itemCount: items.length,
                             itemBuilder: (context, index)
                             {
                               return
                                 Column(
                                   children: [
                                     ListTile(
                                       onLongPress: (){
                                         showModalBottomSheet(context: context,
                                             shape: RoundedRectangleBorder(
                                               borderRadius: BorderRadius.only(
                                                   topRight: Radius.circular(20),
                                                   topLeft: Radius.circular(20)),
                                             ),
                                             builder: (context){
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
                                                     backgroundColor: Colors.white,
                                                     gravity: ToastGravity.CENTER,
                                                   );
                                                   FlutterClipboard.copy(
                                                       items[index]['bbody']+items[index]['btitle']
                                                   )
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
                                                     text: items[index]['bbody']+items[index]['btitle'],
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
                                                   "DELETE",
                                                   style: TextStyle(
                                                       color: Colors.grey[800],
                                                       fontWeight: FontWeight.bold),
                                                 ),
                                                 leading: Icon(Icons.delete),
                                                 onTap: (){
                                                   bDatabaseProvider.bdb.deleteBookmark(items[index]['bid']);
                                                   Navigator.of(context).push(MaterialPageRoute(builder: (context) => MyApp()));
                                                 },
                                               )

                                             ],
                                           );
                                         });
                                       },
                                       onTap: (){
                                         Navigator.of(context).push(MaterialPageRoute(builder: (context) => Verse(chapter: items[index]['btitle'].toString(),)));
                                       },
                                     title: Text(items[index]['bbody'], style: TextStyle(color: Colors.white, fontWeight: FontWeight.bold, fontSize: 16),),
                                     subtitle: Text(items[index]['btitle'], style: TextStyle(color: Colors.grey,fontWeight: FontWeight.w800),),
                               ),
                                     Divider(color: Colors.white,)
                                   ],
                                 );
                             }

                           ),

                         );
                      }
                    }

                  }),
            )
          ],
        ),

      );
  }

}
