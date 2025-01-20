import 'package:audioplayers/audioplayers.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

class AudioFile extends StatefulWidget {
  final AudioPlayer advancedPlayer;
  final String audioPath;
  const AudioFile({Key? key, required this.advancedPlayer,required this.audioPath}) : super(key: key);

  @override
  State<AudioFile> createState() => _AudioFileState();
}

class _AudioFileState extends State<AudioFile> {

  Duration _duration=new Duration();
  Duration _position=new Duration();
 // final String path="https://st.bslmeiyu.com/uploads/%E6%9C%97%E6%96%87%E5%9B%BD%E9%99%85SBS%E7%B3%BB%E5%88%97/%E6%9C%97%E6%96%87%E5%9B%BD%E9%99%85%E8%8B%B1%E8%AF%AD%E6%95%99%E7%A8%8B%E7%AC%AC1%E5%86%8C_V2/%E5%AD%A6%E7%94%9F%E7%94%A8%E4%B9%A6/P149_Chapter%2016_Vocabulary%20Preview.mp3";
  //final String path="https://www.soundhelix.com/examples/mp3/SoundHelix-Song-8.mp3";
 // final String path="https://hearthis.at/alive-drumming/2i3x24a1a24emambofulldry190variation4of8allmix/";
  bool isPlayed=false;
  bool isPaused=false;
  bool isRepeat=false;
  Color clr=Colors.black;
  List<IconData>_icons=
  [
    Icons.play_circle_fill,
    Icons.pause_circle_filled,


  ];


  @override
  void initState()
  {
    super.initState();
    this.widget.advancedPlayer.onDurationChanged.listen((d)//to refer to instance
    {
      setState(()
    {_duration =d;}
      );
    });
    this.widget.advancedPlayer.onPositionChanged.listen((p)
    {
      setState(()
      {_position =p;}
      );
    });

    this.widget.advancedPlayer.setSourceUrl(this.widget.audioPath);
    this.widget.advancedPlayer.onPlayerComplete.listen((event) {
      setState((){
        _position=Duration(seconds: 0);
        isPlayed=false;
        isRepeat=false;
        if(isRepeat==true)
          {
            isPlayed=true;
          }

      });
    });
  }

  Widget btnStart()
  {
    return IconButton
      (
        padding:const EdgeInsets.only(bottom:10),
        onPressed: (){
          if(isPlayed==false)
          {
          this.widget.advancedPlayer.play(UrlSource(this.widget.audioPath));
          setState((){
                   isPlayed=true;
          });
          }
          else if(isPlayed==true)
          {
            this.widget.advancedPlayer.pause();
            setState((){
              isPlayed=false;
            });
          }
        },
        icon:isPlayed==false?Icon(_icons[0],size:50,color:Colors.grey.shade900):Icon(_icons[1],size:50,color:Colors.grey.shade900)
      );
  }





  Widget btnFast()
  {
    return IconButton(
      icon:ImageIcon(
        AssetImage('asset/fwrd.png'),
        size:40,
        color:Colors.black,
      ),
      onPressed: ()
      {
           this.widget.advancedPlayer.setPlaybackRate(1.5);
      },

    );
  }

  Widget btnRepeat()
  {
    return IconButton(
      icon:ImageIcon(
        AssetImage('asset/repeat.png'),
        size:49,
        color:clr,
      ), onPressed: () {
if(isRepeat==false)
  {
    this.widget.advancedPlayer.setReleaseMode(ReleaseMode.loop);
     setState(()
     {
       isRepeat=true;
       clr=Colors.red;
     });

  }

else if(isRepeat==true)
  {
    this.widget.advancedPlayer.setReleaseMode(ReleaseMode.release);
     clr=Colors.black;
  }
    },
    );
  }

  Widget btnLoop()
  {
      return IconButton
        (
      icon:ImageIcon(
        AssetImage('asset/loop.png'),
        size:25,
      ), onPressed: () {

    },
    );
  }




  Widget btnSlow()
  {
    return IconButton(
      icon:ImageIcon(
        AssetImage('asset/bwrd.png'),
        size:40,
        color:Colors.black,
      ),
      onPressed: ()
      {
        this.widget.advancedPlayer.setPlaybackRate(0.5);
      },

    );
  }

  Widget loadAsset()
  {
    return Container(
      child:Row(
        crossAxisAlignment: CrossAxisAlignment.center,
        mainAxisAlignment: MainAxisAlignment.spaceEvenly,
        children:[
          btnRepeat(),
          btnSlow(),
          btnStart(),
          btnFast(),
          btnLoop(),
        ]
      )
    );
  }

  @override
  Widget slider()
  {
    return Slider(
        activeColor:Colors.grey.shade700,
      inactiveColor: Colors.grey,
      value:_position.inSeconds.toDouble(),
      max:_duration.inSeconds.toDouble(),
      min:0.0,
      onChanged: (double value)
      {
           setState(()
           {
             changeToSecond(value.toInt());
             value=value;

           });
      },

    );
  }


  void  changeToSecond(int sec)
  {
     Duration newDuration=Duration(seconds:sec);
     this.widget.advancedPlayer.seek(newDuration);
  }


   @override

  Widget build(BuildContext context) {
    return Container(
      child:Column(
          children:[Padding(padding:const EdgeInsets.only(left:20,right:20),
      child:Row(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children:[

          Text(_position.toString().split(".")[0],style:TextStyle(fontFamily: "cursive",fontSize: 18,color: Colors.red.shade800,fontWeight: FontWeight.bold))
,Text(_duration.toString().split(".")[0],style:TextStyle(fontFamily: "cursive",fontSize: 18,color: Colors.red.shade800,fontWeight: FontWeight.bold))

        ]


    ),
    ),
        slider(),
        loadAsset(),]
      ),

      );
}
}
