import 'dart:async';
import 'dart:developer';
import 'package:carousel_slider/carousel_slider.dart';
import 'package:carpeyom/config/routes/routes.dart';
import 'package:carpeyom/core/constants/index.dart';
import 'package:carpeyom/core/widgets/index.dart';
import 'package:dots_indicator/dots_indicator.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:flutter_svg/flutter_svg.dart';

import '../bloc/explorebloc/explore_home_bloc.dart';

class ExploreDashboardPage extends StatefulWidget {
  const ExploreDashboardPage({super.key});

  @override
  State<ExploreDashboardPage> createState() => _ExploreDashboardPageState();
}

class _ExploreDashboardPageState extends State<ExploreDashboardPage>
    with TextStyleMixin {
  int _index = 0;
  final List<ProductCardModel> productCards = [
    ProductCardModel(assetName: ImageConstants.finance, text: "Finance"),
    ProductCardModel(assetName: ImageConstants.insurance, text: "Insurance"),
    ProductCardModel(assetName: ImageConstants.investment, text: "Investment"),
    ProductCardModel(assetName: ImageConstants.wellNess, text: "Wellness"),
  ];

  final List<VideoCardModel> videoCards = [
    VideoCardModel(
        assetName: ImageConstants.prog1,
        text: "Program1",
        controler: ImageConstants.videoControler1),
    VideoCardModel(
        assetName: ImageConstants.prog2,
        text: "Program2",
        controler: ImageConstants.videoControler2),
    VideoCardModel(
        assetName: ImageConstants.prog3,
        text: "Program3",
        controler: ImageConstants.videoControler2),
  ];

  final items = [
    Transform.scale(
        scale: 1.1,
        child: Image.asset(
          ImageConstants.banner1,
          fit: BoxFit.fill,
        )),
    Transform.scale(
        scale: 1.1,
        child: Image.asset(ImageConstants.banner1, fit: BoxFit.fill)),
    Transform.scale(
        scale: 1.1,
        child: Image.asset(ImageConstants.banner1, fit: BoxFit.fill)),
    Transform.scale(
        scale: 1.1,
        child: Image.asset(ImageConstants.banner1, fit: BoxFit.fill)),
    Transform.scale(
        scale: 1.1,
        child: Image.asset(ImageConstants.banner1, fit: BoxFit.fill)),
  ];
  late CarouselController controller;
  int currentIndex = 0;
  //Declare a timer
  Timer? timer;
  @override
  void initState() {
    controller = CarouselController();
    startTime();
    super.initState();
  }

  Future<void> startTime() async {
    /// Initialize timer with 120 second duration
    timer = Timer(const Duration(seconds: 120), () {
      log("time Start $timer");
      context
          .read<ExploreHomeBloc>()
          .add(const ExploreHomeConfigurableEvent(isTimedOut: true));
    });
  }

  void _onItemTapped(int index) {
    setState(() {
      _index = index;
    });
    //! Major Action
    ExploreHomeBloc().onRegisterPrompt(context);
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white,
      appBar: AppBar(
        shadowColor: Colors.white,
        backgroundColor: Colors.white,
        elevation: 25.h,
        toolbarHeight: 160.w,
        title: BlocConsumer<ExploreHomeBloc, ExploreHomeState>(
          listener: (context, state) {
            if (state is ExploreHomeTimedOutState) {
              ExploreHomeBloc().showButtomSheet(context);
            }
          },
          builder: (context, state) {
            return Column(
              children: <Widget>[
                SizedBox(height: 10.h),
                Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    Align(
                        alignment: Alignment.topLeft,
                        child: Padding(
                          padding: EdgeInsets.only(top: 10.h, bottom: 10.h),
                          child: SvgPicture.asset(ImageConstants.logoIcon),
                        )),
                    Align(
                        alignment: Alignment.topRight,
                        child: InkWell(
                          onTap: () {
                            //! Major Action
                            ExploreHomeBloc().onRegisterPrompt(context);
                          },
                          child: Padding(
                            padding: EdgeInsets.only(top: 10.h, bottom: 10.h),
                            child: SvgPicture.asset(ImageConstants.bellIcon),
                          ),
                        ))
                  ],
                ),
                SizedBox(height: 10.h),
                Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    Padding(
                      padding: EdgeInsets.only(top: 10.h, bottom: 10.h),
                      child: Text(
                        "Lets get started",
                        textAlign: TextAlign.left,
                        style: appBarStyle(
                            fontSize: 22.sp, color: AppColors.black100),
                      ),
                    ),
                    Align(
                        alignment: Alignment.topRight,
                        child: Padding(
                          padding: EdgeInsets.only(top: 10.h, bottom: 10.h),
                          child: Container(
                            width: 36.w,
                            height: 36.w,
                            decoration: const BoxDecoration(
                                shape: BoxShape.circle,
                                gradient:
                                    LinearGradient(// gives the Gradient color
                                        colors: [
                                  AppColors.green100,
                                  AppColors.green70,
                                ])),
                            child: IconButton(
                              icon: const Icon(Icons.arrow_forward),
                              iconSize: 13,
                              color: Colors.white,
                              onPressed: () {
                                ExploreHomeBloc().showRegistration(context);
                              },
                            ),
                          ),
                        ))
                  ],
                ),
                Row(
                  children: [
                    Padding(
                      padding: EdgeInsets.only(bottom: 20.h),
                      child: Text(
                        "Join the platform for limitless opportunities",
                        textAlign: TextAlign.left,
                        style: appBarStyle(
                            fontSize: 14.sp,
                            fontWeight: FontWeight.w400,
                            color: AppColors.black20),
                      ),
                    ),
                  ],
                ),
              ],
            );
          },
        ),
        automaticallyImplyLeading: false,
        //centerTitle: true,
        flexibleSpace: Container(
          decoration: const BoxDecoration(
            color: Colors.white,
            borderRadius: BorderRadius.only(
                bottomLeft: Radius.circular(25),
                bottomRight: Radius.circular(25)),
          ),
        ),
      ),
      body: SingleChildScrollView(
        child: Padding(
            padding: EdgeInsets.symmetric(
              horizontal: 14.w,
            ),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                SizedBox(height: 20.h),
                Column(
                  // alignment: AlignmentDirectional.topCenter,
                  children: [
                    InkWell(
                      onTap: () {
                        //! Major Action
                        ExploreHomeBloc().onRegisterPrompt(context);
                      },
                      child: ClipRRect(
                        borderRadius: BorderRadius.circular(10.w),
                        child: CarouselSlider(
                          carouselController: controller,
                          options: CarouselOptions(
                            viewportFraction: 5,
                            //aspectRatio: 1,
                            height: 165.h,
                            autoPlay: true,

                            onPageChanged: (index, reason) {
                              setState(() {
                                currentIndex = index;
                              });
                            },
                          ),
                          items: items,
                        ),
                      ),
                    ),
                    SizedBox(height: 5.h),
                    DotsIndicator(
                      dotsCount: items.length,
                      position: currentIndex,
                      onTap: (index) {
                        controller.animateToPage(index);
                      },
                      decorator: DotsDecorator(
                        spacing: EdgeInsets.symmetric(horizontal: 2.w),
                        color: AppColors.black40,
                        activeColor: AppColors.green90,
                        size: Size.square(7.w),
                        activeSize: Size(7.w, 7.w),
                        activeShape: RoundedRectangleBorder(
                          borderRadius: BorderRadius.circular(5.w),
                        ),
                      ),
                    ),
                  ],
                ),
                Padding(
                  padding: EdgeInsets.only(bottom: 10.h),
                  child: Text(
                    "Products",
                    textAlign: TextAlign.left,
                    style: headingStyle(
                      fontSize: 15.sp,
                    ),
                  ),
                ),
                SizedBox(
                  height: 93.h,
                  child: Row(
                    children: [
                      Expanded(
                        child: ListView.separated(
                          padding: EdgeInsets.zero,
                          separatorBuilder: (BuildContext context, int index) {
                            return SizedBox(
                              width: 2.w,
                            );
                          },
                          shrinkWrap: true,
                          scrollDirection: Axis.horizontal,
                          itemCount: productCards.length,
                          itemBuilder: (BuildContext context, int index) {
                            return Padding(
                              padding: const EdgeInsets.all(2.0),
                              child: InkWell(
                                onTap: () {
                                  Navigator.pushNamed(
                                    context,
                                    Routes.exploreProductList,
                                  );
                                },
                                child: ProductCard(
                                  assetName: productCards[index].assetName,
                                  text: productCards[index].text,
                                ),
                              ),
                            );
                          },
                        ),
                      ),
                    ],
                  ),
                ),
                SizedBox(
                  height: 10.h,
                ),
                Padding(
                  padding: EdgeInsets.symmetric(vertical: 10.h),
                  child: Text(
                    "My Business",
                    textAlign: TextAlign.left,
                    style: headingStyle(
                      fontSize: 15.sp,
                    ),
                  ),
                ),
                Container(
                  height: 110.h,
                  decoration: BoxDecoration(
                    color: AppColors.green10,
                    borderRadius: BorderRadius.circular(10),
                  ),
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      Row(
                        crossAxisAlignment: CrossAxisAlignment.center,
                        children: [
                          Padding(
                            padding: EdgeInsets.all(8.w),
                            child: Image.asset(
                              ImageConstants.myBusiness,
                              height: 79.h,
                              width: 81.w,
                            ),
                          ),
                          Column(
                            mainAxisAlignment: MainAxisAlignment.center,
                            children: [
                              Padding(
                                padding:
                                    EdgeInsets.only(right: 10.w, bottom: 8.h),
                                child: Text(
                                  "Performance \nDashboard",
                                  textAlign: TextAlign.left,
                                  style: bodyStyle(
                                      fontSize: 16.sp,
                                      fontWeight: FontWeight.w600,
                                      color: AppColors.green20),
                                ),
                              ),
                              Text(
                                "Start earning now",
                                textAlign: TextAlign.left,
                                style: bodyStyle(color: AppColors.black20),
                              ),
                            ],
                          ),
                        ],
                      ),
                      Align(
                          alignment: Alignment.center,
                          child: Padding(
                            padding: EdgeInsets.only(
                                top: 10.h, bottom: 10.h, right: 25.w),
                            child: Container(
                              width: 50.w,
                              height: 50.w,
                              decoration: const BoxDecoration(
                                  shape: BoxShape.circle,
                                  gradient: LinearGradient(
                                      // gives the Gradient color
                                      colors: [
                                        AppColors.green100,
                                        AppColors.green70,
                                      ])),
                              child: IconButton(
                                icon: const Icon(Icons.arrow_forward),
                                iconSize: 20,
                                color: Colors.white,
                                onPressed: () {
                                  //! Major Action
                                  ExploreHomeBloc().onRegisterPrompt(context);
                                },
                              ),
                            ),
                          ))
                    ],
                  ),
                ),
                SizedBox(
                  height: 10.h,
                ),
                Padding(
                  padding: EdgeInsets.symmetric(vertical: 10.h),
                  child: Text(
                    "Learning and Development",
                    textAlign: TextAlign.left,
                    style: headingStyle(
                      fontSize: 15.sp,
                    ),
                  ),
                ),
                InkWell(
                  onTap: () {
                    //! Major Action
                    ExploreHomeBloc().onRegisterPrompt(context);
                  },
                  child: SizedBox(
                    height: 150.h,
                    child: Row(
                      children: [
                        Expanded(
                          child: ListView.separated(
                            padding: EdgeInsets.zero,
                            separatorBuilder:
                                (BuildContext context, int index) {
                              return SizedBox(
                                width: 2.w,
                              );
                            },
                            shrinkWrap: true,
                            scrollDirection: Axis.horizontal,
                            itemCount: videoCards.length,
                            itemBuilder: (BuildContext context, int index) {
                              return Padding(
                                padding: const EdgeInsets.all(4.0),
                                child: VideoCard(
                                    assetImage: videoCards[index].assetName,
                                    text: videoCards[index].text,
                                    controler: videoCards[index].controler),
                              );
                            },
                          ),
                        ),
                      ],
                    ),
                  ),
                ),
                SizedBox(
                  height: 10.h,
                )
              ],
            )),
      ),
      bottomNavigationBar: Container(
        decoration: BoxDecoration(
          borderRadius: BorderRadius.only(
              topRight: Radius.circular(32.w), topLeft: Radius.circular(32.w)),
          boxShadow: const [
            BoxShadow(color: Colors.black26, spreadRadius: 1, blurRadius: 5),
          ],
        ),
        child: ClipRRect(
          borderRadius: BorderRadius.only(
            topLeft: Radius.circular(30.w),
            topRight: Radius.circular(30.w),
          ),
          child: BottomNavigationBar(
            currentIndex: _index,
            onTap: _onItemTapped,
            type: BottomNavigationBarType.fixed,
            selectedFontSize: 10.sp,
            unselectedFontSize: 10.sp,
            iconSize: 21.sp,
            selectedItemColor: const Color(0xff97D700),
            unselectedItemColor: AppColors.green100,
            showUnselectedLabels: true,
            items: [
              BottomNavigationBarItem(
                icon: SvgPicture.asset(ImageConstants.bnb1),
                label: "Home",
              ),
              BottomNavigationBarItem(
                icon: SvgPicture.asset(ImageConstants.bnb2outlined),
                label: "Dashboard",
              ),
              BottomNavigationBarItem(
                icon: SvgPicture.asset(ImageConstants.bnb3outlined),
                label: "Favorites",
              ),
              BottomNavigationBarItem(
                icon: SvgPicture.asset(ImageConstants.bnb4outlined),
                label: "Payment",
              ),
              BottomNavigationBarItem(
                icon: SvgPicture.asset(ImageConstants.bnb5outlined),
                label: "Profile",
              ),
            ],
          ),
        ),
      ),
    );
  }

  @override
  void dispose() {
    super.dispose();
    timer?.cancel();
  }
}

class VideoCardModel {
  final String assetName;
  final String text;
  final String controler;
  VideoCardModel(
      {required this.assetName, required this.text, required this.controler});
}

class ProductCardModel {
  final String assetName;
  final String text;
  ProductCardModel({
    required this.assetName,
    required this.text,
  });
}
