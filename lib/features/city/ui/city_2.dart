// // screens/cities/cities_screen.dart
// import 'package:flutter/material.dart';
// import 'package:summit_team/features/city/model.dart';
// import 'package:summit_team/features/city/ui/city_dialog.dart';
// import 'package:summit_team/features/city/ui/dialog_2.dart';
// import 'package:summit_team/features/city/ui/models.dart';

// class CitiesScreen extends StatefulWidget {
//   const CitiesScreen({Key? key}) : super(key: key);

//   @override
//   State<CitiesScreen> createState() => _CitiesScreenState();
// }

// class _CitiesScreenState extends State<CitiesScreen> {
//   final List<CityModel> cities = [];
//   final Map<String, List<PropertyCategoryModel>> citiesCategories = {};
//   bool isLoading = false;
//   CityModel? selectedCity;

//   @override
//   void initState() {
//     super.initState();
//     _loadCities();
//   }

//   Future<void> _loadCities() async {
//     setState(() => isLoading = true);
    
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
//       ]);

//       // إضافة كاتيجوريز وهمية للقاهرة
//       citiesCategories['1'] = [
//         PropertyCategoryModel(
//           id: 'cat1',
//           nameAr: 'شقة',
//           nameEn: 'Apartment',
//           cityId: '1',
//           order: 1,
//           isActive: true,
//           icon: Icons.apartment,
//           createdAt: DateTime.now(),
//         ),
//         PropertyCategoryModel(
//           id: 'cat2',
//           nameAr: 'فيلا',
//           nameEn: 'Villa',
//           cityId: '1',
//           order: 2,
//           isActive: true,
//           icon: Icons.villa,
//           createdAt: DateTime.now(),
//         ),
//         PropertyCategoryModel(
//           id: 'cat3',
//           nameAr: 'محل تجاري',
//           nameEn: 'Shop',
//           cityId: '1',
//           order: 3,
//           isActive: true,
//           icon: Icons.store,
//           createdAt: DateTime.now(),
//         ),
//         PropertyCategoryModel(
//           id: 'cat4',
//           nameAr: 'عيادة',
//           nameEn: 'Clinic',
//           cityId: '1',
//           order: 4,
//           isActive: true,
//           icon: Icons.local_hospital,
//           createdAt: DateTime.now(),
//         ),
//         PropertyCategoryModel(
//           id: 'cat5',
//           nameAr: 'استوديو',
//           nameEn: 'Studio',
//           cityId: '1',
//           order: 5,
//           isActive: true,
//           icon: Icons.weekend,
//           createdAt: DateTime.now(),
//         ),
//       ];

//       // كاتيجوريز للإسكندرية
//       citiesCategories['2'] = [
//         PropertyCategoryModel(
//           id: 'cat6',
//           nameAr: 'شقة',
//           nameEn: 'Apartment',
//           cityId: '2',
//           order: 1,
//           isActive: true,
//           icon: Icons.apartment,
//           createdAt: DateTime.now(),
//         ),
//         PropertyCategoryModel(
//           id: 'cat7',
//           nameAr: 'شاليه',
//           nameEn: 'Chalet',
//           cityId: '2',
//           order: 2,
//           isActive: true,
//           icon: Icons.cottage,
//           createdAt: DateTime.now(),
//         ),
//       ];

//       isLoading = false;
//     });
//   }

//   @override
//   Widget build(BuildContext context) {
//     return Scaffold(
//       backgroundColor: const Color(0xFF1A1A2E),
//       body: Row(
//         children: [
//           // قائمة المدن - الجانب الأيسر
//           Expanded(
//             flex: 2,
//             child: Container(
//               decoration: BoxDecoration(
//                 border: Border(
//                   left: BorderSide(
//                     color: Colors.white.withOpacity(0.1),
//                     width: 1,
//                   ),
//                 ),
//               ),
//               child: Column(
//                 children: [
//                   _buildCitiesHeader(),
//                   Expanded(
//                     child: isLoading
//                         ? const Center(child: CircularProgressIndicator())
//                         : _buildCitiesList(),
//                   ),
//                 ],
//               ),
//             ),
//           ),
          
