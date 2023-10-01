import 'dart:convert';
import 'dart:io';

import 'package:jimpact/models/blogs/blog_model.dart';

import 'package:jimpact/shared/app_urls.dart';
import 'package:jimpact/utils/app_extensions.dart';
import 'package:jimpact/utils/failure.dart';
import 'package:jimpact/utils/network_errors.dart';
import 'package:fpdart/fpdart.dart';
import 'package:http/http.dart' as http;

class BlogRepository {
  const BlogRepository();

  //! get blogs
  Future<List<BlogModel>> getAllBlogs() async {
    try {
      //! FETCH USER TOKEN
      // final Iterable<UserToken?> userToken = await TokenCache.getUserTokens();

      http.Request request = http.Request("GET", Uri.parse(AppUrls.getBlogs))
        ..headers.addAll({
          "Content-Type": "application/json; charset=UTF-8",
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
}
