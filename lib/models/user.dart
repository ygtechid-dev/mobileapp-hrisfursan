part of 'models.dart';

class User extends Equatable {
  final int? id;
  final String? first_name;
  final String? last_name;
  final String? email;
  final String? phone;
  final String? company_id;
  final String? email_verified_at;
  final String? avatar;
  final String? dob;
  final String? designation_id;
  final String? address;
  final String? type;
  final String? lang;
  final int? plan;
  final String? plan_expire_date;
  final int? storage_limit;
  final String? last_login;
  final int? is_active;
  final int? active_status;
  final int? is_login_enable;
  final int? dark_mode;
  final String? messenger_color;
  final int? is_disable;
  final String? created_by;
  static String? token;


  User(
      {this.id,
      this.first_name,
      this.last_name,
        this.phone,
        this.company_id,
        this.designation_id,
      this.email,
      this.email_verified_at,
      this.avatar,
      this.type,
        this.dob,
        this.address,
      this.lang,
      this.plan,
      this.plan_expire_date,
      this.storage_limit,
      this.last_login,
      this.is_active,
      this.active_status,
      this.is_login_enable,
      this.dark_mode,
      this.messenger_color,
      this.is_disable,
      this.created_by});

  factory User.fromJson(Map<String, dynamic> data) =>
      User(
        first_name: data['first_name'] ?? null,
        id: data['id'],
        last_name: data['last_name'] ?? null,
        email: data['email'] ?? null,
        phone: data['phone'] ?? null,
        company_id: data['company_id'] ?? null,
        email_verified_at: data['email_verified_at'] ?? null,
        avatar: data['avatar'] ?? null,
        type: data['type'] ?? null,
        lang: data['lang'] ?? null,
        plan: data['plan'] ?? null,
        plan_expire_date: data['plan_expire_date'] ?? null,
        storage_limit: data['storage_limit'] ?? null,
        last_login: data['last_login'] ?? null,
        is_active: data['is_active'] ?? null,
        active_status: data['active_status'] ?? null,
        is_login_enable: data['is_login_enable'] ?? null,
        dark_mode: data['dark_mode'] ?? null,
        messenger_color: data['messenger_color'] ?? null,
        is_disable: data['is_disable'] ?? null,
        // created_by: data['created_by'] ?? null,
        dob: data['dob'] ?? null,
        address: data['address'] ?? null,

      );



  @override
  List<Object?> get props =>
      [
        id,
        first_name,
        last_name,
        email,
        email_verified_at,
        company_id,
        phone,
        email,
        avatar,
        type,
        lang,
        plan,
        plan_expire_date,
        last_login,
        storage_limit,
        active_status,
        is_login_enable,
        dark_mode,
        messenger_color,
        is_disable,
        created_by,
        dob,
        address,
      ];
}

class UserFirebase extends Equatable {
  final int? id;
  final String? nickname;
  final String? user_id;
  final String? photoUrl;
  final String? uid;
  final String? createdAt;
  final String? chattingWith;
  final String? loginAt;
  final String? token_message;
  final String? content;
  final String? unread_message;
  final String? seller_name;
  final String? photoSellerUrl;
  final String? status;

  UserFirebase(
      {this.id,
        this.nickname,
        this.photoUrl,
        this.user_id,
        this.uid,
        this.createdAt,
        this.chattingWith,
        this.loginAt,
        this.token_message,
        this.content,
        this.unread_message,
        this.seller_name,
        this.photoSellerUrl,
        this.status});


  @override
  // TODO: implement props
  List<Object?> get props => [id, nickname, photoUrl, uid, user_id, createdAt, chattingWith,
    loginAt, token_message, content, unread_message, seller_name, photoSellerUrl, status];
}

class MemberUser extends Equatable {
  final int? point;
  final int? point_expired;
  final String? date_expired;
  final String? tiers;

  MemberUser({this.point, this.point_expired, this.date_expired, this.tiers});

  factory MemberUser.fromJson(Map<String, dynamic> data) => MemberUser(
    point: data['point'] ?? 0,
    point_expired: data['point_expired'] ?? 0,
    date_expired: data['date_expired'] ?? "",
    tiers: data['tiers'] ?? "Bronze",
  );

  @override
  // TODO: implement props
  List<Object?> get props => [point, point_expired, date_expired, tiers];
}

class OfficeAssets extends Equatable {
  final String? name;
  final String? brand;
  final String? warranty;
  final String? buying_date;

  OfficeAssets({this.name, this.brand, this.warranty, this.buying_date});

  factory OfficeAssets.fromJson(Map<String, dynamic> data) => OfficeAssets(
    name: data['name'] ?? "",
    brand: data['brand'] ?? "",
    warranty: data['warranty'] ?? "",
    buying_date: data['buying_date'] ?? "",
  );

  @override
  // TODO: implement props
  List<Object?> get props => [buying_date, warranty, brand, name];
}

class Resign extends Equatable {
  final String? resign_date;
  final String? description;
  final String? attachment;

  Resign({this.resign_date, this.description, this.attachment});

  factory Resign.fromJson(Map<String, dynamic> data) => Resign(
    resign_date: data['resign_date'] ?? "",
    description: data['description'] ?? "",
    attachment: data['attachment'] ?? "",
  );

  @override
  // TODO: implement props
  List<Object?> get props => [resign_date, description, attachment];
}