//           // قائمة الكاتيجوريز - الجانب الأيمن
//           Expanded(
//             flex: 3,
//             child: selectedCity == null
//                 ? _buildEmptyCategoryState()
//                 : Column(
//                     children: [
//                       _buildCategoriesHeader(),
//                       Expanded(child: _buildCategoriesList()),
//                     ],
//                   ),
//           ),
//         ],
//       ),
//     );
//   }

//   Widget _buildCitiesHeader() {
//     return Container(
//       padding: const EdgeInsets.all(24),
//       decoration: BoxDecoration(
//         color: const Color(0xFF16213E),
//         border: Border(
//           bottom: BorderSide(
//             color: Colors.white.withOpacity(0.1),
//             width: 1,
//           ),
//         ),
//       ),
//       child: Row(
//         children: [
//           const Icon(
//             Icons.location_city,
//             color: Color(0xFFD4AF37),
//             size: 28,
//           ),
//           const SizedBox(width: 16),
//           const Text(
//             'المدن',
//             style: TextStyle(
//               fontSize: 20,
//               fontWeight: FontWeight.bold,
//               color: Colors.white,
//             ),
//           ),
//           const Spacer(),
//           ElevatedButton.icon(
//             onPressed: () => _showCityDialog(),
//             icon: const Icon(Icons.add, size: 18),
//             label: const Text('إضافة'),
//             style: ElevatedButton.styleFrom(
//               backgroundColor: const Color(0xFFD4AF37),
//               foregroundColor: const Color(0xFF1A1A2E),
//               padding: const EdgeInsets.symmetric(
//                 horizontal: 20,
//                 vertical: 14,
//               ),
//               shape: RoundedRectangleBorder(
//                 borderRadius: BorderRadius.circular(8),
//               ),
//             ),
//           ),
//         ],
//       ),
//     );
//   }

//   Widget _buildCitiesList() {
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
//                 fontSize: 16,
//                 color: Colors.white.withOpacity(0.5),
//               ),
//             ),
//           ],
//         ),
//       );
//     }

//     return ListView.builder(
//       padding: const EdgeInsets.all(16),
//       itemCount: cities.length,
//       itemBuilder: (context, index) {
//         final city = cities[index];
//         final isSelected = selectedCity?.id == city.id;
//         final categoryCount = citiesCategories[city.id]?.length ?? 0;

