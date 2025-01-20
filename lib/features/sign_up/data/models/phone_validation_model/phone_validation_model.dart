import 'country.dart';
import 'format.dart';

class PhoneValidationModel {
  String? phone;
  bool? valid;
  FormatPhone? format;
  Country? country;
  String? location;
  String? type;
  String? carrier;

  PhoneValidationModel({
    this.phone,
    this.valid,
    this.format,
    this.country,
    this.location,
    this.type,
    this.carrier,
  });

  factory PhoneValidationModel.fromMap(Map<String, dynamic> data) {
    return PhoneValidationModel(
      phone: data['phone'] as String?,
      valid: data['valid'] as bool?,
      format: data['format'] == null
          ? null
          : FormatPhone.fromMap(data['format'] as Map<String, dynamic>),
      country: data['country'] == null
          ? null
          : Country.fromMap(data['country'] as Map<String, dynamic>),
      location: data['location'] as String?,
      type: data['type'] as String?,
      carrier: data['carrier'] as String?,
    );
  }

  Map<String, dynamic> toMap() => {
        'phone': phone,
        'valid': valid,
        'format': format?.toMap(),
        'country': country?.toMap(),
        'location': location,
        'type': type,
        'carrier': carrier,
      };
}
