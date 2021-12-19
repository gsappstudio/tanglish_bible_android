class BookmarkModel{
  int bid;
  String btitle;
  String bbody;


  BookmarkModel({required this.bid, required this.btitle, required this.bbody});

  Map<String, dynamic> toMap(){
    return({
      "bid": bid,
      "btitle": btitle,
      "bbody": bbody,
    });
  }
}