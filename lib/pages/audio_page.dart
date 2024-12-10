import 'package:audio_player/provider/playlist_provider.dart';
import 'package:audio_player/utils/neu_box.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

class AudioPage extends StatelessWidget {
  const AudioPage({super.key});

  @override
  Widget build(BuildContext context) {
    return Consumer<PlaylistProvider>(
        builder: (context, value, child) => Scaffold(
                // appBar: AppBar(
                //   title: Text('A U D I O'),
                //   centerTitle: true,
                // ),
                body: SafeArea(
              child: Padding(
                padding:
                    const EdgeInsets.only(left: 25.0, right: 25, bottom: 25),
                child: Column(
                  children: [
                    //   app bar
                    Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: [
                        //   back btn
                        IconButton(
                          onPressed: () {
                            Navigator.pop(context);
                          },
                          icon: Icon(CupertinoIcons.back),
                        ),
                        //   title
                        Text('P L A Y L I S T'),
                        //   menu btn
                        IconButton(onPressed: () {}, icon: Icon(Icons.menu))
                      ],
                    ),
                    //   album art work
                    NeuBox(
                      child: Column(
                        children: [
                          // image
                          ClipRRect(
                            borderRadius: BorderRadius.circular(8),
                            child: Image.asset('assets/images/album_art_1.jpg'),
                          ),
                        //   audio name
                          Padding(
                            padding: const EdgeInsets.all(15.0),
                            child: Row(
                              mainAxisAlignment: MainAxisAlignment.spaceBetween,
                              children: [
                              Text('Surah', style: TextStyle(fontWeight: FontWeight.bold, fontSize: 20),),
                              Icon(CupertinoIcons.bookmark),
                            ],),
                          )
                        ],
                      ),
                    ),
                    //   audio duration process
                    const SizedBox(height: 25,),

                    //   playback controll
                  ],
                ),
              ),
            )));
  }
}
