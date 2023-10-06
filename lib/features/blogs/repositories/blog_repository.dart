import 'dart:convert';
import 'dart:io';

import 'package:jimpact/cache/token_cache.dart';
import 'package:jimpact/models/blogs/blog_model.dart';
import 'package:jimpact/models/tokens/token_model.dart';

import 'package:jimpact/shared/app_urls.dart';
import 'package:jimpact/utils/app_extensions.dart';
import 'package:jimpact/utils/failure.dart';
import 'package:jimpact/utils/network_errors.dart';
import 'package:fpdart/fpdart.dart';
import 'package:http/http.dart' as http;
import 'package:jimpact/utils/type_defs.dart';

class BlogRepository {
  const BlogRepository();

  //! get blogs
  Future<List<BlogModel>> getAllBlogs() async {
    try {
      //! FETCH USER TOKEN
      final Iterable<UserToken?> userToken = await TokenCache.getUserTokens();

      http.Request request = http.Request("GET", Uri.parse(AppUrls.getBlogs))
        ..headers.addAll({
          "Content-Type": "application/json; charset=UTF-8",
          "Authorization": "Bearer ${userToken.first!.accessToken}",
        });

      //! SEND REQUEST
      http.StreamedResponse response = await request.send();

      //! HOLD RESPONSE
      String responseStream = await response.stream.bytesToString();

      List<dynamic> responseInMap = jsonDecode(responseStream);

      responseInMap.log();

      switch (response.statusCode) {
        //! SERVER REQUEST WAS SUCCESSFUL
        case 200:
          'correct'.log();
          List<BlogModel> blogModels = responseInMap
              .map((blogData) => BlogModel.fromJSON(blogData))
              .toList();

          return blogModels;

        //! SERVER REQUEST FAILED
        case 400:
          "Get Blog List Failure: $responseStream".log();
          //! RETURN THE FAILURE, SHOW THE MESSAGE USING SHORTCUT LEFT.
          throw left(Failure(responseInMap.toString()));

        //! ACCESS DENIED
        // case 401:
        //   await _authRepository.rotateTokens();
        //   final res = await getAllCampaigns();

        //   return res;

        case 404:
          List<BlogModel> emptyList = [];
          return emptyList;

        //! ANY OTHER FAILURE TYPE
        default:
          "blog Error Code: ${response.statusCode} \nResponse: $responseStream, \nReason: ${response.reasonPhrase}"
              .log();
          throw left(Failure(responseInMap.toString()));
      }
    } on SocketException catch (error) {
      "Blog list Socket Exception ${error.message.toString()}".log();
      throw left(Failure(NetworkErrors.socketException));
    } on FormatException catch (error) {
      "Blog list Format Exception ${error.message.toString()}".log();
      throw left(Failure(NetworkErrors.formatException));
    } on HttpException catch (error) {
      "Blog list Http Exception ${error.message.toString()}".log();
      throw left(Failure(NetworkErrors.httpException));
    } catch (error) {
      "Blog default Error ${error.toString()}".log();
      throw left(Failure(NetworkErrors.defaultException));
    }
  }

  //! create blogs
  FutureVoid createBlog({
    required int user,
    required String title,
    required String content,
  }) async {
    try {
      //! FETCH USER TOKEN
      final Iterable<UserToken?> userToken = await TokenCache.getUserTokens();
      //! MAKE REQUEST
      http.Request request =
          http.Request("POST", Uri.parse(AppUrls.createBlogs));

      //! ADD HEADER SUPPORTS
      request.headers.addAll({
        "Content-Type": "application/json; charset=UTF-8",
        "Authorization": "Bearer ${userToken.first!.accessToken}",
      });

      //! REQUEST BODY
      request.body = jsonEncode({
        "user": user,
        "title": title,
        "content": content,
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
          return right(null);

        //! SERVER REQUEST FAILED
        case 400:
          "Create blog Response Failure: $responseStream".log();
          //! RETURN THE FAILURE, SHOW THE MESSAGE USING SHORTCUT LEFT.
          return left(Failure(responseInMap["message"]));

        //! ANY OTHER FAILURE TYPE
        default:
          "Default Create blog Error Code: ${response.statusCode} \nResponse: $responseStream, \nReason: ${response.reasonPhrase}"
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
      "User Create blog Error ${error.toString()}".log();
      return left(Failure(NetworkErrors.defaultException));
    }
  }
}
