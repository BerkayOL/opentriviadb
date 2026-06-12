abstract final class HtmlTextDecoder {
  static const Map<String, String> _entities = {
    '&quot;': '"',
    '&#039;': "'",
    '&amp;': '&',
    '&lt;': '<',
    '&gt;': '>',
  };

  static String decode(String value) {
    var decoded = value;
    for (final entry in _entities.entries) {
      decoded = decoded.replaceAll(entry.key, entry.value);
    }
    return decoded;
  }
}
