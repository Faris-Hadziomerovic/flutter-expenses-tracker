import 'package:flutter/material.dart';

class NoTransactionsFound extends StatelessWidget {
  const NoTransactionsFound({
    Key key,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return LayoutBuilder(
      builder: (ctx, constraints) {
        return Column(
          crossAxisAlignment: CrossAxisAlignment.center,
          children: [
            Container(
              height: constraints.maxHeight * 0.15,
              width: constraints.maxWidth * 0.8,
              child: FittedBox(
                child: Text(
                  'No transactions added yet',
                  style: Theme.of(context).textTheme.headline6,
                ),
              ),
            ),
            SizedBox(height: constraints.maxHeight * 0.1),
            Container(
              height: constraints.maxHeight * 0.65,
              child: Image.asset(
                'assets/images/waiting.png',
                fit: BoxFit.cover,
              ),
            ),
          ],
        );
      },
    );
  }
}
