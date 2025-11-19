import 'package:flutter/material.dart';
import 'package:summit_team/features/Employees/presentation/models/employee.dart';
import 'package:summit_team/features/Employees/presentation/pages/employees_mopile.dart';
import 'package:summit_team/features/Employees/presentation/pages/employees_screen.dart';
import 'package:summit_team/features/Employees/presentation/pages/employees_tablet.dart';

class EmployeesLayout extends StatefulWidget {
  const EmployeesLayout({super.key});

  @override
  State<EmployeesLayout> createState() => _EmployeesLayoutState();
}

class _EmployeesLayoutState extends State<EmployeesLayout> {
  // البيانات التجريبية
  final int totalEmployees = 125;
  final int admins = 8;
  final int accountants = 22;
  final int employees = 95;
  final double growthRate = 12.5;
  final int newThisMonth = 15;

  EmployeeRole? _selectedRole;
  final TextEditingController _searchController = TextEditingController();
  String _searchQuery = '';

  // قائمة الموظفين التجريبية
  final List<Employee> _allEmployees = [
    Employee(
      id: '1',
      name: 'أحمد محمد علي',
      phone: '0501234567',
      address: 'الرياض، حي النخيل',
      role: EmployeeRole.admin,
      createdAt: DateTime.now().subtract(const Duration(days: 30)),
    ),
    Employee(
      id: '2',
      name: 'فاطمة عبدالله حسن',
      phone: '0509876543',
      address: 'جدة، حي الروضة',
      role: EmployeeRole.accountant,
      createdAt: DateTime.now().subtract(const Duration(days: 25)),
    ),
    Employee(
      id: '3',
      name: 'خالد أحمد سعيد',
      phone: '0551234567',
      address: 'الدمام، حي الفيصلية',
      role: EmployeeRole.employee,
      createdAt: DateTime.now().subtract(const Duration(days: 20)),
    ),
    Employee(
      id: '4',
      name: 'سارة محمود يوسف',
      phone: '0559876543',
      address: 'الرياض، حي العليا',
      role: EmployeeRole.accountant,
      createdAt: DateTime.now().subtract(const Duration(days: 15)),
    ),
    Employee(
      id: '5',
      name: 'عمر حسن محمد',
      phone: '0561234567',
      address: 'مكة، حي العزيزية',
      role: EmployeeRole.employee,
      createdAt: DateTime.now().subtract(const Duration(days: 10)),
    ),
    Employee(
      id: '6',
      name: 'نورة سعد العتيبي',
      phone: '0569876543',
      address: 'الرياض، حي الملقا',
      role: EmployeeRole.admin,
      createdAt: DateTime.now().subtract(const Duration(days: 8)),
    ),
    Employee(
      id: '7',
      name: 'محمد عبدالرحمن',
      phone: '0501239999',
      address: 'جدة، حي البلد',
      role: EmployeeRole.employee,
      createdAt: DateTime.now().subtract(const Duration(days: 5)),
    ),
    Employee(
      id: '8',
      name: 'مريم سعيد القحطاني',
      phone: '0559998877',
      address: 'الرياض، حي السليمانية',
      role: EmployeeRole.accountant,
      createdAt: DateTime.now().subtract(const Duration(days: 3)),
    ),
  ];

  @override
  void dispose() {
    _searchController.dispose();
    super.dispose();
  }

  // فلترة الموظفين حسب الدور والبحث
  List<Employee> get _filteredEmployees {
    return _allEmployees.where((employee) {
      final roleMatch = _selectedRole == null || employee.role == _selectedRole;
      final searchMatch =
          _searchQuery.isEmpty ||
          employee.name.contains(_searchQuery) ||
          employee.phone.contains(_searchQuery);
      return roleMatch && searchMatch;
    }).toList();
  }

  void _handleRoleChanged(EmployeeRole? role) {
    setState(() {
      _selectedRole = role;
    });
  }

  void _handleSearchChanged(String query) {
    setState(() {
      _searchQuery = query;
    });
  }

  @override
  Widget build(BuildContext context) {
    final width = MediaQuery.sizeOf(context).width;
    if (width < 800) {
      return EmployeesMopile(
        employees: _filteredEmployees,
        selectedRole: _selectedRole,
        searchQuery: _searchQuery,
        onRoleChanged: _handleRoleChanged,
        onSearchChanged: _handleSearchChanged,
      );
    } else if (width < 1200) {
      return EmployeesTablet(
        employees: _filteredEmployees,
        selectedRole: _selectedRole,
        searchQuery: _searchQuery,
        onRoleChanged: _handleRoleChanged,
        onSearchChanged: _handleSearchChanged,
      );
    } else {
      return EmployeesDeskTop(
        employees: _filteredEmployees,
        selectedRole: _selectedRole,
        searchQuery: _searchQuery,
        onRoleChanged: _handleRoleChanged,
        onSearchChanged: _handleSearchChanged,
      );
    }
  }
}
