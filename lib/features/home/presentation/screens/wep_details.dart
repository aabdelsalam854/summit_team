import 'dart:ui';

import 'package:flutter/material.dart';
import 'package:summit_team/core/utils/alessamy_colors.dart';
import 'package:summit_team/core/utils/app_colors.dart';
import 'package:summit_team/features/properties/data/models/property_model.dart';

class PropertyWepDetailsScreen extends StatefulWidget {
  final PropertyModel property;

  const PropertyWepDetailsScreen({super.key, required this.property});

  @override
  State<PropertyWepDetailsScreen> createState() =>
      _PropertyWepDetailsScreenState();
}

class _PropertyWepDetailsScreenState extends State<PropertyWepDetailsScreen>
    with SingleTickerProviderStateMixin {
  late TabController _tabController;
  int _currentImageIndex = 0;

  @override
  void initState() {
    super.initState();
    _tabController = TabController(length: 4, vsync: this);
  }

  @override
  void dispose() {
    _tabController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: AlessamyColors.backgroundColor,
      body: CustomScrollView(
        slivers: [
          // SliverAppBar(
          //   expandedHeight: 300,
          //   pinned: true,
          //   backgroundColor: const Color(0xFF1A1A1A),
          //   leading: IconButton(
          //     icon: const Icon(Icons.arrow_back, color: Colors.white),
          //     onPressed: () => Navigator.pop(context),
          //   ),
          //   flexibleSpace: FlexibleSpaceBar(
          //     background:
          // PropertyImageSlider(
          //       images: widget.property.images.isNotEmpty
          //           ? widget.property.images
          //           : [widget.property.imageUrl],
          //       currentIndex: _currentImageIndex,
          //       onPageChanged: (index) {
          //         setState(() {
          //           _currentImageIndex = index;
          //         });
          //       },
          //     ),
          //   ),
          //   actions: [
          //     IconButton(
          //       icon: const Icon(Icons.share, color: Colors.white),
          //       onPressed: () {},
          //     ),
          //     IconButton(
          //       icon: const Icon(Icons.favorite_border, color: Colors.white),
          //       onPressed: () {},
          //     ),
          //   ],
          // ),
          SliverToBoxAdapter(
            child: SizedBox(
              height: 300,
              child: PropertyImageSlider(
                images: widget.property.images.isNotEmpty
                    ? widget.property.images
                    : [widget.property.imageUrl],
                currentIndex: _currentImageIndex,
                onPageChanged: (index) {
                  setState(() {
                    _currentImageIndex = index;
                  });
                },
              ),
            ),
          ),
          SliverToBoxAdapter(
            child: Row(
              children: [
                Expanded(
                  flex: 1,
                  child: Card(
                    color: AlessamyColors.cardBackground,
                    child: PriceAndReservation(
                      clientPhone: "01065656764",
                      employeeCode: "123",
                      ownerPhone: "213213230",
                      property: widget.property,
                    ),
                  ),
                ),
                Expanded(
                  flex: 2,
                  child: Column(
                    children: [
                      Padding(
                        padding: const EdgeInsets.all(8.0),
                        child: PropertyTabBar(tabController: _tabController),
                      ),
                      const SizedBox(height: 16),
                      SizedBox(
                        height: MediaQuery.of(context).size.height * 0.6,
                        child: TabBarView(
                          controller: _tabController,
                          children: [
                            Card(
                              color: AlessamyColors.cardBackground,

                              child: OverviewTabWidget(
                                property: widget.property,
                              ),
                            ),
                            Card(
                              color: AlessamyColors.cardBackground,
                              child: PropertyFinanceTable(
                                // property: widget.property,
                              ),
                            ),
                            Card(
                              color: AlessamyColors.cardBackground,
                              child: MoreDetailsTabWidget(
                                property: widget.property,
                              ),
                            ),
                            Card(
                              color: AlessamyColors.cardBackground,
                              child: LocationTabWidget(
                                property: widget.property,
                              ),
                            ),
                          ],
                        ),
                      ),
                    ],
                  ),
                ),
                ],
            ),
          ),
        ],
      ),
      // bottomNavigationBar: PropertyBottomBar(property: widget.property),
    );
  }
}

// =================== ويدجيت الصور ===================
class PropertyImageSlider extends StatelessWidget {
  final List<String> images;
  final int currentIndex;
  final Function(int) onPageChanged;

  const PropertyImageSlider({
    super.key,
    required this.images,
    required this.currentIndex,
    required this.onPageChanged,
  });

