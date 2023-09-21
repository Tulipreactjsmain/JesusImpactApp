import 'dart:convert';
import 'dart:io';

import 'package:jimpact/cache/token_cache.dart';
import 'package:jimpact/models/tokens/token_model.dart';
import 'package:jimpact/models/user/user_model.dart';

import 'package:jimpact/shared/app_urls.dart';
import 'package:jimpact/utils/app_extensions.dart';
import 'package:jimpact/utils/failure.dart';
import 'package:jimpact/utils/network_errors.dart';
import 'package:jimpact/utils/type_defs.dart';
import 'package:fpdart/fpdart.dart';
import 'package:http/http.dart' as http;

class AuthRepository {
  const AuthRepository();

  //! sign up user
  FutureEither<bool> signUpUser({
    required String email,
    required String password,
    required String firstName,
    required String lastName,
    required String username,
  }) async {
    try {
      //! MAKE REQUEST
      http.Request request =
          http.Request("POST", Uri.parse(AppUrls.userSignUp));

      //! ADD HEADER SUPPORTS
      request.headers
          .addAll({"Content-Type": "application/json; charset=UTF-8"});

      //! REQUEST BODY
      request.body = jsonEncode({
        "password": password,
        "email": email,
        "first_name": firstName,
        "last_name": lastName,
        'username': username,
      });

      //! SEND REQUEST
      http.StreamedResponse response = await request.send();

      //! HOLD RESPONSE
      String responseStream = await response.stream.bytesToString();

      //! RESPONSE CONVERTED TO MAP, USED TO RUN AUTH TEST CASES AND DECIDE WHAT ACTION TO TAKE AS SEEN BELOW
      Map<String, dynamic> responseInMap = jsonDecode(responseStream);

      print(responseInMap.toString());

      print(response.statusCode.toString());

      switch (response.statusCode) {
        //! SERVER REQUEST WAS SUCCESSFUL
        case 201:
          print('hey');
          //! CONVERT DATA TO MODEL
          UserModel registeredUser = UserModel(
            userName: responseInMap['username'],
            firstName: responseInMap['first_name'],
            lastName: responseInMap['last_name'],
            email: responseInMap['email'],
          );

          print(registeredUser.firstName);

          //! CACHE ACCESS TOKEN
          // await TokenCache.cacheUserTokens(
          //     tokens: UserToken.fromJSON(responseInMap["tokens"]));

          //! CACHE USER DETAILS
          // await UserDetailsCache.cacheUserDetails(
          //     theUserDetails: registeredUser);

          return right(true);

        //! SERVER REQUEST FAILED
        case 400:
          "Sign Up Response Failure: $responseStream".log();
          //! RETURN THE FAILURE, SHOW THE MESSAGE USING SHORTCUT LEFT.
          return left(Failure(responseInMap["message"]));

        //! ANY OTHER FAILURE TYPE
        default:
          "Default Sign Up Error Code: ${response.statusCode} \nResponse: $responseStream, \nReason: ${response.reasonPhrase}"
              .log();
          return left(Failure(responseInMap["message"]));
      }
    } on SocketException catch (error) {
      "Socket Exception ${error.message.toString()}".log();
      return left(Failure(NetworkErrors.socketException));
    } on FormatException catch (error) {
      "Format Exception ${error.message.toString()}".log();
      return left(Failure(NetworkErrors.formatException));
    } on HttpException catch (error) {
      "Http Exception ${error.message.toString()}".log();
      return left(Failure(NetworkErrors.httpException));
    } catch (error) {
      "User Sign Up Error ${error.toString()}".log();
      return left(Failure(NetworkErrors.defaultException));
    }
  }

