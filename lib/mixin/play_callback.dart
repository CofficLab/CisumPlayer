mixin PlayCallbackMixin {
  Function playingCallback = () {};
  Function pausedCallback = () {};
  Function audioChangedCallback = () {};
  Function positionChangeCallback = () {};

  onPlaying(Function callback) {
    playingCallback = callback;
  }

  onPaused(Function callback) {
    pausedCallback = callback;
  }

  onAudioChanged(Function callback) {
    audioChangedCallback = callback;
  }

  onPositionChanged(Function callback) {
    positionChangeCallback = callback;
  }
}
