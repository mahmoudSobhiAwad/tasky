class Country {
  String? code;
  String? name;
  String? prefix;

  Country({this.code, this.name, this.prefix});

  factory Country.fromMap(Map<String, dynamic> data) => Country(
        code: data['code'] as String?,
        name: data['name'] as String?,
        prefix: data['prefix'] as String?,
      );

  Map<String, dynamic> toMap() => {
        'code': code,
        'name': name,
        'prefix': prefix,
      };
}
