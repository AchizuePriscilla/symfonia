import 'package:flutter/material.dart';
import 'package:symfonia_task/presentation/shared/shared.dart';
import 'package:symfonia_task/utils/extensions/size.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

class HistoryView extends StatelessWidget {
  const HistoryView({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return ResponsiveWidget(
        appBar: AppBar(
          backgroundColor: Palette.offWhite,
          elevation: 0,
          leadingWidth: context.width(.3),
          leading: Row(
            children: [
              const CustomSpacer(
                flex: 5,
                horizontal: true,
              ),
              Text(
                "History",
                style: TextStyle(
                    fontSize: 21.sp,
                    fontWeight: FontWeight.w900,
                    color: Palette.black),
              ),
            ],
          ),
          actions: [
            Row(
              children: const [
                Icon(
                  Icons.tune,
                  color: Palette.black,
                ),
                CustomSpacer(
                  flex: 2,
                  horizontal: true,
                ),
                Text(
                  "Sort/Filter",
                  style: TextStyle(
                      color: Palette.black, fontWeight: FontWeight.w600),
                ),
                CustomSpacer(
                  flex: 4,
                  horizontal: true,
                )
              ],
            )
          ],
        ),
        builder: (context, size) {
          return Container(
            padding: EdgeInsets.symmetric(horizontal: 20.w),
            child: ListView.builder(
              itemCount: 2,
              itemBuilder: ((context, index) {
                return const CoinDetails();
              }),
            ),
          );
        });
  }
}

class CoinDetails extends StatelessWidget {
  const CoinDetails({
    Key? key,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Container(
      margin: EdgeInsets.symmetric(vertical: 10.h),
      child: Row(
        crossAxisAlignment: CrossAxisAlignment.center,
        children: [
          Container(
            height: 60.h,
            width: 50.h,
            decoration: BoxDecoration(
                borderRadius: BorderRadius.circular(10), color: Palette.white),
          ),
          const CustomSpacer(
            flex: 4,
            horizontal: true,
          ),
          Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            mainAxisSize: MainAxisSize.max,
            children: [
              Text(
                'Vol:',
                style: TextStyle(
                    fontSize: 13.sp,
                    color: Palette.grey,
                    fontWeight: FontWeight.w400),
              ),
              const CustomSpacer(
                flex: 2,
              ),
              Text(
                'Bitcoin',
                style: TextStyle(
                    fontSize: 16.sp,
                    color: Palette.black,
                    fontWeight: FontWeight.w600),
              ),
              const CustomSpacer(
                flex: 2,
              ),
              Text(
                'ATH:',
                style: TextStyle(
                    fontSize: 13.sp,
                    color: Palette.grey,
                    fontWeight: FontWeight.w400),
              )
            ],
          ),
          Expanded(child: Container()),
          Text(
            '\$79',
            style: TextStyle(
                fontSize: 16.sp,
                color: Palette.red,
                fontWeight: FontWeight.w600),
          )
        ],
      ),
    );
  }
}
