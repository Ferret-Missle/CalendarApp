import 'package:flutter/material.dart';

class EventAddPage extends StatefulWidget {
  final String eventId;

  EventAddPage({required this.eventId});

  @override
  _EventAddPageState createState() => _EventAddPageState();
}

class _EventAddPageState extends State<EventAddPage> {
  var isOn = false; //終日設定

  @override
  void initState() {
    super.initState();
    // widget.eventIdを使用してデータを取得
    fetchData(widget.eventId);
  }

  void fetchData(String eventId) {
    // データ取得のロジックをここに記述
  }

  Color eventColor = Colors.yellow;
  String colorName = '既定の色';
  Map<String, Color> colorPalette = {
    'トマト': Colors.red,
    'オレンジ': Colors.deepOrangeAccent,
    'バナナ': Colors.yellow,
    'バジル': Colors.green,
    'セージ': Colors.lightGreenAccent,
    'ピーコック': Colors.lightBlueAccent,
    'ブルーベリー': Colors.deepPurple,
    'ブドウ': Colors.purple,
    'グラファイト': Colors.grey,
  };
  void _pickColor() async {
    Color pickerColor = eventColor;
    await showDialog(
      context: context,
      builder: (context) {
        return AlertDialog(
          content: SingleChildScrollView(
            child: Column(
              children: colorPalette.entries.map((entry) {
                return ListTile(
                  leading: Icon(
                    Icons.circle,
                    color: entry.value,
                    size: 28,
                  ),
                  title: Text(entry.key),
                  onTap: () {
                    setState(() {
                      eventColor = entry.value;
                      colorName = entry.key;
                    });
                    Navigator.of(context).pop();
                  },
                );
              }).toList(),
            ),
          ),
        );
      },
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        leading: IconButton(
          icon: Icon(Icons.close),
          onPressed: () {
            Navigator.pop(context);
          },
        ),
        actions: [
          Padding(
            padding: EdgeInsets.only(right: 20),
            child: ElevatedButton(
              onPressed: () {
                Navigator.pop(context);
              },
              child: Text(
                '保存',
                style: TextStyle(color: Colors.white),
              ),
              style: ElevatedButton.styleFrom(
                  backgroundColor: Colors.black,
                  // shape: RoundedRectangleBorder(
                  //   borderRadius: BorderRadius.circular(5),
                  // ),
                  padding: EdgeInsets.symmetric(horizontal: 20)),
            ),
          ),
        ],
      ),
      body: ListView(
        children: [
          Padding(
            padding: EdgeInsets.only(left: 65, right: 40, bottom: 15),
            child: TextField(
              style: TextStyle(fontSize: 28),
              decoration: InputDecoration(
                border: InputBorder.none,
                hintText: 'タイトルを入力',
              ),
            ),
          ),
          Divider(),
          Padding(
            padding: EdgeInsets.symmetric(vertical: 10),
            child: Row(
              children: [
                Padding(
                  padding: const EdgeInsets.only(left: 20, right: 20),
                  child: Icon(
                    Icons.access_time_rounded,
                    size: 28,
                  ),
                ),
                Text(
                  '終日',
                  style: TextStyle(fontSize: 16),
                ),
                Spacer(),
                Padding(
                  padding: EdgeInsets.only(right: 25),
                  child: Switch(
                    value: isOn,
                    onChanged: (bool? value) {
                      if (value != null) {
                        setState(() {
                          isOn = value;
                        });
                      }
                    },
                    activeColor: Colors.white,
                    activeTrackColor: Colors.black,
                  ),
                ),
              ],
            ),
          ),
          Padding(
            padding: EdgeInsets.symmetric(vertical: 5),
            child: Row(children: [
              Padding(
                padding: EdgeInsets.only(left: 70),
                child: TextButton(
                  child: Text(
                    '2024年8月22日(木)',
                    style: TextStyle(
                      fontSize: 18,
                      fontWeight: FontWeight.w400,
                      color: Colors.black,
                    ),
                  ),
                  onPressed: () {},
                ),
              ),
              Spacer(),
              // if (isOn)
              //
              //時刻変数を削除
              if (!isOn)
                Padding(
                  padding: EdgeInsets.only(right: 30),
                  child: TextButton(
                    style: ButtonStyle(),
                    child: Text(
                      '0:30',
                      style: TextStyle(
                        fontSize: 18,
                        fontWeight: FontWeight.w400,
                        color: Colors.black,
                      ),
                    ),
                    onPressed: () {},
                  ),
                ),
            ]),
          ),
          Padding(
            padding: EdgeInsets.symmetric(vertical: 5),
            child: Row(children: [
              Padding(
                padding: EdgeInsets.only(left: 70),
                child: TextButton(
                  child: Text(
                    '2024年8月22日(木)',
                    style: TextStyle(
                      fontSize: 18,
                      fontWeight: FontWeight.w400,
                      color: Colors.black,
                    ),
                  ),
                  onPressed: () {},
                ),
              ),
              Spacer(),
              // if (isOn)
              //時刻変数を削除
              if (!isOn)
                Padding(
                  padding: EdgeInsets.only(right: 30),
                  child: TextButton(
                    child: Text(
                      '1:30',
                      style: TextStyle(
                        fontSize: 18,
                        fontWeight: FontWeight.w400,
                        color: Colors.black,
                      ),
                    ),
                    onPressed: () {},
                  ),
                ),
            ]),
          ),
          Divider(),
          GestureDetector(
            onTap: _pickColor,
            child: Container(
              child: Row(
                children: [
                  Padding(
                    padding: const EdgeInsets.only(
                        left: 20, right: 20, top: 10, bottom: 10),
                    child: Icon(
                      Icons.circle,
                      color: eventColor,
                      size: 28,
                    ),
                  ),
                  Expanded(
                    child: Text(
                      // textAlign: TextAlign.left,
                      colorName,
                      style: TextStyle(
                        fontSize: 16,
                        color: Colors.black,
                      ),
                    ),
                  ),
                ],
              ),
            ),
          ),
          Divider(),
          Row(
            children: [
              Padding(
                padding: const EdgeInsets.only(left: 20, right: 20),
                child: Icon(
                  Icons.text_snippet_outlined,
                  size: 28,
                ),
              ),
              Expanded(
                child: TextField(
                  style: TextStyle(fontSize: 16),
                  decoration: InputDecoration(
                    border: InputBorder.none,
                    hintText: 'メモを追加',
                  ),
                ),
              ),
            ],
          ),
          Divider(),
        ],
      ),
    );
  }
}
