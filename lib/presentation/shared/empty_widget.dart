import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:flutter_svg/svg.dart';
import 'package:symfonia_task/presentation/shared/shared.dart';

class EmptyWidget extends StatelessWidget {
  const EmptyWidget({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.center,
      mainAxisAlignment: MainAxisAlignment.center,
      children: [
        SizedBox(
          height: 200.h,
          width: 200.h,
          child: SvgPicture.asset('assets/empty.svg'),
        ),
        const CustomSpacer(
          flex: 2,
        ),
        Text(
          "Nothing to see here",
          textAlign: TextAlign.center,
          style: TextStyle(
              color: Palette.black,
              fontSize: 18.sp,
              fontWeight: FontWeight.w700),
        )
      ],
    );
  }
}
