import 'package:check_in/data/repos/auth/register_repo.dart';
import 'package:check_in/data/repos/auth/register_repo_imp.dart';
import 'package:check_in/data/repos/settings/setting_repo_impl.dart';
import 'package:dio/dio.dart';
import 'package:get_it/get_it.dart';
import '../../data/repos/booking/booking_repo_impl.dart';
import '../../data/repos/hotels/hotel_repo_impl.dart';

final getIt = GetIt.instance;
void setUp() {
  getIt.registerSingleton<RegisterRepoImp>(RegisterRepoImp());
  getIt.registerSingleton<HotelsRepoImp>(HotelsRepoImp());
  getIt.registerSingleton<BookingRepoImpl>(BookingRepoImpl());
  getIt.registerSingleton<SettingRepoImpl>(SettingRepoImpl());
  // getIt.registerSingleton<HomeRepoImpl>(HomeRepoImpl(getIt.get<ApiServices>()));
}
