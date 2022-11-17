import 'package:http/http.dart';
import 'package:local_library/core/constants/constants.dart';

Future<void> main(List<String> args) async {
  const String url = '${Constants.api}/'
      '${Constants.apiTypeRest}/'
      '${Constants.apiVersion}/'
      'book?select=id,registry(remains)&id=eq.2';

  final Response response = await get(
    Uri.parse(url),
    headers: Constants.authHeaders,
  );

  print(response.statusCode);
  print(response.body);
}
