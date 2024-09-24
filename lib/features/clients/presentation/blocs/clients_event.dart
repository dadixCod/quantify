import 'package:quantify/features/clients/domain/entity/client.dart';
import 'package:quantify/features/clients/domain/entity/update_client_data.dart';

abstract class ClientsEvent {}

class GetClientsEvent extends ClientsEvent {}

class AddClientEvent extends ClientsEvent {
  final ClientEntity client;
  AddClientEvent({required this.client});
}

class UpdateClientEvent extends ClientsEvent {
  final ClientEntity client;
  UpdateClientEvent({required this.client});
}

class DeleteClientEvent extends ClientsEvent {
  final int id;
  DeleteClientEvent({required this.id});
}

class ClientDoneEvent extends ClientsEvent {
  final UpdateClientData updateData;
  ClientDoneEvent({required this.updateData});
}
