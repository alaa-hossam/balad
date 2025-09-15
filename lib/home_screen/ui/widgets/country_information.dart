import '../../../constants/colors.dart';
import '../../logic/cubit/country_cubit.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

class CountryInformation extends StatelessWidget {
  const CountryInformation({super.key});

  Widget buildInformationItem({
    required Widget child,
    required String label,
    bool? status,
  }) {
    return Container(
      width: 250.w,
      height: 160.h,
      padding: EdgeInsets.all(12.w),
      margin: EdgeInsets.only(right: 12.w),
      decoration: BoxDecoration(
        color: ColorsManager.moreLightGray,
        borderRadius: BorderRadius.circular(12.r),
        boxShadow: [
          BoxShadow(
            color: Colors.black12,
            blurRadius: 6,
            offset: const Offset(5, 5),
          ),
        ],
        border: Border.all(width: 1.3.w, color: ColorsManager.gray),
      ),
      child: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          child,
          SizedBox(height: 8.h),
          Row(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              Text(
                label,
                style: TextStyle(
                  fontSize: 16.sp,
                  fontWeight: FontWeight.w500,
                  color: ColorsManager.darkBlue,
                ),
              ),
              if (status != null) ...[
                SizedBox(width: 4.w),
                Icon(
                  status ? Icons.check_circle : Icons.cancel,
                  color: status ? Colors.green : Colors.red,
                  size: 18.sp,
                ),
              ],
            ],
          ),
        ],
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    return BlocBuilder<CountryCubit, CountryState>(
      builder: (context, state) {
        if (state is CountryLoaded) {
          final country = state.country;

          return Padding(
            padding: EdgeInsets.symmetric(horizontal: 15.w),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(
                  'Country Information',
                  style: TextStyle(
                    fontSize: 18.sp,
                    fontWeight: FontWeight.bold,
                    color: ColorsManager.darkBlue,
                  ),
                ),
                SizedBox(height: 12.h),

                SizedBox(
                  height: 200.h,
                  child: ListView(
                    scrollDirection: Axis.horizontal,
                    children: [
                      // Flag
                      buildInformationItem(
                        child: country.flagUrl.isNotEmpty
                            ? FadeInImage.assetNetwork(
                                height: 60.h,
                                placeholder: "assets/images/loader.gif",
                                image: country.flagUrl,
                                fit: BoxFit.cover,
                              )
                            : Image.asset(
                                'assets/images/Balad_logo.png',
                                height: 60.h,
                              ),
                        label: "Flag",
                      ),

                      // Coat of Arms
                      buildInformationItem(
                        child: country.coatOfArmsUrl.isNotEmpty
                            ? FadeInImage.assetNetwork(
                                height: 60.h,
                                placeholder: "assets/images/loader.gif",
                                image: country.coatOfArmsUrl,
                                fit: BoxFit.cover,
                              )
                            : Image.asset(
                                "assets/images/Balad_logo.png",
                                height: 60.h,
                              ),
                        label: "Coat of Arms",
                      ),

                      // UN Member
                      buildInformationItem(
                        child: Image.asset(
                          "assets/images/united_nations.png",
                          height: 60.h,
                        ),
                        label: "United Nations",
                        status: country.unMember,
                      ),

                      // Independent
                      buildInformationItem(
                        child: Image.asset(
                          "assets/images/independnt.png",
                          height: 60.h,
                        ),
                        label: "Independent",
                        status: country.independent,
                      ),
                    ],
                  ),
                ),
                SizedBox(height: 20.h),
              ],
            ),
          );
        }

        // Default: show nothing until a country is selected
        return const SizedBox.shrink();
      },
    );
  }
}
