class ApiHost {
  static String get versionPath => '3';

  static String get baseURL {
    return 'https://api.themoviedb.org/${ApiHost.versionPath}';
  }

  static String get baseImageURL {
    return 'https://image.tmdb.org/t/p/w780';
  }

  static Map<String, String> get defaultQueryParams => {'api_key': 'API_KEY'};
}
