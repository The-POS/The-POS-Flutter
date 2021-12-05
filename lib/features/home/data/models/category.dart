import 'package:hive/hive.dart';

part 'category.g.dart';

@HiveType(typeId: 2)
class Category {
  Category({
    required this.id,
    required this.name,
  });
  @HiveField(0)
  int id;
  @HiveField(1)
  String name;

  factory Category.fromJson(Map<String, dynamic> json) => Category(
        id: json['id'],
        name: json["name"],
      );

  Map<String, dynamic> toJson() => {
        "id": id,
        "name": name,
      };
}
