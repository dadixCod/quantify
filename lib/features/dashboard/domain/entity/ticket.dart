// ignore_for_file: public_member_api_docs, sort_constructors_first
import 'package:flutter/material.dart';

class TicketEntity {
  int? id;
  int? number;
  final String date;
  final TimeOfDay time;
  final double price;
  final int clientId;
  final String clientName;
  final String clientPhone;
   bool isDone;

  TicketEntity({
    this.id,
    this.number,
    required this.date,
    required this.time,
    required this.price,
    required this.clientId,
    required this.clientName,
    required this.clientPhone,
    this.isDone = false,
  });

  

  TicketEntity copyWith({
    int? id,
    int? number,
    String? date,
    TimeOfDay? time,
    double? price,
    int? clientId,
    String? clientName,
    String? clientPhone,
    bool? isDone,
  }) {
    return TicketEntity(
      id: id ?? this.id,
      number: number ?? this.number,
      date: date ?? this.date,
      time: time ?? this.time,
      price: price ?? this.price,
      clientId: clientId ?? this.clientId,
      clientName: clientName ?? this.clientName,
      clientPhone: clientPhone ?? this.clientPhone,
      isDone: isDone ?? this.isDone,
    );
  }
}
