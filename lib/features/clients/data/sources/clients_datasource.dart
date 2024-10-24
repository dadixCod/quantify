import 'package:quantify/features/clients/data/model/client.dart';
import 'package:quantify/features/clients/shared/update_client_data.dart';
import 'package:quantify/features/dashboard/data/model/ticket.dart';
import 'package:quantify/service_locator.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:sqflite/sqflite.dart';

class ClientsDatasource {
  String tableName = 'clients';
  final Database db;
  ClientsDatasource(this.db);
  Future<List<ClientModel>> getClients() async {
    final shopId = sl<SharedPreferences>().getInt('shopId');
    try {
      final response =
          await db.query(tableName, where: 'shopId = ?', whereArgs: [shopId]);
      return response.map((e) => ClientModel.fromJson(e)).toList();
    } catch (e) {
      rethrow;
    }
  }

  Future<bool> addClient(ClientModel client) async {
    try {
      final result = await db.insert(tableName, client.toJson());
      if (result == 1) {
        return true;
      } else {
        throw Exception('Error adding client');
      }
    } catch (e) {
      rethrow;
    }
  }

  Future<bool> updateClient(ClientModel client) async {
    final shopId = sl<SharedPreferences>().getInt('shopId');
    return await db.transaction((txn) async {
      try {
        final result = await txn.update(
          tableName,
          client.toJson(),
          where: 'id = ?',
          whereArgs: [client.id],
        );
        if (result == 1) {
          //Update All Old Tickets with the same clientId
          //1. Fetching tickets
          final ticketsListMap = await txn.query(
            'tickets',
            where: 'clientId = ? AND shopID = ?',
            whereArgs: [client.id, shopId],
          );
          //2. Turning them into TicketModels
          final ticketsList = ticketsListMap
              .map((ticket) => TicketModel.fromJson(ticket))
              .toList();
          //3. Looping threw tickets with same clientId and Updating client name and phone
          for (var ticket in ticketsList) {
            final updatedTicket = TicketModel(
              id: ticket.id,
              date: ticket.date,
              time: ticket.time,
              price: ticket.price,
              dept: ticket.dept,
              clientId: ticket.clientId,
              clientName: client.name,
              clientPhone: client.phone,
              number: ticket.number,
              shopId: ticket.shopId,
              isDone: ticket.isDone,
            );
            await txn.update(
              'tickets',
              updatedTicket.toJson(),
              where: 'id = ?',
              whereArgs: [ticket.id],
            );
          }

          return true;
        } else {
          throw Exception('Error updating client');
        }
      } catch (e) {
        rethrow;
      }
    });
  }

  Future<bool> clientDone(UpdateClientData data) async {
    final shopId = sl<SharedPreferences>().getInt('shopId');
    try {
      final clients = await db.query(
        tableName,
        where: 'id = ? AND shopId = ?',
        whereArgs: [data.clientId, shopId],
      );
      final selectedClient =
          clients.map((client) => ClientModel.fromJson(client)).first;
      final oldVisitsCount = selectedClient.visits;
      final oldMoneySpent = selectedClient.totalSpent;
      final newMoneySpent = oldMoneySpent! + data.spentValue;
      final visits = oldVisitsCount! + 1;

      final result = await db.update(
        tableName,
        {
          'visits': visits,
          'totalSpent': newMoneySpent,
          'dept': selectedClient.dept,
        },
        where: 'id = ?',
        whereArgs: [data.clientId],
      );

      if (result == 1) {
        return true;
      } else {
        throw Exception('Error updating client');
      }
    } catch (e) {
      rethrow;
    }
  }

  Future<bool> deleteClient(int id) async {
    return await db.transaction((txn) async {
      try {
        final result =
            await txn.delete(tableName, where: 'id = ?', whereArgs: [id]);
        if (result == 1) {
          await txn.delete(
            'tickets',
            where: 'clientId = ?',
            whereArgs: [id],
          );
          return true;
        } else {
          throw Exception('Error deleting client');
        }
      } catch (e) {
        rethrow;
      }
    });
  }

  Future<List<ClientModel>> searchClients(String text) async {
    final shopId = sl<SharedPreferences>().getInt('shopId');
    return await db.transaction((txn) async {
      try {
        final queryClients = await txn.query(
          tableName,
          where: "name LIKE ? AND shopId = ?",
          whereArgs: ['%$text%', shopId],
        );
        final fetchedClients =
            queryClients.map((client) => ClientModel.fromJson(client)).toList();
        return fetchedClients;
      } catch (e) {
        rethrow;
      }
    });
  }
}
