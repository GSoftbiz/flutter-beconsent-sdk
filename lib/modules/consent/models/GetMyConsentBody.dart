class GetMyConsentBody {
  GetMyConsentBody({
      String? uid,}){
    _uid = uid;
}

  GetMyConsentBody.fromJson(dynamic json) {
    _uid = json['uid'];
  }
  String? _uid;
GetMyConsentBody copyWith({  String? uid,
}) => GetMyConsentBody(  uid: uid ?? _uid,
);
  String? get uid => _uid;

  Map<String, dynamic> toJson() {
    final map = <String, dynamic>{};
    map['uid'] = _uid;
    return map;
  }

}