import 'package:quantify/core/utils/use_case.dart';
import 'package:quantify/features/clients/domain/entity/update_client_data.dart';
import 'package:quantify/features/clients/domain/repository/clients_repository.dart';
import 'package:quantify/service_locator.dart';

class ClientDoneUseCase extends UseCase<bool, UpdateClientData> {
  @override
  Future<bool> call({UpdateClientData? params}) async {
    return await sl<ClientsRepository>().clientDone(params!);
  }
}
