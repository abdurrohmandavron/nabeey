import 'package:hive/hive.dart';
import 'package:nabeey/data/models/file_model.dart';

part 'user_model.g.dart';

@HiveType(typeId: 1)
class UserModel extends HiveObject {
  @HiveField(1)
  final int id;

  @HiveField(2)
  final String firstName;

  @HiveField(3)
  final String lastName;

  @HiveField(4)
  final String email;

  @HiveField(5)
  final String phone;

  @HiveField(6)
  final int userRole;

  @HiveField(7)
  final FileModel? asset;

  // Constructor
  UserModel({
    required this.id,
    required this.firstName,
    required this.lastName,
    required this.email,
    required this.phone,
    required this.userRole,
    this.asset,
  });

  // Factory constructor for JSON deserialization
  factory UserModel.fromJson(Map<String, dynamic>? json) {
    if (json == null) return UserModel.empty();

    return UserModel(
      id: json["id"] ?? 0,
      firstName: json["firstName"] ?? '',
      lastName: json["lastName"] ?? '',
      email: json["email"] ?? '',
      phone: json["phone"] ?? '',
      userRole: json["userRole"] ?? 0,
      asset: json["asset"] != null ? FileModel.fromJson(json["asset"]) : null,
    );
  }

  // Method to serialize to JSON
  Map<String, String> toJson({String? password}) {
    final Map<String, String> json = {
      "firstName": firstName,
      "lastName": lastName,
      "email": email,
      "phone": phone,
      // "userRole": userRole,
      // "asset": asset?.toJson(),
    };

    if (password != null) {
      json["password"] = password;
    } else {
      // json["id"] = id;
    }

    return json;
  }

  // Static method to provide an empty instance
  factory UserModel.empty() {
    return UserModel(
      id: 0,
      firstName: '',
      lastName: '',
      email: '',
      phone: '',
      userRole: 0,
      asset: null,
    );
  }
}