//         return Container(
//           margin: const EdgeInsets.only(bottom: 12),
//           decoration: BoxDecoration(
//             color: isSelected 
//                 ? const Color(0xFFD4AF37).withOpacity(0.1)
//                 : const Color(0xFF16213E),
//             borderRadius: BorderRadius.circular(12),
//             border: Border.all(
//               color: isSelected 
//                   ? const Color(0xFFD4AF37)
//                   : Colors.white.withOpacity(0.1),
//               width: isSelected ? 2 : 1,
//             ),
//           ),
//           child: InkWell(
//             onTap: () {
//               setState(() {
//                 selectedCity = city;
//               });
//             },
//             borderRadius: BorderRadius.circular(12),
//             child: Padding(
//               padding: const EdgeInsets.all(16),
//               child: Column(
//                 crossAxisAlignment: CrossAxisAlignment.start,
//                 children: [
//                   Row(
//                     children: [
//                       Container(
//                         padding: const EdgeInsets.all(8),
//                         decoration: BoxDecoration(
//                           color: const Color(0xFFD4AF37).withOpacity(0.1),
//                           borderRadius: BorderRadius.circular(8),
//                         ),
//                         child: const Icon(
//                           Icons.location_on,
//                           color: Color(0xFFD4AF37),
//                           size: 20,
//                         ),
//                       ),
//                       const SizedBox(width: 12),
//                       Expanded(
//                         child: Column(
//                           crossAxisAlignment: CrossAxisAlignment.start,
//                           children: [
//                             Text(
//                               city.nameAr,
//                               style: const TextStyle(
//                                 fontSize: 16,
//                                 fontWeight: FontWeight.bold,
//                                 color: Colors.white,
//                               ),
//                             ),
//                             const SizedBox(height: 2),
//                             Text(
//                               city.nameEn,
//                               style: TextStyle(
//                                 fontSize: 13,
//                                 color: Colors.white.withOpacity(0.6),
//                               ),
//                             ),
//                           ],
//                         ),
//                       ),
//                       _buildStatusChip(city.isActive),
//                     ],
//                   ),
//                   const SizedBox(height: 12),
//                   Row(
//                     children: [
//                       Icon(
//                         Icons.category,
//                         size: 14,
//                         color: Colors.white.withOpacity(0.5),
//                       ),
//                       const SizedBox(width: 6),
//                       Text(
//                         '$categoryCount تصنيف',
//                         style: TextStyle(
//                           fontSize: 12,
//                           color: Colors.white.withOpacity(0.5),
//                         ),
//                       ),
//                       const Spacer(),
//                       IconButton(
//                         onPressed: () => _showCityDialog(city: city),
//                         icon: const Icon(Icons.edit),
//                         color: const Color(0xFFD4AF37),
//                         iconSize: 18,
//                         tooltip: 'تعديل',
//                         padding: EdgeInsets.zero,
//                         constraints: const BoxConstraints(),
//                       ),
//                       const SizedBox(width: 12),
//                       IconButton(
//                         onPressed: () => _confirmDeleteCity(city),
//                         icon: const Icon(Icons.delete),
//                         color: Colors.red,
//                         iconSize: 18,
//                         tooltip: 'حذف',
//                         padding: EdgeInsets.zero,
//                         constraints: const BoxConstraints(),
//                       ),
//                     ],
//                   ),
//                 ],
//               ),
//             ),
//           ),
//         );
//       },
//     );
//   }

//   Widget _buildCategoriesHeader() {
//     return Container(
//       padding: const EdgeInsets.all(24),
//       decoration: BoxDecoration(
//         color: const Color(0xFF16213E),
//         border: Border(
//           bottom: BorderSide(
//             color: Colors.white.withOpacity(0.1),
//             width: 1,
//           ),
//         ),
//       ),
//       child: Row(
//         children: [
//           const Icon(
//             Icons.category,
//             color: Color(0xFFD4AF37),
//             size: 28,
//           ),
//           const SizedBox(width: 16),
//           Column(
//             crossAxisAlignment: CrossAxisAlignment.start,
//             children: [
//               const Text(
//                 'تصنيفات العقارات',
//                 style: TextStyle(
//                   fontSize: 20,
//                   fontWeight: FontWeight.bold,
//                   color: Colors.white,
//                 ),
//               ),
//               const SizedBox(height: 4),
//               Text(
//                 'مدينة ${selectedCity?.nameAr ?? ""}',
//                 style: TextStyle(
//                   fontSize: 14,
//                   color: Colors.white.withOpacity(0.6),
//                 ),
//               ),
//             ],
//           ),
//           const Spacer(),
//           ElevatedButton.icon(
//             onPressed: () => _showCategoryDialog(),
//             icon: const Icon(Icons.add, size: 18),
//             label: const Text('إضافة تصنيف'),
//             style: ElevatedButton.styleFrom(
//               backgroundColor: const Color(0xFFD4AF37),
//               foregroundColor: const Color(0xFF1A1A2E),
//               padding: const EdgeInsets.symmetric(
//                 horizontal: 20,
//                 vertical: 14,
//               ),
//               shape: RoundedRectangleBorder(
//                 borderRadius: BorderRadius.circular(8),
//               ),
//             ),
//           ),
//         ],
//       ),
//     );
//   }

//   Widget _buildCategoriesList() {
//     final categories = citiesCategories[selectedCity!.id] ?? [];

