import 'local_db.dart';

// 接続先URL
//ローカル
// String baseUrl = 'http://10.0.2.2:8000/api/';
//サーバー
String baseUrl = 'https://photoma.lolipop.io/api/';

Future<int> user() async {
  final localData = await ldb.queryAllRows();
  int id = localData[0]['_user_id'];
  return Future.value(id);
}
