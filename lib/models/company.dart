

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

  factory Company.fromJson(Map<dynamic, dynamic> json) {

    return new Company._(
        id: json['id'],
        name: json['name'] as String,
        balance: json['balance'] as String,
        offers: json['offers'] as List,
        has_menu: json['has_menu'] as bool
    );
  }
}
