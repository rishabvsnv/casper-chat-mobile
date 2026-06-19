class ApiConfig {
  static String live = "https://myschoolio.com";
  static String local = "http://localhost/myschoolio";

  static String _baseUrl = live;

  // Getter
  static String get baseUrl => _baseUrl;

  // Setter (optional if you need to override manually)
  static void setBaseUrl(String url) {
    _baseUrl = url;
  }

  // Reset to development URL with /myschoolio suffix
  static void resetBaseUrl() {
    _baseUrl;
  }
}
