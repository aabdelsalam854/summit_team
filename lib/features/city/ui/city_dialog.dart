// // widgets/city_dialog.dart
// import 'package:flutter/material.dart';

// import '../model/data.dart';

// class CityDialog extends StatefulWidget {
//   final CityModel? city;
//   final Function(Map<String, dynamic>) onSave;

//   const CityDialog({super.key, this.city, required this.onSave});

//   @override
//   State<CityDialog> createState() => _CityDialogState();
// }

// class _CityDialogState extends State<CityDialog> {
//   final _formKey = GlobalKey<FormState>();
//   late TextEditingController _nameArController;
//   late TextEditingController _nameEnController;
//   late bool _isActive;

//   @override
//   void initState() {
//     super.initState();
//     _nameArController = TextEditingController(text: widget.city?.nameAr ?? '');
//     _nameEnController = TextEditingController(text: widget.city?.nameEn ?? '');
//     _isActive = widget.city?.isActive ?? true;
//   }

//   @override
//   void dispose() {
//     _nameArController.dispose();
//     _nameEnController.dispose();
//     super.dispose();
//   }

//   @override
//   Widget build(BuildContext context) {
//     return Dialog(
//       backgroundColor: const Color(0xFF16213E),
//       shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(16)),
//       child: Container(
//         width: 500,
//         padding: const EdgeInsets.all(24),
//         child: Form(
//           key: _formKey,
//           child: Column(
//             mainAxisSize: MainAxisSize.min,
//             crossAxisAlignment: CrossAxisAlignment.start,
//             children: [
//               Row(
//                 children: [
//                   Icon(
//                     widget.city == null
//                         ? Icons.add_location
//                         : Icons.edit_location,
//                     color: const Color(0xFFD4AF37),
//                     size: 28,
//                   ),
//                   const SizedBox(width: 12),
//                   Text(
//                     widget.city == null ? 'إضافة مدينة جديدة' : 'تعديل المدينة',
//                     style: const TextStyle(
//                       fontSize: 20,
//                       fontWeight: FontWeight.bold,
//                       color: Colors.white,
//                     ),
//                   ),
//                 ],
//               ),
//               const SizedBox(height: 24),
//               TextFormField(
//                 controller: _nameArController,
//                 style: const TextStyle(color: Colors.white),
//                 decoration: InputDecoration(
//                   labelText: 'اسم المدينة (عربي)',
//                   labelStyle: TextStyle(color: Colors.white.withOpacity(0.7)),
//                   prefixIcon: const Icon(
//                     Icons.location_city,
//                     color: Color(0xFFD4AF37),
//                   ),
//                   filled: true,
//                   fillColor: Colors.white.withOpacity(0.05),
//                   border: OutlineInputBorder(
//                     borderRadius: BorderRadius.circular(8),
//                     borderSide: BorderSide(
//                       color: Colors.white.withOpacity(0.1),
//                     ),
//                   ),
//                   enabledBorder: OutlineInputBorder(
//                     borderRadius: BorderRadius.circular(8),
//                     borderSide: BorderSide(
//                       color: Colors.white.withOpacity(0.1),
//                     ),
//                   ),
//                   focusedBorder: OutlineInputBorder(
//                     borderRadius: BorderRadius.circular(8),
//                     borderSide: const BorderSide(color: Color(0xFFD4AF37)),
//                   ),
//                 ),
//                 validator: (value) {
//                   if (value == null || value.trim().isEmpty) {
//                     return 'الرجاء إدخال اسم المدينة بالعربي';
//                   }
//                   return null;
//                 },
//               ),
//               const SizedBox(height: 16),
//               TextFormField(
//                 controller: _nameEnController,
//                 style: const TextStyle(color: Colors.white),
//                 decoration: InputDecoration(
//                   labelText: 'اسم المدينة (إنجليزي)',
//                   labelStyle: TextStyle(color: Colors.white.withOpacity(0.7)),
//                   prefixIcon: const Icon(Icons.abc, color: Color(0xFFD4AF37)),
//                   filled: true,
//                   fillColor: Colors.white.withOpacity(0.05),
//                   border: OutlineInputBorder(
//                     borderRadius: BorderRadius.circular(8),
//                     borderSide: BorderSide(
//                       color: Colors.white.withOpacity(0.1),
//                     ),
//                   ),
//                   enabledBorder: OutlineInputBorder(
//                     borderRadius: BorderRadius.circular(8),
//                     borderSide: BorderSide(
//                       color: Colors.white.withOpacity(0.1),
//                     ),
//                   ),
//                   focusedBorder: OutlineInputBorder(
//                     borderRadius: BorderRadius.circular(8),
//                     borderSide: const BorderSide(color: Color(0xFFD4AF37)),
//                   ),
//                 ),
//                 validator: (value) {
//                   if (value == null || value.trim().isEmpty) {
//                     return 'الرجاء إدخال اسم المدينة بالإنجليزي';
//                   }
//                   return null;
//                 },
//               ),
//               const SizedBox(height: 16),
//               Container(
//                 padding: const EdgeInsets.all(16),
//                 decoration: BoxDecoration(
//                   color: Colors.white.withOpacity(0.05),
//                   borderRadius: BorderRadius.circular(8),
//                   border: Border.all(color: Colors.white.withOpacity(0.1)),
//                 ),
//                 child: Row(
//                   children: [
//                     const Icon(Icons.toggle_on, color: Color(0xFFD4AF37)),
//                     const SizedBox(width: 12),
//                     Text(
//                       'حالة المدينة',
//                       style: TextStyle(
//                         color: Colors.white.withOpacity(0.7),
//                         fontSize: 16,
//                       ),
//                     ),
//                     const Spacer(),
//                     Switch(
//                       value: _isActive,
//                       onChanged: (value) {
//                         setState(() {
//                           _isActive = value;
//                         });
//                       },
//                       activeColor: const Color(0xFFD4AF37),
//                     ),
//                     const SizedBox(width: 8),
//                     Text(
//                       _isActive ? 'نشط' : 'غير نشط',
//                       style: TextStyle(
//                         color: _isActive ? Colors.green : Colors.red,
//                         fontWeight: FontWeight.bold,
//                       ),
//                     ),
//                   ],
//                 ),
//               ),
//               const SizedBox(height: 24),
//               Row(
//                 mainAxisAlignment: MainAxisAlignment.end,
//                 children: [
//                   TextButton(
//                     onPressed: () => Navigator.pop(context),
//                     child: Text(
//                       'إلغاء',
//                       style: TextStyle(color: Colors.white.withOpacity(0.7)),
//                     ),
//                   ),
//                   const SizedBox(width: 12),
//                   ElevatedButton(
//                     onPressed: _handleSave,
//                     style: ElevatedButton.styleFrom(
//                       backgroundColor: const Color(0xFFD4AF37),
//                       foregroundColor: const Color(0xFF1A1A2E),
//                       padding: const EdgeInsets.symmetric(
//                         horizontal: 32,
//                         vertical: 16,
//                       ),
//                       shape: RoundedRectangleBorder(
//                         borderRadius: BorderRadius.circular(8),
//                       ),
//                     ),
//                     child: Text(widget.city == null ? 'إضافة' : 'حفظ'),
//                   ),
//                 ],
//               ),
//             ],
//           ),
//         ),
//       ),
//     );
//   }

//   void _handleSave() {
//     if (_formKey.currentState!.validate()) {
//       widget.onSave({
//         'nameAr': _nameArController.text.trim(),
//         'nameEn': _nameEnController.text.trim(),
//         'isActive': _isActive,
//       });
//     }
//   }
// }
