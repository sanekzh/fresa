import 'dart:convert';

class City {
  final String id;
  final String locality;
  final String zip;
  final String region1;
  final String region1_type;
  final String region2;
  final String region2_type;
  final String region3;
  final String aoid;
  final String shortname;
  final String slug;

  City._({
    this.id,
    this.locality,
    this.zip,
    this.region1,
    this.region1_type,
    this.region2,
    this.region2_type,
    this.region3,
    this.aoid,
    this.shortname,
    this.slug,
  });

  static String utf8convert(String text) {
    List<int> bytes = text
        .toString()
        .codeUnits;
    return utf8.decode(bytes);
  }

  factory City.fromJson(Map<dynamic, dynamic> json) {
    return new City._(
      id: json['id'] as String,
      locality: utf8convert(json['locality'] as String),
      zip: json['zip'] as String,
      region1: utf8convert(json['region1'] as String),
      region1_type: utf8convert(json['region1_type'] as String),
      region2: utf8convert(json['region2'] as String),
      region2_type: utf8convert(json['region2_type'] as String),
      region3: utf8convert(json['region3'] as String),
      aoid: json['aoid'] as String,
      shortname: utf8convert(json['shortname'] as String),
      slug: json['slug'] as String,
    );
  }
}

//{
//  "JSON":
//      [
//        {
//          "id":"3611199",
//          "region1":"Москва",
//          "region1_type":"г",
//          "region2":"",
//          "region2_type":"",
//          "region3":"",
//          "locality":"Москва",
//          "zip":"103070",
//          "aoid":"0c5b2444-70a0-4932-980c-b4dc0d3f02b5",
//          "shortname":"г",
//          "slug":"moskva"
//        }
//      ]
//}