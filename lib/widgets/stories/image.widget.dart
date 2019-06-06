import 'dart:io';
import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

class ImageWidget extends StatelessWidget {
  const ImageWidget({
    @required this.imageUrl,
    this.fit = BoxFit.cover,
    this.placeholder = const CupertinoActivityIndicator(),
  });

  final String imageUrl;
  final BoxFit fit;
  final Widget placeholder;

  @override
  Widget build(BuildContext context) {
    /*return WillPopScope(
      onWillPop: () async => !Platform.isIOS,
      child: Scaffold(
        body: Stack(

        ),
      ),
    );*/

    return Image(image: new CachedNetworkImageProvider(imageUrl));

    return CachedNetworkImage(
      imageUrl: "http://via.placeholder.com/350x150",
      placeholder: (context, url) => new CircularProgressIndicator(),
      errorWidget: (context, url, error) => new Icon(Icons.error),
    );
  }
}
