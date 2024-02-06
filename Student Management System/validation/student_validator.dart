mixin StudentValidationMixin {
  String? validateFirstName(String? value) {
    if (value == null || value.length < 2) {
      return "Name must be longer than 2 characters";
    }
    return null;
  }
  String? validateLastName(String? value) {
    if (value == null || value.length < 2) {
      return "Last name must be longer than 2 characters";
    }
    return null;
  }
  String? validateGrade(String? value) {
    var grade=int.parse(value!);
    if (grade<0||grade>100) {
      return "Grade must be between (0-100)";
    }
    return null;
  }
}