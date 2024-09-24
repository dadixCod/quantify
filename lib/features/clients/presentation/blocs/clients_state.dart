import 'package:quantify/features/clients/domain/entity/client.dart';

abstract class ClientsState {}

class ClientsLoading extends ClientsState {}

class ClientsLoaded extends ClientsState {
  final List<ClientEntity> clients;
  ClientsLoaded({required this.clients});
}

class ClientsError extends ClientsState {
  final String message;
  ClientsError({required this.message});
}

class ClientActionLoading extends ClientsState {}

class AddClientDone extends ClientsState {}

class UpdateClientDone extends ClientsState {}

class DeleteClientDone extends ClientsState {}

class ClientDone extends ClientsState{}

class ClientActionError extends ClientsState {
  final String message;
  ClientActionError({required this.message});
}
