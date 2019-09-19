import 'dart:convert';

class Address {
  final int id;
  final String locality;
  final String locality_id;
  final String iso;
  final String region1;
  final String region2;
  final String region3;
  final String region1_type;
  final String zip;
  final String street;
  final String street_type;
  final String building;
  final String door_number;
  final String comment;
  final String company;
  final String name;
  final String phone;

  Address._({
    this.id,
    this.locality,
    this.locality_id,
    this.iso,
    this.region1,
    this.region2,
    this.region3,
    this.region1_type,
    this.zip,
    this.street,
    this.street_type,
    this.building,
    this.door_number,
    this.comment,
    this.company,
    this.name,
    this.phone,
  });

  static String utf8convert(String text) {
    List<int> bytes = text.toString().codeUnits;
    return utf8.decode(bytes);
  }

  factory Address.fromJson(Map<dynamic, dynamic> json) {

    return new Address._(
        id: json['id'],
        locality:  utf8convert(json['locality']['locality'] as String),
        locality_id: json['locality']['id'].toString(),
        iso: json['locality']['iso'] as String,
        region1: utf8convert(json['locality']['region1'] as String),
        region2: utf8convert(json['locality']['region2'] as String),
        region3: utf8convert(json['locality']['region3'] as String),
        region1_type: utf8convert(json['locality']['region1_type'] as String),
        zip: json['zip'] as String,
        street: utf8convert(json['street'] as String),
        street_type: utf8convert(json['street_type'] as String),
        building: utf8convert(json['building'] as String),
        door_number: utf8convert(json['door_number'] as String),
        comment: utf8convert(json['comment'] as String),
        company: utf8convert(json['company'] as String),
        name: utf8convert(json['name'] as String),
        phone: utf8convert(json['phone'] as String),
    );
  }
}

//{"JSON":
//{"count":3,"next":null,"previous":null,"results":
//[
//  {
//    "id":8125825,
//    "locality":
//  {
//    "aoid":"22973a33-7a1c-449d-9535-def88bd91ed3",
//    "region2_type":"",
//    "region3_type":"",
//    "id":3615604,""
//    "locality":"Прохладный",
//    "slug":"prohladnyj",
//    "region3":"",
//    "region2":"",
//    "region1":"Кабардино-Балкарская",
//    "iso":"RU",
//    "region1_type":"Респ"
//  },
//  "zip":"361044",
//  "street":"ул Магистальная",
//  "street_type":"",
//  "building":"1",
//  "door_number":"1",
//  "comment":"Помит",
//  "company":"тьмс",
//  "name":"мао",
//  "phone":"+75455858887",
//  "usergroup":{"id":14930,"title":"Bro"},
//  "is_favorite":false,
//  "show_in_book":true,
//  "address_line_1":"",
//  "address_line_2":"",
//  "has_permissions":true,
//  "latitude":43.756247,
//  "longitude":44.073369,
//  "phone2":null,
//  "need_region2":false,
//  "phone_extension":null,
//  "phone2_extension":null,
//  "inn":null
//  }