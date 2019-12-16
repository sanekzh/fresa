
class CategoryCompany {
  final int id;
  final String name;
  final String category_name;
  final String price;
  final String created_at;
  final String description;

  CategoryCompany._({
    this.id,
    this.name,
    this.category_name,
    this.price,
    this.created_at,
    this.description
  });

  factory CategoryCompany.fromJson(Map<dynamic, dynamic> json, i) {

    return new CategoryCompany._(
        id: json['id'],
        name: json['name'] as String,
        price: json['price'].toString(),
        created_at: json['created_at'] as String,
        category_name: i['name'],
        description: json['description'] as String,
    );
  }
}