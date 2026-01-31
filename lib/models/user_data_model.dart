class UserDataModel {
  const UserDataModel({
    this.id,
    this.email,
    this.name,
  });

  final int? id;
  final String? email;
  final String? name;

  factory UserDataModel.fromJson(Map<String, dynamic> json) {
    return UserDataModel(
      id: json['id'] as int?,
      email: json['email'] as String?,
      name: json['name'] as String?,
    );
  }

  Map<String, dynamic> toJson() => {
        'id': id,
        'email': email,
        'name': name,
      };
}
