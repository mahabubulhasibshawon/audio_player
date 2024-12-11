import 'package:audio_player/pages/pages.dart';
import 'package:audio_player/provider/playlist_provider.dart';
import 'package:audio_player/utils/neu_box.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

class AudioPage extends StatelessWidget {
  const AudioPage({super.key});

  // convert duration into min:sec
  String formatTime(Duration duration) {
    String twoDigitSeconds = duration.inSeconds.remainder(60).toString().padLeft(2, '0');
    String formattedTime = "${duration.inMinutes}:$twoDigitSeconds";
    return formattedTime;
  }

  @override
  Widget build(BuildContext context) {
    return Consumer<PlaylistProvider>(
      builder: (context, value, child) {
        // get playlist
        final playlist = value.playlist;
        // get current audio index
        final currentAudio = playlist[value.currentAudioIndex ?? 0];
        return Scaffold(
          // appBar: AppBar(
          //   title: Text('A U D I O'),
          //   centerTitle: true,
          // ),
          body: SafeArea(
            child: Padding(
              padding: const EdgeInsets.only(left: 25.0, right: 25, bottom: 25),
              child: Column(
                mainAxisAlignment: MainAxisAlignment.center,
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
                        icon: const Icon(CupertinoIcons.back),
                      ),
                      //   title
                      const Text('P L A Y L I S T'),
                      //   menu btn
                      IconButton(onPressed: () {
                        Navigator.push(context, MaterialPageRoute(builder: (context) => SettingsPage()));
                      }, icon: const Icon(Icons.menu))
                    ],
                  ),
                  //   album art work
                  NeuBox(
                    child: Column(
                      children: [
                        // image
                        ClipRRect(
                          borderRadius: BorderRadius.circular(8),
                          child: Image.asset(currentAudio.albumArtImagePath),
                        ),
                        //   audio name
                        Padding(
                          padding: EdgeInsets.all(15.0),
                          child: Row(
                            mainAxisAlignment: MainAxisAlignment.spaceBetween,
                            children: [
                              Column(
                                children: [
                                  Text(
                                    currentAudio.audioName,
                                    style: TextStyle(
                                        fontWeight: FontWeight.bold, fontSize: 20),
                                  ),
                                  Text(currentAudio.audioSource)
                                ],
                              ),
                              Icon(CupertinoIcons.bookmark),
                            ],
                          ),
                        )
                      ],
                    ),
                  ),
                  //   audio duration process
                  const SizedBox(
                    height: 25,
                  ),
                  Padding(
                    padding: EdgeInsets.symmetric(horizontal: 25.0),
                    child: Column(
                      children: [
                        Row(
                          mainAxisAlignment: MainAxisAlignment.spaceBetween,
                          children: [
                            Text(formatTime(value.currentDuration)),
                            Icon(CupertinoIcons.shuffle),
                            IconButton(onPressed: value.repeatAudio, icon: Icon(CupertinoIcons.repeat, color: value.isRepeatEnabled ? Colors.green : Theme.of(context).colorScheme.inversePrimary,)),
                            Text(formatTime(value.totalDuration)),
                          ],
                        ),
                        SliderTheme(
                          data: SliderTheme.of(context).copyWith(
                              thumbShape:
                              const RoundSliderThumbShape(enabledThumbRadius: 0)),
                          child: Slider(
                            min: 0,
                            max: value.totalDuration.inSeconds.toDouble(),
                            activeColor: Colors.green,
                            value: value.currentDuration.inSeconds.toDouble(),
                            onChanged: (double double) {},
                            onChangeEnd: (double double) {
                              value.seek(Duration(seconds: double.toInt()));
                            },
                          ),
                        ),
                      ],
                    ),
                    //   slider

                  ),

                  //   playback controll
                  Row(
                    children: [
                      Expanded(
                        child: GestureDetector(
                          onTap: value.playPreviousAudio,
                          child: const NeuBox(
                            child: Icon(Icons.skip_previous),
                          ),
                        ),
                      ),
                      const SizedBox(
                        width: 20,
                      ),
                      Expanded(
                        flex: 2,
                        child: GestureDetector(
                          onTap: value.pauseOrResume,
                          child: NeuBox(
                            child: Icon(value.isPlaying? Icons.pause : Icons.play_arrow),
                          ),
                        ),
                      ),
                      const SizedBox(
                        width: 20,
                      ),
                      Expanded(
                        child: GestureDetector(
                          onTap: value.playNextAudio,
                          child: const NeuBox(
                            child: Icon(Icons.skip_next),
                          ),
                        ),
                      ),
                    ],
                  )
                ],
              ),
            ),
          ),
        );
      }
    );
  }
}
