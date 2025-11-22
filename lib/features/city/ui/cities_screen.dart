// // screens/cities/cities_screen.dart
// import 'package:flutter/material.dart';
// import 'package:summit_team/features/city/model.dart';
// import 'package:summit_team/features/city/ui/city_dialog.dart';

// class CitiesScreen extends StatefulWidget {
//   const CitiesScreen({Key? key}) : super(key: key);

//   @override
//   State<CitiesScreen> createState() => _CitiesScreenState();
// }

// class _CitiesScreenState extends State<CitiesScreen> {
//   final List<CityModel> cities = [];
//   bool isLoading = false;

//   @override
//   void initState() {
//     super.initState();
//     _loadCities();
//   }

//   Future<void> _loadCities() async {
//     setState(() => isLoading = true);

//     // مدن وهمية للتجربة
//     await Future.delayed(const Duration(milliseconds: 800));

//     setState(() {
//       cities.addAll([
//         CityModel(
//           id: '1',
//           nameAr: 'القاهرة',
//           nameEn: 'Cairo',
//           isActive: true,
//           createdAt: DateTime.now().subtract(const Duration(days: 30)),
//         ),
//         CityModel(
//           id: '2',
//           nameAr: 'الإسكندرية',
//           nameEn: 'Alexandria',
//           isActive: true,
//           createdAt: DateTime.now().subtract(const Duration(days: 28)),
//         ),
//         CityModel(
//           id: '3',
//           nameAr: 'الجيزة',
//           nameEn: 'Giza',
//           isActive: true,
//           createdAt: DateTime.now().subtract(const Duration(days: 25)),
//         ),
//         CityModel(
//           id: '4',
//           nameAr: 'الشرقية',
//           nameEn: 'Sharqia',
//           isActive: true,
//           createdAt: DateTime.now().subtract(const Duration(days: 22)),
//         ),
//         CityModel(
//           id: '5',
//           nameAr: 'المنوفية',
//           nameEn: 'Menofia',
//           isActive: false,
//           createdAt: DateTime.now().subtract(const Duration(days: 20)),
//         ),
//         CityModel(
//           id: '6',
//           nameAr: 'القليوبية',
//           nameEn: 'Qalyubia',
//           isActive: true,
//           createdAt: DateTime.now().subtract(const Duration(days: 18)),
//         ),
//         CityModel(
//           id: '7',
//           nameAr: 'البحيرة',
//           nameEn: 'Beheira',
//           isActive: true,
//           createdAt: DateTime.now().subtract(const Duration(days: 15)),
//         ),
//         CityModel(
//           id: '8',
//           nameAr: 'الدقهلية',
//           nameEn: 'Dakahlia',
//           isActive: true,
//           createdAt: DateTime.now().subtract(const Duration(days: 12)),
//         ),
//         CityModel(
//           id: '9',
//           nameAr: 'الغربية',
//           nameEn: 'Gharbia',
//           isActive: false,
//           createdAt: DateTime.now().subtract(const Duration(days: 10)),
//         ),
//         CityModel(
//           id: '10',
//           nameAr: 'أسيوط',
//           nameEn: 'Assiut',
//           isActive: true,
//           createdAt: DateTime.now().subtract(const Duration(days: 8)),
//         ),
//         CityModel(
//           id: '11',
//           nameAr: 'المنيا',
//           nameEn: 'Minya',
//           isActive: true,
//           createdAt: DateTime.now().subtract(const Duration(days: 6)),
//         ),
//         CityModel(
//           id: '12',
//           nameAr: 'سوهاج',
//           nameEn: 'Sohag',
//           isActive: true,
//           createdAt: DateTime.now().subtract(const Duration(days: 5)),
//         ),
//         CityModel(
//           id: '13',
//           nameAr: 'بني سويف',
//           nameEn: 'Beni Suef',
//           isActive: true,
//           createdAt: DateTime.now().subtract(const Duration(days: 4)),
//         ),
//         CityModel(
//           id: '14',
//           nameAr: 'الفيوم',
//           nameEn: 'Fayoum',
//           isActive: false,
//           createdAt: DateTime.now().subtract(const Duration(days: 3)),
//         ),
//         CityModel(
//           id: '15',
//           nameAr: 'قنا',
//           nameEn: 'Qena',
//           isActive: true,
//           createdAt: DateTime.now().subtract(const Duration(days: 2)),
//         ),
//         CityModel(
//           id: '16',
//           nameAr: 'أسوان',
//           nameEn: 'Aswan',
//           isActive: true,
//           createdAt: DateTime.now().subtract(const Duration(days: 1)),
//         ),
//         CityModel(
//           id: '17',
//           nameAr: 'الأقصر',
//           nameEn: 'Luxor',
//           isActive: true,
//           createdAt: DateTime.now(),
//         ),
//         CityModel(
//           id: '18',
//           nameAr: 'دمياط',
//           nameEn: 'Damietta',
//           isActive: true,
//           createdAt: DateTime.now().subtract(const Duration(hours: 12)),
//         ),
//         CityModel(
//           id: '19',
//           nameAr: 'بورسعيد',
//           nameEn: 'Port Said',
//           isActive: false,
//           createdAt: DateTime.now().subtract(const Duration(hours: 8)),
//         ),
//         CityModel(
//           id: '20',
//           nameAr: 'السويس',
//           nameEn: 'Suez',
//           isActive: true,
//           createdAt: DateTime.now().subtract(const Duration(hours: 4)),
//         ),
//         CityModel(
//           id: '21',
//           nameAr: 'الإسماعيلية',
//           nameEn: 'Ismailia',
//           isActive: true,
//           createdAt: DateTime.now().subtract(const Duration(hours: 2)),
//         ),
//         CityModel(
//           id: '22',
//           nameAr: 'كفر الشيخ',
//           nameEn: 'Kafr El Sheikh',
//           isActive: true,
//           createdAt: DateTime.now().subtract(const Duration(hours: 1)),
//         ),
//         CityModel(
//           id: '23',
//           nameAr: 'مطروح',
//           nameEn: 'Matrouh',
//           isActive: true,
//           createdAt: DateTime.now().subtract(const Duration(minutes: 30)),
//         ),
//         CityModel(
//           id: '24',
//           nameAr: 'البحر الأحمر',
//           nameEn: 'Red Sea',
//           isActive: true,
//           createdAt: DateTime.now().subtract(const Duration(minutes: 15)),
//         ),
//         CityModel(
//           id: '25',
//           nameAr: 'الوادي الجديد',
//           nameEn: 'New Valley',
//           isActive: false,
//           createdAt: DateTime.now().subtract(const Duration(minutes: 5)),
//         ),
//         CityModel(
//           id: '26',
//           nameAr: 'شمال سيناء',
//           nameEn: 'North Sinai',
//           isActive: true,
//           createdAt: DateTime.now().subtract(const Duration(minutes: 2)),
//         ),
//         CityModel(
//           id: '27',
//           nameAr: 'جنوب سيناء',
//           nameEn: 'South Sinai',
//           isActive: true,
//           createdAt: DateTime.now(),
//         ),
//       ]);
//       isLoading = false;
//     });
//   }

