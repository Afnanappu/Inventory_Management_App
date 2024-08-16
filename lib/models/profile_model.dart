class ProfileModel {
  static ProfileModel profile = ProfileModel();

  String? name;
  String? phone;
  String? email;
  String? address;
  String? image;
  ProfileModel({this.name, this.phone, this.email, this.address, this.image});
}
