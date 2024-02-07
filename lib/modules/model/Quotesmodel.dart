import 'dart:convert';

List<QuotesModel> quotesModelFromJson(String str) => List<QuotesModel>.from(
    json.decode(str).map((x) => QuotesModel.fromJson(x)));

String quotesModelToJson(List<QuotesModel> data) =>
    json.encode(List<dynamic>.from(data.map((x) => x.toJson())));

class QuotesModel {
  int? id;
  String? category;
  List<Quote>? quotes;

  QuotesModel({
    this.id,
    this.category,
    this.quotes,
  });

  factory QuotesModel.fromJson(Map<String, dynamic> json) => QuotesModel(
        id: json["id"],
        category: json["category"],
        quotes: json["quotes"] == null
            ? []
            : List<Quote>.from(
                json["quotes"]!.map(
                  (x) => Quote.fromJson(x),
                ),
              ),
      );

  Map<String, dynamic> toJson() => {
        "id": id,
        "category": category,
        "quotes": quotes == null
            ? []
            : List<dynamic>.from(quotes!.map((x) => x.toJson())),
      };
}

class Quote {
  int? id;
  String? quote;
  String? author;
  int? favorite;

  Quote({
    this.id,
    this.quote,
    this.author,
    this.favorite,
  });

  factory Quote.fromJson(Map<String, dynamic> json) => Quote(
        id: json["id"],
        quote: json["quote"],
        author: json["author"],
        favorite: json["favorite"],
      );

  Map<String, dynamic> toJson() => {
        "id": id,
        "quote": quote,
        "author": author,
        "favorite": favorite,
      };
}
