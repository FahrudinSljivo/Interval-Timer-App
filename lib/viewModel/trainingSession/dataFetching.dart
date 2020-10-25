import 'package:http/http.dart' as http;

Future<String> fetchTheQuote() async {
  String url = 'https://pastebin.com/raw/jmhKjPLD';
  final response = await http.get(url);

  return response.body;
}
