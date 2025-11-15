// import 'package:flutter/material.dart';
// import 'package:flutter_bloc/flutter_bloc.dart';
// import 'package:summit_team/features/Employees/presentation/cubit/employees_cubit.dart';
// import 'package:summit_team/features/Employees/presentation/widgets/employee_card.dart';
// import 'package:summit_team/features/Employees/presentation/widgets/employee_form_dialog.dart';
// import 'package:summit_team/features/Employees/presentation/widgets/employee_role_filter.dart';

// class EmployeesScreen extends StatefulWidget {
//   const EmployeesScreen({super.key});

//   @override
//   State<EmployeesScreen> createState() => _EmployeesScreenState();
// }

// class _EmployeesScreenState extends State<EmployeesScreen> {
//   @override
//   void initState() {
//     super.initState();
//     // Load employees when screen opens
//     context.read<EmployeesCubit>().getAllEmployees();
//   }

//   void _showAddEmployeeDialog() {
//     showDialog(
//       context: context,
//       builder: (dialogContext) => BlocProvider.value(
//         value: context.read<EmployeesCubit>(),
//         child: const EmployeeFormDialog(),
//       ),
//     );
//   }

//   @override
//   Widget build(BuildContext context) {
//     return Scaffold(
//       appBar: AppBar(
//         title: const Text('الموظفين'),
//         centerTitle: true,
//         elevation: 0,
//         actions: [
//           IconButton(
//             icon: const Icon(Icons.refresh),
//             onPressed: () {
//               context.read<EmployeesCubit>().getAllEmployees();
//             },
//             tooltip: 'تحديث',
//           ),
//         ],
//       ),
//       body: Column(
//         children: [
//           // Role Filter
//           const EmployeeRoleFilter(),
//           const Divider(height: 1),

//           // Employees List
//           Expanded(
//             child: BlocBuilder<EmployeesCubit, EmployeesState>(
//               builder: (context, state) {
//                 if (state is EmployeesLoading) {
//                   return const Center(
//                     child: CircularProgressIndicator(),
//                   );
//                 }

//                 if (state is EmployeesError) {
//                   return Center(
//                     child: Column(
//                       mainAxisAlignment: MainAxisAlignment.center,
//                       children: [
//                         Icon(
//                           Icons.error_outline,
//                           size: 64,
//                           color: Colors.red.shade300,
//                         ),
//                         const SizedBox(height: 16),
//                         Text(
//                           'حدث خطأ',
//                           style: TextStyle(
//                             fontSize: 20,
//                             fontWeight: FontWeight.bold,
//                             color: Colors.red.shade700,
//                           ),
//                         ),
//                         const SizedBox(height: 8),
//                         Padding(
//                           padding: const EdgeInsets.symmetric(horizontal: 32),
//                           child: Text(
//                             state.message,
//                             textAlign: TextAlign.center,
//                             style: TextStyle(
//                               color: Colors.grey.shade600,
//                             ),
//                           ),
//                         ),
//                         const SizedBox(height: 16),
//                         ElevatedButton.icon(
//                           onPressed: () {
//                             context.read<EmployeesCubit>().getAllEmployees();
//                           },
//                           icon: const Icon(Icons.refresh),
//                           label: const Text('إعادة المحاولة'),
//                         ),
//                       ],
//                     ),
//                   );
//                 }

//                 if (state is EmployeesLoaded) {
//                   if (state.employees.isEmpty) {
//                     return Center(
//                       child: Column(
//                         mainAxisAlignment: MainAxisAlignment.center,
//                         children: [
//                           Icon(
//                             Icons.people_outline,
//                             size: 80,
//                             color: Colors.grey.shade300,
//                           ),
//                           const SizedBox(height: 16),
//                           Text(
//                             state.filteredRole != null
//                                 ? 'لا يوجد موظفين بهذا الدور'
//                                 : 'لا يوجد موظفين',
//                             style: TextStyle(
//                               fontSize: 18,
//                               color: Colors.grey.shade600,
//                               fontWeight: FontWeight.w500,
//                             ),
//                           ),
//                           const SizedBox(height: 8),
//                           Text(
//                             'ابدأ بإضافة موظفين جدد',
//                             style: TextStyle(
//                               color: Colors.grey.shade500,
//                             ),
//                           ),
//                           const SizedBox(height: 24),
//                           ElevatedButton.icon(
//                             onPressed: _showAddEmployeeDialog,
//                             icon: const Icon(Icons.add),
//                             label: const Text('إضافة موظف'),
//                           ),
//                         ],
//                       ),
//                     );
//                   }

//                   return RefreshIndicator(
//                     onRefresh: () async {
//                       if (state.filteredRole != null) {
//                         context
//                             .read<EmployeesCubit>()
//                             .getEmployeesByRole(state.filteredRole!);
//                       } else {
//                         context.read<EmployeesCubit>().getAllEmployees();
//                       }
//                     },
//                     child: LayoutBuilder(
//                       builder: (context, constraints) {
//                         // Responsive grid
//                         int crossAxisCount = 1;
//                         if (constraints.maxWidth > 1200) {
//                           crossAxisCount = 3; // Desktop
//                         } else if (constraints.maxWidth > 800) {
//                           crossAxisCount = 2; // Tablet
//                         }

//                         return GridView.builder(
//                           padding: const EdgeInsets.all(16),
//                           gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
//                             crossAxisCount: crossAxisCount,
//                             childAspectRatio: 1.5,
//                             crossAxisSpacing: 16,
//                             mainAxisSpacing: 16,
//                           ),
//                           itemCount: state.employees.length,
//                           itemBuilder: (context, index) {
//                             return EmployeeCard(
//                               employee: state.employees[index],
//                             );
//                           },
//                         );
//                       },
//                     ),
//                   );
//                 }

