import 'dart:convert';

import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:music_app2/audio_page.dart';

class MyHomePage extends StatefulWidget {
  const MyHomePage({Key? key}) : super(key: key);

  @override
  _MyHomePageState createState() => _MyHomePageState();
}

class _MyHomePageState extends State<MyHomePage> with SingleTickerProviderStateMixin {
  //call json fn                                        //above for vsync
  late List popbk;
  late List popbks;
  late List popbkn;
  late List popbkp;
  late ScrollController _scrollController;
 late  TabController _tabController;
    ReadData() async
{
   await DefaultAssetBundle.of(context).loadString("json/popBooks.json").then((s)
  {
    setState(() {
      //decode
     popbk= json.decode(s);
    });

  });

   await DefaultAssetBundle.of(context).loadString("json/Books.json").then((s)
   {
     setState(() {
       //decode
       popbks= json.decode(s);
     });

   });
   await DefaultAssetBundle.of(context).loadString("json/BooksN.json").then((s)
   {
     setState(() {
       //decode
       popbkn= json.decode(s);
     });

   });await DefaultAssetBundle.of(context).loadString("json/BooksP.json").then((s)
   {
     setState(() {
       //decode
       popbkp= json.decode(s);
     });

   });
}
  @override
  void initState()
  {
    super.initState();
    _tabController=TabController(length: 3, vsync: this);
    _scrollController=ScrollController();
    ReadData();
  }

