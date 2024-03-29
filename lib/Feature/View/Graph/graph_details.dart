// ignore_for_file: avoid_unnecessary_containers

import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:syncfusion_flutter_charts/charts.dart';

import '../../../Core/Models/cryptocurrenct.dart';
import '../../Services/Market/market_provider.dart';
import '../../../Core/Shared Preferences/prices.dart';

class GraphDetails extends StatefulWidget {
  final String id;
  final CryptoCurrency currentCrypto;
  const GraphDetails(
      {super.key, required this.id, required this.currentCrypto});

  @override
  State<GraphDetails> createState() => _GraphDetailsState();
}

class _GraphDetailsState extends State<GraphDetails> {
  @override
  Widget build(BuildContext context) {
    return Consumer<MarketProvider>(
      builder: (context, marketProvider, child) {
        marketProvider.fetchGraphData(widget.id);
        return Padding(
          padding: const EdgeInsets.only(
            right: 8,
          ),
          child: SfCartesianChart(
            enableAxisAnimation: true,
            plotAreaBorderColor: Colors.transparent,
            plotAreaBackgroundColor: Colors.transparent,
            palette: [
              (widget.currentCrypto.priceChange24h! > 0)
                  ? Colors.green
                  : Colors.red
            ],
            // primaryXAxis: DateTimeAxis(),
            series: <ChartSeries>[
              LineSeries<Price, dynamic>(
                  dataSource: marketProvider.prices,
                  xValueMapper: (Price price, _) => price.timestamp,
                  yValueMapper: (Price price, _) => price.value)
            ],
          ),
        );
      },
    );
  }
}
