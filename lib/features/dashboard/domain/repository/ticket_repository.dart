import 'package:quantify/features/dashboard/domain/entity/ticket.dart';

abstract class TicketRepository {
  Future<List<TicketEntity>> getUndoneTickets(DateTime date);
  Future<List<TicketEntity>> getDoneTickets(DateTime date);
  Future<bool> addTicket(TicketEntity ticket);
  Future<bool> deleteTicket(int id);
  Future<bool> markDoneTicket(TicketEntity ticket);
  Future<bool> markeClientInDept(TicketEntity ticket);
  Future<bool> markeUndoneTicket(TicketEntity ticket);
  Future<bool> updateTicket(TicketEntity ticket);
}
