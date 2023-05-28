import 'package:weather/core/request/request.dart';

class LoginRequest extends Request {
  final String number;

  LoginRequest(this.number);

  @override
  Map<String, dynamic> toJson() {
    return {"phone_number": number};
  }
}
