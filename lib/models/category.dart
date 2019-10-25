//class CategoryCompany {
//  final int id;
//  final String name;
//  final List items;
//  final String created_at;
//
//  CategoryCompany._({
//    this.id,
//    this.name,
//    this.items,
//    this.created_at
//  });
//
//  factory CategoryCompany.fromJson(Map<dynamic, dynamic> json, i) {
//
//    return new CategoryCompany._(
//      id: json['id'],
//      name: json['name'] as String,
//      items: json['items'] as List,
//      created_at: json['created_at'] as String,
//    );
//  }
//}


class CategoryCompany {
  final int id;
  final String name;
  final String category_name;
  final String price;
  final String created_at;

  CategoryCompany._({
    this.id,
    this.name,
    this.category_name,
    this.price,
    this.created_at
  });

  factory CategoryCompany.fromJson(Map<dynamic, dynamic> json, i) {

    return new CategoryCompany._(
        id: json['id'],
        name: json['name'] as String,
        price: json['price'].toString(),
        created_at: json['created_at'] as String,
        category_name: i['name']
    );
  }
}