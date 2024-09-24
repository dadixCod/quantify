import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:quantify/features/dashboard/domain/usecase/add_ticket.dart';
import 'package:quantify/features/dashboard/domain/usecase/delete_ticket.dart';
import 'package:quantify/features/dashboard/domain/usecase/get_done_tickets.dart';
import 'package:quantify/features/dashboard/domain/usecase/get_undone_tickets.dart';
import 'package:quantify/features/dashboard/domain/usecase/update_ticket.dart';
import 'package:quantify/features/dashboard/presentation/blocs/tickets_event.dart';
import 'package:quantify/features/dashboard/presentation/blocs/tickets_state.dart';
import 'package:quantify/service_locator.dart';

class TicketsBloc extends Bloc<TicketsEvent, TicketsState> {
  TicketsBloc() : super(TicketsLoading()) {
    on<GetTicketsEvent>((event, emit) async {
      try {
        final doneTickets =
            await sl<GetDoneTicketsUseCase>().call(params: event.date);
        final undoneTickets =
            await sl<GetUndoneTicketsUseCase>().call(params: event.date);
        emit(TicketsLoaded(
            doneTickets: doneTickets, undoneTickets: undoneTickets));
      } catch (e) {
        emit(TicketsError(message: e.toString()));
      }
    });
    on<AddTicketEvent>((event, emit) async {
      emit(TicketActionLoading());
      try {
        await sl<AddTicketUseCase>().call(params: event.ticket);
        emit(AddTicketDone());
      } catch (e) {
        emit(TicketActionErreur(message: e.toString()));
      }
    });
    on<DeleteTicketEvent>((event, emit) async {
      emit(TicketActionLoading());
      try {
        await sl<DeleteTicketUseCase>().call(params: event.id);
        emit(DeleteTicketDone());
      } catch (e) {
        emit(TicketActionErreur(message: e.toString()));
      }
    });
    on<UpdateTicketEvent>((event, emit) async {
      emit(TicketActionLoading());
      try {
        await sl<UpdateTicketUseCase>().call(params: event.ticket);
        emit(UpdateTicketDone());
      } catch (e) {
        emit(TicketActionErreur(message: e.toString()));
      }
    });
  }
}
