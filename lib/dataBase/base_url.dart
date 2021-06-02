import 'local_db.dart';

//サーバー
String baseUrl = 'https://photoma.lolipop.io/api/';
// 接続先URL
//ローカル
// String baseUrl = 'http://10.0.2.2:9999/api/';
// String baseUrl = 'http://192.168.10.170:9999/api/';

Future<int> user() async {
  final localData = await ldb.queryAllRows();
  int id = localData[0]['_user_id'];
  return Future.value(id);
}
