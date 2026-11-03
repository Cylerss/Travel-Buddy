class ImageUtils {
  /// Optimizes Unsplash image URLs to lightweight, highly-compressed WebP format
  /// with appropriate width and quality settings for fast network loading.
  static String optimizeUrl(String url, {int width = 300, int quality = 60}) {
    if (!url.contains('images.unsplash.com')) return url;

    try {
      final Uri uri = Uri.parse(url);
      final Map<String, String> params = Map.from(uri.queryParameters);
      params['w'] = width.toString();
      params['q'] = quality.toString();
      params['fm'] = 'webp';
      if (!params.containsKey('fit')) {
        params['fit'] = 'crop';
      }

      return uri.replace(queryParameters: params).toString();
    } catch (_) {
      return url;
    }
  }
}