  //! log in user
  FutureEither<UserModel> loginUser({
    required String email,
    required String password,
  }) async {
    try {
      //! MAKE REQUEST
      http.Request request = http.Request("POST", Uri.parse(AppUrls.userLogin));

      //! ADD HEADER SUPPORTS
      request.headers
          .addAll({"Content-Type": "application/json; charset=UTF-8"});

      //! REQUEST BODY
      request.body = jsonEncode({
        "password": password,
        "email": email,
      });

      //! SEND REQUEST
      http.StreamedResponse response = await request.send();

      //! HOLD RESPONSE
      String responseStream = await response.stream.bytesToString();

      //! RESPONSE CONVERTED TO MAP, USED TO RUN AUTH TEST CASES AND DECIDE WHAT ACTION TO TAKE AS SEEN BELOW
      Map<String, dynamic> responseInMap = jsonDecode(responseStream);

      responseInMap.log();

      print(response.statusCode.toString());

      switch (response.statusCode) {
        //! SERVER REQUEST WAS SUCCESSFUL
        case 200:
          //! CONVERT DATA TO MODEL
          UserModel registeredUser = const UserModel(
              // userName: responseInMap['username'],
              // firstName: responseInMap['first_name'],
              // lastName: responseInMap['last_name'],
              // email: responseInMap['email'],
              );

          //! CACHE ACCESS TOKEN
          await TokenCache.cacheUserTokens(
            tokens: UserToken(
              refreshToken: responseInMap['refresh'],
              accessToken: responseInMap['access'],
            ),
          );

          //! CACHE USER DETAILS
          // await UserDetailsCache.cacheUserDetails(
          //     theUserDetails: registeredUser);

          return right(registeredUser);

        //! ACCOUNT ALREADY EXISTS
        case 400:
          "Sign Up Response Failure: $responseStream".log();
          //! RETURN THE FAILURE, SHOW THE MESSAGE USING SHORTCUT LEFT.
          return left(Failure(responseInMap["message"]));

        //! SERVER REQUEST FAILED OR ANY OTHER FAILURE TYPE
        default:
          "Default Sign Up Error Code: ${response.statusCode} \nResponse: $responseStream, \nReason: ${response.reasonPhrase}"
              .log();
          return left(Failure(responseInMap["message"]));
      }
    } on SocketException catch (error) {
      "Socket Exception ${error.message.toString()}".log();
      return left(Failure(NetworkErrors.socketException));
    } on FormatException catch (error) {
      "Format Exception ${error.message.toString()}".log();
      return left(Failure(NetworkErrors.formatException));
    } on HttpException catch (error) {
      "Http Exception ${error.message.toString()}".log();
      return left(Failure(NetworkErrors.httpException));
    } catch (error) {
      "User Sign Up Error ${error.toString()}".log();
      return left(Failure(NetworkErrors.defaultException));
    }
  }

  //! rotate tokens
  Future<void> rotateTokens() async {
    try {
      //! FETCH USER TOKEN
      final Iterable<UserToken?> userToken = await TokenCache.getUserTokens();
      userToken.first!.refreshToken!.log();
      http.Request request =
          http.Request("POST", Uri.parse(AppUrls.rotateTokens))
            ..headers.addAll({
              "Content-Type": "application/json; charset=UTF-8",
              "Authorization": "Bearer ${userToken.first!.refreshToken}"
            });

      //! SEND REQUEST
      http.StreamedResponse response = await request.send();

      //! HOLD RESPONSE
      String responseStream = await response.stream.bytesToString();

      //! RESPONSE CONVERTED TO MAP, USED TO RUN AUTH TEST CASES AND DECIDE WHAT ACTION jTO TAKE AS SEEN BELOW
      Map<String, dynamic> responseInMap = jsonDecode(responseStream);

      responseInMap.log();

      switch (response.statusCode) {
        //! SERVER REQUEST WAS SUCCESSFUL
        case 200:

          //! CACHE ACCESS TOKEN
          await TokenCache.cacheUserTokens(
              tokens: UserToken.fromJSON(responseInMap["data"]));

        //! ACCOUNT ALREADY EXISTS
        case 400:
        // "Sign Up Response Failure: $responseStream".log();
        //! RETURN THE FAILURE, SHOW THE MESSAGE USING SHORTCUT LEFT.
        // responseInMap["message"].log();

        //! SERVER REQUEST FAILED OR ANY OTHER FAILURE TYPE
        default:
        // "Default Sign Up Error Code: ${response.statusCode} \nResponse: $responseStream, \nReason: ${response.reasonPhrase}"
        // .log();
        // responseInMap["message"].log();
      }
    } on SocketException catch (error) {
      "Socket Exception ${error.message.toString()}".log();
    } on FormatException catch (error) {
      "Format Exception ${error.message.toString()}".log();
    } on HttpException catch (error) {
      "Http Exception ${error.message.toString()}".log();
    } catch (error) {
      "User Sign Up Error ${error.toString()}".log();
    }
  }

