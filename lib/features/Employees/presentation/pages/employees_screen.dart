import 'package:equatable/equatable.dart';
import 'package:flutter/material.dart';

import 'package:fl_chart/fl_chart.dart';
import 'package:summit_team/core/utils/alessamy_colors.dart';
import 'package:summit_team/features/Employees/presentation/models/employee.dart';
import 'package:summit_team/features/Employees/presentation/widgets/employee_aashboard_app_bar.dart';
import 'package:summit_team/features/Employees/presentation/widgets/employee_filter_section.dart';
import 'package:summit_team/features/Employees/presentation/widgets/employee_form_dialog.dart';
import 'package:summit_team/features/Employees/presentation/widgets/employees_list_section.dart';
import 'package:summit_team/features/Employees/presentation/widgets/employees_states_row.dart';
import 'package:summit_team/features/Employees/presentation/widgets/role_distribution_card.dart';

import 'package:summit_team/features/dashboard/presentation/widgets/dashboard_stats_card.dart';

class EmployeesDashboard extends StatelessWidget {
  final List<Employee> employees;
  final EmployeeRole? selectedRole;
  final String searchQuery;
  final ValueChanged<EmployeeRole?>? onRoleChanged;
  final ValueChanged<String>? onSearchChanged;

  const EmployeesDashboard({
    super.key,
    required this.employees,
    this.selectedRole,
    this.searchQuery = '',
    this.onRoleChanged,
    this.onSearchChanged,
  });

  int get _totalEmployees => employees.length;

  int get _admins =>
      employees.where((e) => e.role == EmployeeRole.admin).length;

  int get _accountants =>
      employees.where((e) => e.role == EmployeeRole.accountant).length;

  int get _regularEmployees =>
      employees.where((e) => e.role == EmployeeRole.employee).length;

