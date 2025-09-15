import 'package:balad/constants/colors.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:balad/home_screen/logic/cubit/news_cubit.dart';
import 'package:balad/home_screen/data/models/news.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

class CountryNews extends StatelessWidget {
  const CountryNews({super.key});

  @override
  Widget build(BuildContext context) {
    return BlocBuilder<NewsCubit, NewsState>(
      builder: (context, state) {
        if (state is NewsLoading) {
          return const Center(child: CircularProgressIndicator());
        } else if (state is NewsLoaded) {
          final List<News> newsList = state.news;

          if (newsList.isEmpty) {
            return const Center(child: Text("No news available"));
          }

          return Padding(
            padding: EdgeInsets.symmetric(horizontal: 15.w),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(
                  'Be Updated with City News',
                  style: TextStyle(
                    fontSize: 18.sp,
                    fontWeight: FontWeight.bold,
                    color: ColorsManager.darkBlue,
                  ),
                ),
                ListView.builder(
                  shrinkWrap: true,
                  physics: const NeverScrollableScrollPhysics(),
                  itemCount: newsList.length,
                  itemBuilder: (context, index) {
                    final newsItem = newsList[index];
                    return buildNewsItem(newsItem, context);
                  },
                ),
              ],
            ),
          );
        } else if (state is NewsError) {
          return Center(child: Text("Error: ${state.message}"));
        }

        return const SizedBox();
      },
    );
  }

  Widget buildNewsItem(News newsItem, BuildContext context) {
    return Container(
      margin: EdgeInsets.symmetric(vertical: 10.h),
      padding: EdgeInsets.symmetric(vertical: 12.h, horizontal: 12.w),
      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.circular(12.r),
        boxShadow: [
          BoxShadow(
            color: ColorsManager.gray.withOpacity(0.15),
            spreadRadius: 1,
            blurRadius: 6,
            offset: const Offset(0, 3),
          ),
        ],
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Stack(
            children: [
              ClipRRect(
                borderRadius: BorderRadius.circular(8.r),
                child: newsItem.imageUrl.isNotEmpty
                    ? FadeInImage.assetNetwork(
                        width: double.infinity,
                        height: 180.h,
                        placeholder: "assets/images/loading.gif",
                        image: newsItem.imageUrl,
                        fit: BoxFit.cover,
                      )
                    : Container(
                        height: 180.h,
                        width: double.infinity,
                        color: ColorsManager.gray,
                        child: Icon(Icons.image, size: 50.w),
                      ),
              ),
              Positioned(
                top: 10.h,
                right: 0,
                child: Container(
                  padding: const EdgeInsets.symmetric(
                    horizontal: 8,
                    vertical: 4,
                  ),
                  decoration: BoxDecoration(
                    color: ColorsManager.mainBlue,
                    borderRadius: BorderRadius.only(
                      bottomLeft: Radius.circular(6.r),
                      topLeft: Radius.circular(6.r),
                    ),
                  ),
                  child: const Text(
                    "News",
                    style: TextStyle(
                      color: Colors.white,
                      fontWeight: FontWeight.bold,
                    ),
                  ),
                ),
              ),
            ],
          ),
          SizedBox(height: 8.h),

          // publish date
          Text(
            newsItem.publishDate,
            style: TextStyle(color: ColorsManager.gray, fontSize: 12.sp),
          ),
          SizedBox(height: 6.h),

          // title
          Text(
            newsItem.title,
            style: TextStyle(fontSize: 16.sp, fontWeight: FontWeight.bold),
          ),
          SizedBox(height: 6.h),

          // summary
          Text(
            newsItem.summary,
            style: TextStyle(fontSize: 14.sp, color: ColorsManager.darkBlue),
          ),
          SizedBox(height: 10.h),

          // divider
          const Divider(thickness: 1),

          // author row
          Row(
            children: [
              Icon(Icons.person, size: 18.sp, color: ColorsManager.gray),
              SizedBox(width: 6.w),
              Text(
                newsItem.author.isNotEmpty ? newsItem.author : "Unknown",
                style: TextStyle(color: ColorsManager.darkBlue),
              ),
            ],
          ),
        ],
      ),
    );
  }
}
