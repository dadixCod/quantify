class ClientEntity {
  int? id;
  final String name;
  final String phone;
  int? visits;
  double? totalSpent;

  ClientEntity({
    this.id,
    required this.name,
    required this.phone,
    this.visits,
    this.totalSpent,
  });
}
