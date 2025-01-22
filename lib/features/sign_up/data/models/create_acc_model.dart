class CreateAccountModel {
  String phone;
  String? address;
  String name;
  String? expLevel;
  String? expYear;
  String password;
  CreateAccountModel(
      {this.address,
      this.expLevel,
      this.expYear,
      required this.name,
      required this.password,
      required this.phone});
  Map<String, dynamic> toJson() {
    return {
      "phone": phone,
      "password": password,
      "displayName": name,
      if (expYear != null) "experienceYears": int.tryParse(expYear ?? "0"),
      if (address != null) "address": address,
      if (expLevel != null)
        "level": expLevel //fresh , junior , midLevel , senior
    };
  }
}
