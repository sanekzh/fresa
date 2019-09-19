import 'dart:convert';

class House {
  final String postal_code;
  final String house_fias_id;
  final String house_kladr_id;
  final String house_type;
  final String house_type_full;
  final String house;
  final String street_fias_id;

  House._({
    this.postal_code,
    this.house_fias_id,
    this.house_kladr_id,
    this.house_type,
    this.house_type_full,
    this.house,
    this.street_fias_id,
  });

  static String utf8convert(String text) {
    List<int> bytes = text
        .toString()
        .codeUnits;
    return utf8.decode(bytes);
  }

  factory House.fromJson(Map<dynamic, dynamic> json) {
    return new House._(
      postal_code: json['postal_code'] as String,
      house_fias_id:  json['house_fias_id'] as String,
      house_kladr_id: json['house_kladr_id'] as String,
      house_type: json['house_type'] as String,
      house_type_full: json['house_type_full'] as String,
      house:json['house'] as String,
      street_fias_id: json['street_fias_id'] as String,
    );
  }
}



//JSON:
//{
//  "suggestions":
//  [
//{"value":"г Москва, ул Вавилова, д 1",
//"unrestricted_value":"г Москва, ул Вавилова, д 1",
//"data":
//{"postal_code":"119334",
//"country":"Россия",
//"country_iso_code":"RU",
//"federal_district":null,
//"region_fias_id":"0c5b2444-70a0-4932-980c-b4dc0d3f02b5",
//"region_kladr_id":"7700000000000",
//"region_iso_code":"RU-MOW",
//"region_with_type":"г Москва",
//"region_type":"г",
//"region_type_full":"город",
//"region":"Москва",
//"area_fias_id":null,
//"area_kladr_id":null,
//"area_with_type":null,
//"area_type":null,
//"area_type_full":null,
//"area":null,
//"city_fias_id":"0c5b2444-70a0-4932-980c-b4dc0d3f02b5",
//"city_kladr_id":"7700000000000",
//"city_with_type":"г Москва",
//"city_type":"г",
//"city_type_full":"город",
//"city":"Москва",
//"city_area":null,
//"city_district_fias_id":null,
//"city_district_kladr_id":null,
//"city_district_with_type":null,
//"city_district_type":null,
//"city_district_type_full":null,
//"city_district":null,
//"settlement_fias_id":null,
//"settlement_kladr_id":null,
//"settlement_with_type":null,
//"settlement_type":null,
//"settlement_type_full":null,
//"settlement":null,
//"street_fias_id":"25f8f29b-b110-40ab-a48e-9c72f5fb4331",
//"street_kladr_id":"77000000000092400",
//"street_with_type":"ул Вавилова",
//"street_type":"ул",
//"street_type_full":"улица",
//"street":"Вавилова",
//"house_fias_id":"c724cfa2-102f-4419-b481-e8525dfd116f",
//"house_kladr_id":"7700000000009240384",
//"house_type":"д",
//"house_type_full":"дом",
//"house":"1",
//"block_type":null,
//"block_type_full":null,
//"block":null,
//"flat_type":null,
//"flat_type_full":null,
//"flat":null,
//"flat_area":null,
//"square_meter_price":null,
//"flat_price":null,
//"postal_box":null,
//"fias_id":"c724cfa2-102f-4419-b481-e8525dfd116f",
//"fias_code":null,
//"fias_level":"8",
//"fias_actuality_state":null,
//"kladr_id":"7700000000009240384",
//"geoname_id":null,
//"capital_marker":"0",
//"okato":"45296561000",
//"oktmo":"45915000",
//"tax_office":"7725",
//"tax_office_legal":"7725",
//"timezone":null,
//"geo_lat":null,
//"geo_lon":null,
//"beltway_hit":null,
//"beltway_distance":null,
//"metro":null,
//"qc_geo":null,
//"qc_complete":null,
//"qc_house":null,
//"history_values":null,
//"unparsed_parts":null,
//"source":null,
//"qc":null}
//}
