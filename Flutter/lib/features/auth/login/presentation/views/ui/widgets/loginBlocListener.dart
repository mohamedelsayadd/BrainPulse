import 'package:easy_localization/easy_localization.dart';

// import 'package:docdoc/Core/Routing/routes.dart';
// import 'package:docdoc/Core/Theming/text_style.dart';
// import 'package:docdoc/Core/helpers/extentions.dart';
// import 'package:docdoc/Features/login/logic/cubit/login_cubit.dart';
// import 'package:docdoc/Features/login/logic/cubit/login_state.dart';
// import 'package:flutter/material.dart';
// import 'package:flutter_bloc/flutter_bloc.dart';
// import 'package:flutter_screenutil/flutter_screenutil.dart';

// class loginBlocListener extends StatefulWidget {
//   const loginBlocListener({super.key});

//   @override
//   State<loginBlocListener> createState() => _loginBlocListenerState();
// }
// //
// class _loginBlocListenerState extends State<loginBlocListener> {
//   @override
//   Widget build(BuildContext context) {
//     return BlocListener<LoginCubit, LoginState>(
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
//           success: (loginResponse) {
//             context.pop();
//             context.pushNamed(Routes.main);
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
