import 'package:flutter/material.dart';

class ChartBar extends StatelessWidget {
  ChartBar({
    @required this.label,
    @required this.spendingAmount,
    @required this.spendingPercentOfTotal,
  }) : assert(spendingPercentOfTotal >= 0.0 && spendingPercentOfTotal <= 1);

  final double spendingAmount;
  final double spendingPercentOfTotal;
  final String label;

  Color get chartColor {
    if (spendingPercentOfTotal < 0.4) {
      return Colors.green;
    }
    if (spendingPercentOfTotal < 0.6) {
      return Colors.amber;
    }
    if (spendingPercentOfTotal < 0.9) {
      return Colors.deepOrange;
    }

    return Colors.red;
  }

  @override
  Widget build(BuildContext context) {
    return LayoutBuilder(builder: (builderContext, constraints) {
      final spacing = SizedBox(height: constraints.maxHeight * 0.05);

      return Column(
        mainAxisSize: MainAxisSize.min,
        children: [
          Container(
            height: constraints.maxHeight * 0.15,
            padding: EdgeInsets.symmetric(vertical: 2),
            child: FittedBox(
              child: Text(
                '\$${spendingAmount.toStringAsFixed(0)}',
              ),
            ),
          ),
          spacing,
          Container(
            height: constraints.maxHeight * 0.60,
            width: 10,
            clipBehavior: Clip.hardEdge,
            alignment: Alignment.bottomCenter,
            decoration: BoxDecoration(
              color: Theme.of(context).dividerColor,
              borderRadius: BorderRadius.all(
                Radius.circular(10),
              ),
            ),
            child: FractionallySizedBox(
              heightFactor: spendingPercentOfTotal,
              child: Container(
                decoration: BoxDecoration(
                  color: chartColor,
                  borderRadius: BorderRadius.all(
                    Radius.circular(10),
                  ),
                ),
              ),
            ),
          ),
          spacing,
          Container(
            height: constraints.maxHeight * 0.15,
            padding: EdgeInsets.symmetric(vertical: 2),
            child: FittedBox(
              child: Text(label),
            ),
          ),
        ],
      );
    });
  }
}
