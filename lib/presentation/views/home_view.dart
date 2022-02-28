import 'package:badges/badges.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:symfonia_task/presentation/cubits/fetch_coins_cubit.dart';
import 'package:symfonia_task/presentation/shared/shared.dart';
import 'package:symfonia_task/presentation/views/globe_view.dart';
import 'package:symfonia_task/presentation/views/history_view.dart';
import 'package:symfonia_task/presentation/views/notifications_view.dart';
import 'package:symfonia_task/presentation/views/profile_view.dart';
import 'package:symfonia_task/utils/app_utils/locator.dart';

class HomeView extends StatefulWidget {
  const HomeView({Key? key}) : super(key: key);

  @override
  _HomeViewState createState() => _HomeViewState();
}

class _HomeViewState extends State<HomeView> {
  static late FetchCoinsCubit fetchCoinsCubit;
  late PageController _pageController;
  int _selectedIndex = 0;

  void jumpToPage(int page) {
    _selectedIndex = page;
    _pageController.jumpToPage(page);
    setState(() {});
  }

  @override
  void initState() {
    super.initState();
    fetchCoinsCubit = locator.get<FetchCoinsCubit>();
    fetchCoins();
    _pageController = PageController();
  }

  static fetchCoins() async {
    await fetchCoinsCubit.fetchCoins();
  }

  @override
  void dispose() {
    super.dispose();
    fetchCoinsCubit.close();
    _pageController.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return ResponsiveWidget(
        bottomNavigationBar: SizedBox(
          height: 80.h,
          child: BottomNavigationBar(
            type: BottomNavigationBarType.fixed,
            iconSize: 27.w,
            selectedFontSize: 18.sp,
            selectedLabelStyle: const TextStyle(
                fontWeight: FontWeight.w900, color: Palette.black),
            unselectedItemColor: Palette.grey,
            backgroundColor: Palette.white,
            elevation: 15,
            selectedItemColor: Palette.black,
            currentIndex: _selectedIndex,
            onTap: (int page) {
              jumpToPage(page);
            },
            items: [
              const BottomNavigationBarItem(
                icon: Icon(
                  Icons.equalizer_outlined,
                ),
                activeIcon: Icon(
                  Icons.equalizer,
                ),
                label: '.',
              ),
              const BottomNavigationBarItem(
                icon: Icon(Icons.language_outlined),
                activeIcon: Icon(Icons.language),
                label: '.',
              ),
              BottomNavigationBarItem(
                icon: Badge(
                    badgeContent: const Text(
                      '13',
                      style: TextStyle(color: Palette.white),
                    ),
                    child: const Icon(Icons.notifications_outlined)),
                activeIcon: const Icon(Icons.notifications),
                label: '.',
              ),
              const BottomNavigationBarItem(
                icon: Icon(Icons.person_outline_outlined),
                activeIcon: Icon(Icons.person),
                label: '.',
              ),
            ],
          ),
        ),
        builder: (context, size) {
          return PageView(
            physics: const NeverScrollableScrollPhysics(),
            controller: _pageController,
            children: const [
              HistoryView(),
              GlobeView(),
              NotificationsView(),
              ProfileView()
            ],
          );
        });
  }
}
