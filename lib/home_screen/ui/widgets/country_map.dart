import 'package:balad/constants/colors.dart';
import 'package:balad/home_screen/logic/cubit/country_cubit.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:webview_flutter/webview_flutter.dart';

class CountryMapScreen extends StatefulWidget {
  const CountryMapScreen({super.key});

  @override
  State<CountryMapScreen> createState() => _CountryMapScreenState();
}

class _CountryMapScreenState extends State<CountryMapScreen> {
  WebViewController? _controller;

  @override
  Widget build(BuildContext context) {
    return BlocBuilder<CountryCubit, CountryState>(
      builder: (context, state) {
        if (state is CountryLoaded) {
          final country = state.country;

          final openStreetMap = country.maps.firstWhere(
            (map) => map["name"] == "openStreetMaps",
            orElse: () => {},
          );

          final String mapUrl = openStreetMap["url"] ?? "";

          if (mapUrl.isEmpty) {
            return const Center(child: Text("No map available"));
          }

          _controller = WebViewController()
            ..setJavaScriptMode(JavaScriptMode.unrestricted)
            ..setBackgroundColor(const Color(0x00000000))
            ..loadRequest(Uri.parse(mapUrl));

          return Padding(
            padding: EdgeInsets.symmetric(horizontal: 15.w),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(
                  'Country Map',
                  style: TextStyle(
                    fontSize: 18.sp,
                    fontWeight: FontWeight.bold,
                    color: ColorsManager.darkBlue,
                  ),
                ),
                SizedBox(height: 12.h),
                SizedBox(
                  height: 400.h,
                  child: WebViewWidget(controller: _controller!),
                ),
                SizedBox(height: 20.h),
              ],
            ),
          );
        }

        return const SizedBox.shrink();
      },
    );
  }
}
