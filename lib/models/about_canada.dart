import 'package:meta/meta.dart';
import 'dart:convert';

String aboutCanadaToJson(AboutCanada data) => json.encode(data.toJson());

class AboutCanada {
  AboutCanada({
    required this.title,
    required this.description,
    required this.imageHref,
    required this.imagevalid
  });

  final String? title;
  final String? description;
  final String? imageHref;
  final bool imagevalid;

  factory AboutCanada.fromJson(Map<String, dynamic> json, bool imagevalid) => AboutCanada(
        title: json["title"],
        description: json["description"],
        imageHref: json["imageHref"],
        imagevalid: imagevalid
      );

  Map<String, dynamic> toJson() => {
        "title": title,
        "description": description,
        "imageHref": imageHref,
      };
}
