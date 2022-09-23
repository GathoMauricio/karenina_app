// ignore_for_file: non_constant_identifier_names
class UserModel {
  late int id;
  late String name;
  late String email;
  late String password;
  late String api_token;
  late String last_session;
  late String created_at;
  late String updated_at;

  UserModel(this.name, this.email, this.password);
}