//     if (categories.isEmpty) {
//       return Center(
//         child: Column(
//           mainAxisAlignment: MainAxisAlignment.center,
//           children: [
//             Icon(
//               Icons.category_outlined,
//               size: 64,
//               color: Colors.white.withOpacity(0.3),
//             ),
//             const SizedBox(height: 16),
//             Text(
//               'لا توجد تصنيفات لهذه المدينة',
//               style: TextStyle(
//                 fontSize: 16,
//                 color: Colors.white.withOpacity(0.5),
//               ),
//             ),
//             const SizedBox(height: 8),
//             Text(
//               'قم بإضافة تصنيف جديد',
//               style: TextStyle(
//                 fontSize: 14,
//                 color: Colors.white.withOpacity(0.4),
//               ),
//             ),
//           ],
//         ),
//       );
//     }

//     // ترتيب الكاتيجوريز حسب order
//     categories.sort((a, b) => a.order.compareTo(b.order));

//     return ReorderableListView.builder(
//       padding: const EdgeInsets.all(24),
//       onReorder: (oldIndex, newIndex) {
//         setState(() {
//           if (newIndex > oldIndex) {
//             newIndex -= 1;
//           }
//           final category = categories.removeAt(oldIndex);
//           categories.insert(newIndex, category);
          
//           // تحديث الترتيب
//           for (int i = 0; i < categories.length; i++) {
//             categories[i] = categories[i].copyWith(order: i + 1);
//           }
//         });
//       },
//       itemCount: categories.length,
//       itemBuilder: (context, index) {
//         final category = categories[index];
//         return _buildCategoryCard(category, index, key: ValueKey(category.id));
//       },
//     );
//   }

//   Widget _buildCategoryCard(PropertyCategoryModel category, int index, {required Key key}) {
//     return Container(
//       key: key,
//       margin: const EdgeInsets.only(bottom: 16),
//       decoration: BoxDecoration(
//         color: const Color(0xFF16213E),
//         borderRadius: BorderRadius.circular(12),
//         border: Border.all(
//           color: Colors.white.withOpacity(0.1),
//           width: 1,
//         ),
//       ),
//       child: Padding(
//         padding: const EdgeInsets.all(20),
//         child: Row(
//           children: [
//             // أيقونة السحب للترتيب
//             ReorderableDragStartListener(
//               index: index,
//               child: Container(
//                 padding: const EdgeInsets.all(8),
//                 decoration: BoxDecoration(
//                   color: Colors.white.withOpacity(0.05),
//                   borderRadius: BorderRadius.circular(8),
//                 ),
//                 child: Icon(
//                   Icons.drag_indicator,
//                   color: Colors.white.withOpacity(0.5),
//                   size: 20,
//                 ),
//               ),
//             ),
//             const SizedBox(width: 16),
            
//             // رقم الترتيب
//             Container(
//               width: 36,
//               height: 36,
//               decoration: BoxDecoration(
//                 color: const Color(0xFFD4AF37).withOpacity(0.1),
//                 borderRadius: BorderRadius.circular(8),
//                 border: Border.all(
//                   color: const Color(0xFFD4AF37),
//                   width: 1,
//                 ),
//               ),
//               child: Center(
//                 child: Text(
//                   '${category.order}',
//                   style: const TextStyle(
//                     fontSize: 16,
//                     fontWeight: FontWeight.bold,
//                     color: Color(0xFFD4AF37),
//                   ),
//                 ),
//               ),
//             ),
//             const SizedBox(width: 16),
            
//             // أيقونة التصنيف
//             Container(
//               padding: const EdgeInsets.all(12),
//               decoration: BoxDecoration(
//                 color: const Color(0xFFD4AF37).withOpacity(0.1),
//                 borderRadius: BorderRadius.circular(10),
//               ),
//               child: Icon(
//                 category.icon,
//                 color: const Color(0xFFD4AF37),
//                 size: 28,
//               ),
//             ),
//             const SizedBox(width: 16),
            
