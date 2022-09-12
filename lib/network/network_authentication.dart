abstract class NetworkAuthentication {
  
  String? get accessToken;

  Future<String?> get userId;

  Future<bool> doRefreshToken();
}
