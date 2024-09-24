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
  final bool isDone;

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
}
