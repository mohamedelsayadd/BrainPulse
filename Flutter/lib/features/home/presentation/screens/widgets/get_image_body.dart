// import 'package:easy_localization/easy_localization.dart';

// import 'dart:io';
// import 'package:brain_pulse/core/Theming/colors.dart';
// import 'package:brain_pulse/core/Theming/text_style.dart';
// import 'package:brain_pulse/core/Widgets/custom_circle_button_pop.dart';
// import 'package:brain_pulse/core/routing/routers.dart';
// import 'package:brain_pulse/features/data_by_doctor/presentation/screens/display_data.dart';
// import 'package:brain_pulse/features/home/presentation/screens/widgets/custom_button.dart';
// import 'package:dotted_border/dotted_border.dart';
// import 'package:flutter/material.dart';
// import 'package:flutter_bloc/flutter_bloc.dart';
// import 'package:flutter_screenutil/flutter_screenutil.dart';
// import 'package:image_picker/image_picker.dart';

// class GetImageBody extends StatefulWidget {
//   const GetImageBody({super.key});

//   @override
//   State<GetImageBody> createState() => _GetImageBodyState();
// }

// class _GetImageBodyState extends State<GetImageBody> {
//   File? _image;

//   @override
//   Widget build(BuildContext context) {
//     return BlocConsumer<PredictionImageCubit, PredictionImageState>(
//       listener: (context, state) {
//         if (state is LoadedPredictionImageState) {
//           Navigator.push(context, MaterialPageRoute(
//             builder: (context) {
//               return DisplayData(prediction: [
//                 state.gpd,
//                 state.grda,
//                 state.lpd,
//                 state.lrda,
//                 state.seizure,
//                 state.other,
//               ]);
//             },
//           ));
//           // Navigator.pushNamed(context, Routes.eegdata);
//         } else if (state is ErrorPredictionImageState) {
//           ScaffoldMessenger.of(context).showSnackBar(
//             SnackBar(content: Text(state.errormsg)),
//           );
//         }
//       },
//       builder: (context, state) {
//         bool isLoading = state is LoadingPredictionImageState;

//         return Scaffold(
//           backgroundColor: Theme.of(context).scaffoldBackgroundColor,
//           body: SingleChildScrollView(
//             child: Column(
//               children: [
//                 Padding(
//                   padding: EdgeInsets.only(top: 50.h, right: 300.w),
//                   child: const CustomCircleButtonPop(),
//                 ),
//                 Padding(
//                   padding:
//                       EdgeInsets.symmetric(vertical: 50.h, horizontal: 20.w),
//                   child: DottedBorder(
//                     borderType: BorderType.RRect,
//                     radius: Radius.circular(15.r),
//                     strokeWidth: 3,
//                     dashPattern: const [5, 8],
//                     color: ColorsApp.primary,
//                     child: Container(
//                       width: double.infinity,
//                       height: 500.h,
//                       decoration: BoxDecoration(
//                         color: ColorsApp.grey500,
//                         borderRadius: BorderRadius.circular(15.r),
//                       ),
//                       child: _image != null
//                           ? ClipRRect(
//                               borderRadius: BorderRadius.circular(15.r),
//                               child: Image.file(
//                                 _image!,
//                                 fit: BoxFit.cover,
//                                 width: double.infinity,
//                                 height: double.infinity,
//                               ),
//                             )
//                           : Column(
//                               mainAxisAlignment: MainAxisAlignment.center,
//                               children: [
//                                 Image.asset(
//                                   "assets/images/image.png",
//                                   width: 100.w,
//                                   height: 100.h,
//                                 ),
//                                 SizedBox(height: 30.h),
//                                 Text(
//                                   'No image selected, Drop image here'.tr(),
//                                   style: TextStyleApp.styleText(
//                                       15, ColorsApp.black, FontWeight.bold),
//                                 ),
//                                 SizedBox(height: 30.h),
//                                 CustomButton(
//                                   onTap: uploadgallery,
//                                   text: 'Gallery'.tr(),
//                                   width: 140.w,
//                                   height: 50.h,
//                                   color: ColorsApp.primary,
//                                 ),
//                                 SizedBox(height: 15.h),
//                                 Text(
//                                   '-------      or     -------'.tr(),
//                                   style: TextStyleApp.styleText(
//                                       15, ColorsApp.black, FontWeight.bold),
//                                 ),
//                                 SizedBox(height: 15.h),
//                                 CustomButton(
//                                   onTap: uploadcamera,
//                                   text: 'Camera'.tr(),
//                                   width: 140.w,
//                                   height: 50.h,
//                                   color: ColorsApp.primary,
//                                 ),
//                               ],
//                             ),
//                     ),
//                   ),
//                 ),
//                 Padding(
//                   padding:
//                       EdgeInsets.symmetric(vertical: 15.h, horizontal: 40.w),
//                   child: isLoading
//                       ? CircularProgressIndicator(
//                           color: ColorsApp.primary,
//                         )
//                       : CustomButton(
//                           text: 'Show Result'.tr(),
//                           width: double.infinity,
//                           color: ColorsApp.primary,
//                           height: 60.h,
//                           onTap: () {
//                             if (_image != null) {
//                               context
//                                   .read<PredictionImageCubit>()
//                                   .uploadImage(_image!);
//                             } else {
//                               ScaffoldMessenger.of(context).showSnackBar(
//                                 SnackBar(
//                                     content: Text(
//                                         'Please select an image first'.tr())),
//                               );
//                             }
//                           },
//                         ),
//                 ),
//               ],
//             ),
//           ),
//         );
//       },
//     );
//   }

//   void uploadcamera() async {
//     final ImagePicker picker = ImagePicker();
//     var image = await picker.pickImage(source: ImageSource.camera);
//     setState(() {
//       _image = File(image!.path);
//     });
//   }

//   void uploadgallery() async {
//     final ImagePicker picker = ImagePicker();
//     var image = await picker.pickImage(source: ImageSource.gallery);
//     setState(() {
//       _image = File(image!.path);
//     });
//   }
// }
