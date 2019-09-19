import 'dart:convert';

class Street {
  final String country;
  final String country_iso_code;
  final String region_fias_id;
  final String region_kladr_id;
  final String region_with_type;
  final String region_type;
  final String region_type_full;
  final String region;
  final String city_fias_id;
  final String city_kladr_id;
  final String city_with_type;
  final String city_type;
  final String city_type_full;
  final String city;
  final String street_fias_id;
  final String street_kladr_id;
  final String street_with_type;
  final String street_type;
  final String street_type_full;
  final String street;


  Street._({
    this.country,
    this.country_iso_code,
    this.region_fias_id,
    this.region_kladr_id,
    this.region_with_type,
    this.region_type,
    this.region_type_full,
    this.region,
    this.city_fias_id,
    this.city_kladr_id,
    this.city_with_type,
    this.city_type,
    this.city_type_full,
    this.city,
    this.street_fias_id,
    this.street_kladr_id,
    this.street_with_type,
    this.street_type,
    this.street_type_full,
    this.street,

  });

  static String utf8convert(String text) {
    List<int> bytes = text
        .toString()
        .codeUnits;
    return utf8.decode(bytes);
  }

  factory Street.fromJson(Map<dynamic, dynamic> json) {
    return new Street._(
      country: json['country'] as String,
      country_iso_code:  json['country_iso_code'] as String,
      region_fias_id: json['region_fias_id'] as String,
      region_kladr_id: json['region_kladr_id'] as String,

      region_with_type: json['region_with_type'] as String,
      region_type:json['region_type'] as String,
      region_type_full: json['region3'] as String,
      region: json['region'] as String,

      city_fias_id:json['city_fias_id'] as String,
      city_kladr_id: json['city_kladr_id'] as String,
      city_with_type: json['city_with_type'] as String,
      city_type: json['region_with_type'] as String,
      city_type_full: json['city_type'] as String,
      city: json['city'] as String,

      street_fias_id: json['street_fias_id'] as String,
      street_kladr_id: json['street_kladr_id'] as String,
      street_with_type: json['street_with_type'] as String,
      street_type: json['street_type'] as String,
      street_type_full: json['street_type_full'] as String,
      street: json['street'] as String,

    );
  }
}

//JSON:
//{
//  "suggestions":
//  [
//    {
//      "value":"г Москва, Пролетарский пр-кт",
//      "unrestricted_value":"г Москва, Пролетарский пр-кт",
//      "data":
//        {
//          "postal_code":null,
//          "country":"Россия",
//          "country_iso_code":"RU",
//          "federal_district":null,
//          "region_fias_id":"0c5b2444-70a0-4932-980c-b4dc0d3f02b5",
//          "region_kladr_id":"7700000000000",
//          "region_iso_code":"RU-MOW",
//          "region_with_type":"г Москва",
//          "region_type":"г",
//          "region_type_full":"город",
//          "region":"Москва",
//          "area_fias_id":null,
//          "area_kladr_id":null,
//          "area_with_type":null,
//          "area_type":null,
//          "area_type_full":null,
//          "area":null,
//          "city_fias_id":"0c5b2444-70a0-4932-980c-b4dc0d3f02b5",
//          "city_kladr_id":"7700000000000",
//          "city_with_type":"г Москва",
//          "city_type":"г",
//          "city_type_full":"город",
//          "city":"Москва",
//          "city_area":null,
//          "city_district_fias_id":null,
//          "city_district_kladr_id":null,
//          "city_district_with_type":null,
//          "city_district_type":null,
//          "city_district_type_full":null,
//          "city_district":null,
//          "settlement_fias_id":null,
//          "settlement_kladr_id":null,
//          "settlement_with_type":null,
//          "settlement_type":null,
//          "settlement_type_full":null,
//          "settlement":null,
//          "street_fias_id":"c88cbf07-7e5b-4097-8c8f-bf079c6c138e",
//          "street_kladr_id":"77000000000238600",
//          "street_with_type":"Пролетарский пр-кт",
//          "street_type":"пр-кт",
//          "street_type_full":"проспект",
//          "street":"Пролетарский",
//          "house_fias_id":null,
//          "house_kladr_id":null,
//          "house_type":null,
//          "house_type_full":null,
//          "house":null,
//          "block_type":null,
//          "block_type_full":null,
//          "block":null,
//          "flat_type":null,
//          "flat_type_full":null,
//          "flat":null,
//          "flat_area":null,
//          "square_meter_price":null,
//          "flat_price":null,
//          "postal_box":null,
//          "fias_id":"c88cbf07-7e5b-4097-8c8f-bf079c6c138e",
//          "fias_code":null,
//          "fias_level":"7",
//          "fias_actuality_state":null,
//          "kladr_id":"77000000000238600",
//          "geoname_id":null,
//          "capital_marker":"0",
//          "okato":null,
//          "oktmo":null,
//          "tax_office":"7724",
//          "tax_office_legal":"7724",
//          "timezone":null,
//          "geo_lat":null,
//          "geo_lon":null,
//          "beltway_hit":null,
//          "beltway_distance":null,
//          "metro":null,
//          "qc_geo":null,
//          "qc_complete":null,
//          "qc_house":null,
//          "history_values":null,
//          "unparsed_parts":null,
//          "source":null,
//          "qc":null
//        }
//      }
//    ]
//  }


