import 'package:audio_player/models/audio_model.dart';
import 'package:audioplayers/audioplayers.dart';
import 'package:flutter/material.dart';

class PlaylistProvider extends ChangeNotifier {
  final List<AudioModel> _playlist = [
    // audio 1
    AudioModel(
        audioName: "Surah Al Fatiha",
        audioSource: 'Al QURAN : 001',
        albumArtImagePath: 'assets/images/album_art_1.jpg',
        audioPath: 'assets/audio/001_Al-Fatiha.mp3'),
    AudioModel(
        audioName: "Surah Al Falaq",
        audioSource: 'Al QURAN : 113',
        albumArtImagePath: 'assets/images/album_art_2.png',
        audioPath: 'assets/audio/113_Al-Falaq.mp3'),
    AudioModel(
        audioName: "Surah An Nas",
        audioSource: 'Al QURAN : 114',
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
  void pause() async {
    await _audioPlayer.pause();
    _isPlaying = false;
    notifyListeners();
  }
  // resume playing
  void resume() async {
    await _audioPlayer.resume();
    _isPlaying =  true;
    notifyListeners();
  }
  // pause or resume
  void pauseOrResume() async {
    if(_isPlaying) {
      pause();
    } else {
      resume();
    }
    notifyListeners();
  }
  // seek to a specific position in the current
  void seek(Duration position) async {
    await _audioPlayer.seek(position);
  }
  // play next audio
  void playNextAudio() {
    if(_currentAudioIndex != null) {
      if(_currentAudioIndex! < _playlist.length -1) {
      //   go to the next audio if it's not the last audio
        currentAudioIndex = _currentAudioIndex! + 1;
      } else {
      //   go to 1st audio if it's the last
        currentAudioIndex = 0;
      }
    }
  }
  // play previous audio
  void playPreviousAudio() async {
    if(_currentDuration.inSeconds > 2) {}
    else {
      if(_currentAudioIndex! > 0) {
        currentAudioIndex = _currentAudioIndex! -1;
      }
      else {
      //   if it's the first audio the loop back to last one
        currentAudioIndex = _playlist.length -1;
      }
    }
  }
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
    _audioPlayer.onPlayerComplete.listen((event) {
      playNextAudio();
    });
  }
  // dispose audio player

  // getters
  List<AudioModel> get playlist => _playlist;

  int? get currentAudioIndex => _currentAudioIndex;
  bool get isPlaying => _isPlaying;
  Duration get currentDuration => _currentDuration;
  Duration get totalDuration => _totalDuration;

  // setter
  set currentAudioIndex(int? newIndex) {
    _currentAudioIndex = newIndex;

    if (newIndex != null) {
      play();
    }
    notifyListeners();
  }
}
