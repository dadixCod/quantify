import 'package:quantify/features/shop_data/domain/entities/Shop.dart';

abstract class ShopState {}

class ShopInitial extends ShopState {}

class ShopNull extends ShopState{}

class ShopLoading extends ShopState {}

class ShopLoaded extends ShopState {
  final ShopEntity shop;
  ShopLoaded({required this.shop});
}

class ShopAdded extends ShopState{}
class ShopUpdated extends ShopState{}

class ShopError extends ShopState {
  final String message;
  ShopError({required this.message});
}
