import 'package:intl/intl.dart';
import 'package:quantify/features/clients/data/model/client.dart';
import 'package:sqflite/sqflite.dart';
import 'package:quantify/features/dashboard/data/model/ticket.dart';

class TicketSources {
  final Database db;
  TicketSources(this.db);

  Future<List<TicketModel>> getUndoneTickets(DateTime date) async {
    final today = DateFormat('yyyy-MM-dd').format(date);
    final List<Map<String, dynamic>> maps = await db.query('tickets',
        where: 'date = ? AND isDone = ?', whereArgs: [today, 0]);

    return List.generate(maps.length, (i) {
      return TicketModel.fromJson(maps[i]);
    });
  }

  Future<List<TicketModel>> getDoneTickets(DateTime date) async {
    final today = DateFormat('yyyy-MM-dd').format(date);
    final List<Map<String, dynamic>> maps = await db.query('tickets',
        where: 'date = ? AND isDone = ?', whereArgs: [today, 1]);

    return List.generate(maps.length, (i) {
      return TicketModel.fromJson(maps[i]);
    });
  }

  Future<bool> addTicket(TicketModel ticket) async {
    return await db.transaction((txn) async {
      try {
        final todaysTickets = await txn.query(
          'tickets',
          where: 'date = ?',
          whereArgs: [ticket.date],
          orderBy: 'number DESC',
          limit: 1,
        );

        final lastTicket =
            todaysTickets.isNotEmpty ? todaysTickets.first : null;
        final number = lastTicket == null
            ? 1
            : int.parse(lastTicket['number'].toString()) + 1;

        ticket.number = number;

        // Get selected client and increment visits
        final selectedClientList = await txn.query(
          'clients',
          where: 'id = ?',
          whereArgs: [ticket.clientId],
          limit: 1,
        );
        final selectedClient = ClientModel.fromJson(selectedClientList.first);
        selectedClient.visits = (selectedClient.visits ?? 0) + 1;

        // Insert ticket and update client within transaction
        await txn.insert(
          'tickets',
          ticket.toJson(),
          conflictAlgorithm: ConflictAlgorithm.replace,
        );

        await txn.update(
          'clients',
          selectedClient.toJson(),
          where: 'id = ?',
          whereArgs: [ticket.clientId],
          conflictAlgorithm: ConflictAlgorithm.replace,
        );

        return true;
      } catch (e) {
        rethrow;
      }
    });
  }

  Future<bool> updateTicket(TicketModel ticket) async {
    try {
      final response = await db.update(
        'tickets',
        ticket.toJson(),
        where: 'id = ?',
        whereArgs: [ticket.id],
      );
      if (response == 1) {
        return true;
      } else {
        throw Exception('Error updating ticket');
      }
    } catch (e) {
      rethrow;
    }
  }

  Future<bool> deleteTicket(int id) async {
    try {
      final response = await db.delete(
        'tickets',
        where: 'id = ?',
        whereArgs: [id],
      );
      if (response == 1) {
        return true;
      } else {
        throw Exception('Error deleting ticket');
      }
    } catch (e) {
      rethrow;
    }
  }
}
