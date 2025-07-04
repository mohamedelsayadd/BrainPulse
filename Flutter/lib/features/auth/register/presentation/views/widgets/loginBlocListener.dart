import 'package:easy_localization/easy_localization.dart';

// import 'package:docdoc/Core/Routing/routes.dart';
// import 'package:docdoc/Core/Theming/text_style.dart';
// import 'package:docdoc/Core/helpers/extentions.dart';
// import 'package:docdoc/Features/register/logic/cubit/register_cubit.dart';
// import 'package:docdoc/Features/register/logic/cubit/register_state.dart';
// import 'package:flutter/material.dart';
// import 'package:flutter_bloc/flutter_bloc.dart';
// import 'package:flutter_screenutil/flutter_screenutil.dart';

// class registerBlocListener extends StatefulWidget {
//   const registerBlocListener({super.key});

//   @override
//   State<registerBlocListener> createState() => _registerBlocListenerState();
// }

// class _registerBlocListenerState extends State<registerBlocListener> {
//   @override
//   Widget build(BuildContext context) {
//     return BlocListener<RegisterCubit, RegisterState>(
//       listenWhen: (previous, current) =>
//           current is Loading || current is Success || current is Error,
//       listener: (context, state) {
//         state.whenOrNull(
//           loading: () {
//             showDialog(
//               context: context,
//               builder: (context) => const Center(
//                 child: CircularProgressIndicator(
//                   color: Colors.blue,
//                 ),
//               ),
//             );
//           },
//           success: (RegisterResponse) {
//             context.pop();
//             showSuccessDialog(context);
//           },
//           error: (error) {
//             setupErrorState(context, error);
//             print('Error: $error');
//           },
//         );
//       },
//       child: const SizedBox.shrink(),
//     );
//   }

//   void showSuccessDialog(BuildContext context) {
//     showDialog(
//       context: context,
//       builder: (BuildContext context) {
//         return AlertDialog(
//           title: const Text('Signup Successful'.tr()),
//           content: const SingleChildScrollView(
//             child: ListBody(
//               children: <Widget>[
//                 Text('Congratulations, you have signed up successfully!'.tr()),
//               ],
//             ),
//           ),
//           actions: <Widget>[
//             TextButton(
//               style: TextButton.styleFrom(
//                 foregroundColor: Colors.white,
//                 backgroundColor: Colors.blue,
//                 disabledForegroundColor: Colors.grey.withOpacity(0.38),
//               ),
//               onPressed: () {
//                 context.pushNamed(Routes.login);
//               },
//               child: const Text('Continue'.tr()),
//             ),
//           ],
//         );
//       },
//     );
//   }

//   void setupErrorState(BuildContext context, String error) {
//     context.pop();
//     showDialog(
//       context: context,
//       builder: (context) => AlertDialog(
//         icon: Icon(
//           Icons.error,
//           color: Colors.red,
//           size: 32.sp,
//         ),
//         content: Text(
//           error,
//           style: TextStyleApp.font22weight400colorRed,
//         ),
//         actions: [
//           TextButton(
//             onPressed: () {
//               context.pop();
//             },
//             child: Text(
//               'Got it'.tr(),
//               style: TextStyleApp.font14weight400colorGrey,
//             ),
//           ),
//         ],
//       ),
//     );
//   }
// }
