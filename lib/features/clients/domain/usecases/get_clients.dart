import 'package:quantify/core/utils/use_case.dart';
import 'package:quantify/features/clients/domain/entity/client.dart';
import 'package:quantify/features/clients/domain/repository/clients_repository.dart';
import 'package:quantify/service_locator.dart';

class GetClientsUseCase extends UseCase<List<ClientEntity>, void> {
  @override
  Future<List<ClientEntity>> call({void params}) async {
    return await sl<ClientsRepository>().getClients();
  }
}
