import 'package:hive_flutter/hive_flutter.dart';
part 'wishlist_item.g.dart';
@HiveType(typeId: 1)
class WishlistItem extends HiveObject{
  @HiveField(0)
  int id;
  @HiveField(1)
  String name;
  @HiveField(2)
  String image;
  @HiveField(3)
  int cookTimeMinutes;

  WishlistItem({
    required this.id,
    required this.name,
    required this.image,
    required this.cookTimeMinutes,
  });
}