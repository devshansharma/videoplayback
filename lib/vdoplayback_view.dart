import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:vdocipher_flutter/vdocipher_flutter.dart';

const EmbedInfo _embedInfo = EmbedInfo.streaming(
  otp: "20160313versASE313BlEe9YKEaDuju5J0XcX2Z03Hrvm5rzKScvuyojMSBZBxfZ",
  playbackInfo:
      "eyJ2aWRlb0lkIjoiM2YyOWI1NDM0YTVjNjE1Y2RhMThiMTZhNjIzMmZkNzUifQ==",
  embedInfoOptions: EmbedInfoOptions(
    autoplay: true,
  ),
);

class VdoPlaybackView extends StatefulWidget {
  const VdoPlaybackView({Key? key}) : super(key: key);

  @override
  _VdoPlaybackViewState createState() => _VdoPlaybackViewState();
}

class _VdoPlaybackViewState extends State<VdoPlaybackView> {
  late VdoPlayerController _controller;
  final double aspectRatio = 16 / 9;
  ValueNotifier<bool> _isFullScreen = ValueNotifier(false);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Column(
        crossAxisAlignment: CrossAxisAlignment.stretch,
        children: <Widget>[
          Flexible(
            child: Container(
              child: VdoPlayer(
                embedInfo: _embedInfo,
                onPlayerCreated: (controller) => _onPlayerCreated(controller),
                onFullscreenChange: _onFullScreenChange,
              ),
              width: MediaQuery.of(context).size.width,
              height: _isFullScreen.value
                  ? MediaQuery.of(context).size.height
                  : _getHeightForWidth(MediaQuery.of(context).size.width),
            ),
          ),
          ValueListenableBuilder(
              valueListenable: _isFullScreen,
              builder: (context, value, child) {
                return value as bool
                    ? SizedBox.shrink()
                    : _nonFullScreenContent();
              }),
        ],
      ),
    );
  }

  _nonFullScreenContent() {
    return Column(children: [
      Text(
        'Sample Playback',
        style: TextStyle(fontSize: 20.0),
      )
    ]);
  }

  _onFullScreenChange(isfullscreen) {
    setState(() {
      _isFullScreen.value = isfullscreen;
    });
  }

  _onPlayerCreated(VdoPlayerController controller) {
    controller.setPlaybackSpeed(0.25);
    setState(() {
      _controller = controller;
      _controller.setPlaybackSpeed(0.25);
    });
  }

  _getHeightForWidth(double width) {
    return width / aspectRatio;
  }
}
