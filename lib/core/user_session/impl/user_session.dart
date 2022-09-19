import 'package:flutter_beconsent_sdk/core/secure_storage/secure_storage.dart';
import 'package:flutter_beconsent_sdk/core/user_session/user_session.dart';
import 'package:flutter/material.dart';
import 'package:uuid/uuid.dart';

class UserSessionImpl implements UserSession {
  static const _accessTokenKey = 'access_token';
  static const _refreshTokenKey = 'refresh_token';
  static const _uuidKey = 'uuid';
  static const _collectionChannelKey = 'collection_channel_key';

  final SecureStorage _secureStorage;
  String? _accessToken;
  String? _refreshToken;
  String? _uuid;
  String? _collectionChannel;

  UserSessionImpl(this._secureStorage);

  @override
  String get accessToken => _accessToken ?? '';

  @override
  String get refreshToken => _refreshToken ?? '';

  @override
  bool get valid => _accessToken != null && _accessToken != '';

  @override
  Future<void> loadSession() async {
    _accessToken = await _secureStorage.read(_accessTokenKey);
    _refreshToken = await _secureStorage.read(_refreshTokenKey);
    _uuid = await _secureStorage.read(_uuidKey);
    _collectionChannel = await _secureStorage.read(_collectionChannelKey);
    if (_uuid == null) {
      saveUUID(const Uuid().v4());
    }
  }

  @override
  Future<void> clearSession() async {
    _accessToken = null;
    _refreshToken = null;
    _uuid = null;
    await _secureStorage.delete(_accessTokenKey);
    await _secureStorage.delete(_refreshTokenKey);
    await _secureStorage.delete(_uuidKey);
  }

  @override
  Future<void> saveSession(String accessToken, String refreshToken) async {
    if (accessToken == '' || refreshToken == '') {
      return;
    }

    try {
      _accessToken = accessToken;
      _refreshToken = refreshToken;
      await _secureStorage.write(_accessTokenKey, accessToken);
      await _secureStorage.write(_refreshTokenKey, refreshToken);
    } catch (_) {}
  }

  @override
  Future<void> saveUUID(String uuid) async {
    try {
      _uuid = uuid;
      await _secureStorage.write(_uuidKey, uuid);
    } catch (_) {}
  }

  @override
  String get uuid => _uuid ?? "";

  @override
  String get collectionChannel => _collectionChannel??"";

  @override
  Future<void> saveCollectionChannel(String channel) async {
    try {
      _collectionChannel = channel;
      await _secureStorage.write(_collectionChannelKey, channel);
    } catch (_) {}
  }
}
