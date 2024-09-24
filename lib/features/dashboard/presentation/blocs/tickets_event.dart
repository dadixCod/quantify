import 'package:quantify/features/dashboard/domain/entity/ticket.dart';

abstract class TicketsEvent {}

class GetTicketsEvent extends TicketsEvent {
  final DateTime date;

  GetTicketsEvent({required this.date});
}

class AddTicketEvent extends TicketsEvent {
  final TicketEntity ticket;

  AddTicketEvent({required this.ticket});
}

class DeleteTicketEvent extends TicketsEvent {
  final int id;
  DeleteTicketEvent({required this.id});
}

class UpdateTicketEvent extends TicketsEvent {
  final TicketEntity ticket;

  UpdateTicketEvent({required this.ticket});
}



