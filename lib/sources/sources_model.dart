// To parse this JSON data, do
//
//     final sources = sourcesFromJson(jsonString);

import 'dart:convert';

Sources sourcesFromJson(String str) => Sources.fromJson(json.decode(str));

String sourcesToJson(Sources data) => json.encode(data.toJson());

class Sources {
  String status;
  List<Source> sources;

  Sources({
    this.status,
    this.sources,
  });

  factory Sources.fromJson(Map<String, dynamic> json) => new Sources(
        status: json["status"],
        sources: new List<Source>.from(
            json["sources"].map((x) => Source.fromJson(x))),
      );

  Map<String, dynamic> toJson() => {
        "status": status,
        "sources": new List<dynamic>.from(sources.map((x) => x.toJson())),
      };
}

class Source {
  String id;
  String name;
  String description;
  String url;
  Category category;
  Language language;
  Country country;

  Source({
    this.id,
    this.name,
    this.description,
    this.url,
    this.category,
    this.language,
    this.country,
  });

  factory Source.fromJson(Map<String, dynamic> json) => new Source(
        id: json["id"],
        name: json["name"],
        description: json["description"],
        url: json["url"],
        category: categoryValues.map[json["category"]],
        language: languageValues.map[json["language"]],
        country: countryValues.map[json["country"]],
      );

  Map<String, dynamic> toJson() => {
        "id": id,
        "name": name,
        "description": description,
        "url": url,
        "category": categoryValues.reverse[category],
        "language": languageValues.reverse[language],
        "country": countryValues.reverse[country],
      };
}

enum Category {
  GENERAL,
  TECHNOLOGY,
  BUSINESS,
  SPORTS,
  ENTERTAINMENT,
  HEALTH,
  SCIENCE
}

final categoryValues = new EnumValues({
  "business": Category.BUSINESS,
  "entertainment": Category.ENTERTAINMENT,
  "general": Category.GENERAL,
  "health": Category.HEALTH,
  "science": Category.SCIENCE,
  "sports": Category.SPORTS,
  "technology": Category.TECHNOLOGY
});

enum Country { US, AU, GB, CA, IT, IN, ZA, IE, IS }

final countryValues = new EnumValues({
  "au": Country.AU,
  "ca": Country.CA,
  "gb": Country.GB,
  "ie": Country.IE,
  "in": Country.IN,
  "is": Country.IS,
  "it": Country.IT,
  "us": Country.US,
  "za": Country.ZA
});

enum Language { EN }

final languageValues = new EnumValues({"en": Language.EN});

class EnumValues<T> {
  Map<String, T> map;
  Map<T, String> reverseMap;

  EnumValues(this.map);

  Map<T, String> get reverse {
    if (reverseMap == null) {
      reverseMap = map.map((k, v) => new MapEntry(v, k));
    }
    return reverseMap;
  }
}
