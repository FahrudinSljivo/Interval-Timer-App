///Class that defines one user (although reduntant class here, I kept in case of future developments of the app)

class UserModel {
  String id;
  String email;
  String password;

  UserModel(
    this.id,
    this.email,
    this.password,
  );
}
