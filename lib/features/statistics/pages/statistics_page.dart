import 'package:fl_chart/fl_chart.dart';
import 'package:flutter/material.dart';
import 'package:quantify/core/constants/app_colors.dart';
import 'package:quantify/core/utils/context.dart';
import 'package:animated_toggle_switch/animated_toggle_switch.dart';
import 'package:quantify/shared/widgets/simple_app_bar.dart';

class StatisticsPage extends StatefulWidget {
  const StatisticsPage({super.key});

  @override
  State<StatisticsPage> createState() => _StatisticsPageState();
}

class _StatisticsPageState extends State<StatisticsPage> {
  int selectedRange = 0;
  int selectedType = 0;
  @override
  Widget build(BuildContext context) {
    final height = context.deviceSize.height;
    final width = context.deviceSize.width;
    final isLight = context.brightness == Brightness.light;
    return Scaffold(
      body: SizedBox(
        height: height,
        width: width,
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            SimpleAppBar(
              height: height,
              width: width,
              title: 'Statistics',
              trailing: IconButton(
                onPressed: () {},
                icon: const Icon(
                  Icons.calendar_month_outlined,
                  color: AppColors.bgColor,
                ),
              ),
            ),
            const SizedBox(height: 15),

            //Toggle Switch
            Align(
              alignment: Alignment.center,
              child: AnimatedToggleSwitch<int>.size(
                current: selectedRange,
                values: const [0, 1, 2, 3],
                indicatorSize: const Size.fromWidth(94),
                borderWidth: 0,
                onChanged: (value) {
                  setState(() {
                    selectedRange = value;
                  });
                },
                height: 40,
                animationCurve: Curves.fastOutSlowIn,
                iconAnimationCurve: Curves.easeInOutSine,
                iconBuilder: (value) {
                  return Text(
                    ['Year', 'Month', 'Week', 'Custom'][value],
                    style: TextStyle(
                      fontSize: selectedRange == value ? 10 : 12,
                      color: selectedRange == value
                          ? isLight
                              ? Colors.white
                              : Colors.black
                          : Colors.black, // White if selected
                      fontWeight: selectedRange == value
                          ? FontWeight.w600
                          : FontWeight.normal, // Bold if selected
                    ),
                  );
                },
                style: ToggleStyle(
                  backgroundColor: isLight
                      ? Colors.grey[200]
                      : AppColors.bgColor.withOpacity(0.25),
                  indicatorColor: isLight ? AppColors.maincolor : Colors.white,
                ),
              ),
            ),
            const SizedBox(height: 10),

            Align(
              alignment: Alignment.topLeft,
              child: Padding(
                padding: const EdgeInsets.only(left: 20),
                child: SizedBox(
                  width: width * 0.3,
                  height: 25,
                  child: DecoratedBox(
                    decoration: BoxDecoration(
                      borderRadius: BorderRadius.circular(16),
                      border: Border.all(
                        color: isLight
                            ? AppColors.darkBgColor.withOpacity(0.3)
                            : AppColors.bgColor.withOpacity(0.3),
                      ),
                    ),
                    child: DropdownButtonHideUnderline(
                        child: DropdownButton<int>(
                      value: selectedType,
                      icon: const Icon(
                        Icons.keyboard_arrow_down_rounded,
                      ),
                      padding: const EdgeInsets.symmetric(horizontal: 10),
                      borderRadius: BorderRadius.circular(16),
                      items: const [
                        DropdownMenuItem(
                          value: 0,
                          child: Text(
                            'Tickets',
                            style: TextStyle(
                              fontSize: 12,
                            ),
                          ),
                        ),
                        DropdownMenuItem(
                          value: 1,
                          child: Text(
                            'Income',
                            style: TextStyle(
                              fontSize: 12,
                            ),
                          ),
                        ),
                      ],
                      onChanged: (value) {
                        setState(() {
                          selectedType = value!;
                        });
                      },
                    )),
                  ),
                ),
              ),
            ),

            //Line Chart
            SizedBox(
              height: height * 0.25,
              width: width,
              child: LineChart(
                LineChartData(
                  gridData: const FlGridData(
                    show: false,
                  ),
                  titlesData: const FlTitlesData(
                    show: true,
                    leftTitles: AxisTitles(
                      sideTitles: SideTitles(showTitles: false),
                    ),
                    rightTitles: AxisTitles(
                      sideTitles: SideTitles(showTitles: false),
                    ),
                    topTitles: AxisTitles(
                      sideTitles: SideTitles(showTitles: false),
                    ),
                    bottomTitles: AxisTitles(
                      sideTitles: SideTitles(showTitles: false),
                    ),
                  ),
                  lineTouchData: LineTouchData(
                    touchTooltipData: LineTouchTooltipData(
                      tooltipBorder: const BorderSide(
                        width: 0,
                        color: Colors.transparent,
                      ),
                      tooltipRoundedRadius: 10,
                      getTooltipColor: (touchedSpot) {
                        return AppColors.borderDarkColor;
                      },
                    ),
                  ),
                  lineBarsData: [
                    LineChartBarData(
                      dotData: const FlDotData(
                        show: false,
                      ),
                      color: isLight
                          ? AppColors.maincolor
                          : AppColors.bgColor.withAlpha(100),
                      belowBarData: BarAreaData(
                        show: true,
                        gradient: LinearGradient(
                          colors: [
                            isLight
                                ? AppColors.maincolor.withOpacity(0.4)
                                : AppColors.bgColor
                                    .withAlpha(100)
                                    .withOpacity(0.2),
                            isLight
                                ? AppColors.maincolor
                                    .withAlpha(100)
                                    .withOpacity(0.3)
                                : AppColors.bgColor
                                    .withAlpha(100)
                                    .withOpacity(0.15),
                            isLight
                                ? AppColors.maincolor.withOpacity(0)
                                : AppColors.bgColor.withOpacity(0),
                          ],
                          begin: Alignment.topCenter,
                          end: Alignment.bottomCenter,
                          stops: const [0.2, 0.35, 1.0],
                        ),
                      ),
                      spots: [
                        const FlSpot(-0.5, 0),
                        const FlSpot(0.5, 2),
                        const FlSpot(2, 1),
                        const FlSpot(3, 3),
                        const FlSpot(3.5, 2),
                        const FlSpot(4.5, 4),
                        const FlSpot(6, 3),
                      ],
                      isCurved: true,
                    ),
                  ],
                  borderData: FlBorderData(
                    show: false,
                  ),
                ),
              ),
            ),

            //
            const SizedBox(height: 30),
            const Padding(
              padding: EdgeInsets.symmetric(horizontal: 20),
              child: Text(
                'OVERVIEW',
                style: TextStyle(
                  fontSize: 18,
                  fontWeight: FontWeight.w500,
                ),
              ),
            ),
            const SizedBox(height: 20),
            Padding(
              padding: const EdgeInsets.symmetric(horizontal: 20.0),
              child: Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  SizedBox(
                    height: 80,
                    width: width * 0.425,
                    child: DecoratedBox(
                      decoration: BoxDecoration(
                        color: isLight ? Colors.white : AppColors.darkContainer,
                        borderRadius: BorderRadius.circular(10),
                      ),
                      child: Padding(
                        padding: const EdgeInsets.symmetric(
                          horizontal: 10,
                          vertical: 8,
                        ),
                        child: Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            Text(
                              'TOTAL INCOME',
                              style: TextStyle(
                                fontSize: 12,
                                fontWeight: FontWeight.w600,
                                color: isLight
                                    ? AppColors.darkBgColor.withOpacity(0.8)
                                    : AppColors.bgColor.withOpacity(0.8),
                              ),
                            ),
                            const SizedBox(height: 10),
                            const Row(
                              mainAxisAlignment: MainAxisAlignment.spaceBetween,
                              children: [
                                Text(
                                  '7873273 DA',
                                  style: TextStyle(
                                    fontSize: 16,
                                    fontWeight: FontWeight.w600,
                                  ),
                                ),
                                Icon(
                                  Icons.keyboard_arrow_up_rounded,
                                  color: Colors.green,
                                ),
                              ],
                            )
                          ],
                        ),
                      ),
                    ),
                  ),
                  SizedBox(
                    height: 80,
                    width: width * 0.425,
                    child: DecoratedBox(
                      decoration: BoxDecoration(
                        color: isLight ? Colors.white : AppColors.darkContainer,
                        borderRadius: BorderRadius.circular(10),
                      ),
                      child: Padding(
                        padding: const EdgeInsets.symmetric(
                          horizontal: 10,
                          vertical: 8,
                        ),
                        child: Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            Text(
                              'TOTAL TICKETS',
                              style: TextStyle(
                                fontSize: 12,
                                fontWeight: FontWeight.w600,
                                color: isLight
                                    ? AppColors.darkBgColor.withOpacity(0.8)
                                    : AppColors.bgColor.withOpacity(0.8),
                              ),
                            ),
                            const SizedBox(height: 10),
                            const Row(
                              mainAxisAlignment: MainAxisAlignment.spaceBetween,
                              children: [
                                Text(
                                  '788722',
                                  style: TextStyle(
                                    fontSize: 16,
                                    fontWeight: FontWeight.w600,
                                  ),
                                ),
                                Icon(
                                  Icons.keyboard_arrow_up_rounded,
                                  color: Colors.green,
                                ),
                              ],
                            )
                          ],
                        ),
                      ),
                    ),
                  ),
                ],
              ),
            ),
            const SizedBox(height: 20),
            Padding(
              padding: const EdgeInsets.symmetric(horizontal: 20.0),
              child: Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  SizedBox(
                    height: 80,
                    width: width * 0.425,
                    child: DecoratedBox(
                      decoration: BoxDecoration(
                        color: isLight ? Colors.white : AppColors.darkContainer,
                        borderRadius: BorderRadius.circular(10),
                      ),
                      child: Padding(
                        padding: const EdgeInsets.symmetric(
                          horizontal: 10,
                          vertical: 8,
                        ),
                        child: Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            Text(
                              'TOTAL CLIENTS',
                              style: TextStyle(
                                fontSize: 12,
                                fontWeight: FontWeight.w600,
                                color: isLight
                                    ? AppColors.darkBgColor.withOpacity(0.8)
                                    : AppColors.bgColor.withOpacity(0.8),
                              ),
                            ),
                            const SizedBox(height: 10),
                            const Row(
                              mainAxisAlignment: MainAxisAlignment.spaceBetween,
                              children: [
                                Text(
                                  '429290',
                                  style: TextStyle(
                                    fontSize: 16,
                                    fontWeight: FontWeight.w600,
                                  ),
                                ),
                                Icon(
                                  Icons.keyboard_arrow_up_rounded,
                                  color: Colors.green,
                                ),
                              ],
                            )
                          ],
                        ),
                      ),
                    ),
                  ),
                  SizedBox(
                    height: 80,
                    width: width * 0.425,
                    child: DecoratedBox(
                      decoration: BoxDecoration(
                        color: isLight ? Colors.white : AppColors.darkContainer,
                        borderRadius: BorderRadius.circular(10),
                      ),
                      child: Padding(
                        padding: const EdgeInsets.symmetric(
                          horizontal: 10,
                          vertical: 8,
                        ),
                        child: Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            Text(
                              'TOTAL DEPT',
                              style: TextStyle(
                                fontSize: 12,
                                fontWeight: FontWeight.w600,
                                color: isLight
                                    ? AppColors.darkBgColor.withOpacity(0.8)
                                    : AppColors.bgColor.withOpacity(0.8),
                              ),
                            ),
                            const SizedBox(height: 10),
                            const Row(
                              mainAxisAlignment: MainAxisAlignment.spaceBetween,
                              children: [
                                Text(
                                  '40032 DA',
                                  style: TextStyle(
                                    fontSize: 16,
                                    fontWeight: FontWeight.w600,
                                  ),
                                ),
                                Icon(
                                  Icons.keyboard_arrow_up_rounded,
                                  color: Colors.red,
                                ),
                              ],
                            )
                          ],
                        ),
                      ),
                    ),
                  ),
                ],
              ),
            )
          ],
        ),
      ),
    );
  }
}

