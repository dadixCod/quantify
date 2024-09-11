import 'package:quantify/core/utils/use_case.dart';
import 'package:quantify/features/shop_data/domain/entities/Shop.dart';
import 'package:quantify/features/shop_data/domain/repository/shop_repository.dart';

class UpdateShopUsecase extends UseCase<bool, ShopEntity> {
  final ShopRepository repository;
  UpdateShopUsecase(this.repository);
  @override
  Future<bool> call({ShopEntity? params}) async {
    return await repository.updateShopData(params!);
  }
}
