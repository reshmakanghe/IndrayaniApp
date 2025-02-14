import 'package:auto_size_text/auto_size_text.dart';
import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';
import 'package:flutter_widget_from_html/flutter_widget_from_html.dart';
import 'package:indrayani/module/info_video_module/screen/articles.dart';
import 'package:indrayani/utils/WebService/api_config.dart';
import 'package:indrayani/utils/widgetConstant/common_widget/common_widget.dart';
import 'package:indrayani/utils/widgetConstant/text_widget/text_constant_widget.dart';
import 'package:url_launcher/url_launcher.dart';

class InfoVideoCard extends StatefulWidget {
  final String? title;
  final String? content;
  final String? url;
  final String? imageUrl;
  final String? type;
  final bool isArticle;
  final Color color;

  const InfoVideoCard({
    Key? key,
    this.title,
    this.content,
    this.url,
    this.imageUrl,
    this.type,
    required this.isArticle,
    required this.color,
  }) : super(key: key);

  @override
  _InfoVideoCardState createState() => _InfoVideoCardState();
}

class _InfoVideoCardState extends State<InfoVideoCard> {
  bool isExpanded = false;

  // _launchURL(String eurl) async {
  //   if (await canLaunch(eurl)) {
  //     await launch(eurl);
  //   } else {
  //     throw 'Could not launch ${eurl}';
  //   }
  // }
  // _launchURL(String eurl) async {
  //   if (!eurl.startsWith('http://') && !eurl.startsWith('https://')) {
  //     eurl = 'http://' + eurl;
  //   }
  //   if (await canLaunch(eurl)) {
  //     await launch(eurl);
  //   } else {
  //     throw 'Could not launch ${eurl}';
  //   }
  // }
  // Future<void> _launchURL(String? eurl) async {
  //   if (eurl == null || eurl.isEmpty) {
  //     throw 'URL is null or empty';
  //   }

  //   // Log the URL for debugging
  //   print('Attempting to launch URL: $eurl');

  //   // Ensure the URL is properly formed
  //   final Uri uri = Uri.parse(
  //       eurl.startsWith('http') || eurl.startsWith('https')
  //           ? eurl
  //           : 'http://$eurl');

  //   // Log the launch mode for debugging
  //   print('Using launch mode: $eurl');

  //   // Attempt to launch the URL
  //   try {
  //     if (await canLaunchUrl(uri)) {
  //       await launchUrl(
  //         uri,
  //         mode: LaunchMode.externalApplication,
  //       );
  //     } else {
  //       throw 'Could not launch $eurl';
  //     }
  //   } catch (e) {
  //     // Log the error for further debugging
  //     print('Error launching URL: $e');
  //     throw 'Could not launch $eurl: $e';
  //   }
  // }
  String truncateContent(String content, {int maxWords = 10}) {
    List<String> words = content.split(" ");
    if (words.length > maxWords) {
      return words.take(maxWords).join(" ") + '...';
    } else {
      return content;
    }
  }

  bool isEnglish(String text) {
    final englishRegex = RegExp(r'^[\x00-\x7F]+$');
    return englishRegex.hasMatch(text);
  }