//             // اسم التصنيف
//             Expanded(
//               child: Column(
//                 crossAxisAlignment: CrossAxisAlignment.start,
//                 children: [
//                   Text(
//                     category.nameAr,
//                     style: const TextStyle(
//                       fontSize: 18,
//                       fontWeight: FontWeight.bold,
//                       color: Colors.white,
//                     ),
//                   ),
//                   const SizedBox(height: 4),
//                   Text(
//                     category.nameEn,
//                     style: TextStyle(
//                       fontSize: 14,
//                       color: Colors.white.withOpacity(0.6),
//                     ),
//                   ),
//                 ],
//               ),
//             ),
            
//             // الحالة
//             _buildStatusChip(category.isActive),
//             const SizedBox(width: 16),
            
//             // أزرار التحكم
//             Row(
//               children: [
//                 IconButton(
//                   onPressed: () => _showCategoryDialog(category: category),
//                   icon: const Icon(Icons.edit),
//                   color: const Color(0xFFD4AF37),
//                   tooltip: 'تعديل',
//                 ),
//                 const SizedBox(width: 8),
//                 IconButton(
//                   onPressed: () => _confirmDeleteCategory(category),
//                   icon: const Icon(Icons.delete),
//                   color: Colors.red,
//                   tooltip: 'حذف',
//                 ),
//               ],
//             ),
//           ],
//         ),
//       ),
//     );
//   }

//   Widget _buildEmptyCategoryState() {
//     return Center(
//       child: Column(
//         mainAxisAlignment: MainAxisAlignment.center,
//         children: [
//           Icon(
//             Icons.touch_app,
//             size: 80,
//             color: Colors.white.withOpacity(0.3),
//           ),
//           const SizedBox(height: 24),
//           Text(
//             'اختر مدينة من القائمة',
//             style: TextStyle(
//               fontSize: 20,
//               fontWeight: FontWeight.bold,
//               color: Colors.white.withOpacity(0.5),
//             ),
//           ),
//           const SizedBox(height: 8),
//           Text(
//             'لعرض وإدارة التصنيفات الخاصة بها',
//             style: TextStyle(
//               fontSize: 16,
//               color: Colors.white.withOpacity(0.4),
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

//   // Dialog إضافة/تعديل المدينة
//   void _showCityDialog({CityModel? city}) {
//     showDialog(
//       context: context,
//       builder: (context) => CityDialog(
//         city: city,
//         onSave: (cityData) async {
//           if (city == null) {
//             final newCity = CityModel(
//               id: DateTime.now().millisecondsSinceEpoch.toString(),
//               nameAr: cityData['nameAr']!,
//               nameEn: cityData['nameEn']!,
//               isActive: cityData['isActive'] as bool,
//               createdAt: DateTime.now(),
//             );
            
//             setState(() {
//               cities.add(newCity);
//               citiesCategories[newCity.id] = [];
//               selectedCity = newCity;
//             });
//           } else {
//             final index = cities.indexWhere((c) => c.id == city.id);
//             if (index != -1) {
//               setState(() {
//                 cities[index] = city.copyWith(
//                   nameAr: cityData['nameAr'],
//                   nameEn: cityData['nameEn'],
//                   isActive: cityData['isActive'] as bool,
//                 );
//                 if (selectedCity?.id == city.id) {
//                   selectedCity = cities[index];
//                 }
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

//   // Dialog إضافة/تعديل التصنيف
//   void _showCategoryDialog({PropertyCategoryModel? category}) {
//     if (selectedCity == null) return;

//     showDialog(
//       context: context,
//       builder: (context) => CategoryDialog(
//         category: category,
//         cityId: selectedCity!.id,
//         onSave: (categoryData) async {
//           final categories = citiesCategories[selectedCity!.id] ?? [];
          
//           if (category == null) {
//             final newCategory = PropertyCategoryModel(
//               id: DateTime.now().millisecondsSinceEpoch.toString(),
//               nameAr: categoryData['nameAr']!,
//               nameEn: categoryData['nameEn']!,
//               cityId: selectedCity!.id,
//               order: categories.length + 1,
//               isActive: categoryData['isActive'] as bool,
//               icon: categoryData['icon'] as IconData,
//               createdAt: DateTime.now(),
//             );
            
