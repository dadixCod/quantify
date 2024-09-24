import 'package:quantify/core/utils/use_case.dart';
import 'package:quantify/features/dashboard/domain/entity/ticket.dart';
import 'package:quantify/features/dashboard/domain/repository/ticket_repository.dart';
import 'package:quantify/service_locator.dart';

class UpdateTicketUseCase extends UseCase<bool, TicketEntity> {
  @override
  Future<bool> call({TicketEntity? params}) async {
    return await sl<TicketRepository>().updateTicket(params!);
  }
}
