import 'package:flutter/material.dart';
import 'package:quantify/features/dashboard/domain/entity/ticket.dart';

class TicketModel extends TicketEntity {
  TicketModel({
    super.id,
    super.number,
    required super.date,
    required super.time,
    required super.price,
    required super.clientId,
    required super.clientName,
    required super.clientPhone,
    super.isDone,
  });
  factory TicketModel.fromJson(Map<String, dynamic> data) {
    return TicketModel(
      id: data['id'],
      number: data['number'],
      date: data['date'],
      time: TimeOfDay(
          hour: int.parse(data['time'].split(':')[0]),
          minute: int.parse(data['time'].split(':')[1])),
      price: data['price'],
      clientId: data['clientId'],
      clientName: data['clientName'],
      clientPhone: data['clientPhone'],
      isDone: data['isDone'] == 1 ? true : false,
    );
  }

  Map<String, dynamic> toJson() {
    return {
      'id': id,
      'number': number,
      'date': date,
      'time': '${time.hour}:${time.minute}',
      'price': price,
      'clientId': clientId,
      'clientName': clientName,
      'clientPhone': clientPhone,
      'isDone': isDone ? 1 : 0,
    };
  }

  factory TicketModel.fromEntity(TicketEntity entity) {
    return TicketModel(
      id: entity.id,
      number: entity.number,
      date: entity.date,
      time: entity.time,
      price: entity.price,
      clientId: entity.clientId,
      clientName: entity.clientName,
      clientPhone: entity.clientPhone,
      isDone: entity.isDone,
    );
  }

  @override
  String toString() {
    return 'TicketModel(id: $id, number: $number, date: $date, time: $time, price: $price,clientId: $clientId, clientName: $clientName, clientPhone: $clientPhone, isDone: $isDone)';
  }
}
