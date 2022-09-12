import 'package:flutter_beconsent_sdk/network/network.dart';

abstract class Repository {
  final Network apiClient;

  Repository(this.apiClient);
}
