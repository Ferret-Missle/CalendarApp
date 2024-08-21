import 'package:flutter/material.dart';

class EventAddPage extends StatefulWidget {
  final String eventId;

  EventAddPage({required this.eventId});

  @override
  _EventAddPageState createState() => _EventAddPageState();
}

class _EventAddPageState extends State<EventAddPage> {
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
        title: Text('イベントを追加'),
      ),
      body: Padding(
        padding: EdgeInsets.all(16.0),
        child: Column(
          children: [
            TextField(
              decoration: InputDecoration(labelText: 'タイトル'),
            ),
            // 他の入力フィールドやウィジェットをここに追加
          ],
        ),
      ),
    );
  }
}
