import 'package:quantify/features/clients/data/model/client.dart';
import 'package:quantify/features/clients/domain/entity/update_client_data.dart';
import 'package:sqflite/sqflite.dart';

class ClientsDatasource {
  String tableName = 'clients';
  final Database db;
  ClientsDatasource(this.db);

  Future<List<ClientModel>> getClients() async {
    try {
      final response = await db.query(tableName);
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
    try {
      final result = await db.update(
        tableName,
        client.toJson(),
        where: 'id = ?',
        whereArgs: [client.id],
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

  Future<bool> clientDone(UpdateClientData data) async {
    try {
      final clients = await db.query(
        tableName,
        where: 'id = ?',
        whereArgs: [data.clientId],
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
    try {
      final result =
          await db.delete(tableName, where: 'id = ?', whereArgs: [id]);
      if (result == 1) {
        return true;
      } else {
        throw Exception('Error deleting client');
      }
    } catch (e) {
      rethrow;
    }
  }
}
