
import 'package:isar/isar.dart';

part 'card.g.dart';

@collection
class Card {
  Id id = Isar.autoIncrement;
    late String productId;
  late String collectionId;
  late String thumbnail;
  late int discountPrice;
  late int price;
  late String popularity;
  late String name;
  late String categoryId;
}