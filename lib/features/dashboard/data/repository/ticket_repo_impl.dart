import 'package:quantify/features/dashboard/data/model/ticket.dart';
import 'package:quantify/features/dashboard/data/sources/ticket_sources.dart';
import 'package:quantify/features/dashboard/domain/entity/ticket.dart';
import 'package:quantify/features/dashboard/domain/repository/ticket_repository.dart';

class TicketRepositoryImpl extends TicketRepository {
  final TicketSources datasources;

  TicketRepositoryImpl(this.datasources);

  @override
  Future<bool> addTicket(TicketEntity ticket) async {
    final ticketModel = TicketModel.fromEntity(ticket);
    return await datasources.addTicket(ticketModel);
  }

  @override
  Future<bool> deleteTicket(int id) async {
    return await datasources.deleteTicket(id);
  }

  @override
  Future<List<TicketEntity>> getDoneTickets(DateTime date) async {
    return await datasources.getDoneTickets(date);
  }

  @override
  Future<List<TicketEntity>> getUndoneTickets(DateTime date) async {
    return await datasources.getUndoneTickets(date);
  }

  @override
  Future<bool> markDoneTicket(TicketEntity ticket) async {
    final ticketModel = TicketModel.fromEntity(ticket);
    return await datasources.markDoneTicket(ticketModel);
  }

  @override
  Future<bool> markeClientInDept(TicketEntity ticket) async {
    final ticketModel = TicketModel.fromEntity(ticket);
    return await datasources.markClientInDept(ticketModel);
  }

  @override
  Future<bool> markeUndoneTicket(TicketEntity ticket) async {
    final ticketModel = TicketModel.fromEntity(ticket);
    return await datasources.markUnDoneTicket(ticketModel);
  }

  @override
  Future<bool> updateTicket(TicketEntity ticket) async {
    final ticketModel = TicketModel.fromEntity(ticket);
    return await datasources.updateTicket(ticketModel);
  }
}
