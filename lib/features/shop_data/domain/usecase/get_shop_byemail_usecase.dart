import 'package:quantify/core/utils/use_case.dart';
import 'package:quantify/features/shop_data/domain/entities/Shop.dart';
import 'package:quantify/features/shop_data/domain/repository/shop_repository.dart';

class GetShopDataByEmailUseCase extends UseCase<ShopEntity, String> {
  final ShopRepository repository;
  GetShopDataByEmailUseCase(this.repository);

  @override
  Future<ShopEntity> call({String? params}) async {
    return await repository.getShopDataByEmail(params!);
  }
}
