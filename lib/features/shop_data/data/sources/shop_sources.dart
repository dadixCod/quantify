import 'package:quantify/features/shop_data/data/models/shop.dart';
import 'package:sqflite/sqflite.dart';

class ShopSources {
  final Database db;
  ShopSources(this.db);

  Future<ShopModel> getShopData() async {
    try {
      final response = await db.transaction((txn) {
        return txn.query('shops');
      });
      final shopList =
          response.map((shop) => ShopModel.fromJson(shop)).toList();
      if (shopList.isNotEmpty) {
        return shopList[0];
      }
      throw Exception('No user found');
    } catch (e) {
      rethrow;
    }
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
        });
      });
      if (response != -1) {
        return true;
      }
      throw Exception ('Error while adding');
    } catch (e) {
      rethrow;
    }
  }

  Future<bool> updateShopData(ShopModel shop) async {
    try {
      final response = await db.transaction((txn) {
        return  txn.update(
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
}