//                 return const SizedBox.shrink();
//               },
//             ),
//           ),
//         ],
//       ),
//       floatingActionButton: FloatingActionButton.extended(
//         onPressed: _showAddEmployeeDialog,
//         icon: const Icon(Icons.add),
//         label: const Text('إضافة موظف'),
//       ),
//     );
//   }
// }

import 'package:equatable/equatable.dart';
import 'package:flutter/material.dart';

import 'package:fl_chart/fl_chart.dart';
import 'package:summit_team/core/utils/alessamy_colors.dart';
import 'package:summit_team/features/dashboard/presentation/widgets/custom_drower.dart';
import 'package:summit_team/features/dashboard/presentation/widgets/dashboard_stats_card.dart';

class ProfessionalEmployeesDashboard extends StatefulWidget {
  const ProfessionalEmployeesDashboard({super.key});

  @override
  State<ProfessionalEmployeesDashboard> createState() =>
      _ProfessionalEmployeesDashboardState();
}

class _ProfessionalEmployeesDashboardState
    extends State<ProfessionalEmployeesDashboard> {
  // بيانات تجريبية
  final int totalEmployees = 125;
  final int admins = 8;
  final int accountants = 22;
  final int employees = 95;
  final double growthRate = 12.5;
  final int newThisMonth = 15;
  EmployeeRole? selectedRole;

  // للبحث والفلتر
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
      // فلترة بالدور
      final roleMatch = selectedRole == null || employee.role == selectedRole;

      // فلترة بالبحث (اسم أو رقم هاتف)
      final searchMatch =
          _searchQuery.isEmpty ||
          employee.name.contains(_searchQuery) ||
          employee.phone.contains(_searchQuery);

      return roleMatch && searchMatch;
    }).toList();
  }

  @override
  Widget build(BuildContext context) {
    return Directionality(
      textDirection: TextDirection.rtl,
      child: Scaffold(
        backgroundColor: AlessamyColors.backgroundColor,
        body: Row(
          children: [
            Expanded(flex: 1, child: CustomDrower()),
            Expanded(
              flex: 5,
              child: CustomScrollView(
                slivers: [
                  // App Bar
                  SliverAppBar(
                    backgroundColor: AlessamyColors.cardBackground,
                    pinned: true,
                    expandedHeight: 100,
                    toolbarHeight: 80, // ارتفاع عند التمرير إلى الأعلى

                    flexibleSpace: FlexibleSpaceBar(
                      titlePadding: const EdgeInsets.symmetric(
                        horizontal: 24,
                        vertical: 12,
                      ),

                      title: Row(
                        children: [
                          Expanded(
                            flex: 3,
                            child: Text(
                              "SUMMIT TEAM",
                              style: const TextStyle(
                                fontSize: 22,
                                fontWeight: FontWeight.bold,
                                color: Colors.white,
                              ),
                              overflow: TextOverflow.ellipsis,
                            ),
                          ),
                          const SizedBox(width: 16),
                          Expanded(
                            flex: 3,
                            child: SizedBox(
                              height: 40,
                              child: TextField(
                                // controller: searchController,
                                decoration: InputDecoration(
                                  hintText: 'بحث...',
                                  prefixIcon: const Icon(Icons.search),
                                  filled: true,
                                  fillColor: Colors.white,
                                  contentPadding: const EdgeInsets.symmetric(
                                    vertical: 0,
                                    horizontal: 12,
                                  ),
                                  border: OutlineInputBorder(
                                    borderRadius: BorderRadius.circular(12),
                                    borderSide: BorderSide.none,
                                  ),
                                ),
                              ),
                            ),
                          ),
                          const SizedBox(width: 16),
                          Expanded(
                            flex: 2,
                            child: Row(
                              children: [
                                CircleAvatar(
                                  radius: 20,
                                  backgroundColor: AlessamyColors.primaryGold,
                                  child: IconButton(
                                    onPressed: () {},
                                    icon: const Icon(
                                      Icons.person,
                                      color: Colors.white,
                                      size: 20,
                                    ),
                                  ),
                                ),
                                const SizedBox(width: 8),
                                Expanded(
                                  child: Padding(
                                    padding: const EdgeInsets.all(8.0),
                                    child: Column(
                                      crossAxisAlignment:
                                          CrossAxisAlignment.start,
                                      mainAxisAlignment:
                                          MainAxisAlignment.center,
                                      children: const [
                                        Text(
                                          'اسم المستخدم',
                                          style: TextStyle(
                                            fontSize: 14,
                                            color: Colors.white,
                                          ),
                                          overflow: TextOverflow.ellipsis,
                                        ),
                                        Text(
                                          'دور المستخدم',
                                          style: TextStyle(
                                            fontSize: 12,
                                            color: Colors.white70,
                                          ),
                                          overflow: TextOverflow.ellipsis,
                                        ),
                                      ],
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
                  // Main Content
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
                                  child: _buildStatsRow(context),
                                ),
                              ),
                            ),
                            const SizedBox(width: 40),
                            // Pie Chart - توزيع الموظفين
                            Expanded(child: _buildRoleDistributionCard()),

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
                        _buildFiltersSection(),

                        const SizedBox(height: 24),

                        // Employees List
                        _buildEmployeesListSection(),
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

  Widget _buildAppBar() {
    return Padding(
      padding: const EdgeInsets.fromLTRB(24, 60, 24, 20),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        crossAxisAlignment: CrossAxisAlignment.end,
        children: [
          Column(
            mainAxisAlignment: MainAxisAlignment.end,
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              const Text(
                'لوحة تحكم الموظفين',
                style: TextStyle(
                  fontSize: 20,
                  fontWeight: FontWeight.bold,
                  color: Colors.white,
                ),
              ),
              const SizedBox(height: 8),
              Row(
                children: [
                  // Container(
                  //   padding: const EdgeInsets.symmetric(
                  //     horizontal: 12,
                  //     vertical: 6,
                  //   ),
                  //   decoration: BoxDecoration(
                  //     color: const Color(0xFF27AE60).withOpacity(0.2),
                  //     borderRadius: BorderRadius.circular(20),
                  //   ),
                  //   child: Row(
                  //     children: [
                  //       const Icon(
                  //         Icons.trending_up,
                  //         color: Color(0xFF27AE60),
                  //         size: 16,
                  //       ),
                  //       const SizedBox(width: 4),
                  //       Text(
                  //         '+$growthRate% نمو هذا الشهر',
                  //         style: const TextStyle(
                  //           color: Color(0xFF27AE60),
                  //           fontSize: 14,
                  //           fontWeight: FontWeight.bold,
                  //         ),
                  //       ),
                  //     ],
                  //   ),
                  // ),
                  const SizedBox(width: 12),
                  Text(
                    'آخر تحديث: ${DateTime.now().hour}:${DateTime.now().minute.toString().padLeft(2, '0')}',
                    style: const TextStyle(
                      color: Color(0xFF95A5A6),
                      fontSize: 14,
                    ),
                  ),
                ],
              ),
            ],
          ),
          ElevatedButton.icon(
            onPressed: () {
              // _showAddEmployeeDialog();
            },
            icon: const Icon(Icons.add, size: 20),
            label: const Text(
              'إضافة موظف',
              style: TextStyle(fontSize: 16, fontWeight: FontWeight.bold),
            ),
            style: ElevatedButton.styleFrom(
              backgroundColor: const Color(0xFFF1C40F),
              foregroundColor: const Color(0xFF0F1419),
              padding: const EdgeInsets.symmetric(horizontal: 32, vertical: 16),
              shape: RoundedRectangleBorder(
                borderRadius: BorderRadius.circular(12),
              ),
              elevation: 0,
            ),
          ),
        ],
      ),
    );
  }
  //  Widget _buildStatsCards(BuildContext context) {
  //     return Padding(
  //       padding: const EdgeInsets.symmetric(horizontal: 32, vertical: 16),
  //       child: Column(
  //         children: [
  //           Row(
  //             children: [
  //               Expanded(
  //                 child: DashboardStatsCard(
  //                   title: 'إجمالي العقارات',
  //                   value: '${_properties.length}',
  //                   icon: Icons.home_work,
  //                   color: Colors.blue,
  //                 ),
  //               ),
  //               const SizedBox(width: 16),
  //               Expanded(
  //                 child: DashboardStatsCard(
  //                   title: 'عقارات للبيع',
  //                   value:
  //                       '${_properties.where((p) => p.purpose == PropertyPurpose.sale).length}',
  //                   icon: Icons.sell,
  //                   color: Colors.green,
  //                 ),
  //               ),
  //             ],
  //           ),
  //           const SizedBox(height: 16),
  //           Row(
  //             children: [
  //               Expanded(
  //                 child: DashboardStatsCard(
  //                   title: 'عقارات للإيجار',
  //                   value:
  //                       '${_properties.where((p) => p.purpose == PropertyPurpose.rent).length}',
  //                   icon: Icons.key,
  //                   color: Colors.orange,
  //                 ),
  //               ),
  //               const SizedBox(width: 16),
  //               Expanded(
  //                 child: DashboardStatsCard(
  //                   title: 'عقارات مميزة',
  //                   value: '${_properties.where((p) => p.isFeatured).length}',
  //                   icon: Icons.star,
  //                   color: Colors.amber,
  //                 ),
  //               ),
  //             ],
  //           ),
  //         ],
  //       ),
  //     );
  //   }

  Widget _buildStatsRow(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 32, vertical: 16),
      child: Column(
        children: [
          Row(
            children: [
              Expanded(
                child: DashboardStatsCard(
                  title: 'إجمالي الموظفين',
                  value: totalEmployees.toString(),
                  icon: Icons.people,
                  color: const Color(0xFF3498DB),
                  // subtitle: '+$newThisMonth موظف جديد',
                ),
              ),
              const SizedBox(width: 16),
              Expanded(
                child: DashboardStatsCard(
                  title: 'مدراء',
                  value: admins.toString(),
                  icon: Icons.admin_panel_settings,
                  color: const Color(0xFF9B59B6),
                  // subtitle:
                  //     '${((admins / totalEmployees) * 100).toStringAsFixed(1)}% من الإجمالي',
                ),
              ),
            ],
          ),
          const SizedBox(height: 16),
          Row(
            children: [
              Expanded(
                child: DashboardStatsCard(
                  title: 'محاسبين',
                  value: accountants.toString(),
                  icon: Icons.account_balance,
                  color: const Color(0xFFF39C12),
                  // subtitle:
                  //     '${((accountants / totalEmployees) * 100).toStringAsFixed(1)}% من الإجمالي',
                ),
              ),
              const SizedBox(width: 16),
              Expanded(
                child: DashboardStatsCard(
                  title: 'موظفين',
                  value: employees.toString(),
                  icon: Icons.person,
                  color: const Color(0xFF27AE60),
                  // :
                  //     '${((employees / totalEmployees) * 100).toStringAsFixed(1)}% من الإجمالي',
                ),
              ),
            ],
          ),
        ],
      ),
    );
  }

  Widget _buildFiltersSection() {
    return Padding(
      padding: const EdgeInsets.all(24),
      child: Container(
        padding: const EdgeInsets.all(20),
        decoration: BoxDecoration(
          color: AlessamyColors.cardBackground,
          borderRadius: BorderRadius.circular(16),
          border: Border.all(color: const Color(0xFF2C3E50), width: 1),
        ),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            // Search Field
            TextField(
              controller: _searchController,
              onChanged: (value) {
                setState(() {
                  _searchQuery = value;
                });
              },
              style: const TextStyle(color: Colors.white),
              decoration: InputDecoration(
                hintText: 'بحث بالاسم أو رقم الهاتف...',
                hintStyle: const TextStyle(color: Color(0xFF95A5A6)),
                prefixIcon: const Icon(Icons.search, color: Color(0xFFF1C40F)),
                suffixIcon: _searchQuery.isNotEmpty
                    ? IconButton(
                        icon: const Icon(Icons.clear, color: Color(0xFF95A5A6)),
                        onPressed: () {
                          setState(() {
                            _searchController.clear();
                            _searchQuery = '';
                          });
                        },
                      )
                    : null,
                filled: true,
                fillColor: const Color(0xFF1a1a2e),
                border: OutlineInputBorder(
                  borderRadius: BorderRadius.circular(12),
                  borderSide: BorderSide.none,
                ),
                enabledBorder: OutlineInputBorder(
                  borderRadius: BorderRadius.circular(12),
                  borderSide: const BorderSide(
                    color: Color(0xFF2C3E50),
                    width: 1,
                  ),
                ),
                focusedBorder: OutlineInputBorder(
                  borderRadius: BorderRadius.circular(12),
                  borderSide: const BorderSide(
                    color: Color(0xFFF1C40F),
                    width: 2,
                  ),
                ),
                contentPadding: const EdgeInsets.symmetric(
                  horizontal: 16,
                  vertical: 14,
                ),
              ),
            ),
            const SizedBox(height: 20),
            const Text(
              'تصفية حسب الدور الوظيفي:',
              style: TextStyle(
                color: Colors.white,
                fontSize: 16,
                fontWeight: FontWeight.bold,
              ),
            ),
            const SizedBox(height: 12),
            Wrap(
              spacing: 8,
              runSpacing: 8,
              children: [
                _buildRoleChip('الكل', null),
                _buildRoleChip('مدير', EmployeeRole.admin),
                _buildRoleChip('محاسب', EmployeeRole.accountant),
                _buildRoleChip('موظف', EmployeeRole.employee),
              ],
            ),
          ],
        ),
      ),
    );
  }

  Widget _buildEmployeesListSection() {
    final filteredEmployees = _filteredEmployees;

    return Card(
      color: AlessamyColors.cardBackground,
      child: Padding(
        padding: const EdgeInsets.all(24),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    const Text(
                      'قائمة الموظفين',
                      style: TextStyle(
                        fontSize: 24,
                        fontWeight: FontWeight.bold,
                        color: Colors.white,
                      ),
                    ),
                    const SizedBox(height: 4),
                    Text(
                      'إجمالي النتائج: ${filteredEmployees.length}',
                      style: const TextStyle(
                        fontSize: 14,
                        color: Color(0xFF95A5A6),
                      ),
                    ),
                  ],
                ),
                if (selectedRole != null || _searchQuery.isNotEmpty)
                  TextButton.icon(
                    onPressed: () {
                      setState(() {
                        selectedRole = null;
                        _searchController.clear();
                        _searchQuery = '';
                      });
                    },
                    icon: const Icon(Icons.clear_all, color: Color(0xFFF1C40F)),
                    label: const Text(
                      'إلغاء الفلترة',
                      style: TextStyle(
                        color: Color(0xFFF1C40F),
                        fontWeight: FontWeight.bold,
                      ),
                    ),
                  ),
              ],
            ),
            const SizedBox(height: 24),

            if (filteredEmployees.isEmpty)
              Center(
                child: Padding(
                  padding: const EdgeInsets.all(48),
                  child: Column(
                    children: [
                      Icon(
                        Icons.search_off,
                        size: 80,
                        color: const Color(0xFF95A5A6).withOpacity(0.5),
                      ),
                      const SizedBox(height: 16),
                      const Text(
                        'لا توجد نتائج',
                        style: TextStyle(
                          fontSize: 20,
                          fontWeight: FontWeight.bold,
                          color: Color(0xFF95A5A6),
                        ),
                      ),
                      const SizedBox(height: 8),
                      const Text(
                        'جرب تغيير معايير البحث أو الفلترة',
                        style: TextStyle(
                          fontSize: 14,
                          color: Color(0xFF95A5A6),
                        ),
                      ),
                    ],
                  ),
                ),
              )
            else
              Card(
                color: AlessamyColors.cardBackground,

                child: GridView.builder(
                  shrinkWrap: true,
                  physics: const NeverScrollableScrollPhysics(),
                  gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
                    crossAxisCount: 3,
                    childAspectRatio: 1.5,
                    crossAxisSpacing: 16,
                    mainAxisSpacing: 16,
                  ),
                  itemCount: filteredEmployees.length,
                  itemBuilder: (context, index) {
                    final employee = filteredEmployees[index];
                    return EmployeeCard(
                      employee: employee,
                      onEdit: () {
                        // TODO: Implement edit
                      },
                      onDelete: () {
                        // TODO: Implement delete
                      },
                    );
                  },
                ),
              ),
          ],
        ),
      ),
    );
  }

  Widget _buildRoleChip(String label, EmployeeRole? role) {
    final isSelected = selectedRole == role;

    return FilterChip(
      label: Text(label),
      selected: isSelected,
      onSelected: (selected) {
        setState(() {
          selectedRole = selected ? role : null;
        });
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

  Widget _buildStatCard(
    String title,
    String value,
    IconData icon,
    Color color,
    String subtitle,
  ) {
    return Container(
      padding: const EdgeInsets.all(24),
      decoration: BoxDecoration(
        color: AlessamyColors.cardBackground,
        borderRadius: BorderRadius.circular(16),
        border: Border.all(color: color.withOpacity(0.2), width: 1),
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              Container(
                padding: const EdgeInsets.all(12),
                decoration: BoxDecoration(
                  color: color.withOpacity(0.1),
                  borderRadius: BorderRadius.circular(12),
                ),
                child: Icon(icon, color: color, size: 24),
              ),
              Icon(Icons.more_vert, color: const Color(0xFF95A5A6), size: 20),
            ],
          ),
          const SizedBox(height: 20),
          Text(
            title,
            style: const TextStyle(
              color: Color(0xFF95A5A6),
              fontSize: 14,
              fontWeight: FontWeight.w500,
            ),
          ),
          const SizedBox(height: 8),
          Text(
            value,
            style: TextStyle(
              color: color,
              fontSize: 36,
              fontWeight: FontWeight.bold,
            ),
          ),
          const SizedBox(height: 12),
          Container(
            padding: const EdgeInsets.symmetric(horizontal: 8, vertical: 4),
            decoration: BoxDecoration(
              color: color.withOpacity(0.1),
              borderRadius: BorderRadius.circular(6),
            ),
            child: Text(
              subtitle,
              style: TextStyle(
                color: color,
                fontSize: 12,
                fontWeight: FontWeight.w600,
              ),
            ),
          ),
        ],
      ),
    );
  }

  Widget _buildRoleDistributionCard() {
    return Container(
      padding: const EdgeInsets.all(24),
      decoration: BoxDecoration(
        color: AlessamyColors.cardBackground,
        borderRadius: BorderRadius.circular(16),
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
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
                Expanded(
                  child: Column(
                    mainAxisAlignment: MainAxisAlignment.center,
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      _buildLegendItem(
                        'مدراء',
                        admins,
                        const Color(0xFF9B59B6),
                      ),
                      const SizedBox(height: 16),
                      _buildLegendItem(
                        'محاسبين',
                        accountants,
                        const Color(0xFFF39C12),
                      ),
                      const SizedBox(height: 16),
                      _buildLegendItem(
                        'موظفين',
                        employees,
                        const Color(0xFF27AE60),
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

  Widget _buildLegendItem(String label, int count, Color color) {
    final percentage = ((count / totalEmployees) * 100).toStringAsFixed(1);

    return Row(
      children: [
        Container(
          width: 16,
          height: 16,
          decoration: BoxDecoration(
            color: color,
            borderRadius: BorderRadius.circular(4),
          ),
        ),
        const SizedBox(width: 12),
        Expanded(
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Text(
                label,
                style: const TextStyle(
                  color: Colors.white,
                  fontSize: 14,
                  fontWeight: FontWeight.w600,
                ),
              ),
              const SizedBox(height: 4),
              Text(
                '$count موظف ($percentage%)',
                style: const TextStyle(color: Color(0xFF95A5A6), fontSize: 12),
              ),
            ],
          ),
        ),
      ],
    );
  }

  Widget _buildMonthlyGrowthCard() {
    return Container(
      padding: const EdgeInsets.all(24),
      decoration: BoxDecoration(
        color: const Color(0xFF1a1f28),
        borderRadius: BorderRadius.circular(16),
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              const Text(
                'نمو الموظفين الشهري',
                style: TextStyle(
                  fontSize: 20,
                  fontWeight: FontWeight.bold,
                  color: Colors.white,
                ),
              ),
              Row(
                children: [
                  _buildChartTypeButton('أشهر', true),
                  const SizedBox(width: 8),
                  _buildChartTypeButton('أسابيع', false),
                ],
              ),
            ],
          ),
          const SizedBox(height: 32),
          SizedBox(
            height: 280,
            child: BarChart(
              BarChartData(
                alignment: BarChartAlignment.spaceAround,
                maxY: 30,
                barTouchData: BarTouchData(
                  enabled: true,
                  touchTooltipData: BarTouchTooltipData(
                    getTooltipItem: (group, groupIndex, rod, rodIndex) {
                      final months = [
                        'يناير',
                        'فبراير',
                        'مارس',
                        'أبريل',
                        'مايو',
                        'يونيو',
                      ];
                      return BarTooltipItem(
                        '${months[group.x.toInt()]}\n${rod.toY.toInt()} موظف',
                        const TextStyle(
                          color: Colors.white,
                          fontWeight: FontWeight.bold,
                        ),
                      );
                    },
                  ),
                ),
                titlesData: FlTitlesData(
                  show: true,
                  rightTitles: const AxisTitles(
                    sideTitles: SideTitles(showTitles: false),
                  ),
                  topTitles: const AxisTitles(
                    sideTitles: SideTitles(showTitles: false),
                  ),
                  bottomTitles: AxisTitles(
                    sideTitles: SideTitles(
                      showTitles: true,
                      getTitlesWidget: (value, meta) {
                        const months = [
                          'يناير',
                          'فبراير',
                          'مارس',
                          'أبريل',
                          'مايو',
                          'يونيو',
                        ];
                        return Padding(
                          padding: const EdgeInsets.only(top: 8),
                          child: Text(
                            months[value.toInt()],
                            style: const TextStyle(
                              color: Color(0xFF95A5A6),
                              fontSize: 12,
                            ),
                          ),
                        );
                      },
                    ),
                  ),
                  leftTitles: AxisTitles(
                    sideTitles: SideTitles(
                      showTitles: true,
                      reservedSize: 40,
                      getTitlesWidget: (value, meta) {
                        return Text(
                          value.toInt().toString(),
                          style: const TextStyle(
                            color: Color(0xFF95A5A6),
                            fontSize: 12,
                          ),
                        );
                      },
                    ),
                  ),
                ),
                gridData: FlGridData(
                  show: true,
                  drawVerticalLine: false,
                  horizontalInterval: 10,
                  getDrawingHorizontalLine: (value) {
                    return FlLine(
                      color: const Color(0xFF2C3E50),
                      strokeWidth: 1,
                    );
                  },
                ),
                borderData: FlBorderData(show: false),
                barGroups: [
                  _buildBarGroup(0, 12, const Color(0xFF3498DB)),
                  _buildBarGroup(1, 18, const Color(0xFF3498DB)),
                  _buildBarGroup(2, 15, const Color(0xFF3498DB)),
                  _buildBarGroup(3, 22, const Color(0xFF3498DB)),
                  _buildBarGroup(4, 20, const Color(0xFF3498DB)),
                  _buildBarGroup(5, 25, const Color(0xFFF1C40F)),
                ],
              ),
            ),
          ),
        ],
      ),
    );
  }

  BarChartGroupData _buildBarGroup(int x, double y, Color color) {
    return BarChartGroupData(
      x: x,
      barRods: [
        BarChartRodData(
          toY: y,
          color: color,
          width: 32,
          borderRadius: const BorderRadius.only(
            topLeft: Radius.circular(6),
            topRight: Radius.circular(6),
          ),
        ),
      ],
    );
  }

  Widget _buildChartTypeButton(String label, bool isSelected) {
    return Container(
      padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 8),
      decoration: BoxDecoration(
        color: isSelected
            ? const Color(0xFFF1C40F).withOpacity(0.2)
            : Colors.transparent,
        borderRadius: BorderRadius.circular(8),
        border: Border.all(
          color: isSelected ? const Color(0xFFF1C40F) : const Color(0xFF2C3E50),
        ),
      ),
      child: Text(
        label,
        style: TextStyle(
          color: isSelected ? const Color(0xFFF1C40F) : const Color(0xFF95A5A6),
          fontSize: 12,
          fontWeight: FontWeight.bold,
        ),
      ),
    );
  }

  Widget _buildGrowthTrendCard() {
    return Container(
      padding: const EdgeInsets.all(24),
      decoration: BoxDecoration(
        color: const Color(0xFF1a1f28),
        borderRadius: BorderRadius.circular(16),
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          const Text(
            'اتجاه النمو',
            style: TextStyle(
              fontSize: 20,
              fontWeight: FontWeight.bold,
              color: Colors.white,
            ),
          ),
          const SizedBox(height: 8),
          const Text(
            'مقارنة بنفس الفترة من العام الماضي',
            style: TextStyle(fontSize: 14, color: Color(0xFF95A5A6)),
          ),
          const SizedBox(height: 32),
          SizedBox(
            height: 280,
            child: LineChart(
              LineChartData(
                gridData: FlGridData(
                  show: true,
                  drawVerticalLine: false,
                  horizontalInterval: 20,
                  getDrawingHorizontalLine: (value) {
                    return FlLine(
                      color: const Color(0xFF2C3E50),
                      strokeWidth: 1,
                    );
                  },
                ),
                titlesData: FlTitlesData(
                  show: true,
                  rightTitles: const AxisTitles(
                    sideTitles: SideTitles(showTitles: false),
                  ),
                  topTitles: const AxisTitles(
                    sideTitles: SideTitles(showTitles: false),
                  ),
                  bottomTitles: AxisTitles(
                    sideTitles: SideTitles(
                      showTitles: true,
                      getTitlesWidget: (value, meta) {
                        const months = [
                          'يناير',
                          'فبراير',
                          'مارس',
                          'أبريل',
                          'مايو',
                          'يونيو',
                        ];
                        if (value.toInt() >= 0 &&
                            value.toInt() < months.length) {
                          return Padding(
                            padding: const EdgeInsets.only(top: 8),
                            child: Text(
                              months[value.toInt()],
                              style: const TextStyle(
                                color: Color(0xFF95A5A6),
                                fontSize: 12,
                              ),
                            ),
                          );
                        }
                        return const Text('');
                      },
                    ),
                  ),
                  leftTitles: AxisTitles(
                    sideTitles: SideTitles(
                      showTitles: true,
                      reservedSize: 40,
                      getTitlesWidget: (value, meta) {
                        return Text(
                          value.toInt().toString(),
                          style: const TextStyle(
                            color: Color(0xFF95A5A6),
                            fontSize: 12,
                          ),
                        );
                      },
                    ),
                  ),
                ),
                borderData: FlBorderData(show: false),
                lineBarsData: [
                  // العام الحالي
                  LineChartBarData(
                    spots: const [
                      FlSpot(0, 80),
                      FlSpot(1, 95),
                      FlSpot(2, 100),
                      FlSpot(3, 110),
                      FlSpot(4, 115),
                      FlSpot(5, 125),
                    ],
                    isCurved: true,
                    color: const Color(0xFF27AE60),
                    barWidth: 3,
                    isStrokeCapRound: true,
                    dotData: FlDotData(
                      show: true,
                      getDotPainter: (spot, percent, barData, index) {
                        return FlDotCirclePainter(
                          radius: 4,
                          color: const Color(0xFF27AE60),
                          strokeWidth: 2,
                          strokeColor: const Color(0xFF1a1f28),
                        );
                      },
                    ),
                    belowBarData: BarAreaData(
                      show: true,
                      color: const Color(0xFF27AE60).withOpacity(0.1),
                    ),
                  ),
                  // العام الماضي
                  LineChartBarData(
                    spots: const [
                      FlSpot(0, 70),
                      FlSpot(1, 75),
                      FlSpot(2, 80),
                      FlSpot(3, 85),
                      FlSpot(4, 90),
                      FlSpot(5, 95),
                    ],
                    isCurved: true,
                    color: const Color(0xFF95A5A6),
                    barWidth: 2,
                    isStrokeCapRound: true,
                    dashArray: [5, 5],
                    dotData: const FlDotData(show: false),
                  ),
                ],
              ),
            ),
          ),
          const SizedBox(height: 24),
          Row(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              _buildTrendLegend('2024', const Color(0xFF27AE60), false),
              const SizedBox(width: 24),
              _buildTrendLegend('2023', const Color(0xFF95A5A6), true),
            ],
          ),
        ],
      ),
    );
  }

  Widget _buildTrendLegend(String label, Color color, bool isDashed) {
    return Row(
      children: [
        Container(
          width: 24,
          height: 3,
          decoration: BoxDecoration(
            color: color,
            borderRadius: BorderRadius.circular(2),
          ),
        ),
        if (isDashed) ...[
          const SizedBox(width: 4),
          Container(
            width: 4,
            height: 3,
            decoration: BoxDecoration(
              color: color,
              borderRadius: BorderRadius.circular(2),
            ),
          ),
        ],
        const SizedBox(width: 8),
        Text(
          label,
          style: TextStyle(
            color: color,
            fontSize: 14,
            fontWeight: FontWeight.w600,
          ),
        ),
      ],
    );
  }

  Widget _buildRecentEmployeesCard() {
    final recentEmployees = [
      {'name': 'أحمد محمد', 'role': 'مدير', 'color': const Color(0xFF9B59B6)},
      {
        'name': 'فاطمة عبدالله',
        'role': 'محاسب',
        'color': const Color(0xFFF39C12),
      },
      {'name': 'خالد أحمد', 'role': 'موظف', 'color': const Color(0xFF27AE60)},
      {'name': 'سارة محمود', 'role': 'محاسب', 'color': const Color(0xFFF39C12)},
      {'name': 'عمر حسن', 'role': 'موظف', 'color': const Color(0xFF27AE60)},
    ];

    return Container(
      padding: const EdgeInsets.all(24),
      decoration: BoxDecoration(
        color: AlessamyColors.cardBackground,
        borderRadius: BorderRadius.circular(16),
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              const Text(
                'الموظفون الجدد',
                style: TextStyle(
                  fontSize: 20,
                  fontWeight: FontWeight.bold,
                  color: Colors.white,
                ),
              ),
              TextButton(
                onPressed: () {},
                child: const Text(
                  'عرض الكل',
                  style: TextStyle(
                    color: Color(0xFFF1C40F),
                    fontWeight: FontWeight.w600,
                  ),
                ),
              ),
            ],
          ),
          const SizedBox(height: 16),
          ...recentEmployees.map((employee) {
            return Padding(
              padding: const EdgeInsets.only(bottom: 16),
              child: Row(
                children: [
                  Container(
                    width: 48,
                    height: 48,
                    decoration: BoxDecoration(
                      color: (employee['color'] as Color).withOpacity(0.2),
                      shape: BoxShape.circle,
                    ),
                    child: Center(
                      child: Text(
                        (employee['name'] as String)[0],
                        style: TextStyle(
                          fontSize: 20,
                          fontWeight: FontWeight.bold,
                          color: employee['color'] as Color,
                        ),
                      ),
                    ),
                  ),
                  const SizedBox(width: 12),
                  Expanded(
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Text(
                          employee['name'] as String,
                          style: const TextStyle(
                            color: Colors.white,
                            fontSize: 16,
                            fontWeight: FontWeight.w600,
                          ),
                        ),
                        const SizedBox(height: 4),
                        Text(
                          employee['role'] as String,
                          style: TextStyle(
                            color: employee['color'] as Color,
                            fontSize: 12,
                            fontWeight: FontWeight.w500,
                          ),
                        ),
                      ],
                    ),
                  ),
                  Container(
                    padding: const EdgeInsets.symmetric(
                      horizontal: 8,
                      vertical: 4,
                    ),
                    decoration: BoxDecoration(
                      color: const Color(0xFF27AE60).withOpacity(0.2),
                      borderRadius: BorderRadius.circular(6),
                    ),
                    child: const Text(
                      'جديد',
                      style: TextStyle(
                        color: Color(0xFF27AE60),
                        fontSize: 10,
                        fontWeight: FontWeight.bold,
                      ),
                    ),
                  ),
                ],
              ),
            );
          }).toList(),
        ],
      ),
    );
  }
}

