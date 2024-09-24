import 'package:quantify/core/utils/use_case.dart';
import 'package:quantify/features/dashboard/domain/entity/ticket.dart';
import 'package:quantify/features/dashboard/domain/repository/ticket_repository.dart';
import 'package:quantify/service_locator.dart';

class GetUndoneTicketsUseCase extends UseCase<List<TicketEntity>, DateTime> {
  @override
  Future<List<TicketEntity>> call({DateTime? params}) async {
    return await sl<TicketRepository>().getUndoneTickets(params!);
  }
}
