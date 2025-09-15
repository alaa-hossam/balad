import 'package:balad/home_screen/logic/cubit/news_cubit.dart';

import '../../../constants/colors.dart';
import '../../logic/cubit/country_cubit.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

class TextAndDropDown extends StatefulWidget {
  const TextAndDropDown({super.key});

  @override
  State<TextAndDropDown> createState() => _TextAndDropDownState();
}

class _TextAndDropDownState extends State<TextAndDropDown> {
  String? selectedCountry;
  List<String> allCountries = [];

  @override
  void initState() {
    super.initState();
    context.read<CountryCubit>().getAllCountriesName();
  }

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: EdgeInsets.symmetric(horizontal: 15.w),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Text(
            'Welcome to World Countries',
            style: TextStyle(
              fontSize: 22.sp,
              fontWeight: FontWeight.bold,
              color: ColorsManager.mainBlue,
            ),
          ),
          SizedBox(height: 8.h),
          Text(
            "Here we go , We can go all around the world , "
            "We'll visit every corner of this earth , "
            "You and I, we'll visit everywhere",
            style: TextStyle(fontSize: 14.sp, color: ColorsManager.gray),
          ),
          SizedBox(height: 20.h),
          BlocConsumer<CountryCubit, CountryState>(
            listener: (context, state) {
              if (state is CountriesNameLoaded) {
                allCountries = state.countries;
              }
            },
            builder: (context, state) {
              return DropdownButtonFormField<String>(
                isExpanded: true,
                decoration: InputDecoration(
                  fillColor: ColorsManager.moreLightGray,
                  border: OutlineInputBorder(
                    borderRadius: BorderRadius.circular(12.r),
                  ),
                  enabledBorder: OutlineInputBorder(
                    borderSide: const BorderSide(
                      color: ColorsManager.gray,
                      width: 1.5,
                    ),
                    borderRadius: BorderRadius.circular(12.r),
                  ),
                  focusedBorder: OutlineInputBorder(
                    borderSide: BorderSide(
                      color: ColorsManager.gray,
                      width: 1.3.w,
                    ),
                    borderRadius: BorderRadius.circular(12.r),
                  ),
                ),
                value: selectedCountry,
                hint: Text(
                  "Select a country",
                  style: TextStyle(fontSize: 14.sp),
                ),
                items: allCountries.map((country) {
                  return DropdownMenuItem(
                    value: country,
                    child: Text(country, overflow: TextOverflow.ellipsis),
                  );
                }).toList(),
                onChanged: (value) {
                  setState(() {
                    selectedCountry = value;
                  });
                  if (value != null) {
                    context.read<CountryCubit>().getCountry(value).then((country) {
                      if (country != null) {
                        context.read<NewsCubit>().fetchCountryNews(
                          country.cca2,
                        );
                      }
                    });
                  }
                },
              );
            },
          ),
        ],
      ),
    );
  }
}
