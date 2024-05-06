import 'package:partner_3clean/app/common/util/exports.dart';
import 'package:flutter/material.dart';

import '../../../../common/util/shimmer.dart';

class LoadingPage extends StatelessWidget {
  const LoadingPage({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Container(
      // height: 48.h,
      padding: EdgeInsets.symmetric(horizontal: 16.w, vertical: 16.h).r,
      width: 343.w,
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Row(
            children: [
              customShimmer(width: 64.w, height: 64.h),
              SizedBox(width: 6.w),
              customShimmer(width: 64.w, height: 64.h),
              SizedBox(width: 6.w),
              customShimmer(width: 64.w, height: 64.h),
              SizedBox(width: 6.w),
              customShimmer(width: 64.w, height: 64.h),
            ],
          ),
          SizedBox(width: 0.0, height: 16.h),
          customShimmer(width: 58.w, height: 16.h),
          SizedBox(width: 0.0, height: 16.h),
          customShimmer(width: 343.w, height: 140.h),
          SizedBox(width: 0.0, height: 16.h),
          customShimmer(width: 343.w, height: 140.h),
        ],
      ),
    );
  }
}
