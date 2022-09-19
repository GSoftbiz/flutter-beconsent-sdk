class CreateDSRMResponse {
  CreateDSRMResponse({
    required this.uuid,
  });
  late final String uuid;

  CreateDSRMResponse.fromJson(Map<String, dynamic> json){
    uuid = json['uuid'];
  }

  Map<String, dynamic> toJson() {
    final _data = <String, dynamic>{};
    _data['uuid'] = uuid;
    return _data;
  }
}