  @override
  Widget build(BuildContext context) {
    return Stack(
      fit: StackFit.expand,
      children: [
        ScrollConfiguration(
          behavior: ScrollConfiguration.of(context).copyWith(
            dragDevices: {PointerDeviceKind.touch, PointerDeviceKind.mouse},
          ),
          child: PageView.builder(
            itemCount: 4,
            onPageChanged: onPageChanged,
            itemBuilder: (context, index) {
              return Image.network(
                images[index],
                fit: BoxFit.cover,
                errorBuilder: (context, error, stackTrace) => Container(
                  color: Colors.grey[800],
                  child: const Icon(
                    Icons.image,
                    size: 50,
                    color: Colors.white54,
                  ),
                ),
              );
            },
          ),
        ),

        Container(
          decoration: BoxDecoration(
            gradient: LinearGradient(
              begin: Alignment.topCenter,
              end: Alignment.bottomCenter,
              colors: [
                Colors.black.withOpacity(0.3),
                Colors.transparent,
                Colors.black.withOpacity(0.7),
              ],
            ),
          ),
        ),
        Positioned(
          bottom: 16,
          right: 16,
          child: Row(
            children: List.generate(5, (i) {
              int idx = 0; // الصورة الأولى من قائمة images
              return Padding(
                padding: const EdgeInsets.only(left: 4),
                child: ClipRRect(
                  borderRadius: BorderRadius.circular(8),
                  child: Container(
                    width: 60,
                    height: 60,
                    decoration: BoxDecoration(
                      border: Border.all(
                        color: currentIndex == idx
                            ? Colors.yellow
                            : Colors.transparent,
                        width: 2,
                      ),
                    ),
                    child: Image.network(
                      images[idx],
                      fit: BoxFit.cover,
                      errorBuilder: (context, e, s) =>
                          Container(color: Colors.grey[800]),
                    ),
                  ),
                ),
              );
            }),
          ),
        ),

        if (images.length > 1)
          Positioned(
            bottom: 16,
            left: 16,
            child: Container(
              padding: const EdgeInsets.symmetric(horizontal: 12, vertical: 6),
              decoration: BoxDecoration(
                color: Colors.black54,
                borderRadius: BorderRadius.circular(20),
              ),
              child: Text(
                '${currentIndex + 1}/${images.length}',
                style: const TextStyle(color: Colors.white, fontSize: 12),
              ),
            ),
          ),
      ],
    );
  }
}

// =================== شريط التبويبات ===================
class PropertyTabBar extends StatelessWidget {
  final TabController tabController;
  const PropertyTabBar({super.key, required this.tabController});

  @override
  Widget build(BuildContext context) {
    return Container(
      height: 60,

      decoration: BoxDecoration(
        borderRadius: BorderRadius.circular(60),
        color: const Color(0xFF1A1A1A),
      ),

      child: TabBar(
        controller: tabController,
        indicatorColor: Colors.yellow,
        labelColor: Colors.white,
        unselectedLabelColor: Colors.grey,
        tabs: const [
          Tab(text: 'نظرة عامة'),
          Tab(text: 'البيانات المالية'),
          Tab(text: 'تفاصيل أكثر'),
          Tab(text: 'الموقع'),
        ],
      ),
    );
  }
}

class PropertyFinanceTable extends StatelessWidget {
  const PropertyFinanceTable({super.key});

