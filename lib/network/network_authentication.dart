abstract class NetworkAuthentication {
  String? get validateToken;

  String? get accessToken;

  Future<String?> get userId;

  Future<bool> doRefreshToken();
}
