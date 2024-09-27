import 'package:flutter/material.dart';
import 'package:video_player/video_player.dart';

class OnlineVideoPlayer extends StatefulWidget{
  final String url;

  const OnlineVideoPlayer({super.key,required this.url});
  @override
  State<StatefulWidget> createState() =>OnlineVideoPlayerState();
  
}

class OnlineVideoPlayerState extends State<OnlineVideoPlayer>{

  late VideoPlayerController _playerController;
  late Future<void> _initializeVideoPlayerFuture;

  @override
  void initState(){
    super.initState();
  
    _playerController=VideoPlayerController.networkUrl(Uri.parse(widget.url))
    ..initialize().then((_) => setState(() {},));
    _playerController.setLooping(true);
    _playerController.setVolume(1.0);
    _initializeVideoPlayerFuture=_playerController.initialize();
    _playerController.play();
    
  }

  @override
  void dispose(){
    super.dispose();
  
    _playerController.dispose();
  }

  @override
  Widget build(BuildContext context) {
    bool isVisible=true;
    return Container(
      padding: EdgeInsets.zero,
      child: GestureDetector(
        child: FutureBuilder(
          future: _initializeVideoPlayerFuture,
          builder: (context, snapshot) {
            return _playerController.value.isInitialized?
            Stack(
              alignment: Alignment.center,
        children: <Widget>[
          // Visibility(
          //   visible: true,
            //child:
             
            
          //),
          AspectRatio(
            aspectRatio: _playerController.value.aspectRatio,
            child: VideoPlayer(_playerController),
          ),
          Container(
              alignment: Alignment.center,
              width: 100,
              height: 100,
              child: IconButton(
                iconSize: 50,
            icon: _playerController.value.isPlaying? const Icon(Icons.play_arrow) : const Icon(Icons.pause),
            color: Colors.grey,
            onPressed: ()=>{
              _playerController.value.isPlaying?
                setState(() {_playerController.pause();})
              :
                setState(() {_playerController.play();},)
              
            },
          ),
            ),
          
        ],
      ):
          const Align(
              alignment: Alignment.center,
              child: CircularProgressIndicator(color: Colors.grey,),
            );
            
          },
          
        ),
      onTap: (){
        setState(() {
          isVisible=!isVisible;
        });
      },
      ),
    );
  }
  
}