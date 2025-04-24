import 'package:admin_panel/models/booking_model.dart';

class UserModel {
  final String firstName;
  final String lastName;
  final String gender;
  final String login;
  final String password;
  final DateTime birthDate;
  final List<BookingModel> bookings;

  const UserModel({
    required this.firstName,
    required this.lastName,
    required this.gender,
    required this.login,
    required this.password,
    required this.birthDate,
    required this.bookings,
  });

  factory UserModel.fromJson(Map<String, dynamic> json) {
    return UserModel(
      firstName: json["firstName"],
      lastName: json["lastName"],
      gender: json["gender"],
      login: json["login"],
      password: json["password"],
      birthDate: _parseDate(json["birthDate"]),
      bookings:
          (json["bookings"] as Map<String, dynamic>? ?? {}).entries
              .map((e) => BookingModel.fromJson(e.value))
              .toList(),
    );
  }

  Map<String, dynamic> toJson() {
    return {
      "firstName": firstName,
      "lastName": lastName,
      "gender": gender,
      "login": login,
      "password": password,
      "birthDate": birthDate.toString(),
      "booking": bookings,
    };
  }

  static DateTime _parseDate(String dateStr) {
    try {
      return DateTime.parse(dateStr);
    } catch (_) {
      final parts = dateStr.split("-");
      if (parts.length == 3) {
        final day = int.parse(parts[0]);
        final month = int.parse(parts[1]);
        final year = int.parse(parts[2]);
        return DateTime(year, month, day);
      }
      throw FormatException("Yaroqsiz sana formati: $dateStr");
    }
  }
}
