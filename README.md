# cached_s5_image

A simple cached image provider for S5 CID's

![Demo GIF](https://raw.githubusercontent.com/s5-dev/cached_s5_image/main/static/demo.gif)

### Usage

See [example](example/lib/main.dart).

This is a library built on [s5](https://pub.dev/packages/s5). See there for more details.

Basic Usage:

```dart
Widget cachedS5Image = CachedS5Image(
  cid: cid, // String
  s5: s5, // See https://pub.dev/packages/s5
  thumbhash: thumbhashText, // String rep of thumbhash
);
```

### Acknowledgement

This work is supported by a [Sia Foundation](https://sia.tech/) grant
