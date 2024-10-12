import 'package:quantify/features/clients/domain/entity/client.dart';

class ClientModel extends ClientEntity {
  ClientModel({
    super.id,
    required super.name,
    required super.phone,
    super.visits,
    super.totalSpent,
    super.dept,
  });

  factory ClientModel.fromJson(Map<String, dynamic> data) {
    return ClientModel(
      id: data['id'],
      name: data['name'],
      phone: data['phone'],
      visits: data['visits'],
      totalSpent: data['totalSpent'],
      dept: data['dept'],
    );
  }

  Map<String, dynamic> toJson() {
    return {
      'id': id,
      'name': name,
      'phone': phone,
      'visits': visits,
      'totalSpent': totalSpent,
      'dept': dept,
    };
  }

  factory ClientModel.fromEntity(ClientEntity entity) {
    return ClientModel(
      id: entity.id,
      name: entity.name,
      phone: entity.phone,
      visits: entity.visits,
      totalSpent: entity.totalSpent,
      dept: entity.dept,
    );
  }
}
