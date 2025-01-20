class FormatPhone {
  String? international;
  String? local;

  FormatPhone({this.international, this.local});

  factory FormatPhone.fromMap(Map<String, dynamic> data) => FormatPhone(
        international: data['international'] as String?,
        local: data['local'] as String?,
      );

  Map<String, dynamic> toMap() => {
        'international': international,
        'local': local,
      };

}
