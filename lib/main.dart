import 'package:flutter/material.dart';
import 'package:intl/date_symbol_data_local.dart';
import 'package:intl/intl.dart';
import 'package:table_calendar/table_calendar.dart';

void main() {
  initializeDateFormatting().then((_) => runApp(MyApp()));
}

class MyApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Flutter Calendar Demo',
      theme: ThemeData(
        primarySwatch: Colors.blue,
      ),
      home: MyHomePage(),
    );
  }
}

class MyHomePage extends StatefulWidget {
  @override
  _MyHomePageState createState() => _MyHomePageState();
}

class _MyHomePageState extends State<MyHomePage> {
  DateTime _focusedDay = DateTime.now();
  DateTime? _selectedDay;
  CalendarFormat _calendarFormat = CalendarFormat.month;
  final Map<DateTime, List> _events = {};
  final GlobalKey<ScaffoldState> _scaffoldKey = GlobalKey<ScaffoldState>();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      key: _scaffoldKey,
      appBar: AppBar(
        leading: IconButton(
          icon: Icon(Icons.menu, size: 30),
          onPressed: () {
            _scaffoldKey.currentState?.openDrawer();
          },
        ),
        title: Text(
          DateFormat.yMMM('ja_JP').format(_focusedDay),
          style: TextStyle(fontSize: 24),
        ),
        actions: [
          IconButton(
            icon: Icon(Icons.settings, size: 30),
            onPressed: () {
              ScaffoldMessenger.of(context).showSnackBar(
                SnackBar(content: Text('Setting Icon Pushed!')),
              );
            },
          ),
        ],
      ),
      drawer: Drawer(
        child: Center(child: Text('drawer')),
      ),
      body: TableCalendar(
        locale: 'ja_JP',
        shouldFillViewport: true,
        headerVisible: false,
        //ヘッダー部分のカスタマイズ
        // headerStyle: HeaderStyle(
        //   titleCentered: true,
        //   titleTextStyle: TextStyle(
        //     fontSize: 24,
        //   ),
        //   formatButtonVisible: false,
        //   leftChevronVisible: false,
        //   rightChevronVisible: false,
        // ),
        pageAnimationEnabled: true,
        pageJumpingEnabled: true,
        sixWeekMonthsEnforced: true,

        //表示形式を指定する
        calendarFormat: _calendarFormat,

        //カレンダーの開始日・終了日を設定
        firstDay: DateTime.utc(1950, 1, 1),
        lastDay: DateTime.utc(2050, 12, 31),
        //フォーカスされる日の指定
        focusedDay: _focusedDay,

        //日付選択
        selectedDayPredicate: (day) {
          return isSameDay(_selectedDay, day);
        },
        onDaySelected: (selectedDay, focusedDay) {
          setState(() {
            _selectedDay = selectedDay;
            _focusedDay = focusedDay;
          });
        },

        //表示付き変更
        onPageChanged: (focusedDay) {
          setState(() {
            _focusedDay = focusedDay;
          });
        },

        //イベント読み込み関数
        eventLoader: (day) {
          return _events[day] ?? [];
        },

        //カレンダーのスタイル調整
        calendarBuilders: CalendarBuilders(
          //今日の日付スタイル
          todayBuilder: (context, day, focusedDay) {
            return Container(
              // margin: EdgeInsets.only(top: 10),
              alignment: Alignment.topCenter,
              decoration: BoxDecoration(
                border: Border.all(color: Colors.grey, width: 0.1),
              ),
              child: Container(
                width: 20,
                height: 20,
                decoration: BoxDecoration(
                  color: Colors.blue,
                  shape: BoxShape.circle,
                ),
                child: Center(
                  child: Text(
                    day.day.toString(),
                    style: TextStyle(color: Colors.white, fontSize: 12),
                  ),
                ),
              ),
            );
          },
          //選択日の日付スタイル
          selectedBuilder: (context, day, focusedDay) {
            return Container(
              alignment: Alignment.topCenter,
              decoration: BoxDecoration(
                color: Colors.blue[50],
                border: Border.all(color: Colors.grey, width: 0.1),
              ),
              child: Text(
                day.day.toString(),
                style: TextStyle(color: Colors.black, fontSize: 12),
              ),
            );
          },
          //他日の日付スタイル
          defaultBuilder: (context, day, focusedDay) {
            return Container(
              // margin: EdgeInsets.only(top: 10),
              alignment: Alignment.topCenter,
              decoration: BoxDecoration(
                border: Border.all(color: Colors.grey, width: 0.1),
              ),
              child: Text(
                day.day.toString(),
                style: TextStyle(color: Colors.black, fontSize: 12),
              ),
            );
          },
          //別月の日付スタイル
          outsideBuilder: (context, day, focusedDay) {
            return Container(
              // margin: EdgeInsets.only(top: 10),
              alignment: Alignment.topCenter,
              decoration: BoxDecoration(
                border: Border.all(color: Colors.grey, width: 0.1),
              ),
              child: Text(
                day.day.toString(),
                style: TextStyle(color: Colors.grey, fontSize: 12),
              ),
            );
          },
        ),
        //曜日列スタイル調整
        daysOfWeekHeight: 30,
      ),
      floatingActionButton: FloatingActionButton(
        onPressed: () {
          ScaffoldMessenger.of(context).showSnackBar(
            SnackBar(content: Text('FAB Pushed!')),
          );
        },
        child: Container(
          width: 80,
          height: 80,
          child: Icon(
            Icons.add,
            size: 40,
          ),
        ),
        backgroundColor: Colors.white,
        shape: CircleBorder(),
      ),
    );
  }
}
