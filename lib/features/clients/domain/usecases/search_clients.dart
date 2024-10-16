import 'package:quantify/core/utils/use_case.dart';
import 'package:quantify/features/clients/domain/entity/client.dart';
import 'package:quantify/features/clients/domain/repository/clients_repository.dart';
import 'package:quantify/service_locator.dart';

class SearchClientsUseCase extends UseCase<List<ClientEntity>, String> {
  @override
  Future<List<ClientEntity>> call({String? params}) async {
    return await sl<ClientsRepository>().searchClients(params!);
  }
}
