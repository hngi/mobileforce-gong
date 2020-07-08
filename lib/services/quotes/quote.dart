class Quote {
  String quote;
  String author;
  String id;

  Quote({this.author, this.id, this.quote});

  Map<String, dynamic> toMap() {
      return {
        'id': id,
        'quote': quote,
        'author': author,
      };
    }


  factory Quote.fromJson(Map<String, dynamic> doc){
    return Quote(
      quote: doc['quote'],
      author: doc['author'],
      id: doc['_id']
    );
  }
}
