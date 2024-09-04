import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

import 'api_service.dart';
import 'color_style.dart';

class LoadingImage extends StatelessWidget {
  final String image;
  final BoxFit fit;


  const LoadingImage(
      {required this.image,
        required this.fit,
    });

  @override
  Widget build(BuildContext context) {

    return CachedNetworkImage(
      imageUrl: ApiService.imageURL + image,
      imageBuilder: (context, imageProvider) => Container(
        decoration: BoxDecoration(
          image: DecorationImage(
            image: imageProvider,
            fit: fit,
            // colorFilter: ColorFilter.mode(Colors.red, BlendMode.colorBurn)
          ),
        ),
      ),
      placeholder: (context, url) => LinearProgressIndicator(
        // value: controller.value,
        semanticsLabel: 'Linear progress indicator',
        color: AppStyles.appThemeColor.withOpacity(0.8),
        backgroundColor:AppStyles.appThemeColor.withOpacity(0.4),
      ),
      errorWidget: (context, url, error) => Icon(Icons.error,color:AppStyles.appThemeColor ,),
    );
  }
}

class ProfileImage extends StatelessWidget {
  final String image;
  final BoxFit fit;


  const ProfileImage(
      {required this.image,
        required this.fit,
    });

  @override
  Widget build(BuildContext context) {

    return CachedNetworkImage(
      imageUrl: ApiService.imageURL+image,
      imageBuilder: (context, imageProvider) => Container(
        decoration: BoxDecoration(
          image: DecorationImage(
            image: imageProvider,
            fit: fit,
            // colorFilter: ColorFilter.mode(Colors.red, BlendMode.colorBurn)
          ),
        ),
      ),
      placeholder: (context, url) => LinearProgressIndicator(
        // value: controller.value,
        semanticsLabel: 'Linear progress indicator',
        color: AppStyles.appThemeColor.withOpacity(0.8),
        backgroundColor:AppStyles.appThemeColor.withOpacity(0.4),
      ),
      errorWidget: (context, url, error) =>
          Container(
            padding: EdgeInsets.all(20),
              decoration: BoxDecoration(
                  border: Border.all(
                      color: AppStyles.appThemeColor, width: 2),
                  shape: BoxShape.circle),
              child: Image.asset("assets/icons/ProfileIcon.png")
          ),
    );
  }
}