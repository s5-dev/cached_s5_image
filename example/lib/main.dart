import 'package:cached_s5_image/cached_s5_image.dart';
import 'package:cached_s5_image_example/src/s5.dart';
import 'package:cached_s5_manager/cached_s5_manager.dart';
import 'package:flutter/material.dart';
import 'package:logger/logger.dart';
import 'package:s5/s5.dart';

void main() {
  runApp(const CachedS5ImageDemo());
}

class CachedS5ImageDemo extends StatelessWidget {
  const CachedS5ImageDemo({super.key});

  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    return const MaterialApp(
      title: 'Cached S5 Image Demo',
      home: Demo(),
    );
  }
}

class Demo extends StatefulWidget {
  const Demo({super.key});
  @override
  State<Demo> createState() => _DemoState();
}

class _DemoState extends State<Demo> {
  String? cid;
  final TextEditingController _cidController = TextEditingController(
      text: "z2H7AJ1Pt8FdqG5UNzt4ffEhMY28c2z3K13TGf9fGcCRRwN7kS5B");
  final TextEditingController _thumhashController =
      TextEditingController(text: "mtcJLYbGWGaPeYiLl4dndYaAdgdY");
  S5? s5;
  Logger logger = Logger();
  late CachedS5Manager cacheManager;
  @override
  void initState() {
    _initS5();
    _initCache();
    super.initState();
  }

  void _initCache() async {
    cacheManager.init();
  }

  void _initS5() async {
    // this is an EXAMPLE s5 node, use your own for maximum performance
    s5 = await initS5("https://s5.ninja", "hive", null);
    cacheManager = CachedS5Manager(s5: s5!);
    setState(() {}); // to update UI
  }

  void _submitCID() async {
    if (s5 != null) {
      setState(() {
        cid = _cidController.text;
      });
    }
  }

  void _clearCache() async {
    cacheManager.clear();
  }

  void _clearImage() async {
    setState(() {
      cid = null;
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: ListView(
        children: [
          Row(
            children: [
              const Text("S5 Status:"),
              (s5 == null)
                  ? const CircularProgressIndicator()
                  : const Icon(Icons.check),
            ],
          ),
          TextField(
            controller: _cidController,
            decoration: const InputDecoration(labelText: "CID: z2..."),
          ),
          const SizedBox(
            height: 10,
          ),
          TextField(
            controller: _thumhashController,
            decoration: const InputDecoration(labelText: "Thumbhash: "),
          ),
          const SizedBox(
            height: 10,
          ),
          Row(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              ElevatedButton(
                  onPressed: _submitCID, child: const Text("Submit CID")),
              ElevatedButton(
                  onPressed: _clearCache, child: const Text("Clear Cache")),
              ElevatedButton(
                  onPressed: _clearImage,
                  child: const Text("Clear loaded image"))
            ],
          ),
          const SizedBox(
            height: 10,
          ),
          AnimatedSwitcher(
            duration: const Duration(milliseconds: 300),
            child: (cid != null && s5 != null)
                ? CachedS5Image(
                    cid: cid!,
                    s5: s5!,
                    thumbhash: _thumhashController.text,
                    cacheManager: cacheManager,
                  )
                : Container(),
          ),
        ],
      ),
    );
  }
}
