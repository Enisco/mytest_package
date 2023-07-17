library mytest_package;

export 'package:mytest_package/korapay.dart';
export 'package:mytest_package/src/services/api_services/api_services.dart';

enum Authorization { pin, otp }

enum Errors {
  incorrectChargeData,
  verificationFailure,
}
