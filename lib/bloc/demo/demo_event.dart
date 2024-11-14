abstract class DemoEvent {}

class ProductResponseEvent extends DemoEvent{
  String categoryId;

  ProductResponseEvent(this.categoryId);
}