  //! get user data
  FutureEither<UserModel> getUserData() async {
    try {
      //! FETCH USER TOKEN
      final Iterable<UserToken?> userToken = await TokenCache.getUserTokens();

      //! make request
      http.Request request = http.Request("GET", Uri.parse(AppUrls.getUserData))
        ..headers.addAll({
          "Content-Type": "application/json; charset=UTF-8",
          "Authorization": "Bearer ${userToken.first!.accessToken}"
        });

      //! SEND REQUEST
      http.StreamedResponse response = await request.send();

      //! HOLD RESPONSE
      String responseStream = await response.stream.bytesToString();

      //! RESPONSE CONVERTED TO MAP, USED TO RUN AUTH TEST CASES AND DECIDE WHAT ACTION TO TAKE AS SEEN BELOW
      Map<String, dynamic> responseInMap = jsonDecode(responseStream);

      responseInMap.log();

      switch (response.statusCode) {
        //! SERVER REQUEST WAS SUCCESSFUL
        case 200:
          //! CONVERT DATA TO MODEL
          UserModel user = UserModel.fromJSON(responseInMap["data"]);

          return right(user);

        //! SERVER REQUEST FAILED
        case 400:
          "Sign Up Response Failure: $responseStream".log();
          //! RETURN THE FAILURE, SHOW THE MESSAGE USING SHORTCUT LEFT.
          return left(Failure(responseInMap["message"]));

        //! ANY OTHER FAILURE TYPE
        default:
          "Default Sign Up Error Code: ${response.statusCode} \nResponse: $responseStream, \nReason: ${response.reasonPhrase}"
              .log();
          return left(Failure(responseInMap["message"]));
      }
    } on SocketException catch (error) {
      "Socket Exception ${error.message.toString()}".log();
      return left(Failure(NetworkErrors.socketException));
    } on FormatException catch (error) {
      "Format Exception ${error.message.toString()}".log();
      return left(Failure(NetworkErrors.formatException));
    } on HttpException catch (error) {
      "Http Exception ${error.message.toString()}".log();
      return left(Failure(NetworkErrors.httpException));
    } catch (error) {
      "GET USER DATA Error ${error.toString()}".log();
      return left(Failure(NetworkErrors.defaultException));
    }
  }

  //! send SMS OTP
  FutureEither<String> sendSMSOTP({required String phoneNumber}) async {
    try {
      //! FETCH USER TOKEN
      final Iterable<UserToken?> userToken = await TokenCache.getUserTokens();

      //! MAKE REQUEST
      http.Request request =
          http.Request("POST", Uri.parse(AppUrls.sendSMSOTP));

      //! ADD HEADER SUPPORTS
      request.headers.addAll({
        "Content-Type": "application/json; charset=UTF-8",
        "Authorization": "Bearer ${userToken.first!.accessToken}"
      });

      //! REQUEST BODY
      request.body = jsonEncode({
        "receiver": phoneNumber,
      });

      //! SEND REQUEST
      http.StreamedResponse response = await request.send();

      //! HOLD RESPONSE
      String responseStream = await response.stream.bytesToString();

      //! RESPONSE CONVERTED TO MAP, CAN BE USED TO RUN AUTH TEST CASES AND DECIDE WHAT ACTION TO TAKE AS SEEN BELOW
      Map<String, dynamic> responseInMap = jsonDecode(responseStream);

      responseInMap.log();

      switch (response.statusCode) {
        //! SERVER REQUEST WAS SUCCESSFUL
        case 200:
          return right(responseInMap["message"]);

        //! SERVER REQUEST FAILED
        case 400:
          "Sign Up Response Failure: $responseStream".log();
          //! RETURN THE FAILURE, SHOW THE MESSAGE USING SHORTCUT LEFT.
          return left(Failure(responseInMap["message"]));

        //! ANY OTHER FAILURE TYPE
        default:
          "Default Sign Up Error Code: ${response.statusCode} \nResponse: $responseStream, \nReason: ${response.reasonPhrase}"
              .log();
          return left(Failure(responseInMap["message"]));
      }
    } on SocketException catch (error) {
      "Socket Exception ${error.message.toString()}".log();
      return left(Failure(NetworkErrors.socketException));
    } on FormatException catch (error) {
      "Format Exception ${error.message.toString()}".log();
      return left(Failure(NetworkErrors.formatException));
    } on HttpException catch (error) {
      "Http Exception ${error.message.toString()}".log();
      return left(Failure(NetworkErrors.httpException));
    } catch (error) {
      "User Sign Up Error ${error.toString()}".log();
      return left(Failure(NetworkErrors.defaultException));
    }
  }

