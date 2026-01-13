

class AppEvent {}

class InitialEvent extends AppEvent {}

class LoginEvent extends AppEvent {
  late String? email;
  late String? pass;

  LoginEvent(this.email, this.pass);
}

class RegisterEvent extends AppEvent {
  late String? name;

  late String? email;
  late String? phone;
  late String? pass;


  RegisterEvent(this.name, this.email, this.phone, this.pass, );
}

class VerifyOtpEvent extends AppEvent {
  late String? id;
  late String? otp;

  VerifyOtpEvent(this.id, this.otp);
}

class CreatePropertiesEvent extends AppEvent {
  late String? proName;
  late String? proCatId;
  late String? proStateId;
  late String? proCityId;
  late String? proAddress;
  late String? proBudget;
  late String? proContNo;
  late List<String?> photos;
  late String? userId;

  CreatePropertiesEvent(
    this.proName,
    this.proCatId,
    this.proStateId,
    this.proCityId,
    this.proAddress,
    this.proBudget,
    this.proContNo,
    this.photos,
    this.userId,
  );
}

class GetAllPropertiesEvent extends AppEvent {
  String userId;

  GetAllPropertiesEvent(this.userId);
}