class EmployeeCard extends StatelessWidget {
  final Employee employee;
  final VoidCallback onEdit;
  final VoidCallback onDelete;

  const EmployeeCard({
    Key? key,
    required this.employee,
    required this.onEdit,
    required this.onDelete,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Container(
      decoration: BoxDecoration(
        color: const Color(0xFF16213e),
        borderRadius: BorderRadius.circular(16),
        border: Border.all(
          color: _getRoleColor(employee.role).withOpacity(0.3),
          width: 1,
        ),
      ),
      child: Column(
        children: [
          // Header with Role Badge
          Container(
            padding: const EdgeInsets.all(16),
            decoration: BoxDecoration(
              color: _getRoleColor(employee.role).withOpacity(0.1),
              borderRadius: const BorderRadius.only(
                topLeft: Radius.circular(16),
                topRight: Radius.circular(16),
              ),
            ),
            child: Row(
              children: [
                // Avatar
                Container(
                  width: 60,
                  height: 60,
                  decoration: BoxDecoration(
                    color: _getRoleColor(employee.role).withOpacity(0.2),
                    shape: BoxShape.circle,
                  ),
                  child: Center(
                    child: Text(
                      employee.name.isNotEmpty ? employee.name[0] : 'م',
                      style: TextStyle(
                        fontSize: 24,
                        fontWeight: FontWeight.bold,
                        color: _getRoleColor(employee.role),
                      ),
                    ),
                  ),
                ),
                const SizedBox(width: 16),

                // Name & Role
                Expanded(
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Text(
                        employee.name,
                        style: const TextStyle(
                          fontSize: 20,
                          fontWeight: FontWeight.bold,
                          color: Colors.white,
                        ),
                      ),
                      const SizedBox(height: 4),
                      Container(
                        padding: const EdgeInsets.symmetric(
                          horizontal: 12,
                          vertical: 4,
                        ),
                        decoration: BoxDecoration(
                          color: _getRoleColor(employee.role).withOpacity(0.2),
                          borderRadius: BorderRadius.circular(12),
                        ),
                        child: Row(
                          mainAxisSize: MainAxisSize.min,
                          children: [
                            Icon(
                              _getRoleIcon(employee.role),
                              size: 14,
                              color: _getRoleColor(employee.role),
                            ),
                            const SizedBox(width: 4),
                            Text(
                              employee.role.arabicName,
                              style: TextStyle(
                                fontSize: 12,
                                fontWeight: FontWeight.bold,
                                color: _getRoleColor(employee.role),
                              ),
                            ),
                          ],
                        ),
                      ),
                    ],
                  ),
                ),

                // Action Buttons
                Row(
                  children: [
                    IconButton(
                      onPressed: onEdit,
                      icon: const Icon(Icons.edit_outlined),
                      color: const Color(0xFF3498DB),
                      tooltip: 'تعديل',
                    ),
                    IconButton(
                      onPressed: onDelete,
                      icon: const Icon(Icons.delete_outline),
                      color: const Color(0xFFE74C3C),
                      tooltip: 'حذف',
                    ),
                  ],
                ),
              ],
            ),
          ),

          // Details Section
          Padding(
            padding: const EdgeInsets.all(16),
            child: Expanded(
              child: Column(
                children: [
                  _buildInfoRow(
                    Icons.phone,
                    'رقم الهاتف',
                    employee.phone,
                    const Color(0xFF3498DB),
                  ),
                  const SizedBox(height: 12),
                  _buildInfoRow(
                    Icons.location_on,
                    'العنوان',
                    employee.address,
                    const Color(0xFF27AE60),
                  ),
                  const SizedBox(height: 12),
                  _buildInfoRow(
                    Icons.calendar_today,
                    'تاريخ الإضافة',
                    _formatDate(employee.createdAt),
                    const Color(0xFF95A5A6),
                  ),
                ],
              ),
            ),
          ),
        ],
      ),
    );
  }

  Widget _buildInfoRow(IconData icon, String label, String value, Color color) {
    return Row(
      children: [
        Container(
          padding: const EdgeInsets.all(8),
          decoration: BoxDecoration(
            color: color.withOpacity(0.1),
            borderRadius: BorderRadius.circular(8),
          ),
          child: Icon(icon, size: 18, color: color),
        ),
        const SizedBox(width: 12),
        Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Text(
              label,
              style: const TextStyle(fontSize: 12, color: Color(0xFF95A5A6)),
            ),
            const SizedBox(height: 2),
            Text(
              value,
              style: const TextStyle(
                fontSize: 14,
                fontWeight: FontWeight.w600,
                color: Colors.white,
              ),
            ),
          ],
        ),
      ],
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

  String _formatDate(DateTime date) {
    return '${date.day}/${date.month}/${date.year}';
  }
}

