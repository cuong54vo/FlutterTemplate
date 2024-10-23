import 'package:intl/intl.dart';

class UserRegister {
  String? firstName;
  String? lastName;
  String? email;
  String? phone;

  UserRegister({this.firstName, this.lastName, this.email, this.phone});
}

List<UserRegister> listUserRegister() {
  return [
    UserRegister(
      firstName: "HUYNH",
      lastName: "NGỌC TÀI",
      email: "huynhngoctai92@gmail.com",
      phone: "0776511233",
    ),
  ];
}

class UserResponse {
  int? accountId; // Sửa lỗi chính tả từ accounntId
  DateTime? createDate;
  String? companyName;
  String? primaryUser;

  UserResponse({
    this.accountId,
    this.createDate,
    this.companyName,
    this.primaryUser,
  });

  UserResponse.fromJson(Map<String, dynamic> json) {
    accountId = json['user']?['id'] ?? 0; // Sử dụng toán tử ?. để kiểm tra null
    createDate = json['user']?['created_at'] != null
        ? DateFormat("yyyy-MM-dd").parse(json['user']['created_at'])
        : null; // Kiểm tra null cho trường created_at
    companyName = json['user']?['company'] ?? '';
    primaryUser = json['user']?['email'] ?? '';
  }

  Map<String, dynamic> toJson() {
    return {
      'account_id': accountId,
      'created_at': createDate != null
          ? DateFormat("yyyy-MM-dd").format(createDate!)
          : null,
      'company_name': companyName,
      'primary_user': primaryUser,
    };
  }
}
