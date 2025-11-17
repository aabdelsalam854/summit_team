import 'dart:async';
import 'package:bloc/bloc.dart';
import 'package:equatable/equatable.dart';
import 'package:summit_team/features/Employees/presentation/models/employee.dart';

part 'employees_state.dart';

class EmployeesCubit extends Cubit<EmployeesState> {
  final List<Employee> _employees = [];
  EmployeeRole? _currentFilter;

  EmployeesCubit() : super(EmployeesInitial()) {
    _initializeSampleData();
  }

  void _initializeSampleData() {
    final now = DateTime.now();
    _employees.addAll([
      Employee(
        id: '1',
        name: 'أحمد محمد',
        phone: '01012345678',
        address: 'القاهرة، مصر الجديدة',
        role: EmployeeRole.admin,
        createdAt: now.subtract(const Duration(days: 30)),
      ),
      Employee(
        id: '2',
        name: 'فاطمة علي',
        phone: '01123456789',
        address: 'الجيزة، المهندسين',
        role: EmployeeRole.accountant,
        createdAt: now.subtract(const Duration(days: 25)),
      ),
      Employee(
        id: '3',
        name: 'محمود حسن',
        phone: '01234567890',
        address: 'الإسكندرية، سموحة',
        role: EmployeeRole.employee,
        createdAt: now.subtract(const Duration(days: 20)),
      ),
      Employee(
        id: '4',
        name: 'سارة أحمد',
        phone: '01098765432',
        address: 'القاهرة، مدينة نصر',
        role: EmployeeRole.accountant,
        createdAt: now.subtract(const Duration(days: 15)),
      ),
      Employee(
        id: '5',
        name: 'خالد عبدالله',
        phone: '01156789012',
        address: 'الجيزة، الدقي',
        role: EmployeeRole.employee,
        createdAt: now.subtract(const Duration(days: 10)),
      ),
      Employee(
        id: '6',
        name: 'مريم سعيد',
        phone: '01267890123',
        address: 'القاهرة، التجمع الخامس',
        role: EmployeeRole.employee,
        createdAt: now.subtract(const Duration(days: 5)),
      ),
    ]);
  }

  Future<void> getAllEmployees() async {
    emit(EmployeesLoading());
    // TODO: Implement your data fetching logic here
    // For now, just returning the current list
    await Future.delayed(const Duration(milliseconds: 500));
    emit(EmployeesLoaded(employees: _employees));
  }

  Future<void> getEmployeesByRole(EmployeeRole role) async {
    emit(EmployeesLoading());
    _currentFilter = role;
    // TODO: Implement filtering logic here
    await Future.delayed(const Duration(milliseconds: 500));
    final filteredEmployees = _employees
        .where((emp) => emp.role == role)
        .toList();
    emit(EmployeesLoaded(employees: filteredEmployees, filteredRole: role));
  }

  Future<void> addEmployee(Employee employee) async {
    emit(EmployeesLoading());
    // TODO: Implement your add logic here (e.g., API call)
    await Future.delayed(const Duration(milliseconds: 500));
    _employees.add(employee);
    emit(EmployeeAdded(employee));
    // Refresh the list
    if (_currentFilter != null) {
      getEmployeesByRole(_currentFilter!);
    } else {
      getAllEmployees();
    }
  }

  Future<void> updateEmployee(Employee employee) async {
    emit(EmployeesLoading());
    // TODO: Implement your update logic here (e.g., API call)
    await Future.delayed(const Duration(milliseconds: 500));
    final index = _employees.indexWhere((emp) => emp.id == employee.id);
    if (index != -1) {
      _employees[index] = employee;
    }
    emit(EmployeeUpdated(employee));
    // Refresh the list
    if (_currentFilter != null) {
      getEmployeesByRole(_currentFilter!);
    } else {
      getAllEmployees();
    }
  }

  Future<void> deleteEmployee(String id) async {
    emit(EmployeesLoading());
    // TODO: Implement your delete logic here (e.g., API call)
    await Future.delayed(const Duration(milliseconds: 500));
    _employees.removeWhere((emp) => emp.id == id);
    emit(EmployeeDeleted(id));
    // Refresh the list
    if (_currentFilter != null) {
      getEmployeesByRole(_currentFilter!);
    } else {
      getAllEmployees();
    }
  }

  void clearFilter() {
    _currentFilter = null;
    getAllEmployees();
  }
}
