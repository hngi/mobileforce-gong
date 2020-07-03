class Quote {
  String quote;
  String author;
  String id;

  Quote({this.author, this.id, this.quote});


  factory Quote.fromJson(Map<String, dynamic> doc){
    return Quote(
      quote: doc['quote'],
      author: doc['author'],
      id: doc['_id']
    );
  }
}