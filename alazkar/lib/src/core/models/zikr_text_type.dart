enum ZikrTextType {
  quran,
  foreword,
  count,
  text;

  static ZikrTextType fromString(String value) {
    return ZikrTextType.values.firstWhere((element) => element.name == value);
  }
}
