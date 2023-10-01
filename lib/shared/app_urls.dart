abstract class AppUrls {
  //! baseUrl
  static const String _baseUrl = "https://jimpact.pythonanywhere.com";

  //! auth
  static const String userSignUp = '$_baseUrl/register/';
  static const String userLogin = '$_baseUrl/login/';

  //! profile
  static const String getUserData = '$_baseUrl/profile/';

  //! blogs
  static const String getBlogs = '$_baseUrl/blogs/';
}
