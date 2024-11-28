abstract class ShoppingCardEvent {}

class ShoppingCardDataEvent extends ShoppingCardEvent{}

class ShoppingCardProductRemoveEvent extends ShoppingCardEvent{
  int productId;

  ShoppingCardProductRemoveEvent(this.productId);
}