  @override
  Widget build(BuildContext context) {
    return Container(
      color:Colors.black87,
      child:SafeArea(
        child:Scaffold(
          backgroundColor: Colors.black54,
              body:
            Column(
              children:
                [
                  Container(
                  margin: const EdgeInsets.only(top:10,left:5,right:5),
                    child:  Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children:[
                      Icon(Icons.menu_outlined,color:Colors.white54,size: 35,)
                      ,Row(
                          children:[
                            Icon(Icons.search,size: 30,color:Colors.white54,),
                            SizedBox(width:10),
                            Icon(Icons.notifications,size:25,color:Colors.yellow.shade400,)
                          ]
                      )
                    ]
                )),
                  SizedBox(height:10),
                  Row(
                children:
                  [
                    Container
                      (
                      margin:const EdgeInsets.only(left:35) ,
                      child:Text("Popular Audios",style:
                      TextStyle(
                        fontFamily: "cursive",
                        fontSize:30,
                        color: Colors.white,
                      ))
                    )
                  ]
                    ),
              SizedBox(height:20),
                 Container(
                   height:180,
                   child:Stack(
                     children:
                       [
                        Positioned(
                           top:0,
                        left:-10,
                        right:0,
                        child: Container(
                             height:180,
                             width:MediaQuery.of(context).size.width,
                             child: PageView.builder(
                                 controller:PageController(viewportFraction: 0.8),
                                 itemCount: popbk==null?0:popbk.length,
                                 itemBuilder: (_,i){

                                   return Container(
                                       height:150,
                                        margin:const EdgeInsets.only(right:16)
                                       ,decoration:
                                       BoxDecoration(borderRadius:BorderRadius.circular(15)
                                          ,image:DecorationImage(
                                               image:AssetImage(popbk[i]["img"]),
                                             fit:BoxFit.fill
                                           )
                                       )
                                   );
                                 })

                         )
                         )
                       ]
                   )
                 ),
                  Expanded(child: NestedScrollView(
                      controller: _scrollController,
                    headerSliverBuilder: (BuildContext  context,bool isScroll)
                      {
                        return[
                          SliverAppBar(
                            backgroundColor: Colors.black,
                            pinned: true,
                            bottom:PreferredSize(
                            preferredSize: Size.fromHeight(50),
                              child:Container(
                                margin:const EdgeInsets.only(bottom:15),
                                child:TabBar(
                                  indicatorPadding: const EdgeInsets.all(0),
                                  indicatorSize: TabBarIndicatorSize.label,
                                  labelPadding:const EdgeInsets.only(left:4,right:6)
                                    ,controller: _tabController,
                                  isScrollable:true,
                                  indicator:BoxDecoration(

                                    borderRadius: BorderRadius.circular(10),
                                    boxShadow: [
                                      BoxShadow(
                                        color:Colors.grey.withOpacity(0.4),
                                        offset:Offset(0,0),
                                        blurRadius: 7
                                      )
                                    ]
                                  ),
                                  tabs:[

                                    Container(
                                      height:50,
                                      width:120,
                                      child:Text(
                                        "Trending",style:TextStyle(
                                          fontSize:18,color:Colors.white)
                                      ),
                                        alignment:Alignment.center,//to align text in center
                                      decoration:BoxDecoration(color: Colors.red.shade500,
                                        borderRadius: BorderRadius.circular(10),
                                        boxShadow:[
                                          BoxShadow(
                                            color:Colors.grey.withOpacity(0.4),
                                              offset:Offset(0,0),
                                              blurRadius: 7
                                          )
                                        ]
                                      )
                                    ),
                                    Container(
                                        height:50,
                                        width:120,
                                        child:Text(
                                            "New",style:TextStyle(fontSize:18,color:Colors.white)
                                        ),alignment:Alignment.center,
                                        decoration:BoxDecoration(
                                            color: Colors.yellow.shade700,
                                            borderRadius: BorderRadius.circular(10),
                                            boxShadow:[
                                              BoxShadow(
                                                  color:Colors.grey.withOpacity(0.4),
                                                  offset:Offset(0,5),
                                                  blurRadius: 7
                                              )
                                            ]
                                        )
                                    ),
                                    Container(
                                        height:50,
                                        width:120,
                                        child:Text(
                                            "Popular",style:TextStyle(fontSize:18,color:Colors.white)
                                        ),
                                        alignment:Alignment.center,
                                        decoration:BoxDecoration(color: Colors.blue.shade500,
                                            borderRadius: BorderRadius.circular(10),
                                            boxShadow:[
                                              BoxShadow(
                                                  color:Colors.grey.withOpacity(0.4),
                                                  offset:Offset(0,5),
                                                  blurRadius: 7
                                              )
                                            ]
                                        )
                                    )
                                  ]
                                ),
                              ),
                            ),
                          )

                        ];
                      },
                         body:TabBarView//tabbarview takes childrean
                           (
                           controller: _tabController,
                               children:[
                                 ListView.builder(
                                     itemCount: popbks==null?0:popbks.length,
                                     itemBuilder: (_,i)
                                 {
                                   return GestureDetector(
                                     onDoubleTap:()
                                         {
                                           Navigator.push(context,
                                           MaterialPageRoute(builder: (context)=>AudioPage(booksData:popbks,index: i,))
                                           );


                                         },
                                     child:Container(
                                         margin: const EdgeInsets.only(left:10,right:10,top:5,bottom:5),
                                         child:Container(
                                           decoration: BoxDecoration(
                                               borderRadius: BorderRadius.circular(10),
                                               color:Colors.blueGrey.shade400,
                                               boxShadow:[
                                                 BoxShadow(
                                                     blurRadius:2,
                                                     offset: Offset(0,0),
                                                     color:Colors.grey.withOpacity(0.2)
                                                 )
                                               ]
                                           ),
                                           child:Container(
                                               padding: const EdgeInsets.all(8),
                                               child:Row(
                                                   children:[
                                                     Container(
                                                       width:100,
                                                       height:101,
                                                       decoration: BoxDecoration(
                                                           borderRadius: BorderRadius.circular(25),

                                                           image:DecorationImage(
                                                               image:AssetImage(popbks[i]["imgs"])
                                                           )
                                                       ),
                                                     ),
                                                     SizedBox(width:10),
                                                     Column(
                                                       crossAxisAlignment: CrossAxisAlignment.start,
                                                       children:[Row(


                                                           children:[
                                                             Icon(Icons.star,size:24,color:Colors.amber),
                                                             SizedBox(width:6),
                                                             Text(
                                                                 popbks[i]["r"],

                                                                 style:

                                                                 TextStyle(fontSize:15,color:Colors.black,

                                                                 )

                                                             )
                                                           ],

                                                       ),
                                                         Text(popbks[i]["title"],
                                                             style:TextStyle(fontSize: 18,fontFamily: "avenir",color:Colors.black,fontWeight:FontWeight.bold)
                                                         ),Text(popbks[i]["key"],
                                                             style:TextStyle(fontSize: 14,fontFamily: "fantasy",color:Colors.black)
                                                         ),
                                                         Container(
                                                           width:250,
                                                           height:15,
                                                           //mainAxisAlignment: MainAxisAlignment.end,
                                                           child: Icon(Icons.favorite_outline_sharp,color:Colors.black),
                                                           alignment: Alignment.topRight,



                                                         )

                                                       ],

                                                     )
                                                   ]
                                               )
                                           ),
                                         )
                                     ),
                                   );
                                 }),

                                 Material(
                                   color: Colors.black,
                                 //child:ListTile(
                                   // leading:CircleAvatar(
                                   //   backgroundColor: Colors.grey,
                                   // ),
                                   child:
                                   ListView.builder(

                                       itemCount: popbkn==null?0:popbkn.length,
                                       itemBuilder: (_,i)
                                       {
                                         return GestureDetector(
                                           onDoubleTap:()
                                           {
                                             Navigator.push(context,
                                                 MaterialPageRoute(builder: (context)=>AudioPage(booksData:popbkn,index: i,))
                                             );


                                           },
                                           child:Container(

                                               margin: const EdgeInsets.only(left:10,right:10,top:5,bottom:5),
                                               child:Container(

                                                 decoration: BoxDecoration(

                                                     borderRadius: BorderRadius.circular(10),
                                                     color:Colors.brown.shade200,
                                                     boxShadow:[
                                                       BoxShadow(
                                                           blurRadius:2,
                                                           offset: Offset(0,0),
                                                           color:Colors.grey.withOpacity(0.2)
                                                       )
                                                     ]
                                                 ),
                                                 child:Container(
                                                     padding: const EdgeInsets.all(8),
                                                     child:Row(
                                                         children:[
                                                           Container(
                                                             width:100,
                                                             height:101,
                                                             decoration: BoxDecoration(
                                                                 borderRadius: BorderRadius.circular(25),

                                                                 image:DecorationImage(
                                                                     image:AssetImage(popbkn[i]["imgs"])
                                                                 )
                                                             ),
                                                           ),
                                                           SizedBox(width:10),
                                                           Column(
                                                             crossAxisAlignment: CrossAxisAlignment.start,
                                                             children:[Row(


                                                                 children:[
                                                                   Icon(Icons.star,size:24,color:Colors.yellowAccent),
                                                                   SizedBox(width:6),
                                                                   Text(
                                                                       popbkn[i]["r"],

                                                                       style:

                                                                       TextStyle(fontSize:15,color:Colors.black,

                                                                       )

                                                                   )
                                                                 ]
                                                             ),
                                                               Text(popbkn[i]["title"],
                                                                   style:TextStyle(fontSize: 18,fontFamily: "avenir",color:Colors.black87,fontWeight:FontWeight.bold)
                                                               ),Text(popbkn[i]["key"],
                                                                   style:TextStyle(fontSize: 14,fontFamily: "fantasy",color:Colors.black)
                                                               ),
                                                               Container(
                                                                 width:250,
                                                                 height:15,
                                                                 //mainAxisAlignment: MainAxisAlignment.end,
                                                                 child: Icon(Icons.play_circle,color:Colors.green.shade700),
                                                                 alignment: Alignment.topRight,



                                                               )

                                                             ],

                                                           )
                                                         ]
                                                     )
                                                 ),
                                               )
                                           ),
                                         );
                                       }),
                                 )
                              // )
                                 // ,
                                , Material(
                                   color :Colors.black,
                                     child:ListView.builder(

                                         itemCount: popbkp==null?0:popbkp.length,
                                         itemBuilder: (_,i)
                                         {
                                           return GestureDetector(
                                             onDoubleTap:()
                                             {
                                               Navigator.push(context,
                                                   MaterialPageRoute(builder: (context)=>AudioPage(booksData:popbkp,index: i,))
                                               );


                                             },
                                             child:Container(

                                                 margin: const EdgeInsets.only(left:10,right:10,top:5,bottom:5),
                                                 child:Container(

                                                   decoration: BoxDecoration(

                                                       borderRadius: BorderRadius.circular(10),
                                                       color:Colors.purple.shade100,
                                                       boxShadow:[
                                                         BoxShadow(
                                                             blurRadius:2,
                                                             offset: Offset(0,0),
                                                             color:Colors.grey.withOpacity(0.2)
                                                         )
                                                       ]
                                                   ),
                                                   child:Container(
                                                       padding: const EdgeInsets.all(8),
                                                       child:Row(
                                                           children:[
                                                             Container(
                                                               width:100,
                                                               height:101,
                                                               decoration: BoxDecoration(
                                                                   borderRadius: BorderRadius.circular(25),

                                                                   image:DecorationImage(
                                                                       image:AssetImage(popbkp[i]["imgs"])
                                                                   )
                                                               ),
                                                             ),
                                                             SizedBox(width:10),
                                                             Column(
                                                               crossAxisAlignment: CrossAxisAlignment.start,
                                                               children:[Row(


                                                                   children:[
                                                                     Icon(Icons.star,size:24,color:Colors.amber),
                                                                     SizedBox(width:6),
                                                                     Text(
                                                                         popbkp[i]["r"],

                                                                         style:

                                                                         TextStyle(fontSize:15,color:Colors.black,

                                                                         )

                                                                     )
                                                                   ]
                                                               ),
                                                                 Text(popbkp[i]["title"],
                                                                     style:TextStyle(fontSize: 18,fontFamily: "avenir",color:Colors.black87,fontWeight:FontWeight.bold)
                                                                 ),Text(popbkp[i]["key"],
                                                                     style:TextStyle(fontSize: 14,fontFamily: "fantasy",color:Colors.black)
                                                                 ),
                                                                 Container(
                                                                   width:250,
                                                                   height:15,
                                                                   //mainAxisAlignment: MainAxisAlignment.end,
                                                                   child: Icon(Icons.favorite_outline_sharp,color:Colors.black),
                                                                   alignment: Alignment.topRight,



                                                                 )

                                                               ],

                                                             )
                                                           ]
                                                       )
                                                   ),
                                                 )
                                             ),
                                           );
                                         })),
                                 Material(
                                     child:ListTile(
                                       leading:CircleAvatar(
                                         backgroundColor: Colors.grey,
                                       ),
                                       title:Text("Content"),
                                     )
                                 )

]
                         ),
                  ))

                ],

            ),

        )
      )
    );
  }
}
