import 'dart:async';
import 'dart:io';
import 'package:dospace/dospace.dart' as dospace;
 
class FileUploader {
  static dospace.Spaces spaces = new dospace.Spaces(
    region: "fra1",
    accessKey: "6L7D3WJW7FMFZX7T5UWJ",
    secretKey: "l7YZd8hnKqh+I9CvwpbGxhtrWp/lMWbNcTIFikUK0wA",
  );

  static Future<dynamic> uploadFile(
      String fileName, File file, String type) async {
    dospace.Bucket bucket = spaces.bucket("shaghaph");

    try {
      String etag = await bucket.uploadFile(
           fileName, file, type, dospace.Permissions.public);
      return etag;
    } catch (e) {
      return e;
    }
  }
}
