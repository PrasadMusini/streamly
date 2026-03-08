import 'dart:convert';

List<Video> videoFromJson(String str) =>
    List<Video>.from(json.decode(str).map((x) => Video.fromJson(x)));

String videoToJson(List<Video> data) =>
    json.encode(List<dynamic>.from(data.map((x) => x.toJson())));

class Video {
  final String? title;
  final String? description;
  final String? subtitle;
  final String? thumb;
  final String? source;
  final int? likes;
  final DateTime? createdAt;

  Video({
    this.title,
    this.description,
    this.subtitle,
    this.thumb,
    this.source,
    this.likes,
    this.createdAt,
  });

  factory Video.fromJson(Map<String, dynamic> json) => Video(
    title: json["title"],
    description: json["description"],
    subtitle: json["subtitle"],
    thumb: json["thumb"],
    source: json["source"],
    likes: json["likes"],
    createdAt: json["createdAt"] == null
        ? null
        : DateTime.parse(json["createdAt"]),
  );

  Map<String, dynamic> toJson() => {
    "title": title,
    "description": description,
    "subtitle": subtitle,
    "thumb": thumb,
    "source": source,
    "likes": likes,
    "createdAt": createdAt?.toIso8601String(),
  };
}
