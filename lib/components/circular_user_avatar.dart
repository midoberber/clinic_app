import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/material.dart';

class CircularUserAvatar extends StatelessWidget {
  final String url;
  final double raduis;
  final Color filterColor;
  final double margin;

  final String fallbackImage;

  const CircularUserAvatar({
    Key key,
    this.url,
    this.raduis = 50,
    this.filterColor = Colors.white10,
    this.margin = 4,
    this.fallbackImage = "assets/images/avatar.png",
  }) : super(key: key);

  _buildCircleAvatar(ImageProvider provider) {
    return Container(
      height: raduis,
      width: raduis,
      margin: EdgeInsets.all(margin),
      decoration: BoxDecoration(
        shape: BoxShape.circle,
        image: DecorationImage(
            image: provider,
            fit: BoxFit.cover,
            colorFilter: ColorFilter.mode(filterColor, BlendMode.colorBurn)),
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    return CachedNetworkImage(
      imageUrl: url,
      imageBuilder: (context, imageProvider) =>
          _buildCircleAvatar(imageProvider),
      placeholder: (context, url) =>
          _buildCircleAvatar(AssetImage(fallbackImage)),
      errorWidget: (context, url, error) =>
          _buildCircleAvatar(AssetImage(fallbackImage)),
    );
  }
}
