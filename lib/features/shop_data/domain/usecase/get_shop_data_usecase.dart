import 'package:quantify/core/utils/use_case.dart';
import 'package:quantify/features/shop_data/domain/entities/Shop.dart';
import 'package:quantify/features/shop_data/domain/repository/shop_repository.dart';


class GetShopDataByIdUsecase extends UseCase<ShopEntity, int> {
  final ShopRepository repository;
  GetShopDataByIdUsecase(this.repository);
  @override
  Future<ShopEntity> call({int? params}) async {
    return await repository.getShopData(params!);
  }
}
