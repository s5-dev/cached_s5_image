import 'package:cached_s5_image/main.dart';
import 'package:example/s5.dart';
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
  final TextEditingController _controller = TextEditingController(
      text: "z2H7AJ1Pt8FdqG5UNzt4ffEhMY28c2z3K13TGf9fGcCRRwN7kS5B");
  S5? s5;
  Logger logger = Logger();
  CachedS5ImageManager cacheManager = CachedS5ImageManager();
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
    s5 = await initS5("https://s5.ninja", "hive", null);
    setState(() {}); // to update UI
  }

  void _submitCID() async {
    if (s5 != null) {
      setState(() {
        cid = _controller.text;
      });
    }
  }

  void _clearCache() async {
    cacheManager.clearCache();
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
            controller: _controller,
            decoration: const InputDecoration(labelText: "CID: z2..."),
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
            ],
          ),
          const SizedBox(
            height: 10,
          ),
          (cid != null && s5 != null)
              ? CachedS5Image(
                  cid: cid!,
                  s5: s5!,
                  cacheManager: cacheManager,
                )
              : Container(),
        ],
      ),
    );
  }
}
