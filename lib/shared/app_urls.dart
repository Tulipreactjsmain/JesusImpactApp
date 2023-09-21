abstract class AppUrls {
  //! baseUrl
  static const String _baseUrl = "https://jimpact.pythonanywhere.com";
  static const String _authBaseUrl = "$_baseUrl/auth";
  static const String _driverBaseUrl = "$_baseUrl/driver";
  static const String _mediaBaseUrl = "$_baseUrl/media";

  //! photo
  static String photoUrl({required String imagePath}) =>
      '$_mediaBaseUrl/$imagePath';

  //! auth
  static const String userSignUp = '$_baseUrl/register/';
  static const String userLogin = '$_baseUrl/login/';
  static const String chnagePassword = '$_authBaseUrl/password';
  static const String rotateTokens = '$_authBaseUrl/tokens/new';
  static const String userLogout = '$_authBaseUrl/logout/';
  static const String sendSMSOTP = '$_authBaseUrl/verify/sms/send';
  static const String sendEmailOTP = '$_authBaseUrl/verify/email/send';
  static const String verifySMSOTP = '$_authBaseUrl/verify/sms/check';
  static const String verifyEmailOTP = '$_authBaseUrl/verify/email/check';
  // static const String resetPassword = '$_authBaseUrl/verify/sms/check';

  //! profile
  static const String getUserData = '$_driverBaseUrl/dashboard';
  static const String updateUserInfo = '$_driverBaseUrl/dashboard/details';

  //! campaign
  static const String getAllCampaigns = '$_driverBaseUrl/campaigns';
  static const String getPickupLocations = '$_driverBaseUrl/pickup';
  static String getACampaign({required String campaignId}) =>
      '$_driverBaseUrl/campaign/$campaignId';
  static String applyForACampaign({required String campaignId}) =>
      '$_driverBaseUrl/campaigns/$campaignId/apply';
  static String acceptACampaign({required String campaignId}) =>
      '$_driverBaseUrl/campaigns/$campaignId/accept';
  static const String getAllApplications =
      '$_driverBaseUrl/campaigns/applications';
}
