import 'package:flutter/material.dart';
import 'package:get/get_rx/src/rx_types/rx_types.dart';
import 'package:get/get_state_manager/src/simple/get_controllers.dart';
import 'package:indrayani/module/info_video_module/model/article_data_model.dart';
import 'package:indrayani/module/info_video_module/model/vedio_data_model.dart';
import 'package:indrayani/utils/WebService/api_base_model.dart';
import 'package:indrayani/utils/WebService/api_config.dart';
import 'package:indrayani/utils/WebService/end_points_constant.dart';

import '../../../utils/WebService/api_service.dart';

class InfoVideoViewModel extends GetxController {
  Rx<APIBaseModel<List<ArticleDataModel?>?>?> articleDataModel =
      RxNullable<APIBaseModel<List<ArticleDataModel?>?>?>().setNull();

  Rx<APIBaseModel<List<VideoDataModel?>?>?> videoDataModel =
      RxNullable<APIBaseModel<List<VideoDataModel?>?>?>().setNull();

  RxBool isArticleSelected = true.obs;
  RxBool isVideoSelected = false.obs;

  List<ArticleDataModel> fallbackArticles = [
    ArticleDataModel(
      title: "Article 1",
      content: "Content for Article 1",
      // imageUrl: "assets/Info_and_Video/icon.png",
    ),
    ArticleDataModel(
      title: "Article 1",
      content: "Content for Article 1",
      // imageUrl: "assets/Info_and_Video/icon.png",
    ),
    ArticleDataModel(
      title: "Article 1",
      content: "Content for Article 1",
      // imageUrl: "assets/Info_and_Video/icon.png",
    ),
    ArticleDataModel(
      title: "Article 2",
      content:
          "Content for Article 2. Lorem ipsum dolor sit amet, consectetur adipiscing elit. Nullam eget purus tincidunt, fringilla nunc et, sodales ipsum. ",
      // imageUrl: "assets/Info_and_Video/icon.png",
    ),
    ArticleDataModel(
      title: "Article 3",
      content:
          "Content for Article 3,Nullam eget purus tincidunt, fringilla nunc et, sodales ipsum.  Integer ac dapibus odio. Suspendisse ut tortor vitae justo eleifend eleifend.",
      // imageUrl: "assets/Info_and_Video/icon.png",
    ),
    ArticleDataModel(
      title: "Article 4, ",
      content:
          "Content for Article 4,  Integer ac dapibus odio. Suspendisse ut tortor vitae justo eleifend eleifend.Phasellus auctor nulla non dui lobortis, non commodo arcu cursus. ",
      // imageUrl: "assets/Info_and_Video/icon.png",
    ),
    ArticleDataModel(
      title: "Article 5",
      content: "https://www.themintmagazine.com/people/jayan-jose-thomas/",
      // imageUrl: "assets/Info_and_Video/icon.png",
    ),
    // Add more static articles
  ];

  List<VideoDataModel> fallbackVideos = [
    VideoDataModel(
      title: "Video 1",
      externalUrl: "https://link_to_video1.com",
      imageUrl: "assets/Info_and_Video/icon.png",
    ),
    // Add more static videos
  ];

  void selectArticle() {
    isArticleSelected.value = true;
    isVideoSelected.value = false;
  }

  void selectVideo() {
    isArticleSelected.value = false;
    isVideoSelected.value = true;
  }

  Future<APIBaseModel<List<ArticleDataModel?>?>?> getArticleList() async {
    articleDataModel.value = await APIService
        .getDataFromServerWithoutErrorModel<List<ArticleDataModel?>?>(
      endPoint: articleEndPoint,
      create: (dynamic json) {
        try {
          return (json as List)
              .map((e) => ArticleDataModel.fromJson(e))
              .toList();
        } catch (e) {
          debugPrint(e.toString());
          return null;
        }
      },
    );
    if (articleDataModel.value?.responseBody == null) {
      articleDataModel.value =
          APIBaseModel<List<ArticleDataModel>>(responseBody: fallbackArticles);
    }
    return articleDataModel.value;
  }

  Future<APIBaseModel<List<VideoDataModel?>?>?> getVideoList(
      {int? userId}) async {
    videoDataModel.value = await APIService.getDataFromServerWithoutErrorModel<
        List<VideoDataModel?>?>(
      endPoint: videoEndPoint,
      create: (dynamic json) {
        try {
          return (json as List).map((e) => VideoDataModel.fromJson(e)).toList();
        } catch (e) {
          debugPrint(e.toString());
          return null;
        }
      },
    );
    if (videoDataModel.value?.responseBody == null) {
      videoDataModel.value =
          APIBaseModel<List<VideoDataModel>>(responseBody: fallbackVideos);
    }
    return videoDataModel.value;
  }
}
