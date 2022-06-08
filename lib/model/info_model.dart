import 'dart:convert';

List<Info> infoFromJson(String str) =>
    List<Info>.from(json.decode(str).map((x) => Info.fromJson(x)));

String infoToJson(List<Info> data) =>
    json.encode(List<dynamic>.from(data.map((x) => x.toJson())));

class Info {
  Info({
    required this.id,
    required this.title,
    required this.body,
  });

  int id;
  String title;
  String body;

  factory Info.fromJson(Map<String, dynamic> json) => Info(
        id: json["id"],
        title: json["title"],
        body: json["body"],
      );

  Map<String, dynamic> toJson() => {
        "id": id,
        "title": title,
        "body": body,
      };
}