  @override
  Widget build(BuildContext context) {
    return Card(
      color: AlessamyColors.cardBackground,
      margin: const EdgeInsets.all(16),

      elevation: 3,
      child: Padding(
        padding: const EdgeInsets.all(16),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            const Text(
              'تفاصيل التمويل',
              style: TextStyle(
                fontSize: 18,
                fontWeight: FontWeight.bold,
                color: Colors.white,
              ),
            ),
            const SizedBox(height: 16),
            Table(
              columnWidths: const {
                0: FlexColumnWidth(2),
                1: FlexColumnWidth(2),
                2: FlexColumnWidth(2),
                3: FlexColumnWidth(2),
              },
              border: TableBorder.all(color: Colors.grey, width: 0.5),
              children: const [
                TableRow(
                  children: [
                    Padding(
                      padding: EdgeInsets.all(8.0),
                      child: Text(
                        'قيمة المقدم',
                        style: TextStyle(color: Colors.white),
                      ),
                    ),
                    Padding(
                      padding: EdgeInsets.all(8.0),
                      child: Text('0', style: TextStyle(color: Colors.white)),
                    ),
                    Padding(
                      padding: EdgeInsets.all(8.0),
                      child: Text(
                        'سنة الحجز',
                        style: TextStyle(color: Colors.white),
                      ),
                    ),
                    Padding(
                      padding: EdgeInsets.all(8.0),
                      child: Text(
                        '13,690,110',
                        style: TextStyle(color: Colors.white),
                      ),
                    ),
                  ],
                ),
                TableRow(
                  children: [
                    Padding(
                      padding: EdgeInsets.all(8.0),
                      child: Text(
                        'سنوات السداد',
                        style: TextStyle(color: Colors.white),
                      ),
                    ),
                    Padding(
                      padding: EdgeInsets.all(8.0),
                      child: Text('12', style: TextStyle(color: Colors.white)),
                    ),
                    Padding(
                      padding: EdgeInsets.all(8.0),
                      child: Text(
                        'اجمالى العقد',
                        style: TextStyle(color: Colors.white),
                      ),
                    ),
                    Padding(
                      padding: EdgeInsets.all(8.0),
                      child: Text(
                        '13,690,110',
                        style: TextStyle(color: Colors.white),
                      ),
                    ),
                  ],
                ),
                TableRow(
                  children: [
                    Padding(
                      padding: EdgeInsets.all(8.0),
                      child: Text(
                        'المدفوع',
                        style: TextStyle(color: Colors.white),
                      ),
                    ),
                    Padding(
                      padding: EdgeInsets.all(8.0),
                      child: Text(
                        '1,291,000',
                        style: TextStyle(color: Colors.white),
                      ),
                    ),
                    Padding(
                      padding: EdgeInsets.all(8.0),
                      child: Text(
                        'الباقى',
                        style: TextStyle(color: Colors.white),
                      ),
                    ),
                    Padding(
                      padding: EdgeInsets.all(8.0),
                      child: Text(
                        '12,399,110',
                        style: TextStyle(color: Colors.white),
                      ),
                    ),
                  ],
                ),
                TableRow(
                  children: [
                    Padding(
                      padding: EdgeInsets.all(8.0),
                      child: Text(
                        'القسط الشهرى',
                        style: TextStyle(color: Colors.white),
                      ),
                    ),
                    Padding(
                      padding: EdgeInsets.all(8.0),
                      child: Text(
                        '41,070',
                        style: TextStyle(color: Colors.white),
                      ),
                    ),
                    Padding(
                      padding: EdgeInsets.all(8.0),
                      child: Text(
                        'عدد الاقساط المتبقية',
                        style: TextStyle(color: Colors.white),
                      ),
                    ),
                    Padding(
                      padding: EdgeInsets.all(8.0),
                      child: Text('0', style: TextStyle(color: Colors.white)),
                    ),
                  ],
                ),
                TableRow(
                  children: [
                    Padding(
                      padding: EdgeInsets.all(8.0),
                      child: Text(
                        'نظام السداد',
                        style: TextStyle(color: Colors.white),
                      ),
                    ),
                    Padding(
                      padding: EdgeInsets.all(8.0),
                      child: Text(
                        'شهرى',
                        style: TextStyle(color: Colors.white),
                      ),
                    ),
                    Padding(
                      padding: EdgeInsets.all(8.0),
                      child: Text(
                        'القسط السنوى',
                        style: TextStyle(color: Colors.white),
                      ),
                    ),
                    Padding(
                      padding: EdgeInsets.all(8.0),
                      child: Text(
                        '397,000',
                        style: TextStyle(color: Colors.white),
                      ),
                    ),
                  ],
                ),
                TableRow(
                  children: [
                    Padding(
                      padding: EdgeInsets.all(8.0),
                      child: Text(
                        'قيمة الوديعة',
                        style: TextStyle(color: Colors.white),
                      ),
                    ),
                    Padding(
                      padding: EdgeInsets.all(8.0),
                      child: Text(
                        '662,625',
                        style: TextStyle(color: Colors.white),
                      ),
                    ),
                    Padding(
                      padding: EdgeInsets.all(8.0),
                      child: Text(
                        'مدفوع من الوديعة',
                        style: TextStyle(color: Colors.white),
                      ),
                    ),
                    Padding(
                      padding: EdgeInsets.all(8.0),
                      child: Text('0', style: TextStyle(color: Colors.white)),
                    ),
                  ],
                ),
                TableRow(
                  children: [
                    Padding(
                      padding: EdgeInsets.all(8.0),
                      child: Text(
                        'الباقى من الوديعة',
                        style: TextStyle(color: Colors.white),
                      ),
                    ),
                    Padding(
                      padding: EdgeInsets.all(8.0),
                      child: Text(
                        '662,625',
                        style: TextStyle(color: Colors.white),
                      ),
                    ),
                    Padding(
                      padding: EdgeInsets.all(8.0),
                      child: Text(
                        'المطلوب',
                        style: TextStyle(color: Colors.white),
                      ),
                    ),
                    Padding(
                      padding: EdgeInsets.all(8.0),
                      child: Text(
                        '1,141,000',
                        style: TextStyle(color: Colors.white),
                      ),
                    ),
                  ],
                ),
              ],
            ),
          ],
        ),
      ),
    );
  }
}

// =================== تبويب النظرة العامة ===================
class OverviewTabWidget extends StatelessWidget {
  final PropertyModel property;
  const OverviewTabWidget({super.key, required this.property});

