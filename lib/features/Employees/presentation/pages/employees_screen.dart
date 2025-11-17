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


// class EmployeeCard extends StatelessWidget {
//   final Employee employee;
//   final VoidCallback onEdit;
//   final VoidCallback onDelete;

//   const EmployeeCard({
//     super.key,
//     required this.employee,
//     required this.onEdit,
//     required this.onDelete,
//   });

//   @override
//   Widget build(BuildContext context) {
//     return Container(
//       decoration: BoxDecoration(
//         color: const Color(0xFF16213e),
//         borderRadius: BorderRadius.circular(16),
//         border: Border.all(
//           color: _getRoleColor(employee.role).withOpacity(0.3),
//           width: 1,
//         ),
//       ),
//       child: Column(
//         children: [
//           // Header with Role Badge
//           Container(
//             padding: const EdgeInsets.all(16),
//             decoration: BoxDecoration(
//               color: _getRoleColor(employee.role).withOpacity(0.1),
//               borderRadius: const BorderRadius.only(
//                 topLeft: Radius.circular(16),
//                 topRight: Radius.circular(16),
//               ),
//             ),
//             child: Row(
//               children: [
//                 // Avatar
//                 Container(
//                   width: 60,
//                   height: 60,
//                   decoration: BoxDecoration(
//                     color: _getRoleColor(employee.role).withOpacity(0.2),
//                     shape: BoxShape.circle,
//                   ),
//                   child: Center(
//                     child: Text(
//                       employee.name.isNotEmpty ? employee.name[0] : 'م',
//                       style: TextStyle(
//                         fontSize: 24,
//                         fontWeight: FontWeight.bold,
//                         color: _getRoleColor(employee.role),
//                       ),
//                     ),
//                   ),
//                 ),
//                 const SizedBox(width: 16),

//                 // Name & Role
//                 Expanded(
//                   child: Column(
//                     crossAxisAlignment: CrossAxisAlignment.start,
//                     children: [
//                       Text(
//                         employee.name,
//                         style: const TextStyle(
//                           fontSize: 20,
//                           fontWeight: FontWeight.bold,
//                           color: Colors.white,
//                         ),
//                       ),
//                       const SizedBox(height: 4),
//                       Container(
//                         padding: const EdgeInsets.symmetric(
//                           horizontal: 12,
//                           vertical: 4,
//                         ),
//                         decoration: BoxDecoration(
//                           color: _getRoleColor(employee.role).withOpacity(0.2),
//                           borderRadius: BorderRadius.circular(12),
//                         ),
//                         child: Row(
//                           mainAxisSize: MainAxisSize.min,
//                           children: [
//                             Icon(
//                               _getRoleIcon(employee.role),
//                               size: 14,
//                               color: _getRoleColor(employee.role),
//                             ),
//                             const SizedBox(width: 4),
//                             Text(
//                               employee.role.arabicName,
//                               style: TextStyle(
//                                 fontSize: 10,
//                                 fontWeight: FontWeight.bold,
//                                 color: _getRoleColor(employee.role),
//                               ),
//                             ),
//                           ],
//                         ),
//                       ),
//                     ],
//                   ),
//                 ),

//                 // Action Buttons
//                 Row(
//                   children: [
//                     IconButton(
//                       onPressed: onEdit,
//                       icon: const Icon(Icons.edit_outlined),
//                       color: const Color(0xFF3498DB),
//                       tooltip: 'تعديل',
//                     ),
//                     IconButton(
//                       onPressed: onDelete,
//                       icon: const Icon(Icons.delete_outline),
//                       color: const Color(0xFFE74C3C),
//                       tooltip: 'حذف',
//                     ),
//                   ],
//                 ),
//               ],
//             ),
//           ),

//           // Details Section
//           Padding(
//             padding: const EdgeInsets.all(16),
//             child: Expanded(
//               child: Column(
//                 children: [
//                   _buildInfoRow(
//                     Icons.phone,
//                     'رقم الهاتف',
//                     employee.phone,
//                     const Color(0xFF3498DB),
//                   ),
//                   const SizedBox(height: 12),
//                   _buildInfoRow(
//                     Icons.location_on,
//                     'العنوان',
//                     employee.address,
//                     const Color(0xFF27AE60),
//                   ),
//                   const SizedBox(height: 12),
//                   _buildInfoRow(
//                     Icons.calendar_today,
//                     'تاريخ الإضافة',
//                     _formatDate(employee.createdAt),
//                     const Color(0xFF95A5A6),
//                   ),
//                 ],
//               ),
//             ),
//           ),
//         ],
//       ),
//     );
//   }

