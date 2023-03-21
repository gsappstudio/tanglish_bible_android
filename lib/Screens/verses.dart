import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:flutter/services.dart' as rootBundle;
import 'package:clipboard/clipboard.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:just_audio/just_audio.dart';
import 'package:share/share.dart';
import 'package:flutter_share/flutter_share.dart';
import 'package:tanglis_bible_mobileapp/Screens/notes.dart';

import '../config/adLoader.dart';
import '../db/database_provider.dart';

//
import '../db/bdatabase_provider.dart';
import '../model/note_model.dart';
import '../model/bookmark_model.dart';

class Verse extends StatefulWidget {
  const Verse({Key? key, required this.chapter, required this.booknumbers, required this.chapternumber}) : super(key: key);
  final chapter;
  final booknumbers;
  final chapternumber;

  @override
  State<Verse> createState() => _VerseState();
}

class _VerseState extends State<Verse> {
  final player_url = "https://www.wordproaudio.net/bibles/app/audio/30/1/1.mp3";
  final _audioPlayer = AudioPlayer();
  bool isPlaying = true;
  Duration duration = Duration.zero;
  Duration position = Duration.zero;
  IconData myIcon = Icons.play_arrow;

  @override
  void initState() {
    super.initState();

    String urls = "https://www.wordproaudio.net/bibles/app/audio/30/"+widget.booknumbers.toString()+"/"+widget.chapternumber.toString()+".mp3";
    //Fluttertoast.showToast(msg: urls);
    _audioPlayer.setAudioSource(AudioSource.uri(Uri.parse(urls)));
    //_audioPlayer.play();

    _audioPlayer.durationStream.listen((totalDuration) {
      duration = totalDuration ?? Duration.zero;
    });
    _audioPlayer.positionStream.listen((positions) {
      setState(() {
        position = positions;
      });
      if (positions == duration) {
        setState(() {
          isPlaying == false;
          print('ended');
        });
      }
    });
  }

  @override
  void dispose() {
    super.dispose();
    _audioPlayer.stop();
  }

  @override
  Widget build(BuildContext context) {
    final _audioplayer = AudioPlayer();
    IconData btn_icon = Icons.play_arrow;
    _audioplayer.setAudioSource(AudioSource.uri(Uri.parse(player_url)));
    Future<List<Books>> ReadJsonData() async {
      final jsondata = await rootBundle.rootBundle
          .loadString('assets/json/${widget.chapter}.json'.replaceAll(' ', ''));
      final list = json.decode(jsondata) as List<dynamic>;
      return list.map((e) => Books.fromJson(e)).toList();
    }

    addNote(NoteModel note) {
      DatabaseProvider.db.addNewNote(note);
    }

    return Scaffold(
      bottomNavigationBar: Container(
        alignment: Alignment.center,
        color: Colors.grey,
        height: 50,
        child: Row(
          crossAxisAlignment: CrossAxisAlignment.center,
          children: [
            IconButton(
                onPressed: () async {
                  print(isPlaying);
                  if (isPlaying == false) {
                    setState(() {
                      isPlaying = true;
                      duration = _audioPlayer.duration ?? Duration.zero;
                      position = _audioPlayer.position;
                      myIcon = Icons.pause;
                    });
                    print(isPlaying);
                    await _audioPlayer.play();
                    setState(() {
                      position = _audioPlayer.position;
                    });
                  } else {
                    _audioPlayer.pause();
                    setState(() {
                      isPlaying = false;
                      myIcon = Icons.play_arrow;
                    });
                    print(isPlaying);
                  }
                },
                icon: Icon(
                  myIcon,
                  size: 35,
                  color: Colors.white,
                )),
            Expanded(
                child: SizedBox(
              child: Slider(
                  thumbColor: Colors.pinkAccent,
                  activeColor: Colors.purple,
                  inactiveColor: Colors.purple.shade200,
                  min: 0,
                  max: duration.inSeconds.toDouble() + 01,
                  value: position.inSeconds.toDouble(),
                  onChanged: (value) async {
                    final seeker = Duration(seconds: value.toInt());
                    _audioPlayer.seek(seeker);
                  }),
            ))
          ],
        ),
      ),
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
                '${widget.chapter}',
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
                                                      '${widget.chapter}')
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
                                                    '${widget.chapter}',
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
                                              var note = NoteModel(
                                                  id: DateTime.now().minute +
                                                      DateTime.now()
                                                          .microsecond +
                                                      DateTime.now()
                                                          .millisecond,
                                                  title: '${widget.chapter}',
                                                  body: items[index]
                                                      .tBook
                                                      .toString()
                                                      .toUpperCase(),
                                                  creation_date:
                                                      DateTime.now());
                                              DatabaseProvider.db
                                                  .addNewNote(note);
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
                                              try {
                                                var bnote = BookmarkModel(
                                                    bid: DateTime.now().minute +
                                                        DateTime.now()
                                                            .microsecond +
                                                        DateTime.now()
                                                            .millisecond,
                                                    btitle: '${widget.chapter}',
                                                    bbody: items[index]
                                                        .tBook
                                                        .toString()
                                                        .toUpperCase());
                                                bDatabaseProvider.bdb
                                                    .addNewBookmark(bnote);
                                              } catch (e) {
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
                                items[index].tBook.toString(),
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
          SizedBox(
            height: 65,
            child: AdLoaderHere(),
          )
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