  @override
  Widget build(BuildContext context) {
    return SingleChildScrollView(
      padding: const EdgeInsets.all(16),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          // العنوان والسعر
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              Expanded(
                child: Text(
                  property.title,
                  style: const TextStyle(
                    color: Colors.white,
                    fontSize: 24,
                    fontWeight: FontWeight.bold,
                  ),
                ),
              ),
              Column(
                crossAxisAlignment: CrossAxisAlignment.end,
                children: [
                  Text(
                    '${property.price.toStringAsFixed(0)}\$',
                    style: const TextStyle(
                      color: Colors.white,
                      fontSize: 24,
                      fontWeight: FontWeight.bold,
                    ),
                  ),
                  if (property.purpose == PropertyPurpose.rent)
                    const Text(
                      'للإيجار',
                      style: TextStyle(color: Colors.grey, fontSize: 14),
                    ),
                ],
              ),
            ],
          ),
          const SizedBox(height: 8),
          Row(
            children: [
              const Icon(Icons.star, color: Colors.yellow, size: 20),
              const SizedBox(width: 4),
              const Text(
                '4.8',
                style: TextStyle(color: Colors.white, fontSize: 16),
              ),
              const SizedBox(width: 4),
              const Text(
                '(220)',
                style: TextStyle(color: Colors.grey, fontSize: 14),
              ),
              const Spacer(),
              const Icon(Icons.location_on, color: Colors.grey, size: 18),
              const SizedBox(width: 4),
              Expanded(
                child: Text(
                  '${property.location}, ${property.city}',
                  style: const TextStyle(color: Colors.grey, fontSize: 14),
                  overflow: TextOverflow.ellipsis,
                ),
              ),
            ],
          ),
          const SizedBox(height: 24),
          Row(
            children: [
              Expanded(
                child: DetailCardWidget(
                  icon: Icons.bed,
                  label: 'غرف نوم',
                  value: '${property.bedrooms}',
                ),
              ),
              const SizedBox(width: 12),
              Expanded(
                child: DetailCardWidget(
                  icon: Icons.bathtub,
                  label: 'حمامات',
                  value: '${property.bathrooms}',
                ),
              ),
              const SizedBox(width: 12),
              Expanded(
                child: DetailCardWidget(
                  icon: Icons.square_foot,
                  label: 'المساحة',
                  value: '${property.area.toInt()} م²',
                ),
              ),
            ],
          ),
          const SizedBox(height: 24),
          const Text(
            'الوصف',
            style: TextStyle(
              color: Colors.white,
              fontSize: 18,
              fontWeight: FontWeight.bold,
            ),
          ),
          const SizedBox(height: 8),
          Text(
            property.description,
            style: const TextStyle(
              color: Colors.grey,
              fontSize: 14,
              height: 1.5,
            ),
          ),
          const SizedBox(height: 24),
          PropertyOverviewWidget(property: property),
          // BuilderDetailsCardWidget(property: property),
        ],
      ),
    );
  }
}

// =================== كارد التفاصيل الصغيرة ===================
class DetailCardWidget extends StatelessWidget {
  final IconData icon;
  final String label;
  final String value;
  const DetailCardWidget({
    super.key,
    required this.icon,
    required this.label,
    required this.value,
  });

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: const EdgeInsets.all(16),
      decoration: BoxDecoration(
        color: const Color(0xFF252525),
        borderRadius: BorderRadius.circular(12),
      ),
      child: Column(
        children: [
          Icon(icon, color: Colors.yellow, size: 28),
          const SizedBox(height: 8),
          Text(
            value,
            style: const TextStyle(
              color: Colors.white,
              fontSize: 18,
              fontWeight: FontWeight.bold,
            ),
          ),
          const SizedBox(height: 4),
          Text(label, style: const TextStyle(color: Colors.grey, fontSize: 12)),
        ],
      ),
    );
  }
}

// =================== تفاصيل الوكيل ===================
class BuilderDetailsCardWidget extends StatelessWidget {
  final PropertyModel property;
  const BuilderDetailsCardWidget({super.key, required this.property});

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: const EdgeInsets.all(16),
      decoration: BoxDecoration(
        color: const Color(0xFF252525),
        borderRadius: BorderRadius.circular(12),
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          const Text(
            'تفاصيل الوكيل',
            style: TextStyle(
              color: Colors.white,
              fontSize: 16,
              fontWeight: FontWeight.bold,
            ),
          ),
          const SizedBox(height: 16),
          DetailRow(label: 'الاسم', value: property.agentName ?? 'Super Real'),
          DetailRow(
            label: 'الهاتف',
            value: property.agentPhone ?? 'xxxxxxxxxx',
          ),
          DetailRow(label: 'البريد الإلكتروني', value: 'info@superreal.com'),
          const SizedBox(height: 16),
          SizedBox(
            width: double.infinity,
            child: ElevatedButton(
              onPressed: () {},
              style: ElevatedButton.styleFrom(
                backgroundColor: Colors.yellow,
                foregroundColor: Colors.black,
                padding: const EdgeInsets.symmetric(vertical: 14),
                shape: RoundedRectangleBorder(
                  borderRadius: BorderRadius.circular(8),
                ),
              ),
              child: const Text(
                'اتصل بالوكيل',
                style: TextStyle(fontSize: 16, fontWeight: FontWeight.bold),
              ),
            ),
          ),
          const SizedBox(height: 12),
          OutlinedButton(
            onPressed: () {},
            style: OutlinedButton.styleFrom(
              foregroundColor: Colors.white,
              side: const BorderSide(color: Colors.white),
              padding: const EdgeInsets.symmetric(vertical: 14),
              shape: RoundedRectangleBorder(
                borderRadius: BorderRadius.circular(8),
              ),
            ),
            child: Row(
              mainAxisAlignment: MainAxisAlignment.center,
              children: const [
                Icon(Icons.download, size: 20),
                SizedBox(width: 8),
                Text('تحميل النشرة التعريفية', style: TextStyle(fontSize: 16)),
              ],
            ),
          ),
        ],
      ),
    );
  }
}

