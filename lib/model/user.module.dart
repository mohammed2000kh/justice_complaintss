class UserModel {
  final String firstName;
  final String lastName;
  final String fatherName;
  final String matherName;
  final String username;
  final String password;
  final String numNational;
  final String idNumber;
  final String phone;
  final String gmail;
  final String placeCode;
  final String address;
  final String deviceTokenp;
  final String photo;
  final String photo2;

  const UserModel({
    required this.firstName,
    required this.lastName,
    required this.fatherName,
    required this.matherName,
    required this.username,
    required this.password,
    required this.numNational,
    required this.idNumber,
    required this.phone,
    required this.gmail,
    required this.placeCode,
    required this.address,
    required this.deviceTokenp,
    required this.photo,
    required this.photo2,
  });

  factory UserModel.fromJson(Map<String, dynamic> json) {
    return UserModel(
      firstName: json['first_name'] ?? '',
      lastName: json['last_name'] ?? '',
      fatherName: json['father_name'] ?? '',
      matherName: json['mather_name'] ?? '',
      username: json['username'] ?? '',
      password: json['password'] ?? '',
      numNational: json['num_national'] ?? '',
      idNumber: json['id_number'] ?? '',
      phone: json['phone'] ?? '',
      gmail: json['gmail'] ?? '',
      placeCode: json['place_code'] ?? '',
      address: json['address'] ?? '',
      deviceTokenp: json['device_tokenp'] ?? '',
      photo: json['photo'] ?? '',
      photo2: json['photo2'] ?? '',
    );
  }

  Map<String, dynamic> toJson() {
    return {
      'first_name': firstName,
      'last_name': lastName,
      'father_name': fatherName,
      'mather_name': matherName,
      'username': username,
      'password': password,
      'num_national': numNational,
      'id_number': idNumber,
      'phone': phone,
      'gmail': gmail,
      'place_code': placeCode,
      'address': address,
      'device_tokenp': deviceTokenp,
      'photo': photo,
      'photo2': photo2,
    };
  }
}
