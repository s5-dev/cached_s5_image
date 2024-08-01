import 'package:path/path.dart';
import 'package:path_provider/path_provider.dart';
import 'package:universal_io/io.dart';

class CachedS5ImageManager {
  Directory? cacheDir;
  CachedS5ImageManager();

  Future<void> init() async {
    cacheDir = Directory(
        join((await getApplicationCacheDirectory()).path, "cid-cache"));
    await cacheDir?.create(recursive: true);
  }

  File? getCacheFile(String cid) {
    if (cacheDir != null) {
      return File(join(cacheDir!.path, cid));
    } else {
      return null;
    }
  }

  Future<void> clearCache() async {
    await cacheDir?.delete(recursive: true);
  }
}
