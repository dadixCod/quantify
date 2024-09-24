import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:quantify/features/clients/domain/usecases/add_client.dart';
import 'package:quantify/features/clients/domain/usecases/client_done.dart';
import 'package:quantify/features/clients/domain/usecases/delete_client.dart';
import 'package:quantify/features/clients/domain/usecases/get_clients.dart';
import 'package:quantify/features/clients/domain/usecases/update_client.dart';
import 'package:quantify/features/clients/presentation/blocs/clients_event.dart';
import 'package:quantify/features/clients/presentation/blocs/clients_state.dart';
import 'package:quantify/service_locator.dart';

class ClientsBloc extends Bloc<ClientsEvent, ClientsState> {
  ClientsBloc() : super(ClientsLoading()) {
    on<GetClientsEvent>((event, emit) async {
      emit(ClientsLoading());
      try {
        final clients = await sl<GetClientsUseCase>().call();
        emit(ClientsLoaded(clients: clients));
      } catch (e) {
        emit(ClientsError(message: e.toString()));
      }
    });
    on<AddClientEvent>((event, emit) async {
      emit(ClientActionLoading());
      try {
        await sl<AddClientUseCase>().call(params: event.client);
        emit(AddClientDone());
      } catch (e) {
        emit(ClientActionError(message: e.toString()));
      }
    });
    on<UpdateClientEvent>((event, emit) async {
            emit(ClientActionLoading());
      try {
        await sl<UpdateClientUseCase>().call(params: event.client);
        emit(UpdateClientDone());
      } catch (e) {
        emit(ClientActionError(message: e.toString()));
      }
    });

    on<DeleteClientEvent>((event, emit) async {
            emit(ClientActionLoading());
      try {
        await sl<DeleteClientUseCase>().call(params: event.id);
        emit(DeleteClientDone());
      } catch (e) {
        emit(ClientActionError(message: e.toString()));
      }
    });
    on<ClientDoneEvent>((event, emit) async {
      emit(ClientActionLoading());
      try {
        await sl<ClientDoneUseCase>().call(params: event.updateData);
        emit(ClientDone());
      } catch (e) {
        emit(ClientActionError(message: e.toString()));
      }
    });
  }
}
