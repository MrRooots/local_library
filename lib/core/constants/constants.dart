/// Basic constants for the project like urls and keys
class Constants {
  /// Api url
  static const String api = 'https://tjntwcbqnaonomvopzon.supabase.co';

  /// Api key
  static const String apiKey =
      'eyJhbGciOiJIUzI1NiIsInR5cCI6IkpXVCJ9.eyJpc3MiOiJzdXBhYmFzZSIsInJlZiI6InRqbnR3Y2JxbmFvbm9tdm9wem9uIiwicm9sZSI6InNlcnZpY2Vfcm9sZSIsImlhdCI6MTY2NjM1NTAwMywiZXhwIjoxOTgxOTMxMDAzfQ.21nA-SR1cx8EIRI6oXr65N_tMVKWfjF86MJ8oID3cfM';

  /// Api request <-> response type
  static const String apiTypeRest = 'rest';

  static const String apiTypeStorage = 'storage';

  static const String apiRequestFor = 'object';

  static const String apiBucketName = 'img';

  /// Api version
  static const String apiVersion = 'v1';

  /// Standart request Content-Type header
  static const String apiContentType = 'application/json';

  /// Basic request authorization headers
  static const Map<String, String> authHeaders = {
    'apikey': apiKey,
    'Authorization': 'Bearer $apiKey',
    'Content-Type': apiContentType,
  };

  static const String cachedCustomer = 'CACHED_CUSTOMER';

  static const String cachedProfileImagePath = 'CACHED_PROFILE_IMAGE_PATH';
}
