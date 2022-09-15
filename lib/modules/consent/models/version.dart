class Version {
  Version({
      int? version,}){
    _version = version;
}

  Version.fromJson(dynamic json) {
    _version = json['version'];
  }
  int? _version;
Version copyWith({  int? version,
}) => Version(  version: version ?? _version,
);
  int? get version => _version;

  Map<String, dynamic> toJson() {
    final map = <String, dynamic>{};
    map['version'] = _version;
    return map;
  }

}