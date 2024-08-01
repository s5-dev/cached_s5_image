import 'dart:typed_data';

import 'package:cached_s5_image/src/cached_image_fetcher.dart';
import 'package:cached_s5_image/src/cached_s5_image_manager.dart';
import 'package:flutter/material.dart';
import 'package:flutter_thumbhash/flutter_thumbhash.dart';
import 'package:s5/s5.dart';

class CachedS5Image extends StatefulWidget {
  final String cid;
  final S5 s5;
  final String? thumbhash;
  final Widget? child;
  final CachedS5ImageManager? cacheManager;
  const CachedS5Image({
    super.key,
    required this.cid,
    required this.s5,
    this.thumbhash,
    this.child,
    this.cacheManager,
  });

  @override
  State<CachedS5Image> createState() => CachedS5ImageState();
}

class CachedS5ImageState extends State<CachedS5Image> {
  ImageProvider? img;
  CachedS5ImageManager cacheManager = CachedS5ImageManager();
  @override
  void initState() {
    _populateImageFromCID();
    super.initState();
  }

  _populateImageFromCID() async {
    Uint8List imgBytes =
        await getImageFromCID(widget.cid, widget.s5, cacheManager);
    setState(() {
      img = Image.memory(imgBytes).image;
    });
  }

  @override
  Widget build(BuildContext context) {
    if (img != null) {
      return Image(image: img!);
    } else if (widget.thumbhash != null) {
      return Image(
        image: ThumbHash.fromBase64(widget.thumbhash!).toImage(),
      );
    } else {
      return const Center(
        child: CircularProgressIndicator(),
      );
    }
  }
}
