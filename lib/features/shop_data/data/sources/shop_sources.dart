import 'dart:developer';

import 'package:quantify/features/shop_data/data/models/shop.dart';
import 'package:quantify/features/shop_data/domain/entities/login_params.dart';
import 'package:sqflite/sqflite.dart';

class ShopSources {
  final Database db;
  ShopSources(this.db);

  Future<ShopModel> getShopData(int id) async {
    try {
      final response = await db.transaction((txn) {
        return txn.query(
          'shops',
          where: 'id = ?',
          whereArgs: [id],
        );
      });
      final shopList =
          response.map((shop) => ShopModel.fromJson(shop)).toList();
      if (shopList.isNotEmpty) {
        return shopList.first;
      }
      throw Exception('No user found from id');
    } catch (e) {
      rethrow;
    }
  }

  Future<ShopModel> getShopDataByEmail(String email) async {
    return await db.transaction((txn) async {
      try {
        final response = await txn.query(
          'shops',
          where: 'email = ?',
          whereArgs: [email],
        );

        final shopsList =
            response.map((shop) => ShopModel.fromJson(shop)).toList();
        if (shopsList.isNotEmpty) {
          log(shopsList.first.toString());
          return shopsList.first;
        } else {
          throw Exception('No user found from email');
        }
      } catch (e) {
        rethrow;
      }
    });
  }

  Future<bool> insertShopData(ShopModel shop) async {
    try {
      final response = await db.transaction((txn) {
        return txn.insert('shops', {
          'name': shop.shopName,
          'address': shop.address ?? '',
          'phone': shop.phoneNumber,
          'start': shop.startHour,
          'end': shop.endHour,
          'email': shop.email,
          'password': shop.password,
        });
      });
      if (response != -1) {
        return true;
      }
      throw Exception('Error while adding');
    } catch (e) {
      rethrow;
    }
  }

  Future<bool> updateShopData(ShopModel shop) async {
    try {
      final response = await db.transaction((txn) {
        return txn.update(
            'shops',
            {
              'name': shop.shopName,
              'address': shop.address ?? '',
              'phone': shop.phoneNumber,
              'start': shop.startHour,
              'end': shop.endHour,
            },
            where: 'id = ?',
            whereArgs: [shop.id]);
      });
      if (response != -1) {
        return true;
      }
      throw Exception('Error while adding');
    } catch (e) {
      rethrow;
    }
  }

  Future<bool> loginShop(LoginParams params) async {
    return await db.transaction((txn) async {
      try {
        final response = await txn.query(
          'shops',
          where: 'email = ?',
          whereArgs: [params.email],
        );

        if (response.isEmpty) {
          throw ('No shop with that email');
        }

        final shop = response.map((shop) => ShopModel.fromJson(shop)).first;

        if (shop.password == params.password) {
          return true;
        } else {
          throw ('Wrong password. Please try again!');
        }
      } catch (e) {
        log('I am here with error : $e');
        rethrow;
      }
    });
  }
}
