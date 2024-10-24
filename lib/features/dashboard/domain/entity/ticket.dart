// ignore_for_file: public_member_api_docs, sort_constructors_first
import 'package:flutter/material.dart';

class TicketEntity {
  int? id;
  int? number;
  final String date;
  final TimeOfDay time;
  final double price;
  double dept;
  final int clientId;
  final String clientName;
  final String clientPhone;
  final int shopId;
  bool isDone;

  TicketEntity({
    this.id,
    this.number,
    required this.date,
    required this.time,
    required this.price,
    required this.dept,
    required this.clientId,
    required this.clientName,
    required this.clientPhone,
    required this.shopId,
    this.isDone = false,
  });

  TicketEntity copyWith({
    int? id,
    int? number,
    String? date,
    TimeOfDay? time,
    double? price,
    double? dept,
    int? clientId,
    String? clientName,
    String? clientPhone,
    int? shopId,
    bool? isDone,
  }) {
    return TicketEntity(
      id: id ?? this.id,
      number: number ?? this.number,
      date: date ?? this.date,
      time: time ?? this.time,
      price: price ?? this.price,
      dept: dept ?? this.dept,
      clientId: clientId ?? this.clientId,
      clientName: clientName ?? this.clientName,
      clientPhone: clientPhone ?? this.clientPhone,
      shopId: shopId ?? this.shopId,
      isDone: isDone ?? this.isDone,
    );
  }

  @override
  String toString() {
    return 'TicketEntity(id: $id, number: $number, date: $date, time: $time, price: $price, dept: $dept, clientId: $clientId, clientName: $clientName, clientPhone: $clientPhone, isDone: $isDone, shopId: $shopId)';
  }
}
