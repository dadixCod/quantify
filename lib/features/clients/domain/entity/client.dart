class ClientEntity {
  int? id;
  final String name;
  final String phone;
  int? visits;
  double? totalSpent;
  double? dept;
  final int shopId;

  ClientEntity({
    this.id,
    required this.name,
    required this.phone,
    this.visits,
    this.totalSpent,
    this.dept,
    required this.shopId,
  });
}
