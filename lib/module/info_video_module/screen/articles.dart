import 'package:flutter/material.dart';
import 'package:flutter_widget_from_html/flutter_widget_from_html.dart';
import 'package:get/get.dart';
import 'package:indrayani/module/info_video_module/view_model/info_video_view_model.dart';
import 'package:indrayani/utils/WebService/api_config.dart';
import 'package:indrayani/utils/common_widgets/app%20bar%20widget/header_curved_container.dart';
import 'package:indrayani/utils/constants/ColorConstant/color_constant.dart';
import 'package:indrayani/utils/internet_connectivity.dart';
import 'package:indrayani/utils/internet_connectivity/internet_connectivity.dart';
import 'package:indrayani/utils/loader.dart';
import 'package:url_launcher/url_launcher.dart';

class ArticleScreen extends StatefulWidget {
  final String? title;
  final String? content;
  final String? url;
  final bool isArticle;
  final Color color;
  final String? img;
  const ArticleScreen({
    super.key,
    this.title,
    this.content,
    this.url,
    this.img,
    required this.isArticle,
    required this.color,
  });

  @override
  State<ArticleScreen> createState() => _ArticleScreenState();
}

_launchURL(String eurl) async {
  if (!eurl.startsWith('http://') && !eurl.startsWith('https://')) {
    eurl = 'http://' + eurl;
  }
  if (await canLaunch(eurl)) {
    await launch(eurl);
  } else {
    throw 'Could not launch ${eurl}';
  }
}

class _ArticleScreenState extends State<ArticleScreen> {
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
    return InternetAwareWidget(
      child: SafeArea(
        child: Scaffold(
          backgroundColor: bodyBGColor,
          appBar: AppBar(
            backgroundColor: primaryColor,
            leading: IconButton(
              icon: Icon(Icons.arrow_back, color: Colors.black),
              onPressed: () => Navigator.of(context).pop(),
            ),
            actions: [
              Padding(
                padding: const EdgeInsets.all(5.0),
                child: Image.asset(
                  'assets/Logo/logo.png', // Replace with your image path
                  // height: 24.0, // Adjust the height as needed
                  // width: 24.0, // Adjust the width as needed
                ),
              ),
            ],
          ),
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
                  Expanded(
                    child: SingleChildScrollView(
                      child: Column(
                        mainAxisAlignment: MainAxisAlignment.spaceAround,
                        children: [
                          Obx(
                            () {
                              final isArticleSelected =
                                  infoVideoViewModel.isArticleSelected.value;
                              final dataModel = isArticleSelected
                                  ? infoVideoViewModel.articleDataModel.value
                                  : infoVideoViewModel.videoDataModel.value;

                              if (dataModel == null ||
                                  dataModel.responseBody == null) {
                                return const Center(
                                    child: CircularProgressIndicator(
                                  color: primaryColor,
                                ));
                              }

                              return Padding(
                                padding: const EdgeInsets.all(8.0),
                                child: SizedBox(
                                  child: Column(
                                    children: [
                                      Padding(
                                        padding:
                                            const EdgeInsets.only(top: 8.0),
                                        child: Container(
                                          decoration: const BoxDecoration(
                                              color: Colors.white,
                                              borderRadius: BorderRadius.only(
                                                topLeft: Radius.circular(5.0),
                                                topRight: Radius.circular(5.0),
                                              )),
                                          height: MediaQuery.of(context)
                                                  .size
                                                  .width *
                                              0.4,
                                          width:
                                              MediaQuery.of(context).size.width,
                                          child: widget.img != null &&
                                                  widget.img!.isNotEmpty
                                              ? Padding(
                                                  padding: const EdgeInsets.all(
                                                      18.0),
                                                  child: Image.network(
                                                    APIConfig.infoImage +
                                                        (widget.img!),
                                                    fit: BoxFit.fill,
                                                  ),
                                                )
                                              : Padding(
                                                  padding:
                                                      const EdgeInsets.all(5.0),
                                                  child: Image.asset(
                                                    'assets/Info_and_Video/article.png',
                                                    fit: BoxFit.contain,
                                                  ),
                                                ),
                                        ),
                                      ),
                                      Container(
                                        decoration: const BoxDecoration(
                                            color: Color.fromARGB(
                                                255, 255, 255, 255),
                                            borderRadius: BorderRadius.only(
                                                bottomLeft: Radius.circular(10),
                                                bottomRight:
                                                    Radius.circular(10))),
                                        width:
                                            MediaQuery.of(context).size.width,
                                        height: MediaQuery.of(context)
                                                    .size
                                                    .height >
                                                800
                                            ? 500
                                            : MediaQuery.of(context)
                                                        .size
                                                        .height >
                                                    700
                                                ? 420
                                                : MediaQuery.of(context)
                                                            .size
                                                            .height >
                                                        650
                                                    ? 360
                                                    : MediaQuery.of(context)
                                                                .size
                                                                .height >
                                                            500
                                                        ? 340
                                                        : MediaQuery.of(context)
                                                                    .size
                                                                    .height >
                                                                400
                                                            ? 310
                                                            : 320,
                                        child: LayoutBuilder(
                                            builder: (context, constraints) {
                                          // Assuming each line is approximately 16 pixels in height (for 12.0 font size)
                                          // double lineHeight = 16.0;
                                          // int maxLinesBeforeScroll =
                                          //     3;
                                          // double maxHeight =
                                          //     lineHeight *
                                          //         maxLinesBeforeScroll;

                                          return Padding(
                                              padding:
                                                  const EdgeInsets.all(12.0),
                                              child: SingleChildScrollView(
                                                child: Column(children: [
                                                  Text(
                                                    widget.title ?? '',
                                                    style: const TextStyle(
                                                        fontSize: 18,
                                                        fontWeight:
                                                            FontWeight.bold),
                                                  ),
                                                  const SizedBox(
                                                    height: 2,
                                                  ),
                                                  const Divider(),
                                                  HtmlWidget(
                                                      widget.content ?? '')
                                                ]),
                                              ));
                                        }),
                                      ),
                                    ],
                                  ),
                                ),
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
          bottomNavigationBar: widget.url != null && widget.url!.isNotEmpty
              ? Padding(
                  padding: const EdgeInsets.all(8.0),
                  child: ElevatedButton(
                      onPressed: () {
                        launch(widget.url!);
                      },
                      style: ElevatedButton.styleFrom(
                        padding: const EdgeInsets.symmetric(
                            horizontal: 45.0, vertical: 10),
                        backgroundColor: Colors.black,
                        shape: const RoundedRectangleBorder(
                          borderRadius: BorderRadius.all(Radius.circular(15)),
                        ),
                        minimumSize: const Size(10.0, 30.0),
                      ),
                      child: const Text(
                        'Go to the link',
                        style: TextStyle(color: Colors.white),
                      )),
                )
              : null,
        ),
      ),
    );
  }
}
