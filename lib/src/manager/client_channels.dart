part of flick_manager;

typedef GetPlayerControlsTimeout = Duration Function({
  bool? errorInVideo,
  bool? isVideoInitialized,
  bool? isPlaying,
  bool? isVideoEnded,
});

GetPlayerControlsTimeout getPlayerControlsTimeoutDefault = ({
  bool? errorInVideo,
  bool? isVideoInitialized,
  bool? isPlaying,
  bool? isVideoEnded,
}) {
  Duration duration;

  if (errorInVideo! || !isVideoInitialized! || !isPlaying! || isVideoEnded!) {
    duration = const Duration(days: 365);
  } else {
    duration = const Duration(seconds: 3);
  }

  return duration;
};
