import 'package:flutter/material.dart';
import 'package:summit_team/features/Employees/presentation/models/employee.dart';
import 'package:summit_team/features/Employees/presentation/widgets/employee_form_dialog.dart';

class EmployeeCard extends StatelessWidget {
  final Employee employee;

  const EmployeeCard({super.key, required this.employee});

  Color _getRoleColor(EmployeeRole role) {
    switch (role) {
      case EmployeeRole.admin:
        return Colors.red.shade700;
      case EmployeeRole.accountant:
        return Colors.blue.shade700;
      case EmployeeRole.employee:
        return Colors.green.shade700;
    }
  }

  IconData _getRoleIcon(EmployeeRole role) {
    switch (role) {
      case EmployeeRole.admin:
        return Icons.admin_panel_settings;
      case EmployeeRole.accountant:
        return Icons.supervisor_account;
      case EmployeeRole.employee:
        return Icons.person;
    }
  }

  void _showEditDialog(BuildContext context) {
    showDialog(
      context: context,
      builder: (dialogContext) => EmployeeFormDialog(employee: employee),
    );
  }

  void _showDeleteConfirmation(BuildContext context) {
    showDialog(
      context: context,
      builder: (dialogContext) => AlertDialog(
        shape: RoundedRectangleBorder(
          borderRadius: BorderRadius.circular(16),
        ),
        title: const Text('تأكيد الحذف'),
        content: Text('هل أنت متأكد من حذف الموظف "${employee.name}"؟'),
        actions: [
          TextButton(
            onPressed: () => Navigator.of(dialogContext).pop(),
            child: const Text('إلغاء'),
          ),
          ElevatedButton(
            onPressed: () {
              // context.read<EmployeesCubit>().deleteEmployee(employee.id);
              Navigator.of(dialogContext).pop();
            },
            style: ElevatedButton.styleFrom(
              backgroundColor: Colors.red,
            ),
            child: const Text('حذف'),
          ),
        ],
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    return Card(
      elevation: 2,
      shape: RoundedRectangleBorder(
        borderRadius: BorderRadius.circular(16),
      ),
      child: Padding(
        padding: const EdgeInsets.all(16),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            // Header with role badge
            Row(
              children: [
                CircleAvatar(
                  radius: 30,
                  backgroundColor: _getRoleColor(employee.role).withOpacity(0.1),
                  child: Icon(
                    _getRoleIcon(employee.role),
                    color: _getRoleColor(employee.role),
                    size: 32,
                  ),
                ),
                const SizedBox(width: 12),
                Expanded(
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Text(
                        employee.name,
                        style: const TextStyle(
                          fontSize: 18,
                          fontWeight: FontWeight.bold,
                        ),
                      ),
                      const SizedBox(height: 4),
                      Container(
                        padding: const EdgeInsets.symmetric(
                          horizontal: 12,
                          vertical: 4,
                        ),
                        decoration: BoxDecoration(
                          color: _getRoleColor(employee.role),
                          borderRadius: BorderRadius.circular(12),
                        ),
                        child: Text(
                          employee.role.arabicName,
                          style: const TextStyle(
                            color: Colors.white,
                            fontSize: 12,
                            fontWeight: FontWeight.bold,
                          ),
                        ),
                      ),
                    ],
                  ),
                ),
                // Action buttons
                PopupMenuButton(
                  icon: const Icon(Icons.more_vert),
                  shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(12),
                  ),
                  itemBuilder: (context) => [
                    PopupMenuItem(
                      child: Row(
                        children: const [
                          Icon(Icons.edit, size: 20),
                          SizedBox(width: 8),
                          Text('تعديل'),
                        ],
                      ),
                      onTap: () {
                        Future.delayed(
                          Duration.zero,
                          () => _showEditDialog(context),
                        );
                      },
                    ),
                    PopupMenuItem(
                      child: Row(
                        children: const [
                          Icon(Icons.delete, color: Colors.red, size: 20),
                          SizedBox(width: 8),
                          Text('حذف', style: TextStyle(color: Colors.red)),
                        ],
                      ),
                      onTap: () {
                        Future.delayed(
                          Duration.zero,
                          () => _showDeleteConfirmation(context),
                        );
                      },
                    ),
                  ],
                ),
              ],
            ),
            const Divider(height: 24),

            // Employee details
            _buildDetailRow(
              Icons.phone,
              'رقم الهاتف',
              employee.phone,
            ),
            const SizedBox(height: 12),
            _buildDetailRow(
              Icons.location_on,
              'العنوان',
              employee.address,
            ),
          ],
        ),
      ),
    );
  }

  Widget _buildDetailRow(IconData icon, String label, String value) {
    return Row(
      children: [
        Icon(icon, size: 20, color: Colors.grey.shade600),
        const SizedBox(width: 8),
        Expanded(
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Text(
                label,
                style: TextStyle(
                  fontSize: 12,
                  color: Colors.grey.shade600,
                ),
              ),
              const SizedBox(height: 2),
              Text(
                value,
                style: const TextStyle(
                  fontSize: 14,
                  fontWeight: FontWeight.w500,
                ),
              ),
            ],
          ),
        ),
      ],
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