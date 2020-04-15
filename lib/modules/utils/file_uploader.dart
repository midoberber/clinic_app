import 'dart:async';
import 'dart:io';
import 'package:dospace/dospace.dart' as dospace;
 
class FileUploader {
  static dospace.Spaces spaces = new dospace.Spaces(
    region: "fra1",
    accessKey: "T2OKKXAYR7PGAT2WAW32",
    secretKey: "TmiqHRBp0ww3BcrZ3R92sTGv4HM7U2uCbeaHVqB1ftU",
  );

  static Future<dynamic> uploadFile(
      String fileName, File file, String type) async {
    dospace.Bucket bucket = spaces.bucket("clinic");

    try {
      String etag = await bucket.uploadFile(
           fileName, file, type, dospace.Permissions.public);
      return etag;
    } catch (e) {
      return e;
    }
  }
}
