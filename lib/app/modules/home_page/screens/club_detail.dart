import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:school_violence_app/app/modules/home_page/models/app_banner.dart';
import 'package:school_violence_app/app/modules/home_page/models/school_club.dart';
import 'package:school_violence_app/app/modules/home_page/models/social_status.dart';
import 'package:school_violence_app/app/modules/home_page/widgets/image_container.dart';
import 'package:url_launcher/url_launcher.dart';

import '../../../core/values/app_colors.dart';
import '../../../core/values/app_text_style.dart';

class ClubDetailScreen extends StatefulWidget {
  const ClubDetailScreen({super.key});

  @override
  State<ClubDetailScreen> createState() => _ClubDetailScreenState();
}

class _ClubDetailScreenState extends State<ClubDetailScreen> {
  final _controllerScroll = ScrollController();
  @override
  Widget build(BuildContext context) {
    final clubDetail = ModalRoute.of(context)!.settings.arguments as SchoolClub;
    return Scaffold(
      body: Padding(
        padding: const EdgeInsets.all(16.0),
        child: SingleChildScrollView(
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              const SizedBox(height: 35),
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  Row(
                    children: [
                      InkWell(
                        onTap: () => Get.back(),
                        child: Image.asset(
                          'assets/images/left-small.png',
                          width: 28,
                        ),
                      ),
                      const SizedBox(width: 22.5),
                      Text(
                        'Clubs',
                        style: CustomTextStyle.h1(AppColors.black),
                      ),
                    ],
                  ),
                ],
              ),
              const SizedBox(height: 20),
              ClipRRect(
                borderRadius: const BorderRadius.all(
                  Radius.circular(16),
                ),
                child: Image.network(
                  clubDetail.thumbnailUrl,
                  height: 200,
                  width: double.infinity,
                  fit: BoxFit.cover,
                ),
              ),
              const SizedBox(
                height: 28,
              ),
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  CircleAvatar(
                    radius: 26,
                    backgroundColor: AppColors.primaryColor,
                    backgroundImage: NetworkImage(clubDetail.avatarUrl),
                  ),
                  const SizedBox(
                    width: 16,
                  ),
                  Flexible(
                    child: Text(
                      clubDetail.title,
                      style: TextStyle(
                        color: AppColors.black,
                        fontSize: 18,
                        fontWeight: FontWeight.w600,
                      ),
                    ),
                  ),
                ],
              ),
              const SizedBox(
                height: 16,
              ),
              Divider(
                color: AppColors.dontHaveAccount.withOpacity(0.2),
                thickness: 0.8,
              ),
              const SizedBox(
                height: 16,
              ),
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  const Text(
                    'Overview',
                    style: TextStyle(
                      fontSize: 20,
                      fontWeight: FontWeight.w600,
                    ),
                  ),
                  GestureDetector(
                    onTap: () {
                      launchUrl(Uri.parse(clubDetail.socialLink));
                    },
                    child: Row(
                      children: const [
                        Text(
                          'More',
                          style: TextStyle(
                            fontSize: 16,
                            fontWeight: FontWeight.w500,
                            color: AppColors.primaryColor,
                          ),
                        ),
                        const SizedBox(
                          width: 6,
                        ),
                        Icon(
                          Icons.arrow_forward_rounded,
                          size: 18,
                          weight: 500,
                          color: AppColors.primaryColor,
                        ),
                      ],
                    ),
                  ),
                ],
              ),
              const SizedBox(
                height: 16,
              ),
              Text(
                clubDetail.overview,
                textAlign: TextAlign.start,
                style: TextStyle(
                  color: AppColors.black.withOpacity(0.8),
                  fontSize: 16,
                  fontWeight: FontWeight.w500,
                ),
              ),
              const SizedBox(
                height: 20,
              ),
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  const Text(
                    'Social',
                    style: TextStyle(
                      fontSize: 20,
                      fontWeight: FontWeight.w600,
                    ),
                  ),
                  GestureDetector(
                    onTap: () {
                      print('Hello');
                    },
                    child: Row(
                      children: const [
                        Text(
                          'View all',
                          style: TextStyle(
                            fontSize: 16,
                            fontWeight: FontWeight.w500,
                            color: AppColors.primaryColor,
                          ),
                        ),
                        const SizedBox(
                          width: 6,
                        ),
                        Icon(
                          Icons.arrow_forward_rounded,
                          size: 18,
                          weight: 500,
                          color: AppColors.primaryColor,
                        ),
                      ],
                    ),
                  ),
                ],
              ),
              ListView.builder(
                controller: _controllerScroll,
                shrinkWrap: true,
                itemCount: socialStatusList.length,
                itemBuilder: (context, index) {
                  return InkWell(
                    onTap: () {
                      launchUrl(Uri.parse(socialStatusList[index].linkStatus));
                    },
                    child: Row(
                      children: [
                        ImageContainer(
                          width: 80,
                          height: 80,
                          margin:
                              const EdgeInsets.fromLTRB(0, 10.0, 10.0, 10.0),
                          borderRadius: 5,
                          imageUrl: socialStatusList[index].avatarUrl,
                        ),
                        Expanded(
                          child: Column(
                            crossAxisAlignment: CrossAxisAlignment.start,
                            mainAxisAlignment: MainAxisAlignment.center,
                            children: [
                              Text(
                                socialStatusList[index].title,
                                maxLines: 2,
                                overflow: TextOverflow.clip,
                                style: TextStyle(
                                  color: AppColors.black.withOpacity(0.8),
                                  fontWeight: FontWeight.w500,
                                ),
                              ),
                              const SizedBox(
                                height: 10,
                              ),
                              Row(
                                children: [
                                  const Icon(
                                    Icons.calendar_month_outlined,
                                    size: 18,
                                  ),
                                  const SizedBox(
                                    width: 5,
                                  ),
                                  Text(
                                    socialStatusList[index].time,
                                  ),
                                  const SizedBox(
                                    width: 140,
                                  ),
                                  const Icon(
                                    Icons.arrow_circle_right,
                                    size: 24,
                                    color: AppColors.primaryColor,
                                  ),
                                ],
                              )
                            ],
                          ),
                        )
                      ],
                    ),
                  );
                },
              ),
            ],
          ),
        ),
      ),
    );
  }
}
