import 'package:hive/hive.dart';
part 'item_model.g.dart';

@HiveType(typeId: 0)
class Item extends HiveObject {
  @HiveField(0)
  String name;

  @HiveField(1)
  String description;

  @HiveField(2)
  double price;

  @HiveField(3)
  String? imagePath;

  Item({
    required this.name,
    required this.description,
    required this.price,
    this.imagePath,
  });
}