class ProfileModel {
  final String? name;
  final String? phone;
  final String? address;
  final int? experienceYear;
  final String? expLevel;
  ProfileModel(
      {this.address,
      this.expLevel,
      this.experienceYear,
      this.name,
      this.phone});

  factory ProfileModel.fromJson(Map<String, dynamic> json) {
    return ProfileModel(
      name: json['displayName'] as String,
      address: json['address'] as String,
      phone: json['username'] as String,
      expLevel: json['level'] as String,
      experienceYear: json['experienceYears'] as int,
    );
  }
}
