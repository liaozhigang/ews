class EnumToString {
  static String parse(enumItem) {
    if (enumItem == null) return null;
    return enumItem.toString().split('.')[1];
  }

  static T fromString<T>(List<T> enumValues, String value) {
    if (value == null) return null;

    return enumValues.singleWhere(
        (enumItem) => EnumToString.parse(enumItem) == value,
        orElse: () => null);
  }
}