// =================== صف التفاصيل ===================
class DetailRow extends StatelessWidget {
  final String label;
  final String value;
  const DetailRow({super.key, required this.label, required this.value});

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.only(bottom: 12),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: [
          Text(label, style: const TextStyle(color: Colors.grey, fontSize: 14)),
          Text(
            value,
            style: const TextStyle(color: Colors.white, fontSize: 14),
          ),
        ],
      ),
    );
  }
}

// =================== تبويب المرافق ===================
class AmenitiesTabWidget extends StatelessWidget {
  final PropertyModel property;
  const AmenitiesTabWidget({super.key, required this.property});

  @override
  Widget build(BuildContext context) {
    final amenities = [
      {'icon': Icons.fitness_center, 'label': 'جيم'},
      {'icon': Icons.security, 'label': 'أمن'},
      {'icon': Icons.grass, 'label': 'كاميرات مراقبة'},
      {'icon': Icons.elevator, 'label': 'لا مصعد'},
      {'icon': Icons.child_care, 'label': 'منطقة لعب للأطفال'},
      {'icon': Icons.games, 'label': 'ألعاب داخلية'},
      {'icon': Icons.local_parking, 'label': 'موقف سيارات'},
      {'icon': Icons.countertops, 'label': 'مساحة مفتوحة'},
    ];

    return Padding(
      padding: const EdgeInsets.all(16),
      child: GridView.builder(
        physics: const NeverScrollableScrollPhysics(),
        gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
          crossAxisCount: 2,
          childAspectRatio: 3,
          crossAxisSpacing: 12,
          mainAxisSpacing: 12,
        ),
        itemCount: amenities.length,
        itemBuilder: (context, index) {
          return Container(
            padding: const EdgeInsets.all(12),
            decoration: BoxDecoration(
              color: const Color(0xFF252525),
              borderRadius: BorderRadius.circular(8),
            ),
            child: Row(
              children: [
                Icon(
                  amenities[index]['icon'] as IconData,
                  color: Colors.yellow,
                  size: 24,
                ),
                const SizedBox(width: 12),
                Expanded(
                  child: Text(
                    amenities[index]['label'] as String,
                    style: const TextStyle(color: Colors.white, fontSize: 13),
                    overflow: TextOverflow.ellipsis,
                  ),
                ),
              ],
            ),
          );
        },
      ),
    );
  }
}

// =================== تبويب التفاصيل الأكثر ===================
class MoreDetailsTabWidget extends StatelessWidget {
  final PropertyModel property;
  const MoreDetailsTabWidget({super.key, required this.property});