//   Widget _buildInfoRow(IconData icon, String label, String value, Color color) {
//     return Row(
//       children: [
//         Container(
//           padding: const EdgeInsets.all(8),
//           decoration: BoxDecoration(
//             color: color.withOpacity(0.1),
//             borderRadius: BorderRadius.circular(8),
//           ),
//           child: Icon(icon, size: 18, color: color),
//         ),
//         const SizedBox(width: 12),
//         Column(
//           crossAxisAlignment: CrossAxisAlignment.start,
//           children: [
//             Text(
//               label,
//               style: const TextStyle(fontSize: 12, color: Color(0xFF95A5A6)),
//             ),
//             const SizedBox(height: 2),
//             Text(
//               value,
//               style: const TextStyle(
//                 fontSize: 14,
//                 fontWeight: FontWeight.w600,
//                 color: Colors.white,
//               ),
//             ),
//           ],
//         ),
//       ],
//     );
//   }

//   Color _getRoleColor(EmployeeRole role) {
//     switch (role) {
//       case EmployeeRole.admin:
//         return const Color(0xFF9B59B6);
//       case EmployeeRole.accountant:
//         return const Color(0xFFF39C12);
//       case EmployeeRole.employee:
//         return const Color(0xFF27AE60);
//     }
//   }

//   IconData _getRoleIcon(EmployeeRole role) {
//     switch (role) {
//       case EmployeeRole.admin:
//         return Icons.admin_panel_settings;
//       case EmployeeRole.accountant:
//         return Icons.account_balance;
//       case EmployeeRole.employee:
//         return Icons.person;
//     }
//   }

//   String _formatDate(DateTime date) {
//     return '${date.day}/${date.month}/${date.year}';
//   }
// }

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

// Enum للأدوار
// enum EmployeeRole {
//   admin('مدير', 'admin'),
//   accountant('محاسب', 'accountant'),
//   employee('موظف', 'employee');

//   final String arabicName;
//   final String value;

//   const EmployeeRole(this.arabicName, this.value);
// }

// // // نموذج الموظف
// class Employee extends Equatable {
//   final String? id;
//   final String name;
//   final String phone;
//   final String address;
//   final EmployeeRole role;
//   final DateTime createdAt;
//   final DateTime? updatedAt;

//   const Employee({
//     this.id,
//     required this.name,
//     required this.phone,
//     required this.address,
//     required this.role,
//     required this.createdAt,
//     this.updatedAt,
//   });

//   Employee copyWith({
//     String? id,
//     String? name,
//     String? phone,
//     String? address,
//     EmployeeRole? role,
//     DateTime? createdAt,
//     DateTime? updatedAt,
//   }) {
//     return Employee(
//       id: id ?? this.id,
//       name: name ?? this.name,
//       phone: phone ?? this.phone,
//       address: address ?? this.address,
//       role: role ?? this.role,
//       createdAt: createdAt ?? this.createdAt,
//       updatedAt: updatedAt ?? this.updatedAt,
//     );
//   }

//   @override
//   List<Object?> get props => [
//     id,
//     name,
//     phone,
//     address,
//     role,
//     createdAt,
//     updatedAt,
//   ];
// }

class RoleDistributionCard extends StatelessWidget {
  final int admins;
  final int accountants;
  final int employees;
  final int totalEmployees;

