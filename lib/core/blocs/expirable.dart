import 'package:weather/app+injection/di.dart';
import 'package:weather/core/error/http/forbidden_error.dart';
import 'package:weather/core/result/result.dart';

// abstract class Expirable {
//   void expire(Result result) {
//     if (result.hasErrorOnly && result.error is ForbiddenError) {
//       locator<AuthBloc>().logout();
//     }
//     return;
//   }
// }
