import 'package:balad/constants/colors.dart';
import 'package:balad/home_screen/data/repos/email_repo.dart';
import 'package:balad/home_screen/data/web_services/email_web_services.dart';
import 'package:balad/home_screen/logic/cubit/country_cubit.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

class SendEmail extends StatefulWidget {
  const SendEmail({super.key});

  @override
  State<SendEmail> createState() => _SendEmailState();
}

class _SendEmailState extends State<SendEmail> {
  final _formKey = GlobalKey<FormState>();

  final TextEditingController _nameController = TextEditingController();
  final TextEditingController _emailController = TextEditingController();
  final TextEditingController _subjectController = TextEditingController();
  final TextEditingController _messageController = TextEditingController();

  bool _isSending = false;

  late EmailRepo emailRepo;

  @override
  void initState() {
    super.initState();
    emailRepo = EmailRepo(EmailWebServices());
  }

Future<void> _sendEmail() async {
  if (_formKey.currentState!.validate()) {
    setState(() => _isSending = true);

    try {
      final success = await emailRepo.sendEmail(
        userName: _nameController.text,
        userEmail: _emailController.text,
        userSubject: _subjectController.text,
        userMessage: _messageController.text,
      );

      if (success) {
        ScaffoldMessenger.of(context).showSnackBar(
          const SnackBar(content: Text("Email sent successfully ✅")),
        );

        _formKey.currentState!.reset();
        _nameController.clear();
        _emailController.clear();
        _subjectController.clear();
        _messageController.clear();
      } else {
        ScaffoldMessenger.of(context).showSnackBar(
          const SnackBar(content: Text("Error: Email not sent ❌")),
        );
      }
    } catch (e) {
      ScaffoldMessenger.of(
        context,
      ).showSnackBar(SnackBar(content: Text("Failed: $e")));
    } finally {
      setState(() => _isSending = false);
    }
  }
}

  @override
  Widget build(BuildContext context) {
    return BlocBuilder<CountryCubit, CountryState>(
      builder: (context, state) {
        if (state is CountryLoaded) {
          return Padding(
            padding: EdgeInsets.symmetric(horizontal: 15.w),
            child: Form(
              key: _formKey,
              child: Column(
                children: [
                  Text(
                    'Get in Touch',
                    style: TextStyle(
                      fontSize: 18.sp,
                      fontWeight: FontWeight.bold,
                      color: ColorsManager.darkBlue,
                    ),
                  ),
                  SizedBox(height: 12.h),

                  /// Name
                  CustomTextField(
                    controller: _nameController,
                    label: "Name",
                    validator: (value) => value == null || value.isEmpty
                        ? "Enter your name"
                        : null,
                  ),
                  SizedBox(height: 10.h),

                  /// Email
                  CustomTextField(
                    controller: _emailController,
                    label: "Email",
                    validator: (value) {
                      if (value == null || value.isEmpty) {
                        return "Enter your email";
                      }
                      if (!RegExp(
                        r"^[\w-\.]+@([\w-]+\.)+[\w-]{2,4}$",
                      ).hasMatch(value)) {
                        return "Enter a valid email";
                      }
                      return null;
                    },
                  ),
                  SizedBox(height: 10.h),

                  /// Subject
                  CustomTextField(
                    controller: _subjectController,
                    label: "Subject",
                    validator: (value) =>
                        value == null || value.isEmpty ? "Enter subject" : null,
                  ),
                  SizedBox(height: 10.h),

                  /// Message (multiline)
                  CustomTextField(
                    controller: _messageController,
                    label: "Message",
                    maxLines: 5,
                    validator: (value) => value == null || value.isEmpty
                        ? "Enter your message"
                        : null,
                  ),
                  SizedBox(height: 15.h),

                  /// Send button
                  SizedBox(
                    width: double.infinity,
                    child: ElevatedButton(
                      style: ElevatedButton.styleFrom(
                        backgroundColor: ColorsManager.darkBlue,
                        padding: EdgeInsets.symmetric(vertical: 12.h),
                      ),
                      onPressed: _isSending ? null : _sendEmail,
                      child: _isSending
                          ? const CircularProgressIndicator(color: Colors.white)
                          : const Text(
                              "Send Message",
                              style: TextStyle(
                                color: Colors.white,
                                fontSize: 16,
                              ),
                            ),
                    ),
                  ),
                ],
              ),
            ),
          );
        }
        return const SizedBox.shrink();
      },
    );
  }
}

/// External reusable TextField widget
class CustomTextField extends StatelessWidget {
  final TextEditingController controller;
  final String label;
  final String? Function(String?)? validator;
  final int maxLines;

  const CustomTextField({
    super.key,
    required this.controller,
    required this.label,
    this.validator,
    this.maxLines = 1,
  });

  @override
  Widget build(BuildContext context) {
    return TextFormField(
      controller: controller,
      maxLines: maxLines,
      decoration: InputDecoration(
        labelText: label,
        border: const OutlineInputBorder(),
      ),
      validator: validator,
    );
  }
}
