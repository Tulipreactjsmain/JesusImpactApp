import 'dart:convert';
import 'dart:io';

import 'package:fpdart/fpdart.dart';
import 'package:jimpact/cache/token_cache.dart';
import 'package:jimpact/models/tokens/token_model.dart';
import 'package:jimpact/models/user/user_model.dart';
import 'package:jimpact/shared/app_urls.dart';
import 'package:jimpact/utils/app_extensions.dart';
import 'package:jimpact/utils/failure.dart';
import 'package:jimpact/utils/network_errors.dart';
import 'package:jimpact/utils/type_defs.dart';
import 'package:http/http.dart' as http;

class ProfileRepository {
  const ProfileRepository();

  //! update username
  FutureEither<UserModel> updateUserName({
    required String username,
    required bool isPassword,
  }) async {
    try {
      //! FETCH USER TOKEN
      final Iterable<UserToken?> userToken = await TokenCache.getUserTokens();
      //! MAKE REQUEST
      http.Request request = http.Request("PATCH", Uri.parse(AppUrls.profile));

      //! ADD HEADER SUPPORTS
      request.headers.addAll({
        "Content-Type": "application/json; charset=UTF-8",
        "Authorization": "Bearer ${userToken.first!.accessToken}",
      });

      //! REQUEST BODY
      request.body = isPassword == true
          ? jsonEncode({
              "password": username,
            })
          : jsonEncode({
              "username": username,
            });

      //! SEND REQUEST
      http.StreamedResponse response = await request.send();

      //! HOLD RESPONSE
      String responseStream = await response.stream.bytesToString();

      //! RESPONSE CONVERTED TO MAP, USED TO RUN AUTH TEST CASES AND DECIDE WHAT ACTION TO TAKE AS SEEN BELOW
      Map<String, dynamic> responseInMap = jsonDecode(responseStream);

      responseInMap.toString().log();

      switch (response.statusCode) {
        //! SERVER REQUEST WAS SUCCESSFUL
        case 200 || 201:

          //! CONVERT DATA TO MODEL
          UserModel updatedUser = UserModel.fromJSON(responseInMap);

          return right(updatedUser);

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
}
