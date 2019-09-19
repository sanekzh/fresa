class UserModel {
  final String individualName;



  UserModel(this.individualName);

  UserModel.fromJson(Map<String, dynamic> json)
      : individualName = json['individual_name'];

  Map<String, dynamic> toJson() =>
      {
        'individual_name': individualName
      };
}