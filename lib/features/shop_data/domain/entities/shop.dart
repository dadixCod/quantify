class ShopEntity {
  final int? id;
  final String shopName;
  final String? address;
  final String phoneNumber;
  final String startHour;
  final String endHour;
  final String email;
  final String password;
  ShopEntity({
    this.id,
    required this.shopName,
    this.address,
    required this.phoneNumber,
    required this.startHour,
    required this.endHour,
    required this.email,
    required this.password,
  });
}
