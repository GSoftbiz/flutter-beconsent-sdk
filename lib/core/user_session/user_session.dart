abstract class UserSession {
  Future<void> loadSession();
  Future<void> clearSession();
  Future<void> saveSession(String accessToken, String refreshToken);
  Future<void> saveUUID(String uuid);
  Future<void> saveCollectionChannel(String channel);
  bool get valid;
  String get refreshToken;
  String get accessToken;
  String get uuid;
  String get collectionChannel;
}
