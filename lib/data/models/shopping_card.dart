
import 'package:isar/isar.dart';

part 'shopping_card.g.dart';

@collection
class ShoppingCard {
  Id id = Isar.autoIncrement;
    late String productId;
  late String collectionId;
  late String thumbnail;
  late int discountPrice;
  late int price;
  late String name;
  late String categoryId;
}