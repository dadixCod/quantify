import 'package:quantify/core/utils/use_case.dart';
import 'package:quantify/features/shop_data/domain/entities/login_params.dart';
import 'package:quantify/features/shop_data/domain/repository/shop_repository.dart';

class LoginShopUsecase extends UseCase<bool, LoginParams> {
  final ShopRepository repository;
  LoginShopUsecase(this.repository);
  @override
  Future<bool> call({LoginParams? params}) async {
    return await repository.loginShop(params!);
  }
}
