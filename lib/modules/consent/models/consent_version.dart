class ConsentVersion {
  ConsentVersion({
      String? version,}){
    _version = version;
}

  ConsentVersion.fromJson(dynamic json) {
    _version = json['version'];
  }
  String? _version;
ConsentVersion copyWith({  String? version,
}) => ConsentVersion(  version: version ?? _version,
);
  String? get version => _version;

  Map<String, dynamic> toJson() {
    final map = <String, dynamic>{};
    map['version'] = _version;
    return map;
  }

}