import 'dart:developer';

import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:quantify/features/dashboard/domain/usecase/add_ticket.dart';
import 'package:quantify/features/dashboard/domain/usecase/delete_ticket.dart';
import 'package:quantify/features/dashboard/domain/usecase/get_done_tickets.dart';
import 'package:quantify/features/dashboard/domain/usecase/get_undone_tickets.dart';
import 'package:quantify/features/dashboard/domain/usecase/mark_dept.dart';
import 'package:quantify/features/dashboard/domain/usecase/mark_undone.dart';
import 'package:quantify/features/dashboard/domain/usecase/mark_done_ticket.dart';
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
        final pendingTickets =
            await sl<GetUndoneTicketsUseCase>().call(params: event.date);

        emit(TicketsLoaded(
            doneTickets: doneTickets, pendingTickets: pendingTickets));
      } catch (e) {
        log("Error $e");
        emit(TicketsError(message: e.toString()));
      }
    });
    on<AddTicketEvent>((event, emit) async {
      emit(TicketActionLoading());
      try {
        await sl<AddTicketUseCase>().call(params: event.ticket);
        emit(TicketActionDone());
      } catch (e) {
        log("Error addding : ${e.toString()}");
        emit(TicketActionErreur(message: e.toString()));
      }
    });
    on<DeleteTicketEvent>((event, emit) async {
      emit(TicketActionLoading());
      try {
        await sl<DeleteTicketUseCase>().call(params: event.id);
        emit(TicketActionDone());
      } catch (e) {
        emit(TicketActionErreur(message: e.toString()));
      }
    });
    on<MarkDoneTicketEvent>((event, emit) async {
      emit(TicketActionLoading());
      try {
        await sl<MarkDoneTicketUseCase>().call(params: event.ticket);
        emit(TicketActionDone());
      } catch (e) {
        log(e.toString());
        emit(TicketActionErreur(message: e.toString()));
      }
    });
    on<MarkClientDept>((event, emit) async {
      emit(TicketActionLoading());
      try {
        await sl<MarkClientInDeptUseCase>().call(params: event.ticket);
        emit(TicketActionDone());
      } catch (e) {
        log(e.toString());
        emit(TicketActionErreur(message: e.toString()));
      }
    });
    on<MarkUndoneTicket>((event, emit) async {
      emit(TicketActionLoading());
      try {
        await sl<MarkUndoneTicketUseCase>().call(params: event.ticket);
        emit(TicketActionDone());
      } catch (e) {
        log(e.toString());
        emit(TicketActionErreur(message: e.toString()));
      }
    });
    on<UpdateTicketEvent>((event, emit) async {
      emit(TicketActionLoading());
      try {
        await sl<UpdateTicketUseCase>().call(params: event.ticket);
        emit(TicketActionDone());
      } catch (e) {
        log(e.toString());
        emit(TicketActionErreur(message: e.toString()));
      }
    });
  }
}