  @override
  Widget build(BuildContext context) {
    bool isTitleEnglish = isEnglish(widget.title ?? "");
    return Card(
      color: widget.color,
      margin: const EdgeInsets.all(8.0),
      shape: RoundedRectangleBorder(
        borderRadius: BorderRadius.circular(15),
      ),
      elevation: 6,
      child: ClipRRect(
        borderRadius: BorderRadius.circular(20),
        child: Row(crossAxisAlignment: CrossAxisAlignment.start, children: [
          Container(
              width: MediaQuery.of(context).size.width * 0.34,
              height: MediaQuery.of(context).size.width * 0.34,
              decoration: BoxDecoration(
                color: Colors.white,
                borderRadius: BorderRadius.circular(15),
                border: Border.all(
                  color: Colors.grey[300]!,
                  width: 0,
                ),
              ),
              child: Padding(
                padding: const EdgeInsets.all(5.0),
                child: widget.imageUrl != null && widget.imageUrl!.isNotEmpty
                    ? Image.network(
                        APIConfig.infoImage + widget.imageUrl!,
                        fit: BoxFit.contain,
                      )
                    : widget.type == 'article'
                        ? Padding(
                            padding: const EdgeInsets.all(15.0),
                            child: Image.asset(
                              'assets/Info_and_Video/article.png',
                              fit: BoxFit.contain,
                            ),
                          )
                        : Padding(
                            padding: const EdgeInsets.all(5.0),
                            child: Image.asset(
                              'assets/Info_and_Video/infovideo.png',
                              fit: BoxFit.contain,
                            ),
                          ),
              )),
          Flexible(
            child: Padding(
              padding: const EdgeInsets.all(5.0),
              child: (widget.isArticle)
                  ? InkWell(
                      onTap: () {
                        Navigator.of(context).push(
                          MaterialPageRoute(
                            builder: (context) => ArticleScreen(
                              title: widget.title ?? '',
                              img: widget.imageUrl,
                              content: widget.content,
                              url: widget.url,
                              isArticle: widget.isArticle,
                              color: widget.color,
                            ),
                          ),
                        );
                      },
                      child: ListTile(
                        dense: true,
                        title: Column(
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: [
                              Padding(
                                padding: isTitleEnglish
                                    ? EdgeInsets.zero
                                    : const EdgeInsets.all(2.0),
                                child: AutoSizeText(
                                  widget.title ?? "",
                                  style: TextStyle(
                                    color: Colors.black,
                                    fontSize:
                                        MediaQuery.of(context).size.height > 800
                                            ? 17
                                            : MediaQuery.of(context)
                                                        .size
                                                        .height >
                                                    700
                                                ? 17
                                                : MediaQuery.of(context)
                                                            .size
                                                            .height >
                                                        650
                                                    ? 14
                                                    : MediaQuery.of(context)
                                                                .size
                                                                .height >
                                                            500
                                                        ? 13
                                                        : MediaQuery.of(context)
                                                                    .size
                                                                    .height >
                                                                400
                                                            ? 11
                                                            : 12,
                                    fontWeight: FontWeight.bold,
                                  ),
                                  maxLines:
                                      2, // You can set this to the maximum number of lines you want
                                  minFontSize: 10,
                                  overflow: TextOverflow.ellipsis,
                                ),
                              ),
                              (widget.isArticle)
                                  ? InkWell(
                                      onTap: () {
                                        launch(widget.url ?? '');
                                      },
                                      child: Text(
                                        widget.url ?? '',
                                        style: TextStyle(
                                          color: Color.fromARGB(
                                            255,
                                            17,
                                            63,
                                            154,
                                          ),
                                          decoration: TextDecoration.underline,
                                          fontSize: MediaQuery.of(context)
                                                      .size
                                                      .height >
                                                  800
                                              ? 12
                                              : MediaQuery.of(context)
                                                          .size
                                                          .height >
                                                      700
                                                  ? 12
                                                  : MediaQuery.of(context)
                                                              .size
                                                              .height >
                                                          650
                                                      ? 10
                                                      : MediaQuery.of(context)
                                                                  .size
                                                                  .height >
                                                              500
                                                          ? 10
                                                          : MediaQuery.of(context)
                                                                      .size
                                                                      .height >
                                                                  400
                                                              ? 9
                                                              : 8,
                                        ),
                                        maxLines: 1,
                                        softWrap: true,
                                        overflow: TextOverflow.ellipsis,
                                      ),
                                    )
                                  : Container(),
                              HtmlWidget(
                                isExpanded
                                    ? widget.content ?? ''
                                    : truncateContent(widget.content ?? '',
                                        maxWords: 2),
                                // Optionally customize how HTML is rendered
                                textStyle: TextStyle(
                                  color: Colors.black,
                                  fontSize: MediaQuery.of(context).size.height >
                                          800
                                      ? 12
                                      : MediaQuery.of(context).size.height > 700
                                          ? 12
                                          : MediaQuery.of(context).size.height >
                                                  650
                                              ? 10
                                              : MediaQuery.of(context)
                                                          .size
                                                          .height >
                                                      500
                                                  ? 10
                                                  : MediaQuery.of(context)
                                                              .size
                                                              .height >
                                                          400
                                                      ? 9
                                                      : 8,
                                ),
                              ),
                              // spaceWidget(height: 2),
                              Align(
                                alignment: Alignment.bottomRight,
                                child: GestureDetector(
                                  onTap: () {
                                    setState(() {
                                      isExpanded = !isExpanded;
                                    });
                                  },
                                  child: GestureDetector(
                                    onTap: () {
                                      Navigator.of(context).push(
                                        MaterialPageRoute(
                                          builder: (context) => ArticleScreen(
                                            title: widget.title,
                                            content: widget.content,
                                            url: widget.url,
                                            img: widget.imageUrl,
                                            isArticle: widget.isArticle,
                                            color: widget.color,
                                          ),
                                        ),
                                      );
                                    },
                                    child: ConstantText(
                                      text: isExpanded
                                          ? 'Read less '
                                          : 'Read more >>',
                                      color: Colors.red,
                                      fontWeight: FontWeight.bold,
                                      fontSize: 12.0,
                                    ),
                                  ),
                                ),
                              ),
                              const SizedBox(height: 4),
                            ]),
                      ))
                  : ListTile(
                      dense: true,
                      title: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          AutoSizeText(
                            widget.title ?? "",
                            style: TextStyle(
                              color: Colors.black,
                              fontSize: MediaQuery.of(context).size.height > 800
                                  ? 15
                                  : MediaQuery.of(context).size.height > 700
                                      ? 14
                                      : MediaQuery.of(context).size.height > 650
                                          ? 14
                                          : MediaQuery.of(context).size.height >
                                                  500
                                              ? 13
                                              : MediaQuery.of(context)
                                                          .size
                                                          .height >
                                                      400
                                                  ? 11
                                                  : 12,
                              fontWeight: FontWeight.bold,
                            ),
                            maxLines:
                                1, // You can set this to the maximum number of lines you want
                            minFontSize: 13,
                            overflow: TextOverflow.ellipsis,
                          ),
                          (widget.isArticle)
                              ? InkWell(
                                  onTap: () {
                                    launch(widget.url ?? '');
                                  },
                                  child: Text(
                                    widget.url ?? '',
                                    style: const TextStyle(
                                        color: Color.fromARGB(255, 17, 63, 154),
                                        decoration: TextDecoration.underline),
                                    maxLines: 1,
                                    softWrap: true,
                                    overflow: TextOverflow.ellipsis,
                                  ),
                                )
                              : Container(),
                          spaceWidget(height: 6),
                          Container(
                            color: Colors.grey[200],
                            padding: const EdgeInsets.all(8.0),
                            child: ElevatedButton(
                              // onPressed: _launchURL('widget.eurl' ?? ''),
                              onPressed: () {
                                launch(widget.url ?? '');
                              },
                              style: ElevatedButton.styleFrom(
                                backgroundColor: Colors.black,
                                shape: const RoundedRectangleBorder(
                                  borderRadius:
                                      BorderRadius.all(Radius.circular(20)),
                                ),
                                minimumSize: const Size(10.0, 30.0),
                              ),
                              child: const Text(
                                "Open Video",
                                style: TextStyle(
                                  fontWeight: FontWeight.bold,
                                  fontSize: 10.0,
                                  color: Colors.white,
                                ),
                              ),
                            ),
                          ),
                        ],
                      ),
                    ),
            ),
          )
        ]),
      ),
    );
  }
}
