import 'package:quantify/core/utils/use_case.dart';
import 'package:quantify/features/dashboard/domain/repository/ticket_repository.dart';
import 'package:quantify/service_locator.dart';

class DeleteTicketUseCase extends UseCase<bool, int> {
  @override
  Future<bool> call({int? params}) async {
    return await sl<TicketRepository>().deleteTicket(params!);
  }
}
