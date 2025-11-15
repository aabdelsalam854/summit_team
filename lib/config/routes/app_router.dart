import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:summit_team/config/routes/routes.dart';
import 'package:summit_team/core/services/server_locator.dart';
import 'package:summit_team/features/Employees/presentation/cubit/employees_cubit.dart';
import 'package:summit_team/features/Employees/presentation/pages/employees_screen.dart';
import 'package:summit_team/features/dashboard/presentation/screens/dashboard_screen.dart';
import 'package:summit_team/features/dashboard/presentation/screens/property_form_screen.dart';
import 'package:summit_team/features/home/presentation/screens/details.dart';
import 'package:summit_team/features/home/presentation/screens/home_screen.dart';

import 'package:go_router/go_router.dart';

import 'package:summit_team/features/properties/data/models/property_model.dart';

abstract class AppRouts {
  static final router = GoRouter(
    initialLocation: Routes.kDashboard,
    routes: [
      // Home Route
      GoRoute(
        path: Routes.kHome,
        name: Routes.kHome,
        builder: (context, state) => const HomeScreen(),
      ),

      // Login Route
      GoRoute(
        path: Routes.kLogin,
        name: Routes.kLogin,
        builder: (context, state) =>
            const HomeScreen(), // TODO: Change to LoginScreen
      ),

      // Dashboard Route
      GoRoute(
        path: Routes.kDashboard,
        name: Routes.kDashboard,
        builder: (context, state) => const DashboardScreen(),
      ),

      // Property Form Route (Add/Edit)
      GoRoute(
        path: Routes.kPropertyForm,
        name: Routes.kPropertyForm,
        builder: (context, state) {
          // يمكن تمرير property للتعديل عبر extra
          // final property = state.extra as PropertyModel?;
          return const PropertyFormScreen();
        },
      ),

      // Property Details Route (للمستقبل)
      GoRoute(
        path: '${Routes.kPropertyDetails}/:id',
        name: Routes.kPropertyDetails,
        builder: (context, state) {
          final property = state.extra as PropertyModel;

          return PropertyDetailsScreen(property: property); // مؤقت
        },
      ),
      GoRoute(
        path: Routes.kEEmployees,
        name: Routes.kEEmployees,
        builder: (context, state) {
          return BlocProvider(
            create: (context) => EmployeesCubit(),
            child: const ProfessionalEmployeesDashboard(),
          );
        },
      ),
    ],
  );
}
