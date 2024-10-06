import 'package:quantify/features/dashboard/domain/entity/ticket.dart';

abstract class TicketsState {}

class TicketsLoading extends TicketsState {}

class TicketsLoaded extends TicketsState {
  final List<TicketEntity> doneTickets;
  final List<TicketEntity> pendingTickets;

  TicketsLoaded({
    required this.doneTickets,
    required this.pendingTickets,
  });
}

class TicketsError extends TicketsState {
  final String message;

  TicketsError({required this.message});
}

class TicketActionLoading extends TicketsState {}

class AddTicketDone extends TicketsState {}

class DeleteTicketDone extends TicketsState {}

class UpdateTicketDone extends TicketsState {}

class TicketActionErreur extends TicketsState {
  final String message;

  TicketActionErreur({required this.message});
}