//   @override
//   Widget build(BuildContext context) {
//     return Scaffold(
//       backgroundColor: const Color(0xFF1A1A2E),
//       body: Column(
//         children: [
//           _buildHeader(),
//           Expanded(
//             child: isLoading
//                 ? const Center(child: CircularProgressIndicator())
//                 : _buildCitiesTable(),
//           ),
//         ],
//       ),
//     );
//   }

//   Widget _buildHeader() {
//     return Container(
//       padding: const EdgeInsets.all(24),
//       decoration: BoxDecoration(
//         color: const Color(0xFF16213E),
//         border: Border(
//           bottom: BorderSide(color: Colors.white.withOpacity(0.1), width: 1),
//         ),
//       ),
//       child: Row(
//         children: [
//           const Icon(Icons.location_city, color: Color(0xFFD4AF37), size: 32),
//           const SizedBox(width: 16),
//           const Text(
//             'إدارة المدن',
//             style: TextStyle(
//               fontSize: 24,
//               fontWeight: FontWeight.bold,
//               color: Colors.white,
//             ),
//           ),
//           const Spacer(),
//           ElevatedButton.icon(
//             onPressed: () => _showCityDialog(),
//             icon: const Icon(Icons.add),
//             label: const Text('إضافة مدينة جديدة'),
//             style: ElevatedButton.styleFrom(
//               backgroundColor: const Color(0xFFD4AF37),
//               foregroundColor: const Color(0xFF1A1A2E),
//               padding: const EdgeInsets.symmetric(horizontal: 24, vertical: 16),
//               shape: RoundedRectangleBorder(
//                 borderRadius: BorderRadius.circular(8),
//               ),
//             ),
//           ),
//         ],
//       ),
//     );
//   }

