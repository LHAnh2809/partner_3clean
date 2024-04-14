import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

import '../../../../common/util/exports.dart';
import '../../../widgets/button_widget.dart';
import '../../../widgets/custom_svg.dart';

class ButtonCircleWidge extends StatelessWidget {
  final VoidCallback onTap;
  final String images;
  final String text;
  const ButtonCircleWidge(
      {Key? key, required this.onTap, required this.images, required this.text})
      : super(key: key);

  @override
  Widget build(BuildContext context) {
    return ButtonWidget(
      onTap: onTap,
      widget: SizedBox(
        width: 80.w,
        height: 75.h,
        child: Column(
          children: [
            Container(
              width: 48.w,
              height: 48.h,
              padding: const EdgeInsets.all(12).r,
              decoration: const BoxDecoration(
                shape: BoxShape.circle,
                gradient: LinearGradient(
                  begin: Alignment.topRight,
                  end: Alignment.bottomLeft,
                  colors: [
                    AppColors.kBrightPurpleColor,
                    AppColors.kDarkPurpleColor,
                  ],
                ),
              ),
              child: CustomSvg(
                image: images,
                color: AppColors.white,
              ),
            ),
            SizedBox(width: 0.0, height: 7.h),
            Text(
              text,
              style: AppTextStyle.textsmallStyle12,
            )
          ],
        ),
      ),
    );
  }
}
