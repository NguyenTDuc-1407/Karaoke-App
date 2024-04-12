// ignore_for_file: unnecessary_null_comparison

import 'package:audioplayers/audioplayers.dart';
import 'package:flutter_lyric/lyrics_reader.dart';
import 'package:get/get.dart';
import 'package:music_app/lyric/lyric.dart';

class MusicController extends GetxController {
  bool isPlaying = false;
  bool isTap = false;
  late final AudioPlayer player;
  late final AssetSource path;
  double sliderProgress = 0;
  int playProgress = 0;
  double maxValue = 269926000;
  Duration duration = const Duration();
  Duration position = const Duration();
  var lyricModel =
      LyricsModelBuilder.create().bindLyricToMain(lyric).getModel();
  var lyricUI = UINetease();

  @override
  void onInit() {
    initPlay();
    super.onInit();
  }

  void changeMusic(double value) async {
    sliderProgress = value;
    update();
  }

  void changeMusicStart(double value) {
    isTap = true;
    update();
  }

  void changeMusicEnd(double value) {
    isTap = false;
    playProgress = value.toInt();
    player.seek(Duration(milliseconds: value.toInt()));
    update();
  }

  void initPlay() async {
    player = AudioPlayer();
    path = AssetSource('audio/beat.mp3');
    player.onDurationChanged.listen((Duration d) {
      duration = d;
      maxValue = d.inMilliseconds.toDouble();
      update();
    });
    player.onPositionChanged.listen((Duration p) {
      if (isTap) return;
      position = p;
      sliderProgress = p.inMilliseconds.toDouble();
      playProgress = p.inMilliseconds;
      update();
    });
    player.onPlayerStateChanged.listen((PlayerState state) {
      isPlaying = state == PlayerState.playing;
      update();
    });
    update();
  }

  void playPause() async {
    if (isPlaying) {
      player.pause();
      isPlaying = true;
    } else {
      player.play(path);
      isPlaying = false;
    }
    update();
  }
}
