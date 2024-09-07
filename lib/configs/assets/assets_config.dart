class AssetsConfig {
  static final AssetsConfig _instance = AssetsConfig._internal();
  AssetsConfig._internal();
  factory AssetsConfig() {
    return _instance;
  }
  ImagesAssetsConfig get images => ImagesAssetsConfig();
}

class ImagesAssetsConfig {
  String get logo => 'assets/images/tag-logo.png';
}
/* class FontsAssetsConfig {
  String get merriweather => 'Merriweather';
} */



/* class VideosAssetsConfig {
  String get test => 'assets/videos/video_test.mp4';
} */