  @override
  Widget build(BuildContext context) {
    return SingleChildScrollView(
      padding: const EdgeInsets.all(16),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          const Text(
            'تفاصيل أكثر',
            style: TextStyle(
              color: Colors.white,
              fontSize: 18,
              fontWeight: FontWeight.bold,
            ),
          ),
          const SizedBox(height: 16),
          if (property.code.isNotEmpty)
            DetailRow(label: 'كود العقار', value: property.code),
          DetailRow(
            label: 'تفاصيل السعر',
            value: '${property.price.toStringAsFixed(0)}\$',
          ),
          DetailRow(
            label: 'مقدم الحجز',
            value: property.downPayment?.toString() ?? 'غير متوفر',
          ),
          if (property.category != null)
            DetailRow(
              label: 'مساحة الأرض',
              value: property.category!.arabicName,
            ),
          if (property.deliveryStatus != null)
            DetailRow(
              label: 'حالة الكهرباء',
              value: property.deliveryStatus!.arabicName,
            ),
          if (property.floor != null)
            DetailRow(label: 'الدور', value: property.floor.toString()),
          if (property.group != null)
            DetailRow(label: 'المجموعة', value: property.group!),
          if (property.building != null)
            DetailRow(label: 'المبنى', value: property.building!),
          if (property.unit != null)
            DetailRow(label: 'الوحدة', value: property.unit!),
          if (property.viewDirection != null)
            DetailRow(label: 'اتجاه الإطلالة', value: property.viewDirection!),
          if (property.gardenArea != null)
            DetailRow(
              label: 'مساحة الحديقة',
              value: '${property.gardenArea} م²',
            ),
          if (property.reservationDate != null)
            DetailRow(
              label: 'تاريخ الحجز',
              value:
                  '${property.reservationDate!.day}/${property.reservationDate!.month}/${property.reservationDate!.year}',
            ),
          if (property.installmentMonths != null)
            DetailRow(
              label: 'مدة الأقساط',
              value: '${property.installmentMonths} شهر',
            ),
          if (property.overPrice != null)
            DetailRow(label: 'زيادة السعر', value: '${property.overPrice}\$'),
          if (property.installmentDetails != null) ...[
            const SizedBox(height: 16),
            const Text(
              'تفاصيل الأقساط',
              style: TextStyle(
                color: Colors.white,
                fontSize: 16,
                fontWeight: FontWeight.bold,
              ),
            ),
            const SizedBox(height: 8),
            Text(
              property.installmentDetails!,
              style: const TextStyle(color: Colors.grey, fontSize: 14),
            ),
          ],
          if (property.notes != null) ...[
            const SizedBox(height: 16),
            const Text(
              'ملاحظات',
              style: TextStyle(
                color: Colors.white,
                fontSize: 16,
                fontWeight: FontWeight.bold,
              ),
            ),
            const SizedBox(height: 8),
            Text(
              property.notes!,
              style: const TextStyle(color: Colors.grey, fontSize: 14),
            ),
          ],
        ],
      ),
    );
  }
}

// =================== تبويب الموقع ===================
class LocationTabWidget extends StatelessWidget {
  final PropertyModel property;
  const LocationTabWidget({super.key, required this.property});

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.all(16),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          const Text(
            'الموقع',
            style: TextStyle(
              color: Colors.white,
              fontSize: 18,
              fontWeight: FontWeight.bold,
            ),
          ),
          const SizedBox(height: 16),
          // Container(
          //   height: 200,
          //   decoration: BoxDecoration(
          //     color: const Color(0xFF252525),
          //     borderRadius: BorderRadius.circular(12),
          //   ),
          //   child: const Center(
          //     child: Column(
          //       mainAxisAlignment: MainAxisAlignment.center,
          //       children: [
          //         Icon(Icons.map, color: Colors.yellow, size: 50),
          //         SizedBox(height: 8),
          //         Text(
          //           'عرض الخريطة',
          //           style: TextStyle(color: Colors.white, fontSize: 16),
          //         ),
          //       ],
          //     ),
          //   ),
          // ),
          const SizedBox(height: 16),
          Row(
            children: [
              const Icon(Icons.location_on, color: Colors.yellow, size: 24),
              const SizedBox(width: 8),
              Expanded(
                child: Text(
                  '${property.location}, ${property.city}',
                  style: const TextStyle(color: Colors.white, fontSize: 16),
                ),
              ),
            ],
          ),
        ],
      ),
    );
  }
}

// =================== شريط السعر والحجز ===================
class PriceAndReservation extends StatelessWidget {
  final PropertyModel property;
  final String clientPhone;
  final String ownerPhone;
  final String employeeCode;

