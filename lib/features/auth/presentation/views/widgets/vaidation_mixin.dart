mixin ValidationMixin {
  String? validateName(String? value) {
    if (value == null || value.isEmpty) {
      return "Name required";
    }
    return null;
  }
}
