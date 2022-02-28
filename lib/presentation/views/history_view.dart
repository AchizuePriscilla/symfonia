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
  final FetchCoinsCubit _fetchCoinsCubit = locator.get<FetchCoinsCubit>();
  @override
  void initState() {
    WidgetsFlutterBinding.ensureInitialized();
    super.initState();
    fetchCoins();
  }

  fetchCoins() async {
    await _fetchCoinsCubit.fetchCoins();
  }

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
              child: BlocBuilder<FetchCoinsCubit, FetchCoinsState>(
                builder: (context, state) {
                  if (state is FetchCoinsLoading) {
                    return const Center(child: CircularProgressIndicator());
                  }
                  if (state is FetchCoinsLoaded) {
                    var coinModel = state.coinModelList;
                    log("Coin model: $coinModel");
                    return ListView.builder(
                      itemCount: 2,
                      itemBuilder: ((context, index) {
                        log("Id: ${coinModel[index].id!}");
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
                        style: TextStyle(color: Palette.black, fontSize: 16.sp),
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
                coinModel.id!,
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
            '\$',
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
