import 'package:audio_player/models/audio_model.dart';
import 'package:audio_player/pages/pages.dart';
import 'package:audio_player/provider/playlist_provider.dart';
import 'package:audio_player/utils/my_drawer.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

class HomePage extends StatefulWidget {
  const HomePage({super.key});

  @override
  State<HomePage> createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {
  late final dynamic playlistProvider;

  @override
  void initState() {
    // TODO: implement initState
    super.initState();
  //   get the playlist provider
    playlistProvider = Provider.of<PlaylistProvider>(context, listen: false);
  }
  void goToAudio(int audioIndex) {
    // update current audio index
    playlistProvider.currentAudioIndex = audioIndex;
    Navigator.push(context, MaterialPageRoute(builder: (context) => AudioPage()));
  }
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Theme.of(context).colorScheme.surface,
      appBar: AppBar(
        title: Text('P L A Y L I S T'),
        backgroundColor: Theme.of(context).colorScheme.primary,
        centerTitle: true,
      ),
      drawer: MyDrawer(),
      body: Consumer<PlaylistProvider>(builder: (context, value, child) {
        // get the play list
        final List<AudioModel> playlist = value.playlist;
        //   return the list view
        return ListView.builder(
            itemCount: playlist.length,
            itemBuilder: (context, index) {
          //   get individual audio
              final AudioModel audioModel = playlist[index];
        //       return listtile ui
              return ListTile(
                title: Text(audioModel.audioName),
                subtitle: Text(audioModel.artistName),
                leading: Image.asset(audioModel.albumArtImagePath),
                onTap: ()=> goToAudio(index),
              );
        });
      }),
    );
  }
}