//   Widget _buildCitiesTable() {
//     if (cities.isEmpty) {
//       return Center(
//         child: Column(
//           mainAxisAlignment: MainAxisAlignment.center,
//           children: [
//             Icon(
//               Icons.location_city_outlined,
//               size: 64,
//               color: Colors.white.withOpacity(0.3),
//             ),
//             const SizedBox(height: 16),
//             Text(
//               'لا توجد مدن مضافة',
//               style: TextStyle(
//                 fontSize: 18,
//                 color: Colors.white.withOpacity(0.5),
//               ),
//             ),
//           ],
//         ),
//       );
//     }

//     return SingleChildScrollView(
//       padding: const EdgeInsets.all(24),
//       child: Container(
//         decoration: BoxDecoration(
//           color: const Color(0xFF16213E),
//           borderRadius: BorderRadius.circular(12),
//           border: Border.all(color: Colors.white.withOpacity(0.1), width: 1),
//         ),
//         child: Column(
//           children: [
//             _buildTableHeader(),
//             ...cities.asMap().entries.map((entry) {
//               return _buildTableRow(entry.value, entry.key);
//             }).toList(),
//           ],
//         ),
//       ),
//     );
//   }

//   Widget _buildTableHeader() {
//     return Container(
//       padding: const EdgeInsets.symmetric(horizontal: 24, vertical: 16),
//       decoration: BoxDecoration(
//         color: const Color(0xFF0F3460),
//         borderRadius: const BorderRadius.only(
//           topLeft: Radius.circular(12),
//           topRight: Radius.circular(12),
//         ),
//       ),
//       child: Row(
//         children: [
//           Expanded(
//             flex: 2,
//             child: Text(
//               'اسم المدينة (عربي)',
//               style: TextStyle(
//                 fontSize: 14,
//                 fontWeight: FontWeight.bold,
//                 color: Colors.white.withOpacity(0.7),
//               ),
//             ),
//           ),
//           Expanded(
//             flex: 2,
//             child: Text(
//               'اسم المدينة (إنجليزي)',
//               style: TextStyle(
//                 fontSize: 14,
//                 fontWeight: FontWeight.bold,
//                 color: Colors.white.withOpacity(0.7),
//               ),
//             ),
//           ),
//           Expanded(
//             child: Text(
//               'الحالة',
//               style: TextStyle(
//                 fontSize: 14,
//                 fontWeight: FontWeight.bold,
//                 color: Colors.white.withOpacity(0.7),
//               ),
//             ),
//           ),
//           Expanded(
//             child: Text(
//               'تاريخ الإضافة',
//               style: TextStyle(
//                 fontSize: 14,
//                 fontWeight: FontWeight.bold,
//                 color: Colors.white.withOpacity(0.7),
//               ),
//             ),
//           ),
//           SizedBox(
//             width: 120,
//             child: Text(
//               'الإجراءات',
//               textAlign: TextAlign.center,
//               style: TextStyle(
//                 fontSize: 14,
//                 fontWeight: FontWeight.bold,
//                 color: Colors.white.withOpacity(0.7),
//               ),
//             ),
//           ),
//         ],
//       ),
//     );
//   }

//   Widget _buildTableRow(CityModel city, int index) {
//     final isEven = index % 2 == 0;
//     return Container(
//       padding: const EdgeInsets.symmetric(horizontal: 24, vertical: 16),
//       decoration: BoxDecoration(
//         color: isEven ? Colors.transparent : Colors.white.withOpacity(0.02),
//         border: Border(
//           bottom: BorderSide(color: Colors.white.withOpacity(0.05), width: 1),
//         ),
//       ),
//       child: Row(
//         children: [
//           Expanded(
//             flex: 2,
//             child: Text(
//               city.nameAr,
//               style: const TextStyle(fontSize: 14, color: Colors.white),
//             ),
//           ),
//           Expanded(
//             flex: 2,
//             child: Text(
//               city.nameEn,
//               style: TextStyle(
//                 fontSize: 14,
//                 color: Colors.white.withOpacity(0.7),
//               ),
//             ),
//           ),
//           Expanded(child: _buildStatusChip(city.isActive)),
//           Expanded(
//             child: Text(
//               _formatDate(city.createdAt),
//               style: TextStyle(
//                 fontSize: 14,
//                 color: Colors.white.withOpacity(0.7),
//               ),
//             ),
//           ),
//           SizedBox(
//             width: 120,
//             child: Row(
//               mainAxisAlignment: MainAxisAlignment.center,
//               children: [
//                 IconButton(
//                   onPressed: () => _showCityDialog(city: city),
//                   icon: const Icon(Icons.edit),
//                   color: const Color(0xFFD4AF37),
//                   tooltip: 'تعديل',
//                 ),
//                 const SizedBox(width: 8),
//                 IconButton(
//                   onPressed: () => _confirmDelete(city),
//                   icon: const Icon(Icons.delete),
//                   color: Colors.red,
//                   tooltip: 'حذف',
//                 ),
//               ],
//             ),
//           ),
//         ],
//       ),
//     );
//   }

