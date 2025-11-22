import 'package:summit_team/config/locale/app_localizations_setup.dart';
import 'package:summit_team/config/routes/app_router.dart';
import 'package:summit_team/core/services/server_locator.dart';
import 'package:summit_team/core/styles/app_theme.dart';
import 'package:summit_team/core/utils/app_constants.dart';
import 'package:summit_team/features/app/presentation/cubits/app/app_cubit.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
  import 'dart:html' as html;

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await setUpServerLocator();


void enableTextSelection() {
  html.document.body!.style.userSelect = 'text';
}
  // setUrlStrategy(PathUrlStrategy());
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
  
    return BlocProvider(
      create: (context) => sl<AppCubit>()
        ..getSavedLang()
        ..getSavedTheme(),
      child: BlocBuilder<AppCubit, AppState>(
        builder: (context, themeState) {
          return MaterialApp.router(
            scaffoldMessengerKey: AppConstants.scaffoldKey,
            // navigatorKey: AppConstants.navigatorKey,
            locale: const Locale("ar"),
            supportedLocales: AppLocalSetup.supportedLocales,
            localizationsDelegates: AppLocalSetup.localizationsDelegates,
            localeResolutionCallback: AppLocalSetup.localeResolutionCallback,
            debugShowCheckedModeBanner: false,
            theme: resolveAppTheme(themeState.appTheme, themeState.fontFamily),
            routerConfig: AppRouts.router,
          );
        },
      ),
    );
  }
}

// import 'package:device_preview/device_preview.dart';
// import 'package:summit_team/config/locale/app_localizations_setup.dart';
// import 'package:summit_team/config/routes/app_router.dart';
// import 'package:summit_team/core/services/server_locator.dart';
// import 'package:summit_team/core/styles/app_theme.dart';
// import 'package:summit_team/core/utils/app_constants.dart';
// import 'package:summit_team/features/app/presentation/cubits/app/app_cubit.dart';
// import 'package:flutter/material.dart';
// import 'package:flutter_bloc/flutter_bloc.dart';


// void main() async {
//   WidgetsFlutterBinding.ensureInitialized();
//   await setUpServerLocator();
//   runApp(
//     DevicePreview(
//       enabled: true, // فعل أو أوقف حسب الحاجة
//       builder: (context) => const MyApp(),
//     ),
//   );
// }

// class MyApp extends StatelessWidget {
//   const MyApp({super.key});

//   @override
//   Widget build(BuildContext context) {
   
//         return BlocProvider(
//           create: (context) => sl<AppCubit>()
//             ..getSavedLang()
//             ..getSavedTheme(),
//           child: BlocBuilder<AppCubit, AppState>(
//             builder: (context, themeState) {
//               return MaterialApp.router(
//                 useInheritedMediaQuery: true, // مهم ل DevicePreview
//                 scaffoldMessengerKey: AppConstants.scaffoldKey,
//                 locale: DevicePreview.locale(context), // مهم ل DevicePreview
//                 supportedLocales: AppLocalSetup.supportedLocales,
//                 localizationsDelegates: AppLocalSetup.localizationsDelegates,
//                 localeResolutionCallback: AppLocalSetup.localeResolutionCallback,
//                 debugShowCheckedModeBanner: false,
//                 theme: resolveAppTheme(
//                   themeState.appTheme,
//                   themeState.fontFamily,
//                 ),
//                 routerConfig: AppRouts.router,
//               );
//             },
//           ),
//         );
   
  
//   }
// }
