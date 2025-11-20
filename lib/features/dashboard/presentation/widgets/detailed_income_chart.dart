import 'package:fl_chart/fl_chart.dart';
import 'package:flutter/material.dart';
import 'package:summit_team/core/utils/app_styles.dart';

class DetailedIncomeChart extends StatefulWidget {
  const DetailedIncomeChart({super.key});

  @override
  State<DetailedIncomeChart> createState() => _DetailedIncomeChartState();
}

class _DetailedIncomeChartState extends State<DetailedIncomeChart> {
  final ValueNotifier<int> activeIndexNotifier = ValueNotifier<int>(-1);

  final List<_ChartItem> data = const [
    _ChartItem(label: 'المتاح', value: 40, color: Color(0xFF7BDCB5)),
    _ChartItem(label: 'المباع', value: 35, color: Color(0xFFF9A875)),
    _ChartItem(label: 'تم تأجيره', value: 25, color: Color(0xFFB58DF1)),
  ];

  @override
  void dispose() {
    activeIndexNotifier.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return ValueListenableBuilder<int>(
      valueListenable: activeIndexNotifier,
      builder: (context, activeIndex, _) {
        return AspectRatio(
          aspectRatio: 1,
          child: Stack(
            alignment: Alignment.center,
            children: [
              PieChart(getChartData(activeIndex)),
              // النص في المنتصف
              Column(
                mainAxisSize: MainAxisSize.min,
                children: [
                  Text(
                    activeIndex >= 0 ? data[activeIndex].label : 'العقارات',
                    style: AppStyles.styleBold16(context)
                        .copyWith(color: Colors.white),
                  ),
                  if (activeIndex >= 0) ...[
                    const SizedBox(height: 4),
                    Text(
                      '${data[activeIndex].value.toInt()}%',
                      style: AppStyles.styleBold18(context)
                          .copyWith(color: data[activeIndex].color),
                    ),
                  ],
                ],
              ),
            ],
          ),
        );
      },
    );
  }

  PieChartData getChartData(int activeIndex) {
    return PieChartData(
      pieTouchData: PieTouchData(
        enabled: true,
        touchCallback: (event, pietouchResponse) {
          activeIndexNotifier.value =
              pietouchResponse?.touchedSection?.touchedSectionIndex ?? -1;
        },
      ),
      sectionsSpace: 0,
      sections: List.generate(data.length, (i) {
        final item = data[i];
        return PieChartSectionData(
          showTitle: false,
          value: item.value,
          radius: activeIndex == i ? 60 : 50,
          color: item.color,
        );
      }),
    );
  }
}

class _ChartItem {
  final String label;
  final double value;
  final Color color;
  const _ChartItem({
    required this.label,
    required this.value,
    required this.color,
  });
}

// الـ Legend والتفاصيل
class IncomeDetails extends StatelessWidget {
  const IncomeDetails({super.key});

  static const items = [
    _ItemDetailsModel(color: Color(0xFF7BDCB5), title: 'المتاح', value: '%40'),
    _ItemDetailsModel(color: Color(0xFFF9A875), title: 'المباع', value: '%35'),
    _ItemDetailsModel(
      color: Color(0xFFB58DF1),
      title: 'تم تأجيره',
      value: '%25',
    ),
  ];

  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: items.map((e) => ItemDetails(itemDetailsModel: e)).toList(),
    );
  }
}

class IncomeDetailsRow extends StatelessWidget {
  const IncomeDetailsRow({super.key});

  static const items = [
    _ItemDetailsModel(color: Color(0xFF7BDCB5), title: 'المتاح', value: '%40'),
    _ItemDetailsModel(color: Color(0xFFF9A875), title: 'المباع', value: '%35'),
    _ItemDetailsModel(
      color: Color(0xFFB58DF1),
      title: 'تم تأجيره',
      value: '%25',
    ),
  ];

  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: items.map((e) => ItemDetails(itemDetailsModel: e)).toList(),
    );
  }
}

class _ItemDetailsModel {
  final Color color;
  final String title;
  final String value;

  const _ItemDetailsModel({
    required this.color,
    required this.title,
    required this.value,
  });
}

class ItemDetails extends StatelessWidget {
  const ItemDetails({super.key, required this.itemDetailsModel});

  // ignore: library_private_types_in_public_api
  final _ItemDetailsModel itemDetailsModel;

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.only(bottom: 12),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: [
          Row(
            children: [
              Container(
                width: 12,
                height: 12,
                decoration: BoxDecoration(
                  color: itemDetailsModel.color,
                  shape: BoxShape.circle,
                ),
              ),
              const SizedBox(width: 12),
              FittedBox(
                fit: BoxFit.scaleDown,
                alignment: Alignment.centerRight,
                child: Text(
                  itemDetailsModel.title,
                  style: AppStyles.styleBold16(
                    context,
                  ).copyWith(color: Colors.white),
                ),
              ),
            ],
          ),
          const SizedBox(width: 60 - 12),
          FittedBox(
            fit: BoxFit.scaleDown,
            child: Text(
              itemDetailsModel.value,
              style: AppStyles.styleBold16(
                context,
              ).copyWith(color: const Color(0xFF4DB7F2)),
            ),
          ),
        ],
      ),
    );
  }
}

// الـ Body اللي بيجمع الـ Chart والـ Details
class IncomeSectionBody extends StatelessWidget {
  const IncomeSectionBody({super.key});

  @override
  Widget build(BuildContext context) {
    double width = MediaQuery.sizeOf(context).width;

    // لو الشاشة كبيرة بس مش أوي، نعرض الـ DetailedChart لوحده
    if (width >= 1024 && width < 1750) {
      return Padding(
        padding: const EdgeInsets.all(16),
        child: Row(
          crossAxisAlignment: CrossAxisAlignment.center,
          children: [DetailedIncomeChart(), IncomeDetailsRow()],
        ),
      );
    }

    // لو الشاشة صغيرة أو كبيرة جداً
    return const Row(
      crossAxisAlignment: CrossAxisAlignment.center,
      children: [
        Expanded(child: DetailedIncomeChart()),
        Expanded(
          flex: 2,
          child: Padding(padding: EdgeInsets.all(8.0), child: IncomeDetails()),
        ),
      ],
    );
  }
}