import 'package:get_it/get_it.dart';
import 'package:training_diary/features/train/calendar_page/data/gateways/calendar_page_gateway.dart';
import 'package:training_diary/features/train/calendar_page/data/gateways/impl/calendar_page_gateway_impl.dart';
import 'package:training_diary/features/train/calendar_page/domain/factory/calendar_page_factory.dart';
import 'package:training_diary/features/train/calendar_page/domain/factory/impl/calendar_page_factory_impl.dart';
import 'package:training_diary/features/train/calendar_page/domain/service/calendar_page_service.dart';
import 'package:training_diary/features/train/calendar_page/domain/service/impl/calendar_page_service_impl.dart';
import 'package:training_diary/utils/database/database_manager.dart';

final getIt = GetIt.instance;

class DependencyManager {
  static void registerDependencies() {
    getIt.registerFactory<DatabaseManager>(() => DatabaseManager());

    getIt.registerFactory<CalendarPageGateway>(
      () => CalendarPageGatewayImpl(getIt<DatabaseManager>()),
    );

    getIt.registerFactory<CalendarPageFactory>(() => CalendarPageFactoryImpl());

    getIt.registerFactory<CalendarPageService>(
      () => CalendarPageServiceImpl(
        getIt<CalendarPageGateway>(),
        getIt<CalendarPageFactory>(),
      ),
    );
  }
}
