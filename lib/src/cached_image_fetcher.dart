import 'package:cached_s5_image/src/cached_s5_image_manager.dart';
import 'package:flutter/foundation.dart';
import 'package:logger/logger.dart';
import 'package:s5/s5.dart';
import 'package:universal_io/io.dart';

// NOTE: Because of limitations, this will skip the caching section if
// it is running from the web
Future<Uint8List> getImageFromCID(
    String cid, S5 s5, CachedS5ImageManager cacheManager) async {
  Logger logger = Logger();
  // check for local existance of the file
  if (!kIsWeb) {
    try {
      await cacheManager.init();
      File? cidCache = cacheManager.getCacheFile(cid);
      if (cidCache != null) {
        if (cidCache.existsSync()) {
          return cidCache.readAsBytesSync();
        } else {
          final Uint8List cidContents =
              await s5.api.downloadRawFile(CID.decode(cid).hash);
          if (cidContents.isNotEmpty) {
            await cidCache.writeAsBytes(cidContents);
            return cidContents;
          }
        }
      }
    } catch (e) {
      logger.e(e);
    }
  }
  // if not, return the web fetched version
  return s5.api.downloadRawFile(CID.decode(cid).hash);
}
