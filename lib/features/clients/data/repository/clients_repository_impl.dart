import 'package:quantify/features/clients/data/model/client.dart';
import 'package:quantify/features/clients/data/sources/clients_datasource.dart';
import 'package:quantify/features/clients/domain/entity/client.dart';
import 'package:quantify/features/clients/domain/repository/clients_repository.dart';
import 'package:quantify/features/clients/shared/update_client_data.dart';

class ClientsRepositoryImpl extends ClientsRepository {
  final ClientsDatasource datasource;
  ClientsRepositoryImpl(this.datasource);
  @override
  Future<bool> addClient(ClientEntity client) async {
    final clientModel = ClientModel.fromEntity(client);
    return await datasource.addClient(clientModel);
  }

  @override
  Future<bool> clientDone(UpdateClientData data) async {
    return await datasource.clientDone(data);
  }

  @override
  Future<bool> deleteClient(int id) async {
    return await datasource.deleteClient(id);
  }

  @override
  Future<List<ClientEntity>> getClients() async {
    return await datasource.getClients();
  }

  @override
  Future<bool> updateClient(ClientEntity client) async {
    final clientModel = ClientModel.fromEntity(client);
    return await datasource.updateClient(clientModel);
  }
}