  //! verify SMS OTP
  FutureEither<String> verifySMSOTP({
    required String phoneNumber,
    required String oTP,
  }) async {
    try {
      //! FETCH USER TOKEN
      final Iterable<UserToken?> userToken = await TokenCache.getUserTokens();

      //! MAKE REQUEST
      http.Request request =
          http.Request("POST", Uri.parse(AppUrls.verifySMSOTP));

      //! ADD HEADER SUPPORTS
      request.headers.addAll({
        "Content-Type": "application/json; charset=UTF-8",
        "Authorization": "Bearer ${userToken.first!.accessToken}"
      });

      //! REQUEST BODY
      request.body = jsonEncode({
        "receiver": phoneNumber,
        "otp": oTP,
      });

      //! SEND REQUEST
      http.StreamedResponse response = await request.send();

      //! HOLD RESPONSE
      String responseStream = await response.stream.bytesToString();

      //! RESPONSE CONVERTED TO MAP, CAN BE USED TO RUN AUTH TEST CASES AND DECIDE WHAT ACTION TO TAKE AS SEEN BELOW
      Map<String, dynamic> responseInMap = jsonDecode(responseStream);

      responseInMap.log();

      switch (response.statusCode) {
        //! SERVER REQUEST WAS SUCCESSFUL
        case 200:
          return right(responseInMap["message"]);

        //! SERVER REQUEST FAILED
        case 400:
          "Sign Up Response Failure: $responseStream".log();
          //! RETURN THE FAILURE, SHOW THE MESSAGE USING SHORTCUT LEFT.
          return left(Failure(responseInMap["message"]));

        //! ANY OTHER FAILURE TYPE
        default:
          "Default Sign Up Error Code: ${response.statusCode} \nResponse: $responseStream, \nReason: ${response.reasonPhrase}"
              .log();
          return left(Failure(responseInMap["message"]));
      }
    } on SocketException catch (error) {
      "Socket Exception ${error.message.toString()}".log();
      return left(Failure(NetworkErrors.socketException));
    } on FormatException catch (error) {
      "Format Exception ${error.message.toString()}".log();
      return left(Failure(NetworkErrors.formatException));
    } on HttpException catch (error) {
      "Http Exception ${error.message.toString()}".log();
      return left(Failure(NetworkErrors.httpException));
    } catch (error) {
      "User Sign Up Error ${error.toString()}".log();
      return left(Failure(NetworkErrors.defaultException));
    }
  }

  //! send email OTP
  FutureEither<String> sendEmailOTP({required String email}) async {
    try {
      //! FETCH USER TOKEN
      // final Iterable<UserToken?> userToken = await TokenCache.getUserTokens();

      //! MAKE REQUEST
      http.Request request =
          http.Request("POST", Uri.parse(AppUrls.sendEmailOTP));

      //! ADD HEADER SUPPORTS
      request.headers.addAll({
        "Content-Type": "application/json; charset=UTF-8",
        // "Authorization": "Bearer ${userToken.first!.accessToken}"
      });

      //! REQUEST BODY
      request.body = jsonEncode({
        "receiver": email,
      });

      //! SEND REQUEST
      http.StreamedResponse response = await request.send();

      //! HOLD RESPONSE
      String responseStream = await response.stream.bytesToString();

      //! RESPONSE CONVERTED TO MAP, CAN BE USED TO RUN AUTH TEST CASES AND DECIDE WHAT ACTION TO TAKE AS SEEN BELOW
      Map<String, dynamic> responseInMap = jsonDecode(responseStream);

      responseInMap.log();

      switch (response.statusCode) {
        //! SERVER REQUEST WAS SUCCESSFUL
        case 200:
          return right(responseInMap["message"]);

        //! SERVER REQUEST FAILED
        case 400:
          "Sign Up Response Failure: $responseStream".log();
          //! RETURN THE FAILURE, SHOW THE MESSAGE USING SHORTCUT LEFT.
          return left(Failure(responseInMap["message"]));

        //! ANY OTHER FAILURE TYPE
        default:
          "Default Sign Up Error Code: ${response.statusCode} \nResponse: $responseStream, \nReason: ${response.reasonPhrase}"
              .log();
          return left(Failure(responseInMap["message"]));
      }
    } on SocketException catch (error) {
      "Socket Exception ${error.message.toString()}".log();
      return left(Failure(NetworkErrors.socketException));
    } on FormatException catch (error) {
      "Format Exception ${error.message.toString()}".log();
      return left(Failure(NetworkErrors.formatException));
    } on HttpException catch (error) {
      "Http Exception ${error.message.toString()}".log();
      return left(Failure(NetworkErrors.httpException));
    } catch (error) {
      "User Sign Up Error ${error.toString()}".log();
      return left(Failure(NetworkErrors.defaultException));
    }
  }

