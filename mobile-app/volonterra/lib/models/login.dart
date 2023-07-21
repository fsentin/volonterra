class LoginForm {
  String email;
  String password;

  LoginForm({this.email, this.password});

  factory LoginForm.fromJson(Map<String, dynamic> json) {
    return LoginForm(
      email: json['email'],
      password: json['password']
    );
  }
}

class LoginResponse {
  int id;
  bool isVolunteer;

  LoginResponse({this.id, this.isVolunteer});

  factory LoginResponse.fromJson(Map<String, dynamic> json) {
    return LoginResponse(
        id: json['id'],
        isVolunteer: json['volunteer']
    );
  }

}