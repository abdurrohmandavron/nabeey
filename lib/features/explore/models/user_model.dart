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

  UserModel({
    this.asset,
    required this.id,
    required this.phone,
    required this.email,
    required this.userRole,
    required this.lastName,
    required this.firstName,
  });

  factory UserModel.fromJson(Map<String, dynamic> json) => UserModel(
        id: json["id"],
        firstName: json["firstName"],
        lastName: json["lastName"],
        email: json["email"],
        phone: json["phone"],
        userRole: json["userRole"],
        asset: json["asset"] != null ? FileModel.fromJson(json["asset"]) : FileModel(fileName: "default", filePath: "https://api.nabeey.uz/Images/e342893178ab49fd85a8570f3ba598d2.jpg"),
      );

  Map<String, dynamic> toJson() => {
        "id": id,
        "firstName": firstName,
        "lastName": lastName,
        "email": email,
        "phone": phone,
        "userRole": userRole,
        "asset": asset != null ? asset!.toJson() : FileModel(fileName: "default", filePath: "https://api.nabeey.uz/Images/e342893178ab49fd85a8570f3ba598d2.jpg").toJson(),
      };
}
