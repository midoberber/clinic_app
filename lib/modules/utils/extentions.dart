import 'package:mime/mime.dart';

extension StringMethods on String {
  bool isVideo() {
    String mime = lookupMimeType(this);
    return mime.startsWith("video");
  }

  String getContentType() {
    return lookupMimeType(this);
  }

  String getFileWithoutExtention() {
    int ind = this.length - 4;
    return this.substring(0, ind);
  }

  String getFileNameWithExtention() {
    return this.split('/').last;
  }

  String getFileNameWithoutExtention() {
    int ind = this.length - 4;
    return this.substring(0, ind).split('/').last;
  }

  bool isNullOrEmpty() {
    return this == null || this.isEmpty;
  }
}

extension NumericMethods on int {
  String toNormalizedValue() {
    if (this < 1000) {
      return this.toString();
    }
    const units = <int, String>{
      1000000000: 'B',
      1000000: 'M',
      1000: 'K',
    };
    return units.entries
        .map((e) => '${this ~/ e.key}${e.value}')
        .firstWhere((e) => !e.startsWith('0'), orElse: () => '$this');
  }
}