  const PriceAndReservation({
    super.key,
    required this.property,
    required this.clientPhone,
    required this.ownerPhone,
    required this.employeeCode,
  });

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: const EdgeInsets.all(16),
      decoration: BoxDecoration(
        color: AlessamyColors.cardBackground,
        boxShadow: [
          BoxShadow(
            color: Colors.black.withOpacity(0.3),
            blurRadius: 10,
            offset: const Offset(0, -5),
          ),
        ],
      ),
      child: SafeArea(
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            // السعر الإجمالي
            Text(
              'السعر الإجمالي',
              style: TextStyle(color: Colors.grey[400], fontSize: 12),
            ),
            Text(
              '${property.price.toStringAsFixed(0)}\$',
              style: const TextStyle(
                color: Colors.white,
                fontSize: 24,
                fontWeight: FontWeight.bold,
              ),
            ),
            const SizedBox(height: 16),

            // رقم هاتف العميل
            Text(
              'رقم هاتف العميل',
              style: TextStyle(color: Colors.grey[400], fontSize: 12),
            ),
            Text(
              clientPhone,
              style: const TextStyle(color: Colors.white, fontSize: 16),
            ),
            const SizedBox(height: 8),

            // رقم هاتف صاحب العقار
            Text(
              'رقم هاتف صاحب العقار',
              style: TextStyle(color: Colors.grey[400], fontSize: 12),
            ),
            Text(
              ownerPhone,
              style: const TextStyle(color: Colors.white, fontSize: 16),
            ),
            const SizedBox(height: 8),

            // كود الموظف
            Text(
              'كود الموظف',
              style: TextStyle(color: Colors.grey[400], fontSize: 12),
            ),
            Text(
              employeeCode,
              style: const TextStyle(color: Colors.white, fontSize: 16),
            ),
            const SizedBox(height: 16),

            // زر الحجز
            SizedBox(
              width: double.infinity,
              child: ElevatedButton(
                onPressed: () {},
                style: ElevatedButton.styleFrom(
                  backgroundColor: Colors.yellow,
                  foregroundColor: Colors.black,
                  padding: const EdgeInsets.symmetric(vertical: 16),
                  shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(8),
                  ),
                ),
                child: const Text(
                  'احجز الآن',
                  style: TextStyle(fontSize: 16, fontWeight: FontWeight.bold),
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}

// الأنواع مترجمة
// enum PropertyType {
//   apartment('شقة'),
//   villa('فيلا'),
//   duplex('دوبلكس'),
//   penthouse('بنتهاوس'),
//   studio('استوديو'),
//   townhouse('تاون هاوس'),
//   land('أرض'),
//   commercial('تجاري');

//   final String arabicName;
//   const PropertyType(this.arabicName);
// }

// enum PropertyPurpose {
//   sale('للبيع'),
//   rent('للإيجار'),
//   both('للبيع والإيجار');

//   final String arabicName;
//   const PropertyPurpose(this.arabicName);
// }

enum PropertyCategory {
  aptResale('شقة ريسيل'),
  aptSale('شقة بيع'),
  villaSale('فيلا بيع'),
  villaResale('فيلا ريسيل'),
  duplexSale('دوبلكس بيع'),
  duplexResale('دوبلكس ريسيل'),
  penthouseSale('بنتهاوس بيع'),
  penthouseResale('بنتهاوس ريسيل'),
  townhouseSale('تاون هاوس بيع'),
  townhouseResale('تاون هاوس ريسيل');

  final String arabicName;
  const PropertyCategory(this.arabicName);
}

// enum DeliveryStatus {
//   rtm('جاهز للسكن - RTM'),
//   ready('جاهز'),
//   underConstruction('تحت الإنشاء'),
//   semiFinished('نصف تشطيب'),
//   finished('تشطيب كامل');

//   final String arabicName;
//   const DeliveryStatus(this.arabicName);
// }

/// Property Overview Section Widget
/// يعرض تفاصيل العقار في شكل Grid منظم
class PropertyOverviewWidget extends StatelessWidget {
  final PropertyModel property;

  const PropertyOverviewWidget({super.key, required this.property});

  @override
  Widget build(BuildContext context) {
    return Container(
      width: double.infinity,
      padding: const EdgeInsets.all(20),
      decoration: BoxDecoration(
        color: const Color(0xFF2D2D2D),
        borderRadius: BorderRadius.circular(12),
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          // Overview Title
          const Text(
            'Overview',
            style: TextStyle(
              color: Colors.white,
              fontSize: 20,
              fontWeight: FontWeight.w600,
            ),
          ),
          const SizedBox(height: 24),

          // First Row
          Row(
            children: [
              Expanded(
                child: _buildInfoItem(
                  label: 'Super Built-Up Area',
                  value:
                      '${property.area.toInt()}sqft / ${property.bedrooms}bhk',
                ),
              ),
              const SizedBox(width: 40),
              Expanded(
                child: _buildInfoItem(
                  label: 'Developer',
                  value: property.agentName ?? 'Angel Group',
                ),
              ),
            ],
          ),

          const SizedBox(height: 20),

          // Second Row
          Row(
            children: [
              Expanded(
                child: _buildInfoItem(
                  label: 'Project',
                  value: property.building ?? 'Krishi Patel',
                ),
              ),
              const SizedBox(width: 40),
              Expanded(
                child: _buildInfoItem(
                  label: 'Transaction Type',
                  value: _getTransactionType(),
                ),
              ),
            ],
          ),

          const SizedBox(height: 20),

          // Third Row
          Row(
            children: [
              Expanded(
                child: _buildInfoItem(label: 'Status', value: _getStatus()),
              ),
              const SizedBox(width: 40),
              Expanded(
                child: _buildInfoItem(
                  label: 'Furnished Status',
                  value: _getFurnishedStatus(),
                ),
              ),
            ],
          ),

          const SizedBox(height: 20),

          // Fourth Row
          Row(
            children: [
              Expanded(
                child: _buildInfoItem(
                  label: 'Car Parking',
                  value: _getCarParking(),
                ),
              ),
              const SizedBox(width: 40),
              Expanded(
                child: _buildInfoItem(
                  label: 'Additional Rooms',
                  value: _getAdditionalRooms(),
                ),
              ),
            ],
          ),

          const SizedBox(height: 24),

          // Description
          Text(
            property.description,
            style: TextStyle(
              color: Colors.grey[400],
              fontSize: 14,
              height: 1.6,
              letterSpacing: 0.2,
            ),
          ),
        ],
      ),
    );
  }

  Widget _buildInfoItem({required String label, required String value}) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Text(
          label,
          style: TextStyle(
            color: Colors.grey[600],
            fontSize: 12,
            fontWeight: FontWeight.w400,
          ),
        ),
        const SizedBox(height: 6),
        Text(
          value,
          style: const TextStyle(
            color: Colors.white,
            fontSize: 15,
            fontWeight: FontWeight.w500,
          ),
        ),
      ],
    );
  }

  String _getTransactionType() {
    switch (property.purpose) {
      case PropertyPurpose.sale:
        return 'New Property';
      case PropertyPurpose.rent:
        return 'Rent Property';
      case PropertyPurpose.both:
        return 'Sale & Rent';
    }
  }

  String _getStatus() {
    if (property.deliveryStatus != null) {
      switch (property.deliveryStatus!) {
        case DeliveryStatus.rtm:
          return 'Ready to Move';
        case DeliveryStatus.ready:
          return 'Ready';
        case DeliveryStatus.underConstruction:
          return 'Construction';
        case DeliveryStatus.semiFinished:
          return 'Semi Finished';
        case DeliveryStatus.finished:
          return 'Finished';
      }
    }
    return 'Construction';
  }

  String _getFurnishedStatus() {
    if (property.deliveryStatus != null) {
      switch (property.deliveryStatus!) {
        case DeliveryStatus.finished:
          return 'Full Furnished';
        case DeliveryStatus.semiFinished:
          return 'Semi Furnished';
        default:
          return 'Unfurnished';
      }
    }
    return 'Full Furnished';
  }

  String _getCarParking() {
    if (property.floor != null && property.floor! > 0) {
      return '1 Covered';
    }
    // يمكن إضافة logic من الـ notes
    if (property.notes != null &&
        (property.notes!.toLowerCase().contains('parking') ||
            property.notes!.toLowerCase().contains('موقف'))) {
      return '1 Covered';
    }
    return 'No Parking';
  }

  String _getAdditionalRooms() {
    if (property.notes != null) {
      final notesLower = property.notes!.toLowerCase();
      if (notesLower.contains('store') || notesLower.contains('مخزن')) {
        return '1 Store Room';
      }
      if (notesLower.contains('study') || notesLower.contains('مكتب')) {
        return '1 Study Room';
      }
      if (notesLower.contains('maid') || notesLower.contains('خادمة')) {
        return '1 Maid Room';
      }
    }
    // Default based on bedrooms
    if (property.bedrooms > 3) {
      return '1 Store Room';
    }
    return 'None';
  }
}

