import 'dart:convert';
import 'dart:io';
import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/material.dart';
import 'package:image_picker/image_picker.dart';

enum DefaultImageType { local, network }

class GenericImagePicker extends StatefulWidget {
  final ValueChanged<File> onFileChanged;
  final String caption;
  final String defaultImage;
  final double redius;
  final DefaultImageType imgType;
  final String isBase64;
  const GenericImagePicker(
      {Key key,
      @required this.onFileChanged,
      @required this.caption,
      @required this.defaultImage,
      this.redius,
      this.imgType = DefaultImageType.local,
      this.isBase64})
      : super(key: key);

  @override
  GenericImagePickerState createState() => GenericImagePickerState();
}

class GenericImagePickerState extends State<GenericImagePicker> {
  File _file;

  mainBottomSheet(BuildContext context) {
    print("Im Triggeres");
    showModalBottomSheet(
        context: context,
        builder: (BuildContext context) {
          return Column(
            mainAxisSize: MainAxisSize.min,
            children: <Widget>[
              _createTile(context, 'Camera', Icons.camera_alt, () {
                _openFilePicker(ImageSource.camera);
              }),
              _createTile(context, 'Gallary', Icons.photo_library, () {
                _openFilePicker(ImageSource.gallery);
              }),
            ],
          );
        });
  }

  ListTile _createTile(
      BuildContext context, String name, IconData icon, Function action) {
    return ListTile(
      leading: Icon(icon),
      title: Text(name),
      onTap: () {
        Navigator.pop(context);
        action();
      },
    );
  }

  void _openFilePicker(ImageSource source) async {
    if (source == ImageSource.camera) {
      // if  (await _service.checkAndRequest(PermissionName.Camera)) {
      _pick(ImageSource.camera);
      // }
    } else {
      // if (await _service.checkAndRequest(PermissionName.Storage)) {
      _pick(ImageSource.gallery);
      // }
    }
  }

  void _pick(ImageSource source) async {
    var file = await ImagePicker.pickImage(
      source: source,
    );
    widget.onFileChanged(file);
    setState(() {
      _file = file;
    });
  }

  @override
  Widget build(BuildContext context) {
    // return
    return InkWell(
      onTap: () {
        // _pick(ImageSource.gallery);
        showBottomSheet(context: context, builder: mainBottomSheet(context));
      },
      child: CircleAvatar(
          backgroundImage: _file != null
              ? FileImage(_file)
              : widget.isBase64 == null
                  ? ((widget.imgType == DefaultImageType.local
                      ? AssetImage(widget.defaultImage)
                      : CachedNetworkImageProvider(
                          widget.defaultImage,
                        )))
                  : MemoryImage(base64.decode(widget.isBase64)),
          radius: widget.redius ?? 60,
          backgroundColor: Colors.white54,
          child: Text(
            widget.caption,
            style: TextStyle(fontSize: 11 , color: Colors.white),
          )),
    );
  }
}
