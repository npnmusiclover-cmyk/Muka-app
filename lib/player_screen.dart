import 'package:flutter/material.dart';
import 'package:youtube_explode_dart/youtube_explode_dart.dart';
import 'package:chewie/chewie.dart';
import 'package:video_player/video_player.dart';

class PlayerScreen extends StatefulWidget {
  final String videoId;
  const PlayerScreen({super.key, required this.videoId});

  @override
  State<PlayerScreen> createState() => _PlayerScreenState();
}

class _PlayerScreenState extends State<PlayerScreen> {
  late VideoPlayerController _videoController;
  ChewieController? _chewieController;
  bool _isLoading = true;

  @override
  void initState() {
    super.initState();
    _initPlayer();
  }

  Future<void> _initPlayer() async {
    final yt = YoutubeExplode();
    var manifest = await yt.videos.streamsClient.getManifest(widget.videoId);
    var streamInfo = manifest.muxed.withHighestBitrate();
    
    _videoController = VideoPlayerController.networkUrl(Uri.parse(streamInfo.url.toString()));
    await _videoController.initialize();
    
    _chewieController = ChewieController(
      videoPlayerController: _videoController,
      autoPlay: true,
      looping: false,
      materialProgressColors: ChewieProgressColors(
        playedColor: Colors.purpleAccent,
        handleColor: Colors.deepPurple,
        backgroundColor: Colors.grey,
      ),
    );
    
    setState(() => _isLoading = false);
    yt.close();
  }

  @override
  void dispose() {
    _videoController.dispose();
    _chewieController?.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.black,
      appBar: AppBar(backgroundColor: Colors.transparent, elevation: 0),
      body: Column(
        children: [
          AspectRatio(
            aspectRatio: 16 / 9,
            child: _isLoading 
                ? const Center(child: CircularProgressIndicator(color: Colors.purpleAccent))
                : Chewie(controller: _chewieController!),
          ),
          const Padding(
            padding: EdgeInsets.all(16.0),
            child: Text("Now Playing - Premium Ad-Free", style: TextStyle(color: Colors.white, fontSize: 18, fontWeight: FontWeight.bold)),
          ),
        ],
      ),
    );
  }
}
