import 'package:quantify/core/utils/use_case.dart';
import 'package:quantify/features/clients/domain/repository/clients_repository.dart';
import 'package:quantify/service_locator.dart';

class DeleteClientUseCase extends UseCase<bool, int> {
  @override
  Future<bool> call({int? params}) async {
    return await sl<ClientsRepository>().deleteClient(params!);
  }
}
