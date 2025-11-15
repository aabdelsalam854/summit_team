part of 'employees_cubit.dart';

abstract class EmployeesState extends Equatable {
  const EmployeesState();

  @override
  List<Object?> get props => [];
}

class EmployeesInitial extends EmployeesState {}

class EmployeesLoading extends EmployeesState {}

class EmployeesLoaded extends EmployeesState {
  final List<Employee> employees;
  final EmployeeRole? filteredRole;

  const EmployeesLoaded({
    required this.employees,
    this.filteredRole,
  });

  @override
  List<Object?> get props => [employees, filteredRole];
}

class EmployeeAdded extends EmployeesState {
  final Employee employee;

  const EmployeeAdded(this.employee);

  @override
  List<Object> get props => [employee];
}

class EmployeeUpdated extends EmployeesState {
  final Employee employee;

  const EmployeeUpdated(this.employee);

  @override
  List<Object> get props => [employee];
}

class EmployeeDeleted extends EmployeesState {
  final String employeeId;

  const EmployeeDeleted(this.employeeId);

  @override
  List<Object> get props => [employeeId];
}

class EmployeesError extends EmployeesState {
  final String message;

  const EmployeesError(this.message);

  @override
  List<Object> get props => [message];
}
