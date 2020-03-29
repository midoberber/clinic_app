class UserEntity {
  final String id;
  final String displayName;
  final String photoUrl;

  UserEntity({this.id, this.displayName, this.photoUrl});

  @override
  bool operator ==(Object other) =>
      identical(this, other) ||
      other is UserEntity &&
          runtimeType == other.runtimeType &&
          id == other.id &&
          displayName == other.displayName &&
          photoUrl == other.photoUrl;

  @override
  int get hashCode => id.hashCode ^ displayName.hashCode ^ photoUrl.hashCode;

  @override
  String toString() {
    return '{id: $id, displayName: $displayName, photoUrl: $photoUrl}';
  }

  dynamic toJson() => {
        "id": this.id,
        "displayName": this.displayName,
        "photoUrl": this.photoUrl
      };

  UserEntity compyWith({String displayName, String photo}) {
    return UserEntity(
        id: this.id,
        displayName: displayName ?? this.displayName,
        photoUrl: photo ?? this.photoUrl);
  }

  static UserEntity fromJson(Map<String, dynamic> json) {
    return UserEntity(
      id: json['id'] as String,
      displayName: json['displayName'] as String,
      photoUrl: json['photoUrl'] as String,
    );
  }
}
