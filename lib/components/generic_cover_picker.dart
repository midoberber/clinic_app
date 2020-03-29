import 'dart:convert';
import 'dart:io';
import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/material.dart';
import 'package:image_picker/image_picker.dart';
import 'package:clinic_app/components/generic_image_picker.dart';

class GenericCoverPicker extends StatefulWidget {
  final ValueChanged<File> onFileChanged;
  final String caption;
  final String defaultImage;
  final double redius;
  final DefaultImageType imgType;

  const GenericCoverPicker({
    Key key,
    @required this.onFileChanged,
    @required this.caption,
    @required this.defaultImage,
    this.redius,
    this.imgType = DefaultImageType.local,
  }) : super(key: key);

  @override
  GenericCoverPickerState createState() => GenericCoverPickerState();
}

class GenericCoverPickerState extends State<GenericCoverPicker> {
  File _file;

  mainBottomSheet(BuildContext context) {
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
      _pick(ImageSource.camera);
    } else {
      _pick(ImageSource.gallery);
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
          showBottomSheet(context: context, builder: mainBottomSheet(context));
        },
        child: _file != null
            ? Container(
                height: 140,
                decoration: BoxDecoration(
                  image: DecorationImage(
                      image: FileImage(_file), fit: BoxFit.cover),
                ),
              )
            : (widget.imgType == DefaultImageType.local
                ? Container(
                    height: 140,
                    decoration: BoxDecoration(
                      image: DecorationImage(
                          image: AssetImage(widget.defaultImage),
                          fit: BoxFit.cover),
                    ),
                  )
                : CachedNetworkImage(
                    imageUrl: widget.defaultImage,
                    imageBuilder: (context, imageProvider) => Container(
                      height: 140,
                      decoration: BoxDecoration(
                        image: DecorationImage(
                            image: imageProvider,
                            fit: BoxFit.cover,
                            colorFilter: ColorFilter.mode(
                                Colors.white, BlendMode.colorBurn)),
                      ),
                    ),
                    placeholder: (context, url) => Center(child: CircularProgressIndicator()),
                    errorWidget: (context, url, error) => Icon(Icons.error),
                  )));
  }
}
