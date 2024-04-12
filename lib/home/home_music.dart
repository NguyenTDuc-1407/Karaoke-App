import 'package:flutter/material.dart';
import 'package:flutter_lyric/lyrics_reader.dart';
import 'package:get/get.dart';
import 'package:music_app/home/music_controller.dart';

class HomeMusic extends GetView {
  const HomeMusic({super.key});

  @override
  Widget build(BuildContext context) {
    return GetBuilder(
      init: MusicController(),
      builder: (MusicController controller) => Scaffold(
        backgroundColor: Colors.purple,
        body: Column(
          mainAxisAlignment: MainAxisAlignment.start,
          children: [
            Stack(
              children: [
                LyricsReader(
                  model: controller.lyricModel,
                  lyricUi: controller.lyricUI,
                  playing: controller.isPlaying,
                  position: controller.playProgress,
                  size: Size(double.infinity,
                      MediaQuery.of(context).size.height * 0.8),
                  emptyBuilder: () => Center(
                    child: Text(
                      "no lyric",
                      style: controller.lyricUI.getOtherMainTextStyle(),
                    ),
                  ),
                  // selectLineBuilder: (progress, confirm) {
                  //   return Row(
                  //     children: [
                  //       IconButton(
                  //           onPressed: () {
                  //             confirm.call();

                  //             controller.player
                  //                 .seek(Duration(milliseconds: progress));
                  //           },
                  //           icon: const Icon(Icons.play_arrow,
                  //               color: Colors.green)),
                  //       Text(
                  //         progress.toString(),
                  //         style: const TextStyle(color: Colors.green),
                  //       )
                  //     ],
                  //   );
                  // },
                )
              ],
            ),
            Text(
              controller.sliderProgress.toString(),
              style: const TextStyle(
                fontSize: 16,
                color: Colors.green,
              ),
            ),
            if (controller.sliderProgress < controller.maxValue)
              Slider(
                value: controller.sliderProgress,
                onChanged: (value) {
                  controller.changeMusic(value);
                },
                min: 0,
                label: controller.sliderProgress.toString(),
                max: controller.maxValue,
                inactiveColor: Colors.grey,
                activeColor: Colors.red,
                onChangeStart: (value) {
                  controller.changeMusicStart(value);
                },
                onChangeEnd: (value) {
                  controller.changeMusicEnd(value);
                },
              ),
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                Text(controller.position.toString().substring(2, 7)),
                Text(controller.duration.toString().substring(2, 7)),
              ],
            ),
            Row(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                InkWell(
                  onTap: () {
                    controller.playPause();
                  },
                  child: Icon(
                    controller.isPlaying
                        ? Icons.pause_circle
                        : Icons.play_circle,
                    size: 50,
                  ),
                ),
              ],
            )
          ],
        ),
      ),
    );
  }
}
