import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:flutter/services.dart'as rootBundle;
import 'package:tanglis_bible_mobileapp/Screens/chapters.dart';

class BibleIndex extends StatefulWidget {
  const BibleIndex({Key? key}) : super(key: key);

  @override
  _BibleIndexState createState() => _BibleIndexState();
}

class _BibleIndexState extends State<BibleIndex> {
  @override
  Widget build(BuildContext context) {
    Future<List<Books>> ReadJsonData() async{
      final jsondata = await rootBundle.rootBundle.loadString('assets/json/bible_index.json');
      final list = json.decode(jsondata) as List<dynamic>;
      return list.map((e) => Books.fromJson(e)).toList();
    }

    return Scaffold(
      backgroundColor: Colors.black87,
      body: Center(
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
                InkWell(
                  onTap: (){
                    Navigator.of(context).push(MaterialPageRoute(builder: (context) => Chapter(bookname: items[index].tBook.toString(),)));
                  },
                  child: Container(
                  width: MediaQuery.of(context).size.width,
                  child:
                  Padding(
                    padding: const EdgeInsets.all(20.0),
                    child:
                    Column(
                      mainAxisAlignment: MainAxisAlignment.start,
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Text(items[index].tBook.toString(), style: TextStyle(color: Colors.white, fontWeight: FontWeight.w700, fontSize: 18),),
                        SizedBox(height: 8,),
                        Text(items[index].id.toString(), style: TextStyle(color: Colors.grey, fontWeight: FontWeight.w500, fontSize: 16),),

                      ],
                    ),
                  ),
              ),
                );
            });
          }
          else{
            return Center(child: CircularProgressIndicator(),);
          }
        },

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
    tBook=json['Tbook'];
    eBook==json['Ebook'];
  }


}

