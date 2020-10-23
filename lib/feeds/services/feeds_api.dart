import 'package:flutter/material.dart';

import '../../common/models/feed/post_model.dart';
import '../../common/services/rest_api_request.dart';
import '../../common/helpers/list_response.dart';
import '../../common/providers/endpoint_url_provider.dart';

class FeedsApiService {
  static Future<PostModel> getFeedById({
    @required String feedId,
  }) async {
    try {
      var url = EndpointUrlProvider.getFeedByIdUrl(feedId);
      var response = await RestApiRequest.get(url, authRequired: false);
      if (response.success) {
        return PostModel.fromJson(response.result);
      }
      return null;
    } catch (e) {
      rethrow;
    }
  }

  static Future<ResponseList<PostModel>> getUserFeeds({
    @required int pageNumber,
    @required String userId,
    int pageSize = 10,
  }) async {
    try {
      var url = EndpointUrlProvider.getUserFeedsUrl(
          userId, pageSize, pageNumber * pageSize);
      var response = await RestApiRequest.get(url);
      if (response.success) {
        return ResponseList.fromJson(response.result);
      }
      //TODO:
      return null;
    } catch (e) {
      rethrow;
    }
  }

  static Future<ResponseList<String>> getFeedLikes({
    @required int pageNumber,
    @required String feedId,
    int pageSize = 10,
  }) async {
    try {
      var url = EndpointUrlProvider.getFeedLikesUrl(
          feedId, pageSize, pageNumber * pageSize);
      var response = await RestApiRequest.get(url);
      if (response.success) {
        return ResponseList.fromJson(response.result);
      }
      //TODO:
      return null;
    } catch (e) {
      rethrow;
    }
  }

  static Future<ResponseList<Comment>> getFeedComments({
    @required int pageNumber,
    @required String feedId,
    int pageSize = 10,
  }) async {
    try {
      var url = EndpointUrlProvider.getFeedCommentsUrl(
          feedId, pageSize, pageNumber * pageSize);
      var response = await RestApiRequest.get(url);
      if (response.success) {
        return ResponseList.fromJson(response.result);
      }
      //TODO:
      return null;
    } catch (e) {
      rethrow;
    }
  }
}
