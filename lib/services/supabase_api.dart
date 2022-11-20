import 'package:local_library/core/constants/constants.dart';

/// Class provides common operatios with remote database using their api
class SupabaseApi {
  static String mapParamsToUrl({
    required final Map<String, String> params,
    final bool orderById = false,
  }) {
    return params.entries
            .map((final e) {
              final value = e.value.split('.').last;
              return value.isNotEmpty &&
                      !(e.key.contains('id') && value == 'null')
                  ? '${e.key}=${e.value}'
                  : '';
            })
            .where((final String el) => el.isNotEmpty)
            .join('&') +
        (orderById ? '&order=id' : '');
  }

  static Uri buildUrlForStorage({required final String filename}) {
    return Uri.parse(
      '${Constants.api}/${Constants.apiTypeStorage}'
      '/${Constants.apiVersion}/${Constants.apiRequestFor}'
      '/${Constants.apiBucketName}/$filename',
    );
  }

  static Uri buildUrlForTable({
    required final String tableName,
    final Map<String, String> queryParams = const {},
    final bool orderById = false,
  }) {
    final String url =
        '${Constants.api}/${Constants.apiTypeRest}/${Constants.apiVersion}/$tableName';

    final String query = mapParamsToUrl(
      params: queryParams,
      orderById: orderById,
    );

    final Uri result = Uri.parse("$url${query.isNotEmpty ? '?$query' : ''}");

    print('Url: $result');

    return result;
  }

  /// Build url for joining [table1] and [table2]
  /// and selecting [column1] from [table1] and [column2] from [table2]
  ///
  /// Return [Uri] like:
  /// { api_url }/[table1]?select=[column1],[table2] ([column2])&[whereParams]
  static Uri buildUrlForJoinTables({
    required final String table1,
    required final String table2,
    required final String column1,
    required final String column2,
    final Map<String, String> whereParams = const {},
  }) {
    String url = '${Constants.api}/'
        '${Constants.apiTypeRest}/'
        '${Constants.apiVersion}/'
        '$table1?select=$column1,$table2($column2)';

    final String whereQuery = mapParamsToUrl(params: whereParams);
    print('Request url: ${whereQuery.isNotEmpty ? '$url&$whereQuery' : url}');
    return Uri.parse(whereQuery.isNotEmpty ? '$url&$whereQuery' : url);
  }

  static Uri buildUrlForFunction({
    required final String function,
    final String param = '',
  }) {
    String url = '${Constants.api}/'
        '${Constants.apiTypeRest}/'
        '${Constants.apiVersion}/rpc/'
        '$function${param.isNotEmpty ? '?$param' : ''}';

    print('Request url: $url');

    return Uri.parse(url);
  }

  /// Build request headers
  ///
  /// If [singularRecord] is true then the headers will be modified to retrieve
  /// single record as an API answer
  ///
  /// Returns [Map] of request headers
  static Map<String, String> getRequestHeaders({
    final bool singularRecord = false,
  }) {
    final Map<String, String> headers = Map.from(Constants.authHeaders);

    if (singularRecord) {
      headers['Accept'] = 'application/vnd.pgrst.object+json';
    }

    return headers;
  }
}
