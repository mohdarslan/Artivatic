import 'package:meta/meta.dart';
import 'dart:convert';

AboutCanada aboutCanadaFromJson(String str) => AboutCanada.fromJson(json.decode(str));

String aboutCanadaToJson(AboutCanada data) => json.encode(data.toJson());

class AboutCanada {
    AboutCanada({
        required this.title,
        required this.description,
        required this.imageHref,
    });

    final String? title;
    final String? description;
    final String? imageHref;

    factory AboutCanada.fromJson(Map<String, dynamic> json) => AboutCanada(
        title: json["title"],
        description: json["description"],
        imageHref: json["imageHref"],
    );

    Map<String, dynamic> toJson() => {
        "title": title,
        "description": description,
        "imageHref": imageHref,
    };
}
