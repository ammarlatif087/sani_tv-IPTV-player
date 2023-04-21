import 'package:connectivity/connectivity.dart';
import 'package:flutter/material.dart';
import 'package:video_player/video_player.dart';
import 'package:visibility_detector/visibility_detector.dart';

import '../flick_video_player.dart';
import '../utils/channel_model.dart';
import 'controls.dart';
import 'data_manager.dart';

class CustomOrientationPlayer extends StatefulWidget {
  const CustomOrientationPlayer({Key? key}) : super(key: key);

  @override
  _CustomOrientationPlayerState createState() =>
      _CustomOrientationPlayerState();
}

class _CustomOrientationPlayerState extends State<CustomOrientationPlayer> {
  FlickManager flickManager =
      FlickManager(videoPlayerController: VideoPlayerController.network(''));
  DataManager dataManager = DataManager(
      flickManager: FlickManager(
          videoPlayerController: VideoPlayerController.network('')),
      urls: []);
  List<Channel> channels = []; // List to store parsed channels
  @override
  void initState() {
    super.initState();
    fetchAndParseM3U();

    Connectivity().onConnectivityChanged.listen((ConnectivityResult result) {
      if (result == ConnectivityResult.none) {
        setState(() {
          isConnected = false;
        });
      } else {
        setState(() {
          isConnected = true;
          fetchAndParseM3U();
        });
      }
    });
  }

  @override
  void dispose() {
    flickManager.dispose();
    super.dispose();
  }

  // skipToVideo(String url) {
  //   flickManager.handleChangeVideo(VideoPlayerController.network(url));

  bool isLoading = true;
  bool isConnected = true;

  void fetchAndParseM3U() async {
    try {
      String m3uUrl =
          "http://192.178.1.195:8000/playlist.m3u8"; //  M3U file URL
      List<Channel> parsedChannels = await M3UParser.parseM3U(m3uUrl);
      // Update state with the parsed channels
      setState(() {
        channels = parsedChannels;
        print(channels);
        flickManager = FlickManager(
          videoPlayerController: VideoPlayerController.network(
            // 'https://github.com/GeekyAnts/flick-video-player-demo-videos/blob/master/example/the_valley_compressed.mp4?raw=true'
            channels[0].link,
          ),
        );

        dataManager = DataManager(flickManager: flickManager, urls: channels);
        isLoading = false; // set isLoading to false once the list is loaded
      });
    } catch (e) {
      // handle the error here, for example show a dialog to inform the user
      print(e.toString());
    }
  }

  @override
  Widget build(BuildContext context) {
    return SafeArea(
      child: Scaffold(
        backgroundColor: Colors.black,
        appBar: AppBar(
          iconTheme: const IconThemeData(color: Colors.white),
          elevation: 0,
          backgroundColor: Colors.transparent,
          titleSpacing: 0,
          bottomOpacity: 0,
        ),
        drawer: Drawer(
          width: 200,
          child: ListView.builder(
            shrinkWrap: true,
            itemCount: channels.length,
            itemBuilder: (BuildContext context, int index) {
              return InkWell(
                onTap: () {
                  playVideo(channels[index].link);
                  print(channels[index].link);
                },
                child: ListTile(
                  title: Text(channels[index].name),
                ),
              );
            },
          ),
        ),
        body: VisibilityDetector(
          key: ObjectKey(flickManager),
          onVisibilityChanged: (visibility) {
            if (visibility.visibleFraction == 0 && mounted) {
              flickManager.flickControlManager?.autoPause();
            } else if (visibility.visibleFraction == 1) {
              flickManager.flickControlManager?.autoResume();
            }
          },
          child: isConnected
              ? isLoading
                  ? const Center(
                      child: CircularProgressIndicator(),
                    )
                  : FlickVideoPlayer(
                      flickManager: flickManager,
                      flickVideoWithControls: FlickVideoWithControls(
                        controls:
                            CustomOrientationControls(dataManager: dataManager),
                      ),
                      flickVideoWithControlsFullscreen: FlickVideoWithControls(
                        videoFit: BoxFit.fill,
                        controls:
                            CustomOrientationControls(dataManager: dataManager),
                      ),
                    )
              : const Center(
                  child: Text(
                    'No internet connection',
                    style: TextStyle(fontSize: 20, color: Colors.white),
                  ),
                ),
        ),
      ),
    );
  }

  void playVideo(String url) {
    flickManager.handleChangeVideo(
      VideoPlayerController.network(
        url,
      ),
    );
  }
}
