import 'package:agent1/common/color_extension.dart';
import 'package:agent1/views/top_bar/hotel/hotel/guests/guests_controller.dart';
import 'package:agent1/views/top_bar/hotel/hotel/hotel_date_controller.dart';
import 'package:agent1/views/top_bar/hotel/search_hotels/search_hotel_controller.dart';
import 'package:agent1/views/top_bar/umrah_pkg/umrah_pkg_controller.dart';
import 'package:agent1/views/welcome_view.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

import 'services/api_service_airarabia.dart';
import 'views/authentication/cotnroller/auth_controller.dart';
import 'views/top_bar/flight/form/controllers/flight_date_controller.dart';
import 'views/top_bar/flight/search_flights/airarabia/airarabia_flight_controller.dart';
import 'views/top_bar/flight/search_flights/airblue/airblue_flight_controller.dart';
import 'widgets/travelers_selection_bottom_sheet.dart';

void main() {
  runApp(
    const MyApp(),
  );
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    Get.lazyPut(() => GuestsController(), fenix: true);
    Get.lazyPut(() => HotelDateController(), fenix: true);
    Get.lazyPut(() => SearchHotelController(), fenix: true);
    Get.lazyPut(() => UmrahPackageController(), fenix: true);
    Get.lazyPut(() => FlightDateController(), fenix: true);
    Get.lazyPut(() => TravelersController(), fenix: true);
    Get.lazyPut(() => AirArabiaFlightController(), fenix: true);
    Get.lazyPut(() => ApiServiceAirArabia(), fenix: true);
    Get.lazyPut(() => AirBlueFlightController(), fenix: true);
    Get.put(AuthController());

    return GetMaterialApp(
      debugShowCheckedModeBanner: false,
      title: 'Flutter Demo',
      theme: ThemeData(
        colorScheme: ColorScheme.fromSeed(seedColor: TColors.primary),
        useMaterial3: true,
      ),
      home: const WelcomeScreen(),
    );
  }
}
