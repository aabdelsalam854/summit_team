// import 'package:summit_team/core/services/server_locator.dart';
// import 'package:equatable/equatable.dart';

// import 'package:flutter_bloc/flutter_bloc.dart';
// import 'package:shared_preferences/shared_preferences.dart';

// part 'lang_state.dart';

// class ThemeCubit extends Cubit<ThemeState> {
//   ThemeCubit() : super(ThemeInitial()) {
//     final isDark = sl.get<SharedPreferences>().getBool('isDark') ?? true;
//     emit(ThemeChanged((isDark ? "en" : "ar")));
//   }

//   void changeThemes() {
//     final isDark = !(state is ThemeChanged &&
//         (state as ThemeChanged).theme. == "en");
//     emit(ThemeChanged((isDark ? "en" : "ar")));
//     sl.get<SharedPreferences>().setBool('isDark', isDark);
//   }
// }
