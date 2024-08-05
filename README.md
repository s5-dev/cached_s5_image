# cached_s5_image

A simple cached image provider for S5 CID's

<video autoplay loop muted>
  <source src="https://raw.githubusercontent.com/s5-dev/cached_s5_image/main/static/demo.mp4" type="video/mp4">
</video>

### Usage

See [example](example/lib/main.dart).

Basic Usage:

```dart
CachedS5Manager cacheManager = CachedS5Manager();
cacheManager.init(); // DON'T forget this
Widget cachedS5Image = CachedS5Image(
  cid: cid, // String
  s5: s5, // See https://pub.dev/packages/s5
  thumbhash: thumbhashText, // String rep of thumbhash
  cacheManager: cacheManager,
);
```

### Acknowledgement

This work is supported by a [Sia Foundation](https://sia.tech/) grant
