import 'package:quantify/core/utils/use_case.dart';
import 'package:quantify/features/shop_data/domain/entities/Shop.dart';
import 'package:quantify/features/shop_data/domain/repository/shop_repository.dart';


class GetShopDataUsecase extends UseCase<ShopEntity, void> {
  final ShopRepository repository;
  GetShopDataUsecase(this.repository);
  @override
  Future<ShopEntity> call({void params}) async {
    return await repository.getShopData();
  }
}
