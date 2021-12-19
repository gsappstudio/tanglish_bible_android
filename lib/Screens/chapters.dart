import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:flutter/services.dart'as rootBundle;
import 'package:tanglis_bible_mobileapp/Screens/verses.dart';


class Chapter extends StatelessWidget {
  const Chapter({Key? key, required this.bookname}) : super(key: key);
  final bookname;
  @override
  Widget build(BuildContext context) {
    Future<List<Books>> ReadJsonData() async{
      final jsondata = await rootBundle.rootBundle.loadString('assets/json/$bookname.json'.replaceAll(' ', ''));
      final list = json.decode(jsondata) as List<dynamic>;
      return list.map((e) => Books.fromJson(e)).toList();
    }

    return Scaffold(
      backgroundColor: Colors.black87,
      body: Center(
          child:
          Column(
            children: [
              SizedBox(height: 35,),
              Container(
                alignment: Alignment.center,

                child:
                Padding(
                  padding: const EdgeInsets.fromLTRB(0.0,15.0,0.0,0.0),
                  child: Text('$bookname', style: TextStyle(color: Colors.white, fontSize: 20, fontWeight: FontWeight.bold),),
                ),
              ),

              Expanded(
                child: FutureBuilder(
                  future: ReadJsonData(),
                  builder: (
                      BuildContext context, data) {
                    if(data.hasError){
                      return Center(child: Text("${data.error}", style: TextStyle(color: Colors.white)),);
                    }
                    else if (data.hasData){
                      var items = data.data as List<Books>;
                      return ListView.builder(
                          itemCount: items.length,
                          itemBuilder: (context, index){
                            return
                              Column(
                                children: [
                                  ListTile(
                                    onTap: (){
                                      Navigator.of(context).push(MaterialPageRoute(builder: (context) => Verse(chapter: items[index].tBook.toString(),)));
                                    },
                                    title: Text(items[index].tBook.toString(), style: TextStyle(color: Colors.white, fontWeight: FontWeight.w700, fontSize: 18),),

                                  ),
                                  Divider(color: Colors.white,indent: 15, endIndent: 15,)
                                ],
                              );
                          });
                    }
                    else{
                      return Center(child: CircularProgressIndicator(),);
                    }
                  },

                ),
              ),
            ],
          )
      ),
    );
  }
}

class Books{
  String? tBook;
  String? eBook;
  String? id;

  Books(this.tBook, this.eBook, this.id);
  Books.fromJson(Map<String,dynamic> json){
    id=json['Ebook'];
    tBook=json['Chapters'];
    eBook==json['Ebook'];
  }


}
