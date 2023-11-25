/// Extension methods for String manipulation.
extension StringExtension on String {
  /// Capitalizes the first letter of the string and converts the rest to lowercase.
  ///
  /// Returns the modified string.
  String capitalize() {
    return isEmpty ? this : this[0].toUpperCase() + substring(1).toLowerCase();
  }

  /// Removes the question mark ('?') at the end of the string, if present.
  ///
  /// Returns the modified string.
  String removeQuestionMark() {
    return isEmpty
        ? this
        : endsWith('?')
            ? substring(0, length - 1)
            : this;
  }
}
