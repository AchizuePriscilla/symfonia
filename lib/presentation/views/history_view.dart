import 'dart:developer';

import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:symfonia_task/models/coin_model.dart';
import 'package:symfonia_task/presentation/shared/shared.dart';
import 'package:symfonia_task/utils/app_utils/locator.dart';
import 'package:symfonia_task/utils/extensions/size.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

import '../cubits/fetch_coins_cubit.dart';

class HistoryView extends StatefulWidget {
  const HistoryView({Key? key}) : super(key: key);

  @override
  State<HistoryView> createState() => _HistoryViewState();
}

class _HistoryViewState extends State<HistoryView> {

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
          return BlocProvider(
            create: (context) => locator.get<FetchCoinsCubit>(),
            child: Container(
              padding: EdgeInsets.symmetric(horizontal: 20.w),
              child: SizedBox(
                child: BlocBuilder<FetchCoinsCubit, FetchCoinsState>(
                  builder: (context, state) {
                    if (state is FetchCoinsLoading) {
                      return const Center(child: CircularProgressIndicator());
                    }
                    if (state is FetchCoinsLoaded) {
                      var coinModel = state.coinModelList;
                      return ListView.builder(
                        itemCount: coinModel.length,
                        itemBuilder: ((context, index) {
                          return CoinDetails(
                            coinModel: coinModel[index],
                          );
                        }),
                      );
                    }

                    if (state is FetchCoinsError) {
                      log(state.message);
                      return Center(
                        child: Text(
                          "Sorry something went wrong, please try again",
                          textAlign: TextAlign.center,
                          style: TextStyle(
                              color: Palette.black, fontSize: 16.sp),
                        ),
                      );
                    }
                    return Center(
                        child: Container(
                      color: Colors.red,
                    ));
                  },
                ),
              ),
            ),
          );
        });
  }
}

class CoinDetails extends StatelessWidget {
  final CoinModel coinModel;
  const CoinDetails({
    required this.coinModel,
    Key? key,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    String priceChange24HR = coinModel.priceChange24H!.toString();
    String formatted24HRPriceChange =
        double.parse(priceChange24HR).toStringAsFixed(2).substring(1);
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
            child: Padding(
              padding: const EdgeInsets.all(18.0),
              child: Image.network(coinModel.image!),
            ),
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
              const CustomSpacer(
                flex: 1,
              ),
              Text(
                'Vol: ${coinModel.totalVolume}',
                style: TextStyle(
                    fontSize: 13.sp,
                    color: Palette.grey,
                    fontWeight: FontWeight.w400),
              ),
              const CustomSpacer(
                flex: 2,
              ),
              Text(
                coinModel.name!,
                style: TextStyle(
                    fontSize: 16.sp,
                    color: Palette.black,
                    fontWeight: FontWeight.w600),
              ),
              const CustomSpacer(
                flex: 2,
              ),
              Text(
                'Price: \$${coinModel.currentPrice}',
                style: TextStyle(
                    fontSize: 13.sp,
                    color: Palette.grey,
                    fontWeight: FontWeight.w400),
              ),
              const CustomSpacer(
                flex: 1,
              ),
            ],
          ),
          Expanded(child: Container()),
          Text(
            coinModel.priceChange24H!.isNegative
                ? '-\$$formatted24HRPriceChange'
                : '+\$${double.parse(priceChange24HR).toStringAsFixed(2)}',
            style: TextStyle(
                fontSize: 16.sp,
                color: coinModel.priceChange24H!.isNegative
                    ? Palette.red
                    : Palette.green,
                fontWeight: FontWeight.w600),
          )
        ],
      ),
    );
  }
}
