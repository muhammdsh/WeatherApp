import 'package:weather/core/request/request.dart';

class OTPVerificationRequest extends Request {
  final String phoneNumber;
  final String otpCode;


  OTPVerificationRequest({this.otpCode, this.phoneNumber});

  @override
  Map<String, dynamic> toJson() {
    return {
      "phone_number": phoneNumber,
      "otp_code": otpCode
    };
  }

}