//   Widget _buildStatusChip(bool isActive) {
//     return Container(
//       padding: const EdgeInsets.symmetric(horizontal: 12, vertical: 6),
//       decoration: BoxDecoration(
//         color: isActive
//             ? Colors.green.withOpacity(0.2)
//             : Colors.red.withOpacity(0.2),
//         borderRadius: BorderRadius.circular(16),
//         border: Border.all(
//           color: isActive ? Colors.green : Colors.red,
//           width: 1,
//         ),
//       ),
//       child: Text(
//         isActive ? 'نشط' : 'غير نشط',
//         textAlign: TextAlign.center,
//         style: TextStyle(
//           fontSize: 12,
//           color: isActive ? Colors.green : Colors.red,
//           fontWeight: FontWeight.bold,
//         ),
//       ),
//     );
//   }

//   String _formatDate(DateTime date) {
//     return '${date.day}/${date.month}/${date.year}';
//   }

//   void _showCityDialog({CityModel? city}) {
//     showDialog(
//       context: context,
//       builder: (context) => CityDialog(
//         city: city,
//         onSave: (cityData) async {
//           if (city == null) {
//             // إضافة مدينة جديدة
//             setState(() {
//               cities.add(
//                 CityModel(
//                   id: DateTime.now().toString(),
//                   nameAr: cityData['nameAr']!,
//                   nameEn: cityData['nameEn']!,
//                   isActive: cityData['isActive'] as bool,
//                   createdAt: DateTime.now(),
//                 ),
//               );
//             });
//           } else {
//             // تعديل مدينة موجودة
//             final index = cities.indexWhere((c) => c.id == city.id);
//             if (index != -1) {
//               setState(() {
//                 cities[index] = city.copyWith(
//                   nameAr: cityData['nameAr'],
//                   nameEn: cityData['nameEn'],
//                   isActive: cityData['isActive'] as bool,
//                 );
//               });
//             }
//           }
//           Navigator.pop(context);
//           _showSuccessSnackBar(
//             city == null ? 'تم إضافة المدينة بنجاح' : 'تم تعديل المدينة بنجاح',
//           );
//         },
//       ),
//     );
//   }

//   void _confirmDelete(CityModel city) {
//     showDialog(
//       context: context,
//       builder: (context) => AlertDialog(
//         backgroundColor: const Color(0xFF16213E),
//         title: const Text('تأكيد الحذف', style: TextStyle(color: Colors.white)),
//         content: Text(
//           'هل أنت متأكد من حذف مدينة "${city.nameAr}"؟',
//           style: TextStyle(color: Colors.white.withOpacity(0.7)),
//         ),
//         actions: [
//           TextButton(
//             onPressed: () => Navigator.pop(context),
//             child: const Text('إلغاء'),
//           ),
//           ElevatedButton(
//             onPressed: () {
//               setState(() {
//                 cities.removeWhere((c) => c.id == city.id);
//               });
//               Navigator.pop(context);
//               _showSuccessSnackBar('تم حذف المدينة بنجاح');
//             },
//             style: ElevatedButton.styleFrom(
//               backgroundColor: Colors.red,
//               foregroundColor: Colors.white,
//             ),
//             child: const Text('حذف'),
//           ),
//         ],
//       ),
//     );
//   }

//   void _showSuccessSnackBar(String message) {
//     ScaffoldMessenger.of(context).showSnackBar(
//       SnackBar(
//         content: Text(message),
//         backgroundColor: Colors.green,
//         behavior: SnackBarBehavior.floating,
//         shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(8)),
//       ),
//     );
//   }
// }
