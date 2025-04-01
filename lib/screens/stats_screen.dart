import 'package:flutter/material.dart';
import 'package:fl_chart/fl_chart.dart';

class StatsScreen extends StatefulWidget {
  @override
  _StatsScreenState createState() => _StatsScreenState();
}

class _StatsScreenState extends State<StatsScreen> with SingleTickerProviderStateMixin {
  late TabController _tabController;

  final List<FlSpot> voltageData = [
    FlSpot(0, 230),
    FlSpot(1, 231),
    FlSpot(2, 229),
    FlSpot(3, 232),
    FlSpot(4, 230),
    FlSpot(5, 228),
    FlSpot(6, 231),
    FlSpot(7, 230),
  ];

  final List<BarChartGroupData> powerConsumptionData = [
    BarChartGroupData(x: 0, barRods: [
      BarChartRodData(toY: 50, color: Colors.blue),
    ]),
    BarChartGroupData(x: 1, barRods: [
      BarChartRodData(toY: 75, color: Colors.blue),
    ]),
    BarChartGroupData(x: 2, barRods: [
      BarChartRodData(toY: 100, color: Colors.blue),
    ]),
  ];

  final List<double> percentageChanges = [0, 50, 33.3];

  final List<Map<String, dynamic>> powerConsumptionKWH = [
    {'device': 'Device 1', 'kwh': 10.5},
    {'device': 'Device 2', 'kwh': 8.2},
    {'device': 'Device 3', 'kwh': 12.4},
  ];

  @override
  void initState() {
    super.initState();
    _tabController = TabController(length: 3, vsync: this);
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Stats'),
        bottom: TabBar(
          controller: _tabController,
          tabs: [
            Tab(text: 'Voltage'),
            Tab(text: 'Power Usage'),
            Tab(text: 'Power in kWh'),
          ],
        ),
      ),
      body: TabBarView(
        controller: _tabController,
        children: [
          SingleChildScrollView(
            child: SizedBox(
              height: 300,
              child: VoltageLineChart(voltageData: voltageData),
            ),
          ),
          SingleChildScrollView(
            child: SizedBox(
              height: 300,
              child: PowerConsumptionBarChart(
                powerConsumptionData: powerConsumptionData,
                percentageChanges: percentageChanges,
              ),
            ),
          ),
          PowerConsumptionKWHList(powerConsumptionKWH: powerConsumptionKWH),
        ],
      ),
    );
  }
}

class VoltageLineChart extends StatelessWidget {
  final List<FlSpot> voltageData;

  VoltageLineChart({required this.voltageData});

  @override
  Widget build(BuildContext context) {
    return LineChart(
      LineChartData(
        titlesData: FlTitlesData(
          leftTitles: AxisTitles(
            sideTitles: SideTitles(showTitles: true),
          ),
          bottomTitles: AxisTitles(
            sideTitles: SideTitles(showTitles: true),
          ),
        ),
        borderData: FlBorderData(show: true),
        lineBarsData: [
          LineChartBarData(
            spots: voltageData,
            isCurved: true,
            color: Colors.green,
            barWidth: 4,
            isStrokeCapRound: true,
            belowBarData: BarAreaData(show: false),
          ),
        ],
      ),
    );
  }
}

class PowerConsumptionBarChart extends StatelessWidget {
  final List<BarChartGroupData> powerConsumptionData;
  final List<double> percentageChanges;

  PowerConsumptionBarChart({
    required this.powerConsumptionData,
    required this.percentageChanges,
  });

  @override
  Widget build(BuildContext context) {
    return BarChart(
      BarChartData(
        titlesData: FlTitlesData(
          leftTitles: AxisTitles(
            sideTitles: SideTitles(showTitles: true),
          ),
          bottomTitles: AxisTitles(
            sideTitles: SideTitles(
              showTitles: true,
              getTitlesWidget: (double value, TitleMeta meta) {
                const labels = ['Device 1', 'Device 2', 'Device 3'];
                return SideTitleWidget(
                  axisSide: meta.axisSide,
                  child: Text(labels[value.toInt()]),
                );
              },
            ),
          ),
        ),
        borderData: FlBorderData(show: true),
        barGroups: powerConsumptionData,
        gridData: FlGridData(show: false),
      ),
    );
  }
}

class PowerConsumptionKWHList extends StatelessWidget {
  final List<Map<String, dynamic>> powerConsumptionKWH;

  PowerConsumptionKWHList({required this.powerConsumptionKWH});

  @override
  Widget build(BuildContext context) {
    return ListView.builder(
      itemCount: powerConsumptionKWH.length,
      itemBuilder: (context, index) {
        return ListTile(
          title: Text(powerConsumptionKWH[index]['device']),
          subtitle: Text('${powerConsumptionKWH[index]['kwh']} kWh'),
        );
      },
    );
  }
}
