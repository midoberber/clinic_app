enum AppState {
  uninitialized,
  authenticated,
  unauthenticated,
  authenticating,
  not_completed
}

class AppData {
  final String token;
  final String languageCode;
  final bool isCompleted;
  final bool isWheelEnabled;

  AppData({
    this.token,
    this.languageCode,
    this.isCompleted,
    this.isWheelEnabled,
  });

  @override
  bool operator ==(Object other) =>
      identical(this, other) ||
      other is AppData &&
          runtimeType == other.runtimeType &&
          token == other.token &&
          languageCode == other.languageCode &&
          isCompleted == other.isCompleted &&
          isWheelEnabled == other.isWheelEnabled;

  @override
  int get hashCode =>
      token.hashCode ^
      languageCode.hashCode ^
      isCompleted.hashCode ^
      isWheelEnabled.hashCode;

  @override
  String toString() {
    return 'AppData{token: $token, languageCode: $languageCode, isCompleted: $isCompleted,isWheelEnabled: $isWheelEnabled }';
  }

  dynamic toJson() => {
        "token": this.token,
        "languageCode": this.languageCode,
        "isCompleted": this.isCompleted,
        "isWheelEnabled": this.isWheelEnabled
      };

  AppData compyWith({bool isCompleted, String langCode, bool isWheelEnabled}) {
    return AppData(
        isCompleted: isCompleted ?? this.isCompleted,
        languageCode: langCode ?? this.languageCode,
        isWheelEnabled: isWheelEnabled ?? this.isWheelEnabled,
        token: this.token);
  }

  static AppData fromJson(Map<String, dynamic> json) {
    return AppData(
      token: (json['token'] as String) ?? "",
      languageCode: (json['languageCode'] as String) ?? "en",
      isCompleted: (json['isCompleted'] as bool) ?? false,
      isWheelEnabled: (json['isWheelEnabled'] as bool) ?? false,
    );
  }
}