  @override
  Widget build(BuildContext context) {
    return Directionality(
      textDirection: TextDirection.rtl,
      child: Scaffold(
        backgroundColor: AlessamyColors.backgroundColor,
        body: Row(
          children: [
            // Expanded(flex: 1, child: CustomDrower()),
            Expanded(
              flex: 5,
              child: CustomScrollView(
                slivers: [
                  // App Bar
                  // SliverAppBar(
                  //   backgroundColor: AlessamyColors.cardBackground,
                  //   pinned: true,
                  //   expandedHeight: 100,
                  //   toolbarHeight: 80, // ارتفاع عند التمرير إلى الأعلى

                  //   flexibleSpace: FlexibleSpaceBar(
                  //     titlePadding: const EdgeInsets.symmetric(
                  //       horizontal: 24,
                  //       vertical: 12,
                  //     ),

                  //     title: Row(
                  //       children: [
                  //         Expanded(
                  //           flex: 3,
                  //           child: Text(
                  //             "SUMMIT TEAM",
                  //             style: const TextStyle(
                  //               fontSize: 22,
                  //               fontWeight: FontWeight.bold,
                  //               color: Colors.white,
                  //             ),
                  //             overflow: TextOverflow.ellipsis,
                  //           ),
                  //         ),
                  //         const SizedBox(width: 16),
                  //         Expanded(
                  //           flex: 3,
                  //           child: SizedBox(
                  //             height: 40,
                  //             child: TextField(
                  //               // controller: searchController,
                  //               decoration: InputDecoration(
                  //                 hintText: 'بحث...',
                  //                 prefixIcon: const Icon(Icons.search),
                  //                 filled: true,
                  //                 fillColor: Colors.white,
                  //                 contentPadding: const EdgeInsets.symmetric(
                  //                   vertical: 0,
                  //                   horizontal: 12,
                  //                 ),
                  //                 border: OutlineInputBorder(
                  //                   borderRadius: BorderRadius.circular(12),
                  //                   borderSide: BorderSide.none,
                  //                 ),
                  //               ),
                  //             ),
                  //           ),
                  //         ),
                  //         const SizedBox(width: 16),
                  //         Expanded(
                  //           flex: 2,
                  //           child: Row(
                  //             children: [
                  //               CircleAvatar(
                  //                 radius: 20,
                  //                 backgroundColor: AlessamyColors.primaryGold,
                  //                 child: IconButton(
                  //                   onPressed: () {},
                  //                   icon: const Icon(
                  //                     Icons.person,
                  //                     color: Colors.white,
                  //                     size: 20,
                  //                   ),
                  //                 ),
                  //               ),
                  //               const SizedBox(width: 8),
                  //               Expanded(
                  //                 child: Padding(
                  //                   padding: const EdgeInsets.all(8.0),
                  //                   child: Column(
                  //                     crossAxisAlignment:
                  //                         CrossAxisAlignment.start,
                  //                     mainAxisAlignment:
                  //                         MainAxisAlignment.center,
                  //                     children: const [
                  //                       Text(
                  //                         'اسم المستخدم',
                  //                         style: TextStyle(
                  //                           fontSize: 14,
                  //                           color: Colors.white,
                  //                         ),
                  //                         overflow: TextOverflow.ellipsis,
                  //                       ),
                  //                       Text(
                  //                         'دور المستخدم',
                  //                         style: TextStyle(
                  //                           fontSize: 12,
                  //                           color: Colors.white70,
                  //                         ),
                  //                         overflow: TextOverflow.ellipsis,
                  //                       ),
                  //                     ],
                  //                   ),
                  //                 ),
                  //               ),
                  //             ],
                  //           ),
                  //         ),
                  //       ],
                  //     ),
                  //   ),
                  // ),

                  // Main Content
                  SliverToBoxAdapter(
                    child: EmployeeDashboardAppBar(
                      lastUpdated: DateTime.now(),
                      onAddPressed: () => showDialog(
                        context: context,
                        builder: (context) =>
                            EmployeeFormDialog(employee: null),
                      ),
                    ),
                  ),

                  SliverPadding(
                    padding: const EdgeInsets.all(24),
                    sliver: SliverList(
                      delegate: SliverChildListDelegate([
                        // Row 1: Stats Cards
                        const SizedBox(height: 24),

                        // Row 2: Charts Row 1
                        Row(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            Expanded(
                              child: Card(
                                color: AlessamyColors.cardBackground,
                                shape: RoundedRectangleBorder(
                                  borderRadius: BorderRadius.circular(12),
                                ),
                                child: Padding(
                                  padding: const EdgeInsets.all(16),
                                  child: EmployeesStatesRowWidget(
                                    totalEmployees: _totalEmployees,
                                    admins: _admins,
                                    accountants: _accountants,
                                    employees: _regularEmployees,
                                  ),
                                ),
                              ),
                            ),
                            const SizedBox(width: 40),
                            // Pie Chart - توزيع الموظفين
                            Expanded(
                              child: RoleDistributionCard(
                                totalEmployees: _totalEmployees,
                                admins: _admins,
                                accountants: _accountants,
                                employees: _regularEmployees,
                              ),
                            ),

                            // Bar Chart - نمو الموظفين شهرياً
                            // Expanded(flex: 3, child: _buildMonthlyGrowthCard()),
                          ],
                        ),

                        const SizedBox(height: 24),

                        // // Row 3: Charts Row 2
                        // Row(
                        //   crossAxisAlignment: CrossAxisAlignment.start,
                        //   children: [
                        //     // Line Chart - اتجاه النمو
                        //     // Expanded(flex: 3, child: _buildGrowthTrendCard()),
                        //     const SizedBox(width: 24),
                        //     // Recent Employees
                        //     Expanded(
                        //       flex: 2,
                        //       child: _buildRecentEmployeesCard(),
                        //     ),
                        //   ],
                        // ),
                        const SizedBox(height: 32),

                        // Filters Section
                        FiltersSection(
                          searchController: TextEditingController(
                            text: searchQuery,
                          ),
                          searchQuery: searchQuery,
                          selectedRole: selectedRole,
                          onSearchChanged: onSearchChanged!,
                          onRoleChanged: onRoleChanged!,
                        ),
                        const SizedBox(height: 24),

                        // Employees List
                        EmployeesListSection(
                          employees: employees,
                          isLoading: false,
                          selectedRole: selectedRole,
                          searchQuery: searchQuery,
                          onClearFilters: () {
                            onRoleChanged?.call(null);
                            onSearchChanged?.call('');
                          },
                          onLoadMore: () {},
                        ),
                      ]),
                    ),
                  ),
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }
}



class AddEmployeeDialog extends StatefulWidget {
  final Employee? employee;
  final Function(Employee) onSave;

  const AddEmployeeDialog({super.key, this.employee, required this.onSave});

  @override
  State<AddEmployeeDialog> createState() => _AddEmployeeDialogState();
}

class _AddEmployeeDialogState extends State<AddEmployeeDialog> {
  final _formKey = GlobalKey<FormState>();
  final _nameController = TextEditingController();
  final _phoneController = TextEditingController();
  final _addressController = TextEditingController();
  EmployeeRole _selectedRole = EmployeeRole.employee;

  bool get isEditing => widget.employee != null;

  @override
  void initState() {
    super.initState();
    if (widget.employee != null) {
      _nameController.text = widget.employee!.name;
      _phoneController.text = widget.employee!.phone;
      _addressController.text = widget.employee!.address;
      _selectedRole = widget.employee!.role;
    }
  }

  @override
  void dispose() {
    _nameController.dispose();
    _phoneController.dispose();
    _addressController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Directionality(
      textDirection: TextDirection.rtl,
      child: Dialog(
        backgroundColor: const Color(0xFF16213e),
        shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(20)),
        child: Container(
          width: 600,
          constraints: const BoxConstraints(maxHeight: 700),
          child: Column(
            mainAxisSize: MainAxisSize.min,
            children: [
              // Header
              Container(
                padding: const EdgeInsets.all(24),
                decoration: BoxDecoration(
                  color: const Color(0xFF1a1a2e),
                  borderRadius: const BorderRadius.only(
                    topLeft: Radius.circular(20),
                    topRight: Radius.circular(20),
                  ),
                ),
                child: Row(
                  children: [
                    Container(
                      padding: const EdgeInsets.all(12),
                      decoration: BoxDecoration(
                        color: const Color(0xFFF1C40F).withOpacity(0.2),
                        shape: BoxShape.circle,
                      ),
                      child: Icon(
                        isEditing ? Icons.edit : Icons.person_add,
                        color: const Color(0xFFF1C40F),
                        size: 28,
                      ),
                    ),
                    const SizedBox(width: 16),
                    Text(
                      isEditing ? 'تعديل بيانات الموظف' : 'إضافة موظف جديد',
                      style: const TextStyle(
                        fontSize: 24,
                        fontWeight: FontWeight.bold,
                        color: Colors.white,
                      ),
                    ),
                    const Spacer(),
                    IconButton(
                      onPressed: () => Navigator.pop(context),
                      icon: const Icon(Icons.close),
                      color: const Color(0xFF95A5A6),
                    ),
                  ],
                ),
              ),

              // Form
              Expanded(
                child: SingleChildScrollView(
                  padding: const EdgeInsets.all(24),
                  child: Form(
                    key: _formKey,
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        // Name Field
                        _buildLabel('الاسم الكامل'),
                        const SizedBox(height: 8),
                        _buildTextField(
                          controller: _nameController,
                          hint: 'أدخل الاسم الكامل',
                          icon: Icons.person,
                          validator: (value) {
                            if (value == null || value.isEmpty) {
                              return 'الرجاء إدخال الاسم';
                            }
                            return null;
                          },
                        ),
                        const SizedBox(height: 20),

                        // Phone Field
                        _buildLabel('رقم الهاتف'),
                        const SizedBox(height: 8),
                        _buildTextField(
                          controller: _phoneController,
                          hint: '05xxxxxxxx',
                          icon: Icons.phone,
                          keyboardType: TextInputType.phone,
                          validator: (value) {
                            if (value == null || value.isEmpty) {
                              return 'الرجاء إدخال رقم الهاتف';
                            }
                            if (!RegExp(r'^05[0-9]{8}$').hasMatch(value)) {
                              return 'رقم الهاتف غير صحيح';
                            }
                            return null;
                          },
                        ),
                        const SizedBox(height: 20),

                        // Address Field
                        _buildLabel('العنوان'),
                        const SizedBox(height: 8),
                        _buildTextField(
                          controller: _addressController,
                          hint: 'أدخل العنوان',
                          icon: Icons.location_on,
                          maxLines: 2,
                          validator: (value) {
                            if (value == null || value.isEmpty) {
                              return 'الرجاء إدخال العنوان';
                            }
                            return null;
                          },
                        ),
                        const SizedBox(height: 20),

                        // Role Selection
                        _buildLabel('الدور الوظيفي'),
                        const SizedBox(height: 12),
                        _buildRoleSelection(),
                      ],
                    ),
                  ),
                ),
              ),

              // Footer Buttons
              Container(
                padding: const EdgeInsets.all(24),
                decoration: const BoxDecoration(
                  color: Color(0xFF1a1a2e),
                  borderRadius: BorderRadius.only(
                    bottomLeft: Radius.circular(20),
                    bottomRight: Radius.circular(20),
                  ),
                ),
                child: Row(
                  children: [
                    Expanded(
                      child: OutlinedButton(
                        onPressed: () => Navigator.pop(context),
                        style: OutlinedButton.styleFrom(
                          padding: const EdgeInsets.symmetric(vertical: 16),
                          side: const BorderSide(color: Color(0xFF95A5A6)),
                          shape: RoundedRectangleBorder(
                            borderRadius: BorderRadius.circular(12),
                          ),
                        ),
                        child: const Text(
                          'إلغاء',
                          style: TextStyle(
                            fontSize: 16,
                            fontWeight: FontWeight.bold,
                            color: Color(0xFF95A5A6),
                          ),
                        ),
                      ),
                    ),
                    const SizedBox(width: 16),
                    Expanded(
                      child: ElevatedButton(
                        onPressed: _saveEmployee,
                        style: ElevatedButton.styleFrom(
                          padding: const EdgeInsets.symmetric(vertical: 16),
                          backgroundColor: const Color(0xFFF1C40F),
                          foregroundColor: const Color(0xFF1a1a2e),
                          shape: RoundedRectangleBorder(
                            borderRadius: BorderRadius.circular(12),
                          ),
                        ),
                        child: Text(
                          isEditing ? 'تحديث البيانات' : 'إضافة الموظف',
                          style: const TextStyle(
                            fontSize: 16,
                            fontWeight: FontWeight.bold,
                          ),
                        ),
                      ),
                    ),
                  ],
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }

  Widget _buildLabel(String text) {
    return Text(
      text,
      style: const TextStyle(
        fontSize: 16,
        fontWeight: FontWeight.bold,
        color: Colors.white,
      ),
    );
  }

  Widget _buildTextField({
    required TextEditingController controller,
    required String hint,
    required IconData icon,
    String? Function(String?)? validator,
    TextInputType? keyboardType,
    int maxLines = 1,
  }) {
    return TextFormField(
      controller: controller,
      validator: validator,
      keyboardType: keyboardType,
      maxLines: maxLines,
      style: const TextStyle(color: Colors.white),
      decoration: InputDecoration(
        hintText: hint,
        hintStyle: const TextStyle(color: Color(0xFF95A5A6)),
        prefixIcon: Icon(icon, color: const Color(0xFF95A5A6)),
        filled: true,
        fillColor: const Color(0xFF1a1a2e),
        border: OutlineInputBorder(
          borderRadius: BorderRadius.circular(12),
          borderSide: BorderSide.none,
        ),
        enabledBorder: OutlineInputBorder(
          borderRadius: BorderRadius.circular(12),
          borderSide: const BorderSide(color: Color(0xFF2C3E50), width: 1),
        ),
        focusedBorder: OutlineInputBorder(
          borderRadius: BorderRadius.circular(12),
          borderSide: const BorderSide(color: Color(0xFFF1C40F), width: 2),
        ),
        errorBorder: OutlineInputBorder(
          borderRadius: BorderRadius.circular(12),
          borderSide: const BorderSide(color: Color(0xFFE74C3C), width: 1),
        ),
        focusedErrorBorder: OutlineInputBorder(
          borderRadius: BorderRadius.circular(12),
          borderSide: const BorderSide(color: Color(0xFFE74C3C), width: 2),
        ),
        contentPadding: const EdgeInsets.symmetric(
          horizontal: 16,
          vertical: 14,
        ),
      ),
    );
  }

  Widget _buildRoleSelection() {
    return Column(
      children: EmployeeRole.values.map((role) {
        final isSelected = _selectedRole == role;
        return Padding(
          padding: const EdgeInsets.only(bottom: 12),
          child: InkWell(
            onTap: () {
              setState(() {
                _selectedRole = role;
              });
            },
            borderRadius: BorderRadius.circular(12),
            child: Container(
              padding: const EdgeInsets.all(16),
              decoration: BoxDecoration(
                color: isSelected
                    ? _getRoleColor(role).withOpacity(0.2)
                    : const Color(0xFF1a1a2e),
                borderRadius: BorderRadius.circular(12),
                border: Border.all(
                  color: isSelected
                      ? _getRoleColor(role)
                      : const Color(0xFF2C3E50),
                  width: 2,
                ),
              ),
              child: Row(
                children: [
                  Container(
                    padding: const EdgeInsets.all(10),
                    decoration: BoxDecoration(
                      color: _getRoleColor(role).withOpacity(0.2),
                      shape: BoxShape.circle,
                    ),
                    child: Icon(
                      _getRoleIcon(role),
                      color: _getRoleColor(role),
                      size: 24,
                    ),
                  ),
                  const SizedBox(width: 16),
                  Expanded(
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Text(
                          role.arabicName,
                          style: TextStyle(
                            fontSize: 18,
                            fontWeight: FontWeight.bold,
                            color: isSelected
                                ? _getRoleColor(role)
                                : Colors.white,
                          ),
                        ),
                        const SizedBox(height: 4),
                        Text(
                          _getRoleDescription(role),
                          style: const TextStyle(
                            fontSize: 14,
                            color: Color(0xFF95A5A6),
                          ),
                        ),
                      ],
                    ),
                  ),
                  if (isSelected)
                    Icon(
                      Icons.check_circle,
                      color: _getRoleColor(role),
                      size: 28,
                    ),
                ],
              ),
            ),
          ),
        );
      }).toList(),
    );
  }

  Color _getRoleColor(EmployeeRole role) {
    switch (role) {
      case EmployeeRole.admin:
        return const Color(0xFF9B59B6);
      case EmployeeRole.accountant:
        return const Color(0xFFF39C12);
      case EmployeeRole.employee:
        return const Color(0xFF27AE60);
    }
  }

  IconData _getRoleIcon(EmployeeRole role) {
    switch (role) {
      case EmployeeRole.admin:
        return Icons.admin_panel_settings;
      case EmployeeRole.accountant:
        return Icons.account_balance;
      case EmployeeRole.employee:
        return Icons.person;
    }
  }

  String _getRoleDescription(EmployeeRole role) {
    switch (role) {
      case EmployeeRole.admin:
        return 'صلاحيات كاملة لإدارة النظام';
      case EmployeeRole.accountant:
        return 'إدارة الحسابات والمعاملات المالية';
      case EmployeeRole.employee:
        return 'صلاحيات محدودة للعمليات اليومية';
    }
  }

  void _saveEmployee() {
    if (_formKey.currentState!.validate()) {
      final employee = Employee(
        id: widget.employee?.id,
        name: _nameController.text.trim(),
        phone: _phoneController.text.trim(),
        address: _addressController.text.trim(),
        role: _selectedRole,
        createdAt: widget.employee?.createdAt ?? DateTime.now(),
        updatedAt: isEditing ? DateTime.now() : null,
      );

      widget.onSave(employee);
    }
  }
}


