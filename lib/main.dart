import 'package:calendar/eventEdit.dart';
import 'package:flutter/material.dart';
import 'package:intl/date_symbol_data_local.dart';
import 'package:intl/intl.dart';
import 'package:table_calendar/table_calendar.dart';

void main() {
  initializeDateFormatting().then((_) => runApp(MyApp()));
}

class MyApp extends StatefulWidget {
  @override
  _MyAppState createState() => _MyAppState();
}

class _MyAppState extends State<MyApp> {
  ThemeMode _themeMode = ThemeMode.system;

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Flutter Calendar Demo',
      theme: ThemeData(
        primarySwatch: Colors.blue,
        useMaterial3: true,
        fontFamily: 'NotoSansJP',
        brightness: Brightness.light,
      ),
      darkTheme: ThemeData(
        primaryColorDark: Colors.grey,
        useMaterial3: true,
        fontFamily: 'NotoSansJP',
        brightness: Brightness.dark,
        appBarTheme: AppBarTheme(color: Colors.grey[900]),
        scaffoldBackgroundColor: Colors.grey[900],
        drawerTheme: DrawerThemeData(backgroundColor: Colors.grey[800]),
        textTheme: TextTheme(
          bodySmall: TextStyle(color: Colors.white),
        ),
        dividerTheme: DividerThemeData(
          color: Colors.grey,
          thickness: 0.5,
        ),
      ),
      themeMode: _themeMode,
      home: MyHomePage(
        onThemeChanged: (ThemeMode themeMode) {
          setState(() {
            _themeMode = themeMode;
          });
        },
        currentTheme: _themeMode,
      ),
    );
  }
}

class MyHomePage extends StatefulWidget {
  final Function(ThemeMode) onThemeChanged;
  final ThemeMode currentTheme;

  MyHomePage({required this.onThemeChanged, required this.currentTheme});

  @override
  _MyHomePageState createState() => _MyHomePageState();
}

class Event {
  late String id;
  late String title;
  bool isAllDay = false;
  late DateTime startDay;
  TimeOfDay? startTime;
  late DateTime endDay;
  TimeOfDay? endTime;
  String? notes = '';
  late Color eventColor;
  bool hasNotification = false;

  Event({
    required this.id,
    required this.title,
    required this.isAllDay,
    required this.startDay,
    this.startTime,
    required this.endDay,
    this.endTime,
    this.notes,
    required this.eventColor,
    required this.hasNotification,
  });
}

class _MyHomePageState extends State<MyHomePage> {
  DateTime _focusedDay = DateTime.now();
  DateTime? _selectedDay;
  CalendarFormat _calendarFormat = CalendarFormat.month;

  //テストデータ
  final Map<DateTime, List> _events = {};
  final GlobalKey<ScaffoldState> _scaffoldKey = GlobalKey<ScaffoldState>();

