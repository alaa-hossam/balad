import 'package:balad/home_screen/ui/widgets/country_information.dart';
import 'package:balad/home_screen/ui/widgets/country_map.dart';
import 'package:balad/home_screen/ui/widgets/country_news.dart';
import 'package:balad/home_screen/ui/widgets/read_some_facts.dart';
import 'package:balad/home_screen/ui/widgets/send_email.dart';
import 'widgets/text_and_drop_down_list.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

class HomeScreen extends StatelessWidget {
  const HomeScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white,
      appBar: AppBar(
        backgroundColor: Colors.white,
        title: Image.asset('assets/images/Balad_logo.png', height: 40.h),
        centerTitle: true,
      ),
      body: SingleChildScrollView(
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            const TextAndDropDown(),
            const CountryInformation(),
            const ReadSomeFacts(),
            const CountryMapScreen(),
            const CountryNews(),
            SizedBox(height: 20.h),
            const SendEmail(),
            SizedBox(height: 150.h),
          ],
        ),
      ),
    );
  }
}
