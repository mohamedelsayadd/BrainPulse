import 'package:easy_localization/easy_localization.dart';

import 'package:brain_pulse/core/Theming/colors.dart';
import 'package:brain_pulse/core/Widgets/gap.dart';
import 'package:brain_pulse/core/Widgets/pop_circle_button.dart';
import 'package:brain_pulse/core/helpers/extentions.dart';
import 'package:brain_pulse/features/auth/login/presentation/controller/cubit/login_cubit.dart';
import 'package:brain_pulse/features/my_account/presentation/widgets/button.dart';
import 'package:brain_pulse/features/my_account/presentation/widgets/text_field_custom.dart';
import 'package:brain_pulse/features/privacy_and_security/presentation/controller/cubit/editdoctor/edit_doctor_cubit.dart';
import 'package:brain_pulse/features/privacy_and_security/presentation/controller/cubit/editdoctor/edit_doctor_state.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:flutter_svg/svg.dart';
import 'package:intl_phone_field/intl_phone_field.dart';
import 'package:intl_phone_field/phone_number.dart';

class EditProfileScreen extends StatefulWidget {
  const EditProfileScreen({super.key});

  @override
  State<EditProfileScreen> createState() => _EditProfileScreenState();
}

class _EditProfileScreenState extends State<EditProfileScreen> {
  String? doctorName;
  String? email;
  String? phonenum;

  @override
  void initState() {
    super.initState();
    loadDoctorName();
  }

  Future<void> loadDoctorName() async {
    final cubit = context.read<LoginCubit>();
    await cubit.loadUserDataFromPrefs();
    setState(() {
      doctorName = cubit.username;
      email = cubit.emailaddress;
      phonenum = cubit.phone;
    });
  }

  @override
  Widget build(BuildContext context) {
    var read = context.read<EditDoctorCubit>();
    return Scaffold(
      backgroundColor: Theme.of(context).scaffoldBackgroundColor,
      body: SafeArea(
        child: BlocConsumer<EditDoctorCubit, EditDoctorState>(
          listener: (context, state) {
            if (state is LoadedEditDoctorState) {
              context.read<LoginCubit>().updateUserData(
                    name: read.name.text,
                    email: read.email.text,
                    phone: read.phoneNumber.text,
                  );
              read.name.clear();
              read.email.clear();
              read.phoneNumber.clear();

              ScaffoldMessenger.of(context).showSnackBar(
                SnackBar(content: Text('Profile updated successfully'.tr())),
              );
              context.pop();
            } else if (state is FailureEditDoctorState) {
              ScaffoldMessenger.of(context).showSnackBar(
                SnackBar(content: Text(state.errormsg)),
              );
            }
          },
          builder: (context, state) {
            return SingleChildScrollView(
              child: Padding(
                padding: EdgeInsets.symmetric(horizontal: 24.w),
                child: Form(
                  key: read.editkeyform,
                  child: Column(
                    children: <Widget>[
                      AppBar(
                        title: Text('Update Profile'.tr()),
                        leading: const PopCircleButton(),
                        centerTitle: true,
                      ),
                      const GapH(height: 40),
                      Hero(
                        tag: 'edit_image'.tr(),
                        child: CircleAvatar(
                          radius: 60.r,
                          backgroundColor: Colors.white,
                          backgroundImage:
                              const AssetImage('assets/images/OO6PT80.jpeg'),
                        ),
                      ),
                      const GapH(height: 30),
                      textFieldCustom(
                        hintText: doctorName,
                        controller: read.name,
                        iconP: IconButton(
                          icon: SvgPicture.asset('assets/svgs/user.svg'),
                          onPressed: () {},
                        ),
                        validator: (value) {
                          if (value == null || value.trim().isEmpty) {
                            return 'Please Enter Name'.tr();
                          }
                          return null;
                        },
                      ),
                      const GapH(height: 20),
                      textFieldCustom(
                        hintText: email,
                        controller: read.email,
                        iconP: IconButton(
                          icon: SvgPicture.asset('assets/svgs/mail.svg'),
                          onPressed: () {},
                        ),
                        validator: (value) {
                          if (value == null || value.trim().isEmpty) {
                            return 'Please Enter Email'.tr();
                          }
                          return null;
                        },
                      ),
                      const GapH(height: 20),
                      IntlPhoneField(
                        //controller: read.phoneNumber,
                        // controller: read.phoneNumber,
                        dropdownIconPosition: IconPosition.trailing,
                        dropdownTextStyle: TextStyle(
                          color: const Color.fromARGB(255, 0, 0, 0),
                          fontSize: 16.sp,
                        ),
                        decoration: InputDecoration(
                          labelStyle: TextStyle(
                            color: Colors.grey,
                            fontSize: 16.sp,
                            fontWeight: FontWeight.w400,
                          ),
                          labelText: phonenum,
                          border: OutlineInputBorder(
                            borderRadius: BorderRadius.circular(16),
                          ),
                        ),
                        validator: (value) {
                          if (value == null || value.number.trim().isEmpty) {
                            return 'Please Enter Name'.tr();
                          }
                          return null;
                        },
                        initialCountryCode: 'EG'.tr(),
                        showCountryFlag: false,
                        keyboardType: TextInputType.number,
                        dropdownIcon: const Icon(
                          Icons.keyboard_arrow_down_outlined,
                          color: Colors.grey,
                        ),
                        onChanged: (PhoneNumber phone) {
                          read.phoneNumber.text = phone.completeNumber;
                        },
                      ),
                      const GapH(height: 150),
                      Row(
                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                        children: <Widget>[
                          SizedBox(
                            width: 160.w,
                            height: 60.h,
                            child: CustomButtonAcc(
                                color: ColorsApp.primary,
                                text: state is LoadingEditDoctorState
                                    ? 'Saving...'.tr()
                                    : 'Save'.tr(),
                                onTap: () {
                                  if (state is! LoadingEditDoctorState) {
                                    read.editDoctorvalidate(
                                      oldName: doctorName ?? '',
                                      oldEmail: email ?? '',
                                      oldPhone: phonenum ?? '',
                                    );
                                  }
                                }),
                          ),
                          SizedBox(
                            width: 160.w,
                            height: 60.h,
                            child: CustomButtonAcc(
                              color: Colors.white,
                              textColor: const Color(0xFFAAB9C5),
                              text: 'Cancel'.tr(),
                              onTap: () {
                                context.pop();
                              },
                            ),
                          ),
                        ],
                      ),
                      const GapH(height: 20),
                    ],
                  ),
                ),
              ),
            );
          },
        ),
      ),
    );
  }
}