//             setState(() {
//               categories.add(newCategory);
//               citiesCategories[selectedCity!.id] = categories;
//             });
//           } else {
//             final index = categories.indexWhere((c) => c.id == category.id);
//             if (index != -1) {
//               setState(() {
//                 categories[index] = category.copyWith(
//                   nameAr: categoryData['nameAr'],
//                   nameEn: categoryData['nameEn'],
//                   isActive: categoryData['isActive'] as bool,
//                   icon: categoryData['icon'] as IconData,
//                 );
//               });
//             }
//           }
//           Navigator.pop(context);
//           _showSuccessSnackBar(
//             category == null ? 'تم إضافة التصنيف بنجاح' : 'تم تعديل التصنيف بنجاح',
//           );
//         },
//       ),
//     );
//   }

//   void _confirmDeleteCity(CityModel city) {
//     showDialog(
//       context: context,
//       builder: (context) => AlertDialog(
//         backgroundColor: const Color(0xFF16213E),
//         shape: RoundedRectangleBorder(
//           borderRadius: BorderRadius.circular(16),
//         ),
//         title: const Text(
//           'تأكيد الحذف',
//           style: TextStyle(color: Colors.white),
//         ),
//         content: Column(
//           mainAxisSize: MainAxisSize.min,
//           crossAxisAlignment: CrossAxisAlignment.start,
//           children: [
//             Text(
//               'هل أنت متأكد من حذف مدينة "${city.nameAr}"؟',
//               style: TextStyle(color: Colors.white.withOpacity(0.7)),
//             ),
//             const SizedBox(height: 12),
//             Container(
//               padding: const EdgeInsets.all(12),
//               decoration: BoxDecoration(
//                 color: Colors.red.withOpacity(0.1),
//                 borderRadius: BorderRadius.circular(8),
//                 border: Border.all(color: Colors.red.withOpacity(0.3)),
//               ),
//               child: Row(
//                 children: [
//                   const Icon(Icons.warning, color: Colors.red, size: 20),
//                   const SizedBox(width: 8),
//                   Expanded(
//                     child: Text(
//                       'سيتم حذف جميع التصنيفات المرتبطة بهذه المدينة',
//                       style: TextStyle(
//                         color: Colors.red.shade300,
//                         fontSize: 13,
//                       ),
//                     ),
//                   ),
//                 ],
//               ),
//             ),
//           ],
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
//                 citiesCategories.remove(city.id);
//                 if (selectedCity?.id == city.id) {
//                   selectedCity = null;
//                 }
//               });
//               Navigator.pop(context);
//               _showSuccessSnackBar('تم حذف المدينة وجميع تصنيفاتها بنجاح');
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

//   void _confirmDeleteCategory(PropertyCategoryModel category) {
//     showDialog(
//       context: context,
//       builder: (context) => AlertDialog(
//         backgroundColor: const Color(0xFF16213E),
//         shape: RoundedRectangleBorder(
//           borderRadius: BorderRadius.circular(16),
//         ),
//         title: const Text(
//           'تأكيد الحذف',
//           style: TextStyle(color: Colors.white),
//         ),
//         content: Text(
//           'هل أنت متأكد من حذف تصنيف "${category.nameAr}"؟',
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
//                 final categories = citiesCategories[selectedCity!.id]!;
//                 categories.removeWhere((c) => c.id == category.id);
                
//                 // إعادة ترتيب الكاتيجوريز
//                 for (int i = 0; i < categories.length; i++) {
//                   categories[i] = categories[i].copyWith(order: i + 1);
//                 }
//               });
//               Navigator.pop(context);
//               _showSuccessSnackBar('تم حذف التصنيف بنجاح');
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
//         shape: RoundedRectangleBorder(
//           borderRadius: BorderRadius.circular(8),
//         ),
//         margin: const EdgeInsets.all(16),
//       ),
//     );
//   }
// }