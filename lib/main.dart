import 'dart:io';

import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';

import 'widgets/transaction_list.dart';
import 'widgets/new_transaction.dart';
import 'widgets/charts.dart';
import 'models/transaction.dart';

void main() {
  // this is needed for the next function
  WidgetsFlutterBinding.ensureInitialized();

  // this allows us to set which orientations are allowed
  // to enable landscape both left and right must be mentioned
  SystemChrome.setPreferredOrientations([
    DeviceOrientation.portraitUp,
    DeviceOrientation.portraitDown,
    DeviceOrientation.landscapeLeft,
    DeviceOrientation.landscapeRight,
  ]);

  runApp(MyApp());
}

class MyApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    final ThemeData lightTheme = ThemeData(
      brightness: Brightness.light,
      // ignore: deprecated_member_use
      accentColor: Color.fromARGB(255, 255, 72, 0),
      fontFamily: 'QuickSand',
      primarySwatch: Colors.deepOrange,
      appBarTheme: AppBarTheme(
        titleTextStyle: ThemeData.light()
            .textTheme
            .copyWith(
              headline6: TextStyle(
                fontFamily: 'QuickSand',
                fontWeight: FontWeight.w500,
                fontSize: 20,
              ),
            )
            .headline6,
      ),
      textTheme: ThemeData.light().textTheme.copyWith(
            headline6: TextStyle(
              fontFamily: 'OpenSans',
              fontWeight: FontWeight.bold,
              fontSize: 18,
            ),
            bodyText2: TextStyle(
              fontSize: 14,
              fontWeight: FontWeight.w600,
            ),
            caption: TextStyle(
              color: Color.fromARGB(255, 155, 155, 155),
            ),
          ),
      cardTheme: CardTheme(
        elevation: 5,
        shape: RoundedRectangleBorder(
          borderRadius: BorderRadius.all(
            Radius.circular(10),
          ),
        ),
      ),
      bottomSheetTheme: BottomSheetThemeData(
        shape: RoundedRectangleBorder(
          borderRadius: BorderRadius.vertical(
            top: Radius.circular(10),
          ),
        ),
      ),
    );

    final ThemeData darkTheme = ThemeData(
      brightness: Brightness.dark,
      // ignore: deprecated_member_use
      accentColor: Color.fromARGB(255, 255, 72, 0),
      fontFamily: 'QuickSand',
      primarySwatch: Colors.deepOrange,
      appBarTheme: AppBarTheme(
        titleTextStyle: ThemeData.light()
            .textTheme
            .copyWith(
              headline6: TextStyle(
                fontFamily: 'QuickSand',
                fontWeight: FontWeight.w500,
                fontSize: 20,
              ),
            )
            .headline6,
      ),
      textTheme: ThemeData.light().textTheme.copyWith(
            headline6: TextStyle(
              fontFamily: 'OpenSans',
              fontWeight: FontWeight.bold,
              fontSize: 18,
            ),
            bodyText2: TextStyle(
              fontSize: 14,
              fontWeight: FontWeight.w600,
            ),
            caption: TextStyle(
              color: Color.fromARGB(255, 155, 155, 155),
            ),
          ),
      cardTheme: CardTheme(
        elevation: 5,
        shape: RoundedRectangleBorder(
          borderRadius: BorderRadius.all(
            Radius.circular(10),
          ),
        ),
      ),
      bottomSheetTheme: BottomSheetThemeData(
        shape: RoundedRectangleBorder(
          borderRadius: BorderRadius.vertical(
            top: Radius.circular(10),
          ),
        ),
      ),
    );

    return Platform.isIOS
        ? CupertinoApp(
            title: 'Personal Expenses App',
            localizationsDelegates: [
              DefaultMaterialLocalizations.delegate,
              DefaultCupertinoLocalizations.delegate,
              DefaultWidgetsLocalizations.delegate,
            ],
            home: MyHomePage(),
          )
        : MaterialApp(
            title: 'Personal Expenses',
            themeMode: ThemeMode.system,
            theme: lightTheme,
            scrollBehavior: CupertinoScrollBehavior(),
            darkTheme: darkTheme,
            home: MyHomePage(),
          );
  }
}

class MyHomePage extends StatefulWidget {
  @override
  State<MyHomePage> createState() => _MyHomePageState();
}

class _MyHomePageState extends State<MyHomePage> with WidgetsBindingObserver {
  @override
  void initState() {
    super.initState();
    WidgetsBinding.instance.addObserver(this);
  }

  @override
  void didChangeAppLifecycleState(AppLifecycleState state) {
    super.didChangeAppLifecycleState(state);
    print(state);
  }

  @override
  void dispose() {
    super.dispose();
    WidgetsBinding.instance.removeObserver(this);
  }

  bool _showCharts = false;

