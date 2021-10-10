import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:vdocipher_flutter/vdocipher_flutter.dart';
import 'package:vdoplayback/vdoplayback_view.dart';

void main() {
  runApp(MyApp());
}

class MyApp extends StatelessWidget {
  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Flutter Demo',
      theme: ThemeData(
        primarySwatch: Colors.blue,
      ),
      home: MyHomePage(title: 'Flutter Demo Home Page'),
    );
  }
}

class MyHomePage extends StatefulWidget {
  const MyHomePage({Key? key, this.title = ""}) : super(key: key);
  final String title;

  @override
  _MyHomePageState createState() => _MyHomePageState();
}

class _MyHomePageState extends State<MyHomePage> {
  String _nativeAndroidLibraryVersion = 'Unknown';

  @override
  void initState() {
    super.initState();
    getNativeAndroidLibraryVersion();
  }

  Future<void> getNativeAndroidLibraryVersion() async {
    String version;
    try {
      version = await VdocipherMethodChannel.nativeAndroidLibraryVersion;
    } on PlatformException {
      version = "Failed to get native android library version";
    }
    if (!mounted) return;
    setState(() {
      _nativeAndroidLibraryVersion = version;
    });
  }

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      home: Scaffold(
        appBar: AppBar(
          title: const Text("Vdocipher Sample Application"),
        ),
        body: Center(
          child: Column(
            children: <Widget>[
              Expanded(
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.center,
                  children: <Widget>[
                    ElevatedButton(
                      onPressed: _goToVideoPlayback,
                      child: const Text(
                        'online playback',
                        style: TextStyle(fontSize: 20),
                      ),
                    ),
                    ElevatedButton(
                      onPressed: null,
                      child: const Text(
                        'Todo: video selection',
                        style: TextStyle(fontSize: 20),
                      ),
                    )
                  ],
                ),
              ),
              Padding(
                padding: EdgeInsets.all(16.0),
                child: Text(
                  'Native android library version $_nativeAndroidLibraryVersion',
                  style: TextStyle(color: Colors.grey, fontSize: 16.0),
                ),
              )
            ],
          ),
        ),
      ),
    );
  }

  void _goToVideoPlayback() {
    Navigator.of(context).push(
      MaterialPageRoute(
        builder: (BuildContext context) {
          return VdoPlaybackView();
        },
      ),
    );
  }
}