  void _showThemeDialog(BuildContext context) {
    ThemeMode _selectedTheme = widget.currentTheme;

    showDialog(
      context: context,
      builder: (BuildContext context) {
        return AlertDialog(
          title: Text(
            'テーマの選択',
            style: TextStyle(fontSize: 16),
          ),
          content: Column(
            mainAxisSize: MainAxisSize.min,
            children: <Widget>[
              RadioListTile<ThemeMode>(
                title: Text('ライトモード'),
                value: ThemeMode.light,
                groupValue: _selectedTheme,
                onChanged: (ThemeMode? value) {
                  setState(() {
                    _selectedTheme = value!;
                    widget.onThemeChanged(_selectedTheme);
                  });
                  Navigator.of(context).pop();
                },
              ),
              RadioListTile<ThemeMode>(
                title: Text('ダークモード'),
                value: ThemeMode.dark,
                groupValue: _selectedTheme,
                onChanged: (ThemeMode? value) {
                  setState(() {
                    _selectedTheme = value!;
                    widget.onThemeChanged(_selectedTheme);
                  });
                  Navigator.of(context).pop();
                },
              ),
              RadioListTile<ThemeMode>(
                title: Text('システムのデフォルト'),
                value: ThemeMode.system,
                groupValue: _selectedTheme,
                onChanged: (ThemeMode? value) {
                  setState(() {
                    _selectedTheme = value!;
                    widget.onThemeChanged(_selectedTheme);
                  });
                  Navigator.of(context).pop();
                },
              ),
            ],
          ),
        );
      },
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      key: _scaffoldKey,
      appBar: AppBar(
        leading: IconButton(
          icon: Icon(Icons.menu, size: 24),
          onPressed: () {
            _scaffoldKey.currentState?.openDrawer();
          },
        ),
        title: Text(
          DateFormat.yMMM('ja_JP').format(_focusedDay),
          style: TextStyle(fontSize: 22),
        ),
        actions: [
          IconButton(
            icon: Icon((Icons.calendar_today), size: 24),
            onPressed: () {
              setState(() {
                _focusedDay = DateTime.now();
                _selectedDay = DateTime.now();
              });
            },
          ),
        ],
      ),
      drawer: Drawer(
        child: ListView(
          children: <Widget>[
            Container(
              width: double.infinity,
              child: ListTile(
                contentPadding: EdgeInsets.symmetric(horizontal: 0),
                leading: IconButton(
                  icon: Icon(Icons.close, size: 28),
                  alignment: Alignment.centerRight,
                  onPressed: () {
                    Navigator.of(context).pop();
                  },
                ),
                trailing: IconButton(
                  icon: Icon(Icons.settings, size: 28),
                  onPressed: () {
                    // Navigator.push(
                    //   context,
                    //   MaterialPageRoute(
                    //     builder: (context) => SettingPage(),
                    //   ),
                    // );
                  },
                ),
              ),
            ),
            Divider(),
            Container(
              width: double.infinity,
              child: ListTile(
                contentPadding: EdgeInsets.only(left: 60),
                title: Text(
                  'テーマ',
                  style: TextStyle(
                    fontSize: 18,
                    color: Theme.of(context).brightness == Brightness.dark
                        ? Colors.white
                        : Colors.black,
                  ),
                  textAlign: TextAlign.left,
                ),
                subtitle: Text(
                  'ライトモード',
                  style: TextStyle(
                    fontSize: 14,
                    fontWeight: FontWeight.w300,
                    color: Theme.of(context).brightness == Brightness.dark
                        ? Colors.white
                        : Colors.black,
                  ),
                  textAlign: TextAlign.left,
                ),
                onTap: () {
                  _showThemeDialog(context);
                },
              ),
            ),
            Divider(),
            Container(
              width: double.infinity,
              child: ListTile(
                title: Text('test'),
                onTap: () {},
              ),
            ),
            Divider(),
          ],
        ),
      ),
      body: TableCalendar(
        locale: 'ja_JP',
        shouldFillViewport: true,
        headerVisible: false,
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
          //イベント表示
          markerBuilder: (context, date, events) {
            if (events.isNotEmpty) {
              return Column(
                children: [
                  SizedBox(height: 24),
                  _buildEventList(events),
                ],
              );
            }
            return null;
          },
          //今日の日付スタイル
          todayBuilder: (context, day, focusedDay) {
            return Container(
              alignment: Alignment.topCenter,
              decoration: BoxDecoration(
                border: Border.all(color: Colors.grey, width: 0.1),
              ),
              child: Container(
                margin: EdgeInsets.only(top: 3),
                width: 16,
                height: 16,
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
            bool isSelectedToday = isSameDay(DateTime.now(), _selectedDay);

            return Container(
              alignment: Alignment.topCenter,
              decoration: BoxDecoration(
                color: Colors.blue[50],
                border: Border.all(color: Colors.grey, width: 0.1),
              ),
              child: Container(
                margin: EdgeInsets.only(top: 3),
                width: 16,
                height: 16,
                decoration: BoxDecoration(
                  color: isSelectedToday ? Colors.blue : Colors.blue[50],
                  shape: BoxShape.circle,
                ),
                child: Container(
                  // margin: EdgeInsets.only(top: 1),
                  child: Center(
                    child: Text(
                      day.day.toString(),
                      style: TextStyle(
                        color: isSelectedToday ? Colors.white : Colors.black,
                        fontSize: 12,
                      ),
                    ),
                  ),
                ),
              ),
            );
          },
          //他日の日付スタイル
          defaultBuilder: (context, day, focusedDay) {
            return Container(
              alignment: Alignment.topCenter,
              decoration: BoxDecoration(
                border: Border.all(color: Colors.grey, width: 0.1),
              ),
              child: Container(
                margin: EdgeInsets.only(top: 3),
                child: Text(
                  day.day.toString(),
                  style: TextStyle(
                    color: Theme.of(context).brightness == Brightness.dark
                        ? Colors.white
                        : Colors.black,
                    fontSize: 12,
                  ),
                ),
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
          // ScaffoldMessenger.of(context).showSnackBar(
          //   SnackBar(content: Text('FAB Pushed!')),
          // );
          Navigator.push(
            context,
            MaterialPageRoute(
              builder: (context) => EventAddPage(eventId: '1'),
            ),
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

  Widget _buildEventList(List events) {
    return Column(
      children: events.map((event) {
        return Container(
          width: double.infinity,
          height: 15,
          alignment: Alignment.centerLeft,
          margin: EdgeInsets.only(top: 0.5, bottom: 0.5, left: 0.5, right: 1),
          padding: EdgeInsets.only(left: 3),
          decoration: BoxDecoration(
            color: Colors.yellow[600],
            borderRadius: BorderRadius.circular(3.0),
          ),
          //イベントテキスト設定
          child: Text(
            event.toString(),
            style: TextStyle().copyWith(
              color: Colors.black,
              fontSize: 9,
            ),
            maxLines: 1,
          ),
        );
      }).toList(),
    );
  }
}
