abstract class MovieDbImagePath {
  static const String _imageBaseUrl = 'https://image.tmdb.org/t/p/';

  static String getImageUrl({
    required String path,
    ImageQuality quality = ImageQuality.normal,
  }) {
    return _imageBaseUrl + quality.value + path;
  }
}

enum ImageQuality {
  low('w300'),
  normal('w400'),
  high('w500');

  final String value;

  const ImageQuality(this.value);
}
