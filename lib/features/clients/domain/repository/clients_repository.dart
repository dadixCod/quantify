import 'package:quantify/features/clients/domain/entity/client.dart';
import 'package:quantify/features/clients/domain/entity/update_client_data.dart';

abstract class ClientsRepository {

  Future<List<ClientEntity>> getClients();

  Future<bool> addClient(ClientEntity client);

  Future<bool> updateClient(ClientEntity client);

  Future<bool> clientDone(UpdateClientData data);


  Future<bool> deleteClient(int id);
}