import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

import '../../flick_video_player.dart';

class VolumeSlider extends StatelessWidget {
  const VolumeSlider({super.key});

  @override
  Widget build(BuildContext context) {
    FlickControlManager controlManager =
        Provider.of<FlickControlManager>(context);
    return Slider(
      activeColor: Colors.white,
      inactiveColor: Colors.white38,
      label: 'Volume',
      value: controlManager.level,
      min: 0.0,
      max: 1.0,
      onChanged: (newValue) {
        controlManager.level = newValue;
        controlManager.setVolume(controlManager.level);
      },
    );
  }
}
