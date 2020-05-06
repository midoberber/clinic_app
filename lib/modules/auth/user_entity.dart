class UserEntity {
  final String id;
  final String displayName;
  final String photoUrl;
  final bool isDoctor;

  UserEntity({this.isDoctor, this.id, this.displayName, this.photoUrl});

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
        "photoUrl": this.photoUrl,
        "isDoctor": this.isDoctor
      };

  UserEntity compyWith({String displayName, String photo , bool isDoctor}) {
    return UserEntity(
        id: this.id,
        displayName: displayName ?? this.displayName,
        isDoctor: isDoctor ?? this.isDoctor,
        photoUrl: photo ?? this.photoUrl);
  }

  static UserEntity fromJson(Map<String, dynamic> json) {
    return UserEntity(
      id: json['id'] as String,
      isDoctor: json['isDoctor'] as bool,
      displayName: json['displayName'] as String,
      photoUrl: json['photoUrl'] as String,
    );
  }
}