  final List<Transaction> _userTransactions = [
    Transaction(
      id: 'id#01',
      title: 'New Shoes',
      amount: 39.99,
      date: DateTime.now().subtract(Duration(days: 1)),
    ),
    Transaction(
      id: 'id#02',
      title: 'Weekly groceries',
      amount: 75.99,
      date: DateTime.now().subtract(Duration(days: 3)),
    ),
    Transaction(
      id: 'id#03',
      title: 'Coffee with friend',
      amount: 4.00,
      date: DateTime.now().subtract(Duration(days: 4)),
    ),
    Transaction(
      id: 'id#04',
      title: 'Dinner in Bingo',
      amount: 12.50,
      date: DateTime.now().subtract(Duration(days: 4)),
    ),
    Transaction(
      id: 'id#05',
      title: 'Hamburger at King',
      amount: 7.00,
      date: DateTime.now().subtract(Duration(days: 5)),
    ),
    Transaction(
      id: 'id#06',
      title: 'Groceries',
      amount: 24.99,
      date: DateTime.now().subtract(Duration(days: 6)),
    ),
  ];

  List<Transaction> get recentTransactions {
    return _userTransactions.where((transaction) {
      return transaction.date.isAfter(
        DateTime.now().subtract(Duration(days: 7)),
      );
    }).toList();
  }

  void _deleteTransaction(Transaction transaction) {
    setState(() {
      _userTransactions.remove(transaction);
    });
  }

  void _addTransaction({
    @required String title,
    @required double amount,
    DateTime date,
  }) {
    final newTransaction = Transaction(
      id: 'id#${DateTime.now().microsecond}',
      title: title,
      amount: amount,
      date: date ?? DateTime.now(),
    );
    setState(() {
      _userTransactions.add(newTransaction);
    });
  }

  void _startAddNewTransaction(BuildContext ctx) {
    showModalBottomSheet(
      backgroundColor: Colors.transparent,
      context: ctx,
      isScrollControlled: true,
      builder: (_) {
        return NewTransaction(addTransaction: _addTransaction);
      },
    );
  }

  List<Widget> _buildPortraitContent(
    double usableScreenHeight,
    TransactionList transactionList,
  ) {
    return [
      Container(
        height: usableScreenHeight * 0.3,
        child: Charts(recentTransactions),
      ),
      Container(
        height: usableScreenHeight * 0.7,
        child: transactionList,
      ),
    ];
  }

  List<Widget> _buildLandscapeContent(
    double usableScreenHeight,
    double usableScreenWidth,
    TransactionList transactionList,
  ) {
    return [
      Container(
        padding: const EdgeInsets.symmetric(horizontal: 10.0),
        height: usableScreenHeight * 0.15,
        child: Row(
          mainAxisAlignment: MainAxisAlignment.end,
          children: [
            const Text('Show charts:'),
            Platform.isIOS
                ? CupertinoSwitch(
                    value: _showCharts,
                    onChanged: (value) {
                      setState(() {
                        _showCharts = value;
                      });
                    },
                  )
                : Switch(
                    value: _showCharts,
                    onChanged: (value) {
                      setState(() {
                        _showCharts = value;
                      });
                    },
                  ),
          ],
        ),
      ),
      _showCharts
          ? Container(
              height: usableScreenHeight * 0.85,
              width: usableScreenWidth * 0.7,
              child: Charts(recentTransactions),
            )
          : Container(
              height: usableScreenHeight * 0.85,
              child: transactionList,
            ),
    ];
  }

  @override
  Widget build(BuildContext context) {
    final PreferredSizeWidget appBar = Platform.isIOS
        ? CupertinoNavigationBar(
            middle: const Text('Personal Expenses'),
            trailing: GestureDetector(
              onTap: () => _startAddNewTransaction(context),
              child: Icon(
                CupertinoIcons.add,
                color: Theme.of(context).primaryColor,
              ),
            ),
          )
        : AppBar(
            title: const Text('Personal Expenses'),
            actions: <Widget>[
              Padding(
                padding: const EdgeInsets.only(right: 12.0),
                child: IconButton(
                  onPressed: () => _startAddNewTransaction(context),
                  icon: const Icon(Icons.add_rounded),
                ),
              ),
            ],
          );

    final mediaQuery = MediaQuery.of(context);
    final isLandscape = mediaQuery.orientation == Orientation.landscape;
    final appBarHeight = appBar.preferredSize.height;
    final toolBarHeight = mediaQuery.padding.top;
    final fullScreenHeight = mediaQuery.size.height;
    final usableScreenHeight = fullScreenHeight - appBarHeight - toolBarHeight;
    final usableScreenWidth = mediaQuery.size.width;

    final transactionList = TransactionList(_userTransactions, _deleteTransaction);

    final pageBody = SafeArea(
      child: Column(
        children: <Widget>[
          if (isLandscape)
            ..._buildLandscapeContent(usableScreenHeight, usableScreenWidth, transactionList),
          if (!isLandscape) ..._buildPortraitContent(usableScreenHeight, transactionList),
        ],
      ),
    );

    return Platform.isIOS
        ? CupertinoPageScaffold(
            resizeToAvoidBottomInset: false,
            navigationBar: appBar,
            child: pageBody,
          )
        : Scaffold(
            resizeToAvoidBottomInset: false,
            appBar: appBar,
            floatingActionButton: isLandscape
                ? Container()
                : FloatingActionButton(
                    child: const Icon(
                      Icons.add_rounded,
                      size: 30,
                    ),
                    onPressed: () => _startAddNewTransaction(context),
                  ),
            body: pageBody,
          );
  }
}
