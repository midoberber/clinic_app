import 'package:flutter/material.dart';
import 'package:flutter_ffmpeg/flutter_ffmpeg.dart';
import 'package:graphql_flutter/graphql_flutter.dart';
import 'package:path_provider/path_provider.dart';
// import 'package:clinic_app/modules/utils/extentions.dart';
// import 'dart:io' show Platform;
import 'package:flutter_native_image/flutter_native_image.dart';

Future<String> get _localPath async {
  final directory = await getApplicationDocumentsDirectory();

  return directory.path;
}

Future<String> getThumbanial(String filePath) async {
  final FlutterFFmpeg _flutterFFmpeg = new FlutterFFmpeg();
  final path = await _localPath;

  String fileNameWithext = "$path/${DateTime.now().millisecondsSinceEpoch}.png";

  int compres = await _flutterFFmpeg.execute(
      "-ss 00:00:01 -i \"$filePath\"  -qmin 1 -q:v 1 -qscale:v 2 -frames:v 1 -huffman optimal \"$fileNameWithext\"");
  print(compres);

  return fileNameWithext;
}

Future<String> compressAndDecodeVideo(String filepath) async {
  final FlutterFFmpeg _flutterFFmpeg = new FlutterFFmpeg();
  final path = await _localPath;
  String fileNameWithext = "$path/${DateTime.now().millisecondsSinceEpoch}.mp4";
  int compressStatus = await _flutterFFmpeg.execute(
      "-y -i $filepath -vcodec h264 -b:v 360k -acodec mp3 $fileNameWithext");
  // "-y -i \"$filepath\" -strict experimental -map 0:0 -map 0:1 -c:v copy -b:v 140k -c:a:1 libmp3lame -b:a 90k -ac 6 \"$fileNameWithext\"" //

  print(compressStatus);
  if (compressStatus == 0) {
    return fileNameWithext;
  } else {
    return null;
  }
}

Future<String> compressImage(String filePath) async {
  return (await FlutterNativeImage.compressImage(filePath)).path;
}



  showConfirm(BuildContext context, RunMutation runMutation, dynamic obj,
      String title, String desc  )  {
    // set up the button
    Widget okButton = FlatButton(
      child: Text("OK"),
      onPressed: () {
        runMutation(obj);
        Navigator.pop(context); 
      },
    );

    Widget cancelButton = FlatButton(
      child: Text("Cancel"),
      onPressed: () {
        Navigator.pop(context);
      },
    );

    // set up the AlertDialog
    AlertDialog alert = AlertDialog(
      title: Text(title),
      content: Text(desc),
      actions: [okButton, cancelButton],
    );

    // show the dialog
    showDialog(
      context: context,
      builder: (BuildContext context) {
        return alert;
      },
    );
  }