class AddEmployeeDialog extends StatefulWidget {
  final Employee? employee;
  final Function(Employee) onSave;

  const AddEmployeeDialog({Key? key, this.employee, required this.onSave})
    : super(key: key);

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
enum EmployeeRole {
  admin('مدير', 'admin'),
  accountant('محاسب', 'accountant'),
  employee('موظف', 'employee');

  final String arabicName;
  final String value;

  const EmployeeRole(this.arabicName, this.value);
}

// نموذج الموظف
class Employee extends Equatable {
  final String? id;
  final String name;
  final String phone;
  final String address;
  final EmployeeRole role;
  final DateTime createdAt;
  final DateTime? updatedAt;

  const Employee({
    this.id,
    required this.name,
    required this.phone,
    required this.address,
    required this.role,
    required this.createdAt,
    this.updatedAt,
  });

  Employee copyWith({
    String? id,
    String? name,
    String? phone,
    String? address,
    EmployeeRole? role,
    DateTime? createdAt,
    DateTime? updatedAt,
  }) {
    return Employee(
      id: id ?? this.id,
      name: name ?? this.name,
      phone: phone ?? this.phone,
      address: address ?? this.address,
      role: role ?? this.role,
      createdAt: createdAt ?? this.createdAt,
      updatedAt: updatedAt ?? this.updatedAt,
    );
  }

  @override
  List<Object?> get props => [
    id,
    name,
    phone,
    address,
    role,
    createdAt,
    updatedAt,
  ];
}
