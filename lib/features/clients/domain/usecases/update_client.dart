import 'package:quantify/core/utils/use_case.dart';
import 'package:quantify/features/clients/domain/entity/client.dart';
import 'package:quantify/features/clients/domain/repository/clients_repository.dart';
import 'package:quantify/service_locator.dart';

class UpdateClientUseCase extends UseCase<bool, ClientEntity> {
  @override
  Future<bool> call({ClientEntity? params}) async {
    return await sl<ClientsRepository>().updateClient(params!);
  }
}
