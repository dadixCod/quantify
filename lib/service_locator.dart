import 'package:get_it/get_it.dart';
import 'package:quantify/features/clients/data/repository/clients_repository_impl.dart';
import 'package:quantify/features/clients/data/sources/clients_datasource.dart';
import 'package:quantify/features/clients/domain/repository/clients_repository.dart';
import 'package:quantify/features/clients/domain/usecases/add_client.dart';
import 'package:quantify/features/clients/domain/usecases/delete_client.dart';
import 'package:quantify/features/clients/domain/usecases/get_clients.dart';
import 'package:quantify/features/clients/domain/usecases/search_clients.dart';
import 'package:quantify/features/clients/domain/usecases/update_client.dart';
import 'package:quantify/features/dashboard/data/repository/ticket_repo_impl.dart';
import 'package:quantify/features/dashboard/data/sources/ticket_sources.dart';
import 'package:quantify/features/dashboard/domain/repository/ticket_repository.dart';
import 'package:quantify/features/dashboard/domain/usecase/add_ticket.dart';
import 'package:quantify/features/dashboard/domain/usecase/delete_ticket.dart';
import 'package:quantify/features/dashboard/domain/usecase/get_done_tickets.dart';
import 'package:quantify/features/dashboard/domain/usecase/get_undone_tickets.dart';
import 'package:quantify/features/dashboard/domain/usecase/mark_dept.dart';
import 'package:quantify/features/dashboard/domain/usecase/mark_undone.dart';
import 'package:quantify/features/dashboard/domain/usecase/mark_done_ticket.dart';
import 'package:quantify/features/dashboard/domain/usecase/update_ticket.dart';
import 'package:quantify/features/onboarding/data/repository/on_boarding_repo_impl.dart';
import 'package:quantify/features/onboarding/domain/repository/on_boarding_repo.dart';
import 'package:quantify/features/onboarding/domain/usecase/change_onboarding_status_usecase.dart';
import 'package:quantify/features/onboarding/domain/usecase/check_onboarding_usecase.dart';
import 'package:quantify/features/shop_data/data/repository/shop_repository_impl.dart';
import 'package:quantify/features/shop_data/data/sources/shop_sources.dart';
import 'package:quantify/features/shop_data/domain/repository/shop_repository.dart';
import 'package:quantify/features/shop_data/domain/usecase/add_shop_usecase.dart';
import 'package:quantify/features/shop_data/domain/usecase/get_shop_data_usecase.dart';
import 'package:quantify/features/shop_data/domain/usecase/update_shop_usecase.dart';
import 'package:quantify/shared/helpers/database_helper.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:sqflite/sqflite.dart';

final sl = GetIt.instance;

Future<void> initializeDependencies() async {
  final prefs = await SharedPreferences.getInstance();
  final db = await DatabaseHelper.initDatabase();
  sl.registerSingleton<SharedPreferences>(prefs);
  sl.registerSingleton<Database>(db);

  //Shared Preferences

  //On Boarding
  sl.registerSingleton<OnBoardingRepo>(OnBoardingRepoImpl(sl()));
  sl.registerSingleton<ChangeOnboardingStatusUsecase>(
      ChangeOnboardingStatusUsecase());
  sl.registerSingleton<CheckOnboardingUsecase>(CheckOnboardingUsecase());

  //Shop data
  sl.registerSingleton<ShopSources>(ShopSources(sl()));
  sl.registerSingleton<ShopRepository>(ShopRepositoryImpl(sl()));
  sl.registerSingleton<GetShopDataUsecase>(GetShopDataUsecase(sl()));
  sl.registerSingleton<AddShopUsecase>(AddShopUsecase(sl()));
  sl.registerSingleton<UpdateShopUsecase>(UpdateShopUsecase(sl()));

  //Dashboard
  sl.registerSingleton<TicketSources>(TicketSources(sl()));
  sl.registerSingleton<TicketRepository>(TicketRepositoryImpl(sl()));
  sl.registerSingleton<GetDoneTicketsUseCase>(GetDoneTicketsUseCase());
  sl.registerSingleton<GetUndoneTicketsUseCase>(GetUndoneTicketsUseCase());
  sl.registerSingleton<AddTicketUseCase>(AddTicketUseCase());
  sl.registerSingleton<MarkDoneTicketUseCase>(MarkDoneTicketUseCase());
  sl.registerSingleton<DeleteTicketUseCase>(DeleteTicketUseCase());
  sl.registerSingleton<MarkClientInDeptUseCase>(MarkClientInDeptUseCase());
  sl.registerSingleton<MarkUndoneTicketUseCase>(MarkUndoneTicketUseCase());
  sl.registerSingleton<UpdateTicketUseCase>(UpdateTicketUseCase());

  //Clients
  sl.registerSingleton<ClientsDatasource>(ClientsDatasource(sl()));
  sl.registerSingleton<ClientsRepository>(ClientsRepositoryImpl(sl()));
  sl.registerSingleton<GetClientsUseCase>(GetClientsUseCase());
  sl.registerSingleton<AddClientUseCase>(AddClientUseCase());
  sl.registerSingleton<UpdateClientUseCase>(UpdateClientUseCase());
  sl.registerSingleton<DeleteClientUseCase>(DeleteClientUseCase());
  sl.registerSingleton<SearchClientsUseCase>(SearchClientsUseCase());
}
