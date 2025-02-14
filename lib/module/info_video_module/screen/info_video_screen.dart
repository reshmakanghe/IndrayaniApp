import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:indrayani/module/info_video_module/model/article_data_model.dart';
import 'package:indrayani/module/info_video_module/model/vedio_data_model.dart';
import 'package:indrayani/module/info_video_module/view_model/info_video_view_model.dart';
import 'package:indrayani/module/info_video_module/screen/info_video_card.dart';
import 'package:indrayani/utils/bottom_bar_widget/view_model/bottom_bar_view-model.dart';
import 'package:indrayani/utils/bottom_bar_widget/view_model/custom_bottom_bar.dart';
import 'package:indrayani/utils/common_widgets/app%20bar%20widget/custom_app_bar.dart';
import 'package:indrayani/utils/common_widgets/app%20bar%20widget/header_curved_container.dart';
import 'package:indrayani/utils/common_widgets/user_drawer.dart';
import 'package:indrayani/utils/constants/ColorConstant/color_constant.dart';
import 'package:indrayani/utils/internet_connectivity.dart';
import 'package:indrayani/utils/internet_connectivity/internet_connectivity.dart';
import 'package:indrayani/utils/loader.dart';
import 'package:indrayani/utils/widgetConstant/text_widget/text_constant_widget.dart';

class InfoVideoScreen extends StatefulWidget {
  const InfoVideoScreen({Key? key}) : super(key: key);

  @override
  State<InfoVideoScreen> createState() => _InfoVideoScreenState();
}

class _InfoVideoScreenState extends State<InfoVideoScreen> {
  final InfoVideoViewModel infoVideoViewModel = Get.put(InfoVideoViewModel());

  @override
  void initState() {
    super.initState();
    WidgetsBinding.instance.addPostFrameCallback((_) async {
      showLoadingDialog();
      await infoVideoViewModel.getArticleList();
      hideLoadingDialog();
      showLoadingDialog();
      await infoVideoViewModel.getVideoList();
      hideLoadingDialog();
    });

    checkConnectivity();
  }

  @override
  Widget build(BuildContext context) {
    return Obx(
      () {
        final bottomBarVisibility =
            Get.find<NavigationController>().showBottomBar.value;
        return InternetAwareWidget(
          child: SafeArea(
              child: Scaffold(
                  backgroundColor: bodyBGColor,
                  appBar: const CustomAppBar(
                    containerText: "ARTICLE AND VIDEO",
                    imagePath: "assets/Icon/info-video-icon.png",
                  ),
                  drawer: const UserDrawer(),
                  body: Stack(
                    alignment: Alignment.center,
                    children: [
                      CustomPaint(
                        painter: HeaderCurvedContainer(),
                        child: SizedBox(
                          width: MediaQuery.of(context).size.width,
                          height: MediaQuery.of(context).size.height,
                        ),
                      ),
                      Column(
                        children: [
                          Container(
                            color: Colors.transparent, // Adjust color as needed
                            padding: const EdgeInsets.symmetric(vertical: 20),
                            child: Row(
                              mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                              children: [
                                Obx(
                                  () => ElevatedButton(
                                    onPressed: infoVideoViewModel.selectArticle,
                                    style: ElevatedButton.styleFrom(
                                      backgroundColor: infoVideoViewModel
                                              .isArticleSelected.value
                                          ? Colors.black
                                          : Colors.grey,
                                      shape: RoundedRectangleBorder(
                                        borderRadius: BorderRadius.circular(8),
                                      ),
                                      fixedSize: const Size(180, 50),
                                    ),
                                    child: const ConstantText(
                                      text: 'Articles',
                                      color: Colors.white,
                                    ),
                                  ),
                                ),
                                Obx(
                                  () => ElevatedButton(
                                    onPressed: infoVideoViewModel.selectVideo,
                                    style: ElevatedButton.styleFrom(
                                      backgroundColor: infoVideoViewModel
                                              .isVideoSelected.value
                                          ? Colors.black
                                          : Colors.grey,
                                      shape: RoundedRectangleBorder(
                                        borderRadius: BorderRadius.circular(8),
                                      ),
                                      fixedSize: const Size(180, 50),
                                    ),
                                    child: const ConstantText(
                                      text: 'Videos',
                                      color: Colors.white,
                                    ),
                                  ),
                                )
                              ],
                            ),
                          ),
                          Expanded(
                            child: SingleChildScrollView(
                              child: Column(
                                mainAxisAlignment:
                                    MainAxisAlignment.spaceAround,
                                children: [
                                  Obx(
                                    () {
                                      final isArticleSelected =
                                          infoVideoViewModel
                                              .isArticleSelected.value;
                                      final dataModel = isArticleSelected
                                          ? infoVideoViewModel
                                              .articleDataModel.value
                                          : infoVideoViewModel
                                              .videoDataModel.value;

                                      if (dataModel == null ||
                                          dataModel.responseBody == null) {
                                        return const Center(
                                            child: CircularProgressIndicator(
                                          color: primaryColor,
                                        ));
                                      }

                                      final list = dataModel.responseBody!;

                                      return ListView.builder(
                                        padding: const EdgeInsets.all(10.0),
                                        shrinkWrap: true,
                                        physics:
                                            const NeverScrollableScrollPhysics(),
                                        itemCount: list.length,
                                        itemBuilder: (context, index) {
                                          final item = list[index];
                                          if (isArticleSelected) {
                                            final article =
                                                item as ArticleDataModel;
                                            return (article.type == 'article')
                                                ? InfoVideoCard(
                                                    title: article.title,
                                                    content: article.content,
                                                    imageUrl: article.imageUrl,
                                                    url: article.externalUrl,
                                                    isArticle: true,
                                                    type: article.type,
                                                    color: Colors.white,
                                                  )
                                                : Container();
                                          } else {
                                            final video =
                                                item as VideoDataModel;
                                            return (video.type == 'video')
                                                ? InfoVideoCard(
                                                    title: video.title,
                                                    imageUrl: video.imageUrl,
                                                    type: video.type,
                                                    url: video.externalUrl,
                                                    isArticle: false,
                                                    color: Colors.white,
                                                  )
                                                : Container();
                                          }
                                        },
                                      );
                                    },
                                  ),
                                ],
                              ),
                            ),
                          ),
                        ],
                      ),
                    ],
                  ),
                  bottomNavigationBar:
                      bottomBarVisibility ? CustomBottomNavBar() : null)),
        );
      },
    );
  }
}
