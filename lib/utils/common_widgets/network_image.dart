
// import 'package:flutter/cupertino.dart';
// import 'package:ping_app/utils/WebService/api_config.dart';
// import 'package:ping_app/utils/constants/asset_constant/asset_constant.dart';
// import 'package:ping_app/utils/widgetConstant/asset_image_constant/asset_image_constant.dart';
// import 'package:cached_network_image/cached_network_image.dart';

// Widget getWidgetForImageWith(
//     {required String? url,
//     double? width,
//     double? height,
//     BoxFit? fit,
//     bool? appendBaseUrl}) {
//   return (url?.isEmpty ?? true)
//       ? ImageFromAssetPath<Widget>(
//           assetPath: productsIcon,
//           width: width ?? 100,
//           height: height ?? 100,
//           fit: fit,
//         ).imageWidget
//       : CachedNetworkImage(
//           width: width ?? 100,
//           height: height ?? 100,
//           imageUrl: appendBaseUrl == true
//               ? (APIConfig.baseUrl + (((url ?? "")).characters.first == "/" ? (url ?? "").substring(1) : (url ?? "")))
//               : url ?? "",
//           fit: fit,
//           errorWidget: (one, two, three) {
//             return ImageFromAssetPath<Widget>(
//               assetPath: productsIcon,
//               width: width ?? 100,
//               height: height ?? 100,
//               fit: fit,
//             ).imageWidget;
//           },
//         );
// }
