class SignupRequest {
  final String email;
  final String password;
  final String passwordConfirmation;
  final List<int> categoryPreferences;

  const SignupRequest({
    required this.email,
    required this.password,
    required this.passwordConfirmation,
    required this.categoryPreferences,
  });

  Map<String, dynamic> toJson() => {
        'email': email,
        'password': password,
        'passwordConfirmation': passwordConfirmation,
        'categoryPreferences': categoryPreferences,
      };
}
