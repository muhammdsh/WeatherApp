import 'package:weather/core/mediators/communication_types/base_communication.dart';

enum Status { startup, authorized, unauthorized }

class AppStatus extends CommunicationType{
  final Status data;

  AppStatus({this.data = Status.startup});
}