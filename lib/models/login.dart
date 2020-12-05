class Login {
  final String nrp;
  final String token;

  Login({this.nrp, this.token});

  factory Login.fromJson(Map<String, dynamic> json) {
    return Login(
      nrp: json['nrp'],
      token: json['token'],
    );
  }
}
