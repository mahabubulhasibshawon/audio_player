import 'package:audio_player/models/audio_model.dart';
import 'package:audioplayers/audioplayers.dart';
import 'package:flutter/material.dart';

class PlaylistProvider extends ChangeNotifier {
  final List<AudioModel> _playlist = [
    // audio 1
    AudioModel(
        audioName: "Surah Al Fatiha",
        artistName: 'Allah',
        albumArtImagePath: 'assets/images/album_art_1.jpg',
        audioPath: 'assets/audio/001_Al-Fatiha.mp3'),
    AudioModel(
        audioName: "Surah Al Falaq",
        artistName: 'Allah',
        albumArtImagePath: 'assets/images/album_art_2.png',
        audioPath: 'assets/audio/113_Al-Falaq.mp3'),
    AudioModel(
        audioName: "Surah An Nas",
        artistName: 'Allah',
        albumArtImagePath: 'assets/images/album_art_3.jpg',
        audioPath: 'assets/audio/114_An-Nas.mp3'),
  ];

  // current audio index
  int? _currentAudioIndex;

  /*
  Audio player
   */
  // audio player
  final AudioPlayer _audioPlayer = AudioPlayer();

  // duration
  Duration _currentDuration = Duration.zero;
  Duration _totalDuration = Duration.zero;

  // constructors
  PlaylistProvider() {listenToDuration();}
  // initially not playing
  bool _isPlaying = false;

  // play the audio
  void play() async {
    final String path = _playlist[_currentAudioIndex!].audioPath;
    await _audioPlayer.stop();
    await _audioPlayer.play(AssetSource(path));
    _isPlaying = true;
    notifyListeners();
  }

  // pause current audio
  // resume playing
  // pause or resume
  // seek to a specific position in the current
  // play next audio
  // play previous audio
  // listen to duration
  void listenToDuration() {
  //   listen for total duration
    _audioPlayer.onDurationChanged.listen((newDuration) {
      _totalDuration = newDuration;
      notifyListeners();
    });
  //   listen for current duration
    _audioPlayer.onPositionChanged.listen((newPosition) {
      _currentDuration = newPosition;
      notifyListeners();
    });
  //   listen for audio completion
  }
  // dispose audio player

  // getters
  List<AudioModel> get playlist => _playlist;

  int? get currentAudioIndex => _currentAudioIndex;

  // setter
  set currentAudioIndex(int? newIndex) {
    _currentAudioIndex = newIndex;
    notifyListeners();
  }
}
