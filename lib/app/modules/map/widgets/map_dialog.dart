import 'package:flutter/material.dart';

import 'package:get/get.dart';
import 'package:school_violence_app/app/core/values/app_colors.dart';
import 'package:school_violence_app/app/core/values/app_text_style.dart';
import 'package:school_violence_app/app/global_widgets/button_custom.dart';
import 'package:school_violence_app/app/modules/intro/widgets/indicator.dart';
import 'package:school_violence_app/app/modules/map/map_controller.dart';
import 'package:school_violence_app/app/modules/map/widgets/slider_page_guide.dart';
import 'package:school_violence_app/app/modules/profile/widgets/customItem.dart';
import 'package:school_violence_app/app/routes/app_routes.dart';

class MapDialog extends StatefulWidget {
  const MapDialog({super.key});

  @override
  State<MapDialog> createState() => _MapDialogState();
}

class _MapDialogState extends State<MapDialog> {
  int _currentPage = 0;
  PageController _controller = PageController();

  List<Widget> _pages = [
    SliderPageGuide(
      title: 'STEP 1',
      description: 'Go to setting.',
      image: 'assets/images/grey-rectangle.png',
    ),
    SliderPageGuide(
      title: 'STEP 2',
      description: 'Go to setting.',
      image: 'assets/images/grey-rectangle.png',
    ),
    SliderPageGuide(
      title: 'STEP 3',
      description: 'Go to setting.',
      image: 'assets/images/grey-rectangle.png',
    ),
    SliderPageGuide(
      title: 'STEP 4',
      description: 'Go to setting.',
      image: 'assets/images/grey-rectangle.png',
    ),
    SliderPageGuide(
      title: 'STEP 5',
      description: 'Go to setting.',
      image: 'assets/images/grey-rectangle.png',
    ),
  ];

  _onChanged(int index) {
    setState(() {
      _currentPage = index;
    });
  }

  @override
  void initState() {
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Dialog(
      shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(50.0)),
      child: Container(
        constraints: const BoxConstraints(maxHeight: 440),
        child: Padding(
          padding: const EdgeInsets.symmetric(
            vertical: 20,
            horizontal: 26,
          ),
          child: Stack(
            children: <Widget>[
              PageView.builder(
                scrollDirection: Axis.horizontal,
                controller: _controller,
                itemCount: _pages.length,
                onPageChanged: _onChanged,
                itemBuilder: (context, int index) {
                  return _pages[index];
                },
              ),
              Align(
                alignment: Alignment.topRight,
                child: InkWell(
                  onTap: () {
                    Navigator.pop(context);
                  },
                  child: Icon(
                    Icons.close_rounded,
                    color: AppColors.black.withOpacity(0.2),
                    size: 32,
                  ),
                ),
              ),
              Column(
                mainAxisAlignment: MainAxisAlignment.end,
                children: [
                  Row(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: List<Widget>.generate(
                      _pages.length,
                      (int index) {
                        return AnimatedContainer(
                          duration: Duration(milliseconds: 300),
                          height: 10,
                          width: (index == _currentPage) ? 30 : 10,
                          margin: EdgeInsets.symmetric(
                            horizontal: 5,
                            vertical: 30,
                          ),
                          decoration: BoxDecoration(
                            borderRadius: BorderRadius.circular(5),
                            color: (index == _currentPage)
                                ? AppColors.primaryColor
                                : AppColors.primaryColor.withOpacity(0.5),
                          ),
                        );
                      },
                    ),
                  )
                ],
              ),
              Align(
                alignment: Alignment.bottomCenter,
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    // ButtonCustom(
                    //   widthButton: 128.0,
                    //   heightButton: 48.0,
                    //   buttonColor: AppColors.secondaryColor,
                    //   buttonShadowColor: AppColors.secondaryColorShadow,
                    //   textStyle: CustomTextStyle.button(AppColors.primaryColor),
                    //   textValue: 'Skip',
                    //   onPress: () => Navigator.pop(context),
                    // ),
                    InkWell(
                      onTap: () {
                        _controller.previousPage(
                          duration: Duration(milliseconds: 800),
                          curve: Curves.easeInOutQuint,
                        );
                      },
                      child: AnimatedContainer(
                        duration: Duration(
                          milliseconds: 300,
                        ),
                        height: 60,
                        alignment: Alignment.center,
                        width: 60,
                        decoration: BoxDecoration(
                          color: (_currentPage == 0)
                              ? AppColors.primaryColor.withOpacity(0.2)
                              : AppColors.primaryColor,
                          borderRadius: BorderRadius.circular(35),
                        ),
                        child: Icon(
                          Icons.navigate_before_rounded,
                          color: (_currentPage == 0)
                              ? AppColors.primaryColor.withOpacity(0.5)
                              : AppColors.white,
                          size: 40,
                        ),
                      ),
                    ),
                    InkWell(
                      onTap: () {
                        _controller.nextPage(
                          duration: Duration(milliseconds: 800),
                          curve: Curves.easeInOutQuint,
                        );
                      },
                      child: AnimatedContainer(
                        duration: Duration(
                          milliseconds: 300,
                        ),
                        height: 60,
                        alignment: Alignment.center,
                        width: 60,
                        decoration: BoxDecoration(
                          color: (_currentPage == (_pages.length - 1))
                              ? AppColors.primaryColor.withOpacity(0.2)
                              : AppColors.primaryColor,
                          borderRadius: BorderRadius.circular(35),
                        ),
                        child: Icon(
                          Icons.navigate_next_rounded,
                          color: (_currentPage == (_pages.length - 1))
                              ? AppColors.primaryColor.withOpacity(0.5)
                              : AppColors.white,
                          size: 40,
                        ),
                      ),
                    ),
                    // ButtonCustom(
                    //   widthButton: 128.0,
                    //   heightButton: 48.0,
                    //   buttonColor: AppColors.primaryColor,
                    //   buttonShadowColor: AppColors.primaryColorShadow,
                    //   textStyle: CustomTextStyle.button(AppColors.white),
                    //   textValue: 'Next',
                    //   onPress: () {
                    //     _controller.nextPage(
                    //       duration: Duration(milliseconds: 800),
                    //       curve: Curves.easeInOutQuint,
                    //     );
                    //   },
                    // ),
                  ],
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
