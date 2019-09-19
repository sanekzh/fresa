import 'dart:convert';

class Company {
  final int id;
  final String name;
  final String balance;


  Company._({
    this.id,
    this.name,
    this.balance,
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
    );
  }
}
