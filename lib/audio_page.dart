import 'dart:convert';

import 'package:audioplayers/audioplayers.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

import 'audiofile.dart';

class AudioPage extends StatefulWidget {
  final booksData;
  final int index;
  const AudioPage({Key? key,this.booksData,required this.index}) : super(key: key);

  @override
  State<AudioPage> createState() => _AudioPageState();
}

class _AudioPageState extends State<AudioPage> {
  late List popbk1;
  //late List popbks;
  ReadData1() async
  {
    await DefaultAssetBundle.of(context).loadString("json/AddBooks.json").then((s)
    {
      setState(() {
        //decode
        popbk1= json.decode(s);
      });

    });


  }



   late AudioPlayer advancedPlayer;
  @override
   void initState()
   {
     super.initState();//INIT AUDIO PLYR
     advancedPlayer=AudioPlayer();
     ReadData1();
   }
  @override
  Widget build(BuildContext context) {
    final double sheight=MediaQuery.of(context).size.height;
    final double swidth=MediaQuery.of(context).size.width;

    return Scaffold(
      backgroundColor: Colors.grey,
      body:Stack//to wrap posn widgets
        (
           children:[//posn takes child as param

             Positioned (
                   top:0,
                   left:0,
                   right:0,
                   height:sheight/3,
                   child:Container(
                     color:Colors.grey.shade800
                   )

  ),
             Positioned(
               top:0,
               left:0,
               right:0,
               child:AppBar(
                 backgroundColor: Colors.grey.shade800,
                 elevation:0.0,
                 leading:IconButton(onPressed: ()=>
                 {Navigator.of(context).pop(),
                   advancedPlayer.stop()}, icon: Icon(Icons.arrow_back_ios))

               ,
               actions: [
                 IconButton(onPressed: (){}, icon: Icon(Icons.more_vert))

               ],)
             ),
             Positioned(
                 top:sheight*0.2,
                 left:0,
                 right:0,
                 height:sheight*0.34,
                 child:Container(

                   decoration: BoxDecoration( color:Colors.grey.shade400,
                     borderRadius: BorderRadius.circular(40)
                   ),
                   child:Column(
                     children:[
                       SizedBox(height:90),
                       Text(this.widget.booksData[this.widget.index]["title"],
                           style:TextStyle(
                             fontFamily: "cursive",
                             fontWeight: FontWeight.bold,
                             fontSize: 25
                           )
                       ),
                       Text(this.widget.booksData[this.widget.index]["key"]
                         ,style:TextStyle(fontSize: 18,fontFamily: "fantasy",color: Colors.black54)
                       ),
                       AudioFile(advancedPlayer:advancedPlayer,audioPath:this.widget.booksData[this.widget.index]["audios"]),


                     ]
                   )
             )),
             Positioned(
                 top:sheight*0.12,
                 left:(swidth-150)/2,
                 right:(swidth-150)/2,
height: sheight*0.17,
                 child:Container(
                   // decoration: BoxDecoration(
                   //   borderRadius: BorderRadius.circular(20)
                   // ,border:Border.all(color: Colors.white,width:2)
                   // ),
                   // child:Padding(
                   //   padding:const EdgeInsets.only(left:15,right:15,top:10,bottom:10),
                      child:Container(
                         decoration: BoxDecoration(
                           shape:BoxShape.circle
                           //  borderRadius: BorderRadius.circular(20)
                             ,border:Border.all(color: Colors.white,width:2)
                        ,image:DecorationImage(
                           image: AssetImage(this.widget.booksData[this.widget.index]["imgs"]),
                           fit: BoxFit.cover
                         )
                         ),

                       ),


                   ),



             )
             ,Positioned (
      bottom:20,
      left:0,
      right:0,

      height:80,
      child:
      Container(
        //  color:Colors.white38,
          margin:const EdgeInsets.only(right:13,left:13),
        decoration: BoxDecoration(
          borderRadius: BorderRadius.circular(30),
          color: Colors.grey.shade50
        ),
        child:Column(
          children: [Row(//SizedBox(height:25),

            mainAxisAlignment: MainAxisAlignment.spaceEvenly,
           children:[

             SizedBox(height:74),

             Icon(Icons.favorite,color: Colors.red.shade600,),SizedBox(width:20),
             Icon(Icons.share,color: Colors.black,),
             SizedBox(width:20),
             Icon(Icons.remove_red_eye,color: Colors.black,),
            SizedBox(width:20),
            Icon(Icons.star_border_outlined,color: Colors.black,),
          ])
          ],
        )
      )
             )
             ,Positioned (
                 bottom:140,
                 left:-190,
                 right:0,
                // top:500,
                 height:170,


                child:

                 Container(

                     margin:const EdgeInsets.only(left:0) ,
                     height:50,
                     width:MediaQuery.of(context).size.width-56,

                     child:PageView.builder(
                         controller:PageController(viewportFraction: 0.27),
                         itemCount: popbk1==null?0:popbk1.length,
                         itemBuilder: (_,i){

                           return Container(
                               height:50,
                               margin:const EdgeInsets.only(right:16)
                               ,decoration:
                           BoxDecoration(borderRadius:BorderRadius.circular(15)
                               ,image:DecorationImage(
                                   image:AssetImage(popbk1[i]["img1"]),

                                   fit:BoxFit.fill
                               )
                           )
                           );
                         })
                   //  color:Colors.pink
                 )
             ),Positioned (
                // top:100,
                 left:0,
                 right:0,
                 bottom:330,
                 height:40,
                 child:Container(
                     //color:Colors.pinkAccent.shad
                   margin:const EdgeInsets.only(left:32)  ,
                   child:Row(children:[
                     Text(
                       "Add To PlayList",style:TextStyle(
                       fontSize:21,color:Colors.black,fontFamily: "fantasy")
                   ),
                     SizedBox(width:5),
                     Icon(Icons.add_circle,color: Colors.black38,),
                   ])

                 )

             ),

             //,)



             // )
],

      ),

    );
  }
}
