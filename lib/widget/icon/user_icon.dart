import 'package:flutter/material.dart';
import 'package:simple_flutter/style/global_icons.dart';

class UserIcon extends StatelessWidget {
  final String imageUrl;
  final double width;
  final double height;
  final VoidCallback onPressed;

  UserIcon(
      {this.imageUrl = "",
      this.width = 30.0,
      this.height = 30.0,
      this.onPressed});

  @override
  Widget build(BuildContext context) {
    return RawMaterialButton(
        materialTapTargetSize: MaterialTapTargetSize.shrinkWrap,
        constraints: BoxConstraints(minHeight: 0.0, minWidth: 0.0),
        child: ClipOval(
          child: FadeInImage.assetNetwork(
            placeholder: GlobalIcons.DEFAULT_USER_ICON,
            image: imageUrl,
            fit: BoxFit.cover,
            width: width,
            height: height,
          ),
        ),
        onPressed: onPressed);
  }
}