  //! verify Email OTP
  FutureEither<String> verifyEmailOTP({
    required String email,
    required String oTP,
  }) async {
    try {
      //! FETCH USER TOKEN
      // final Iterable<UserToken?> userToken = await TokenCache.getUserTokens();

      //! MAKE REQUEST
      http.Request request =
          http.Request("POST", Uri.parse(AppUrls.verifyEmailOTP));

      //! ADD HEADER SUPPORTS
      request.headers.addAll({
        "Content-Type": "application/json; charset=UTF-8",
        // "Authorization": "Bearer ${userToken.first!.accessToken}"
      });

      //! REQUEST BODY
      request.body = jsonEncode({
        "receiver": email,
        "otp": oTP,
      });

      //! SEND REQUEST
      http.StreamedResponse response = await request.send();

      //! HOLD RESPONSE
      String responseStream = await response.stream.bytesToString();

      //! RESPONSE CONVERTED TO MAP, CAN BE USED TO RUN AUTH TEST CASES AND DECIDE WHAT ACTION TO TAKE AS SEEN BELOW
      Map<String, dynamic> responseInMap = jsonDecode(responseStream);

      responseInMap.log();

      switch (response.statusCode) {
        //! SERVER REQUEST WAS SUCCESSFUL
        case 200:
          return right(responseInMap["data"]);

        //! SERVER REQUEST FAILED
        case 400:
          "Sign Up Response Failure: $responseStream".log();
          //! RETURN THE FAILURE, SHOW THE MESSAGE USING SHORTCUT LEFT.
          return left(Failure(responseInMap["message"]));

        //! ANY OTHER FAILURE TYPE
        default:
          "Default Sign Up Error Code: ${response.statusCode} \nResponse: $responseStream, \nReason: ${response.reasonPhrase}"
              .log();
          return left(Failure(responseInMap["message"]));
      }
    } on SocketException catch (error) {
      "Socket Exception ${error.message.toString()}".log();
      return left(Failure(NetworkErrors.socketException));
    } on FormatException catch (error) {
      "Format Exception ${error.message.toString()}".log();
      return left(Failure(NetworkErrors.formatException));
    } on HttpException catch (error) {
      "Http Exception ${error.message.toString()}".log();
      return left(Failure(NetworkErrors.httpException));
    } catch (error) {
      "User Sign Up Error ${error.toString()}".log();
      return left(Failure(NetworkErrors.defaultException));
    }
  }

  //! change password
  FutureEither<String> changePassword({
    required String password,
    required String token,
  }) async {
    try {
      //! FETCH USER TOKEN
      // final Iterable<UserToken?> userToken = await TokenCache.getUserTokens();

      //! MAKE REQUEST
      http.Request request =
          http.Request("PATCH", Uri.parse(AppUrls.chnagePassword));

      //! ADD HEADER SUPPORTS
      request.headers.addAll({
        "Content-Type": "application/json; charset=UTF-8",
        // "Authorization": "Bearer ${userToken.first!.accessToken}"
      });

      //! REQUEST BODY
      request.body = jsonEncode({
        "password": password,
        "userType": "driver",
        "token": token,
      });

      //! SEND REQUEST
      http.StreamedResponse response = await request.send();

      //! HOLD RESPONSE
      String responseStream = await response.stream.bytesToString();

      //! RESPONSE CONVERTED TO MAP, CAN BE USED TO RUN AUTH TEST CASES AND DECIDE WHAT ACTION TO TAKE AS SEEN BELOW
      Map<String, dynamic> responseInMap = jsonDecode(responseStream);

      responseInMap.log();

      switch (response.statusCode) {
        //! SERVER REQUEST WAS SUCCESSFUL
        case 200:
          return right(responseInMap["message"]);

        //! SERVER REQUEST FAILED
        case 400:
          "Sign Up Response Failure: $responseStream".log();
          //! RETURN THE FAILURE, SHOW THE MESSAGE USING SHORTCUT LEFT.
          return left(Failure(responseInMap["message"]));

        //! ANY OTHER FAILURE TYPE
        default:
          "Default Sign Up Error Code: ${response.statusCode} \nResponse: $responseStream, \nReason: ${response.reasonPhrase}"
              .log();
          return left(Failure(responseInMap["message"]));
        // return left(Failure('An error occurred'));
      }
    } on SocketException catch (error) {
      "Socket Exception ${error.message.toString()}".log();
      return left(Failure(NetworkErrors.socketException));
    } on FormatException catch (error) {
      "Format Exception ${error.message.toString()}".log();
      return left(Failure(NetworkErrors.formatException));
    } on HttpException catch (error) {
      "Http Exception ${error.message.toString()}".log();
      return left(Failure(NetworkErrors.httpException));
    } catch (error) {
      "User Sign Up Error ${error.toString()}".log();
      return left(Failure(NetworkErrors.defaultException));
    }
  }
}