// ============= Example Usage =============

class PropertyDetailsExample extends StatelessWidget {
  const PropertyDetailsExample({super.key});

  @override
  Widget build(BuildContext context) {
    // Example property
    final exampleProperty = PropertyModel(
      id: '1',
      code: '5008',
      title: 'Magnificent Townhouse with Valley View Terrace',
      description:
          'Villa Elsewhere\' is a luxurious beautiful, private pool villa, just 90 mins drive from Mumbai. Surrounded by lush green views of fields, hills, and sounds of nature. The Villa has 3 AC en-suite bedrooms, a large AC living room that opens into a private pool and large deck with a Bar. The kitchen is fully equipped where a chef will make delicious meals (*extra charge).',
      price: 5100,
      location: 'B11',
      city: 'Madinaty',
      imageUrl: 'https://example.com/image.jpg',
      images: [],
      type: PropertyType.villa,
      purpose: PropertyPurpose.sale,
      bedrooms: 4,
      bathrooms: 3,
      area: 2703,
      agentName: 'Angel Group',
      agentPhone: '+1234567890',
      createdAt: DateTime.now(),
      building: 'Krishi Patel',
      deliveryStatus: DeliveryStatus.finished,
      floor: 2,
      notes: 'Store room available',
    );

    return Scaffold(
      backgroundColor: const Color(0xFF1A1A1A),
      appBar: AppBar(
        backgroundColor: const Color(0xFF1A1A1A),
        title: const Text('Property Overview'),
      ),
      body: SingleChildScrollView(
        padding: const EdgeInsets.all(16),
        child: PropertyOverviewWidget(property: exampleProperty),
      ),
    );
  }
}

class WepImageDetails extends StatelessWidget {
  const WepImageDetails({super.key});

  @override
  Widget build(BuildContext context) {
    return Row(
      children: [
        Expanded(flex: 1, child: Container(color: AppColors.error)),
        Expanded(
          flex: 1,
          child: Column(
            children: [
              Row(
                children: [
                  Container(color: AppColors.gold),
                  Container(color: AppColors.softGrey),
                ],
              ),
              Row(
                children: [
                  Container(color: AppColors.buttonPrimary),
                  Container(color: AppColors.success),
                ],
              ),
            ],
          ),
        ),
      ],
    );
  }
}
