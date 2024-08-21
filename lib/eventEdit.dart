import 'package:flutter/material.dart';

class EventAddPage extends StatefulWidget {
  final String eventId;

  EventAddPage({required this.eventId});

  @override
  _EventAddPageState createState() => _EventAddPageState();
}

class _EventAddPageState extends State<EventAddPage> {
  var isOn = false;

  @override
  void initState() {
    super.initState();
    // widget.eventIdを使用してデータを取得
    fetchData(widget.eventId);
  }

  void fetchData(String eventId) {
    // データ取得のロジックをここに記述
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
      body: Column(
        children: [
          Padding(
            padding: EdgeInsets.only(left: 40, right: 40, bottom: 15),
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
                    size: 30,
                  ),
                ),
                Text(
                  '終日',
                  style: TextStyle(fontSize: 18),
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
            padding: EdgeInsets.symmetric(vertical: 10),
            child: Row(children: [
              Padding(
                padding: EdgeInsets.only(left: 70),
                child: Text(
                  '2024年8月22日(木)',
                  style: TextStyle(fontSize: 18),
                ),
              ),
              Spacer(),
              Padding(
                padding: EdgeInsets.only(right: 30),
                child: Text(
                  '0:30',
                  style: TextStyle(fontSize: 20),
                ),
              ),
            ]),
          ),
          Padding(
            padding: EdgeInsets.symmetric(vertical: 10),
            child: Row(children: [
              Padding(
                padding: EdgeInsets.only(left: 70),
                child: Text(
                  '2024年8月22日(木)',
                  style: TextStyle(fontSize: 18),
                ),
              ),
              Spacer(),
              Padding(
                padding: EdgeInsets.only(right: 30),
                child: Text(
                  '1:30',
                  style: TextStyle(fontSize: 20),
                ),
              ),
            ]),
          ),
          Divider(),
        ],
      ),
    );
  }
}
