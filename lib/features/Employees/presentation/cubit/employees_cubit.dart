import 'package:bloc/bloc.dart';
import 'package:equatable/equatable.dart';

part 'employees_state.dart';

class EmployeesCubit extends Cubit<EmployeesState> {
  EmployeesCubit() : super(EmployeesInitial());
}
