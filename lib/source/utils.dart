import 'package:http/http.dart' as http;

void checkResponse(http.Response response) {
  if (response.statusCode != 200) {
    throw Exception(
        "Excpected status code 200 but got ${response.statusCode}");
  }
}