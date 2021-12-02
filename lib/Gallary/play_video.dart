


import 'package:flutter/material.dart';
import 'package:video_player/video_player.dart';

class PlayVideo extends StatefulWidget{
  PlayVideo({
    Key? key,
    required this.video_view,

  }) : super(key: key);

   var video_view;



  @override
  _PlayVideoState createState() => _PlayVideoState();
  }

class _PlayVideoState extends State<PlayVideo> {
  VideoPlayerController? _videoPlayerController;
  Future? _initializeVideoPlayerFuture;



  @override
  void initState()
  {

    _videoPlayerController=VideoPlayerController.network("${widget.video_view}",

    );
    _initializeVideoPlayerFuture = _videoPlayerController!.initialize();
    _videoPlayerController!.addListener(() {
      setState(() {});
    });
    _videoPlayerController!.setLooping(true);
    _videoPlayerController!.initialize();
    super.initState();
  }
  @override
  void dispose(){
    _videoPlayerController!.dispose();
    super.dispose();
  }


  @override
  Widget build(BuildContext context) {
    // TODO: implement build
    return MaterialApp(
      home: Scaffold(
        appBar: AppBar(),

        body: Center(
          child: Column(
            children: [


              Container(
                height: 200,
                width: 300,
                child: VideoPlayer(_videoPlayerController!)),


               FloatingActionButton(
                onPressed: () {
                  // Wrap the play or pause in a call to `setState`. This ensures the
                  // correct icon is shown.
                  setState(() {
                    // If the video is playing, pause it.
                    if (_videoPlayerController!.value.isPlaying) {
                      _videoPlayerController!.pause();
                    } else {
                      // If the video is paused, play it.
                      _videoPlayerController!.play();
                    }
                  });
                },
                // Display the correct icon depending on the state of the player.
                child: Icon(
                  _videoPlayerController!.value.isPlaying ? Icons.pause : Icons.play_arrow,
                ),
              ),


            ],
          ),
        )



      ),
    );
  }

}
