import 'package:carpeyom/core/constants/index.dart';
import 'package:carpeyom/core/widgets/index.dart';
import 'package:carpeyom/features/exploreMode/presentation/bloc/explorebloc/explore_home_bloc.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:flutter_svg/flutter_svg.dart';

class ExploreProductListPage extends StatefulWidget {
  const ExploreProductListPage({super.key});

  @override
  State<ExploreProductListPage> createState() => _ExploreProductListPageState();
}

class _ExploreProductListPageState extends State<ExploreProductListPage>
    with TextStyleMixin {
  int selectedIndex1 = 0;
  int selectedIndex2 = 0;

  final List<ServiceProviderModel> serviceCards = [
    ServiceProviderModel(title: "View All"),
    ServiceProviderModel(title: "ADCB"),
    ServiceProviderModel(title: "FAB"),
    ServiceProviderModel(title: "RAK"),
    ServiceProviderModel(title: "Al Hilal Bank"),
  ];

  final List<ProductCategoriesModel> productCards = [
    ProductCategoriesModel(title: "Credit Card"),
    ProductCategoriesModel(title: "Personal Loans"),
    ProductCategoriesModel(title: "WPS"),
    ProductCategoriesModel(title: "Guarantees"),
  ];

  final List<ProductListModel> productlistCards = [
    ProductListModel(
        img: ImageConstants.card1,
        name: "FH - World Card",
        earn: "Avg. AED 200",
        content: "Create Lead"),
    ProductListModel(
        img: ImageConstants.card1,
        name: "FH - World Card",
        earn: "Avg. AED 200",
        content: "Create Lead"),
    ProductListModel(
        img: ImageConstants.card4,
        name: "FH - World Card",
        earn: "Avg. AED 200",
        content: "Create Lead"),
    ProductListModel(
        img: ImageConstants.card4,
        name: "FH - World Card",
        earn: "Avg. AED 200",
        content: "Create Lead"),
    ProductListModel(
        img: ImageConstants.card1,
        name: "FH - World Card",
        earn: "Avg. AED 200",
        content: "Create Lead"),
    ProductListModel(
        img: ImageConstants.card1,
        name: "FH - World Card",
        earn: "Avg. AED 200",
        content: "Create Lead"),
    ProductListModel(
        img: ImageConstants.card4,
        name: "FH - World Card",
        earn: "Avg. AED 200",
        content: "Create Lead"),
    ProductListModel(
        img: ImageConstants.card4,
        name: "FH - World Card",
        earn: "Avg. AED 200",
        content: "Create Lead"),
  ];

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: AppColors.red10,
      appBar: AppBar(
        systemOverlayStyle: const SystemUiOverlayStyle(
          //statusBarColor: Colors.white,
          statusBarIconBrightness: Brightness.dark,
          statusBarBrightness: Brightness.light,
        ),
        shadowColor: Colors.white,
        backgroundColor: Colors.transparent,
        toolbarHeight: 100.w,
        title: Row(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: [
            Align(
                alignment: Alignment.topLeft,
                child: Padding(
                    padding: EdgeInsets.only(top: 5.h, bottom: 5.h),
                    child: InkWell(
                        onTap: () {
                          Navigator.pop(context);
                        },
                        child: SvgPicture.asset(
                          ImageConstants.backButton,
                          height: 25.h,
                          width: 25.w,
                        )))),
            Align(
                alignment: Alignment.center,
                child: Padding(
                  padding: EdgeInsets.only(top: 10.h, bottom: 10.h),
                  child: SvgPicture.asset(ImageConstants.catTitle),
                )),
            Align(
                alignment: Alignment.topRight,
                child: Padding(
                  padding: EdgeInsets.only(top: 10.h, bottom: 10.h),
                  child: InkWell(
                      onTap: () {
                        //! Major Action
                        ExploreHomeBloc().onRegisterPrompt(context);
                      },
                      child: SvgPicture.asset(ImageConstants.search)),
                ))
          ],
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
      body: Stack(
        alignment: Alignment.bottomCenter,
        children: [
          Column(
            mainAxisAlignment: MainAxisAlignment.start,
            children: [
              SizedBox(height: 10.h),
              InkWell(
                onTap: () {
                  ExploreHomeBloc().showRegistration(context);
                },
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    Align(
                      alignment: Alignment.center,
                      child: Padding(
                        padding: EdgeInsets.only(
                            top: 10.h, bottom: 10.h, right: 10.w),
                        child: Text(
                          "Lets get started!",
                          textAlign: TextAlign.center,
                          style: bodyStyle(color: AppColors.red90),
                        ),
                      ),
                    ),
                    Padding(
                      padding: EdgeInsets.only(top: 10.h, bottom: 10.h),
                      child: SvgPicture.asset(ImageConstants.rightArrow),
                    )
                  ],
                ),
              ),
              SizedBox(height: 10.h),
              Expanded(
                child: Container(
                  alignment: Alignment.topLeft,
                  padding: EdgeInsets.all(10.h),
                  color: Colors.white,
                  child: Column(
                    mainAxisAlignment: MainAxisAlignment.start,
                    children: [
                      SizedBox(height: 10.h),
                      Padding(
                        padding: EdgeInsets.only(bottom: 10.h),
                        child: Align(
                          alignment: Alignment.topLeft,
                          child: Text(
                            "Service providers",
                            textAlign: TextAlign.left,
                            style: bodyStyle(
                                fontSize: 15.sp,
                                fontWeight: FontWeight.w600,
                                color: AppColors.black100),
                          ),
                        ),
                      ),
                      SizedBox(
                        height: 60.h,
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
                                itemCount: serviceCards.length,
                                itemBuilder: (BuildContext context, int index) {
                                  return Padding(
                                    padding: const EdgeInsets.all(2.0),
                                    child: InkWell(
                                      onTap: () {
                                        setState(() {
                                          selectedIndex1 = index;
                                        });

                                        ExploreHomeBloc()
                                            .onRegisterPrompt(context);
                                      },
                                      child: ServiceProviderCard(
                                        title: serviceCards[index].title,
                                        bgColor: selectedIndex1 == index
                                            ? const Color(0xFFE6EDE9)
                                            : AppColors.grey70,
                                        fontColor: selectedIndex1 == index
                                            ? AppColors.green100
                                            : AppColors.black40,
                                      ),
                                    ),
                                  );
                                },
                              ),
                            ),
                          ],
                        ),
                      ),
                      SizedBox(height: 20.h),
                      Padding(
                        padding: EdgeInsets.only(bottom: 10.h),
                        child: Align(
                          alignment: Alignment.topLeft,
                          child: Text(
                            "Product categories",
                            textAlign: TextAlign.left,
                            style: bodyStyle(
                                fontSize: 15.sp,
                                fontWeight: FontWeight.w600,
                                color: AppColors.black100),
                          ),
                        ),
                      ),
                      SizedBox(
                        height: 60.h,
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
                                itemCount: productCards.length,
                                itemBuilder: (BuildContext context, int index) {
                                  return Padding(
                                    padding: const EdgeInsets.all(2.0),
                                    child: InkWell(
                                      onTap: () {
                                        setState(() {
                                          selectedIndex2 = index;
                                        });
                                        //! Major Action
                                        ExploreHomeBloc()
                                            .onRegisterPrompt(context);
                                      },
                                      child: ProductCategoriesCard(
                                        title: productCards[index].title,
                                        bgColor: selectedIndex2 == index
                                            ? const Color(0xFFE6EDE9)
                                            : AppColors.grey70,
                                        fontColor: selectedIndex2 == index
                                            ? AppColors.green100
                                            : AppColors.black40,
                                      ),
                                    ),
                                  );
                                },
                              ),
                            ),
                          ],
                        ),
                      ),
                      SizedBox(height: 20.h),
                      Padding(
                        padding: EdgeInsets.only(bottom: 10.h),
                        child: Align(
                          alignment: Alignment.topLeft,
                          child: Text(
                            "Showing 8 Results",
                            textAlign: TextAlign.left,
                            style: bodyStyle(
                                fontSize: 12.sp,
                                fontWeight: FontWeight.w500,
                                color: AppColors.black20),
                          ),
                        ),
                      ),
                      Expanded(
                          child: GridView.builder(
                              gridDelegate:
                                  SliverGridDelegateWithFixedCrossAxisCount(
                                      childAspectRatio: 0.8,
                                      crossAxisCount: 2,
                                      crossAxisSpacing: 10.h,
                                      mainAxisSpacing: 10.w),
                              itemCount: productlistCards.length,
                              itemBuilder: (context, index) {
                                return InkWell(
                                  onTap: () {
                                    //! Major Action
                                    ExploreHomeBloc().onRegisterPrompt(context);
                                  },
                                  child: ProductListCard(
                                      img: productlistCards[index].img,
                                      name: productlistCards[index].name,
                                      earn: productlistCards[index].earn,
                                      content: productlistCards[index].content),
                                );
                              }))
                    ],
                  ),
                ),
              ),
            ],
          ),
          Positioned(
            bottom: 32.h,
            child: InkWell(
              onTap: () {
                //! Major Action
                ExploreHomeBloc().onRegisterPrompt(context);
              },
              child: Container(
                width: 161.w,
                height: 56.h,
                padding: EdgeInsets.all(10.w),
                alignment: Alignment.center,
                decoration: const BoxDecoration(
                  borderRadius: BorderRadius.all(Radius.circular(10.0)),
                  color: AppColors.green20,
                ),
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    Padding(
                      padding: EdgeInsets.only(right: 8.w),
                      child: SvgPicture.asset(ImageConstants.filter),
                    ),
                    Padding(
                      padding: EdgeInsets.only(right: 8.w),
                      child: Text(
                        'Filter',
                        textAlign: TextAlign.center,
                        style: bodyStyle(
                            fontSize: 12.sp,
                            fontWeight: FontWeight.w500,
                            color: Colors.white),
                      ),
                    ),
                    SizedBox(
                      height: 21.h,
                      child: VerticalDivider(
                        width: 1.w,
                        color: Colors.white,
                      ),
                    ),
                    Padding(
                      padding: EdgeInsets.only(left: 8.w, right: 8.w),
                      child: SvgPicture.asset(ImageConstants.sort),
                    ),
                    Text(
                      'Sort',
                      textAlign: TextAlign.center,
                      style: bodyStyle(
                          fontSize: 12.sp,
                          fontWeight: FontWeight.w500,
                          color: Colors.white),
                    ),
                  ],
                ),
              ),
            ),
          ),
        ],
      ),
    );
  }
}

class ServiceProviderModel {
  final String title;
  ServiceProviderModel({
    required this.title,
  });
}

class ProductCategoriesModel {
  final String title;
  ProductCategoriesModel({
    required this.title,
  });
}

class ProductListModel {
  final String img;
  final String name;
  final String earn;
  final String content;

  ProductListModel({
    required this.img,
    required this.name,
    required this.earn,
    required this.content,
  });
}
