import '../../../constants/colors.dart';
import '../../logic/cubit/country_cubit.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

class ReadSomeFacts extends StatelessWidget {
  const ReadSomeFacts({super.key});

  Widget buildFactItem({
    required IconData icon,
    required String value,
    required String label,
  }) {
    return Column(
      mainAxisAlignment: MainAxisAlignment.center,
      children: [
        CircleAvatar(
          radius: 28.r,
          backgroundColor: Colors.transparent,
          child: Icon(icon, size: 30.sp, color: Colors.amber),
        ),
        SizedBox(height: 8.h),
        Text(
          value,
          style: TextStyle(
            fontSize: 15.sp,
            fontWeight: FontWeight.bold,
            color: Colors.white,
          ),
        ),
        SizedBox(height: 4.h),
        Text(
          label,
          style: TextStyle(
            fontSize: 12.sp,
            fontWeight: FontWeight.w400,
            color: Colors.white70,
          ),
        ),
      ],
    );
  }

  @override
  Widget build(BuildContext context) {
    return BlocBuilder<CountryCubit, CountryState>(
      builder: (context, state) {
        if (state is CountryLoaded) {
          final country = state.country;

          return Container(
            width: double.infinity,
            padding: EdgeInsets.symmetric(vertical: 20.h, horizontal: 16.w),
            margin: EdgeInsets.only(bottom: 20.h),
            decoration: BoxDecoration(
              image: DecorationImage(
                image: AssetImage("assets/images/facts.jpg"),
                fit: BoxFit.cover,
              ),
            ),
            child: Column(
              children: [
                Text(
                  "Read Some Facts",
                  style: TextStyle(
                    fontSize: 20.sp,
                    fontWeight: FontWeight.bold,
                    color: Colors.white,
                  ),
                ),
                SizedBox(height: 20.h),
                SizedBox(
                  height: 140.h,
                  child: ListView(
                    scrollDirection: Axis.horizontal,
                    children: [
                      buildFactItem(
                        icon: Icons.people,
                        value: country.population.toString(),
                        label: "Population",
                      ),
                      SizedBox(width: 5.w),
                      VerticalDivider(
                        color: ColorsManager.gray,
                        thickness: 1.3.w,
                      ),
                      buildFactItem(
                        icon: Icons.map,
                        value: country.region,
                        label: "Region",
                      ),
                      SizedBox(width: 5.w),
                      VerticalDivider(
                        color: ColorsManager.gray,
                        thickness: 1.3.w,
                      ),
                      buildFactItem(
                        icon: Icons.calendar_today,
                        value: country.startOfWeek,
                        label: "Start Of Week",
                      ),
                      SizedBox(width: 5.w),
                      VerticalDivider(
                        color: ColorsManager.gray,
                        thickness: 1.3.w,
                      ),
                      buildFactItem(
                        icon: Icons.access_time,
                        value: country.timezone.isNotEmpty
                            ? country.timezone
                            : "N/A",
                        label: "Time zone",
                      ),
                      SizedBox(width: 5.w),
                      VerticalDivider(
                        color: ColorsManager.gray,
                        thickness: 1.3.w,
                      ),
                      buildFactItem(
                        icon: Icons.home,
                        value: country.capital.isNotEmpty
                            ? country.capital
                            : "N/A",
                        label: "Capital",
                      ),
                    ],
                  ),
                ),
              ],
            ),
          );
        }

        return const SizedBox.shrink();
      },
    );
  }
}
