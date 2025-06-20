import 'package:adradio/extensions/custom_extensions.dart';

class ApiEndpoint {
  static const String mainDomain = "https://appdata.apintie.sr/";


  static const String baseUrl = "$mainDomain/api/v1";

  static String languageURL = '/languages'.addBaseURl();
  static String basicSettingsUrl = '/basic-settings'.addBaseURl();

  static String loginURL = '/login'.addBaseURl();
  static String registerURL = '/register'.addBaseURl();
  static String logoutURL = '/logout'.addBaseURl();

  static String findUserSendCodeURL = '/find/user'.addBaseURl();
  static String verifyCodeURL = '/verify/code'.addBaseURl();
  static String resendCodeURL = '/resend/code'.addBaseURl();
  static String resetPasswordURL = '/reset'.addBaseURl();

  static String mailResendCodeURL = '/mail/resend/code'.addBaseURl();
  static String mailVerifyCodeURL = '/mail/verify/code'.addBaseURl();
  static String newsfeedURL = '/dashboard'.addBaseURl();
  static String notificationURL = '/notification'.addBaseURl();
  static String profileInfoURL = '/user/profile'.addBaseURl();
  static String profileUpdateURL = '/update'.addBaseURl();
  static String profileDeleteURL = '/delete-account'.addBaseURl();
  static String passwordChangeURL = '/password/update'.addBaseURl();

  static String teamURL = '/team'.addBaseURl();
  static String galleryURL = '/gallery'.addBaseURl();
  static String liveShowURL = '/live/show'.addBaseURl();
  static String showSchedulesURL = '/show/schedules'.addBaseURl();
}