  const RoleDistributionCard({
    super.key,
    required this.admins,
    required this.accountants,
    required this.employees,
    required this.totalEmployees,
  });

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: const EdgeInsets.all(24),
      decoration: BoxDecoration(
        color: AlessamyColors.cardBackground,
        borderRadius: BorderRadius.circular(16),
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          // Title Row
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              const Text(
                'توزيع الموظفين حسب الدور',
                style: TextStyle(
                  fontSize: 20,
                  fontWeight: FontWeight.bold,
                  color: Colors.white,
                ),
              ),
              IconButton(
                onPressed: () {},
                icon: const Icon(Icons.more_horiz),
                color: const Color(0xFF95A5A6),
              ),
            ],
          ),

          const SizedBox(height: 32),

          SizedBox(
            height: 280,
            child: Row(
              children: [
                // Pie Chart
                Expanded(
                  flex: 2,
                  child: PieChart(
                    PieChartData(
                      sectionsSpace: 2,
                      centerSpaceRadius: 60,
                      sections: [
                        PieChartSectionData(
                          value: admins.toDouble(),
                          title: '$admins',
                          color: const Color(0xFF9B59B6),
                          radius: 60,
                          titleStyle: const TextStyle(
                            fontSize: 18,
                            fontWeight: FontWeight.bold,
                            color: Colors.white,
                          ),
                        ),
                        PieChartSectionData(
                          value: accountants.toDouble(),
                          title: '$accountants',
                          color: const Color(0xFFF39C12),
                          radius: 60,
                          titleStyle: const TextStyle(
                            fontSize: 18,
                            fontWeight: FontWeight.bold,
                            color: Colors.white,
                          ),
                        ),
                        PieChartSectionData(
                          value: employees.toDouble(),
                          title: '$employees',
                          color: const Color(0xFF27AE60),
                          radius: 60,
                          titleStyle: const TextStyle(
                            fontSize: 18,
                            fontWeight: FontWeight.bold,
                            color: Colors.white,
                          ),
                        ),
                      ],
                    ),
                  ),
                ),

                const SizedBox(width: 32),

                // Legend
                Expanded(
                  child: Column(
                    mainAxisAlignment: MainAxisAlignment.center,
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      LegendItemRow(
                        label: 'مدراء',
                        count: admins,
                        total: totalEmployees,
                        color: const Color(0xFF9B59B6),
                      ),
                      const SizedBox(height: 16),
                      LegendItemRow(
                        label: 'محاسبين',
                        count: accountants,
                        total: totalEmployees,
                        color: const Color(0xFFF39C12),
                      ),
                      const SizedBox(height: 16),
                      LegendItemRow(
                        label: 'موظفين',
                        count: employees,
                        total: totalEmployees,
                        color: const Color(0xFF27AE60),
                      ),
                    ],
                  ),
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }
}

class LegendItemRow extends StatelessWidget {
  final String label;
  final int count;
  final int total;
  final Color color;

  const LegendItemRow({
    super.key,
    required this.label,
    required this.count,
    required this.total,
    required this.color,
  });

  @override
  Widget build(BuildContext context) {
    final percentage = total == 0
        ? '0%'
        : '${((count / total) * 100).toStringAsFixed(1)}%';

    return Row(
      children: [
        Container(
          width: 14,
          height: 14,
          decoration: BoxDecoration(color: color, shape: BoxShape.circle),
        ),
        const SizedBox(width: 12),
        Text(label, style: const TextStyle(color: Colors.white, fontSize: 16)),
        const SizedBox(width: 12),
        Text('($percentage)', style: const TextStyle(color: Colors.white70)),
      ],
    );
  }
}

class RoleChip extends StatelessWidget {
  final String label;
  final EmployeeRole? role;
  final EmployeeRole? selectedRole;
  final ValueChanged<EmployeeRole?> onSelected;

  const RoleChip({
    super.key,
    required this.label,
    required this.role,
    required this.selectedRole,
    required this.onSelected,
  });

  @override
  Widget build(BuildContext context) {
    final isSelected = selectedRole == role;

    return FilterChip(
      label: Text(label),
      selected: isSelected,
      onSelected: (selected) {
        onSelected(selected ? role : null);
      },
      labelStyle: TextStyle(
        color: isSelected ? const Color(0xFF1a1a2e) : Colors.white,
        fontWeight: FontWeight.bold,
      ),
      backgroundColor: const Color(0xFF1a1a2e),
      selectedColor: const Color(0xFFF1C40F),
      checkmarkColor: const Color(0xFF1a1a2e),
      padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 8),
      shape: RoundedRectangleBorder(
        borderRadius: BorderRadius.circular(20),
        side: BorderSide(
          color: isSelected ? const Color(0xFFF1C40F) : const Color(0xFF95A5A6),
          width: 1,
        ),
      ),
    );
  }
}
