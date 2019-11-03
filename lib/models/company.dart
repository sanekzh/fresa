import 'dart:convert';

class Company {
  final int id;
  final String name;
  final String balance;
  final List offers;
  final bool has_menu;


  Company._({
    this.id,
    this.name,
    this.balance,
    this.offers,
    this.has_menu
  });

  static String utf8convert(String text) {
    List<int> bytes = text.toString().codeUnits;
    return utf8.decode(bytes);
  }

  factory Company.fromJson(Map<dynamic, dynamic> json) {

    return new Company._(
        id: json['id'],
        name: utf8convert(json['name'] as String),
        balance: json['balance'] as String,
        offers: json['offers'] as List,
        has_menu: json['has_menu'] as bool
    );
  }
}
