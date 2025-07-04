import 'dart:io';
import 'dart:typed_data';

import 'package:archive/archive_io.dart';
import 'package:brain_pulse/core/Theming/colors.dart';
import 'package:brain_pulse/core/Theming/text_style.dart';
import 'package:brain_pulse/core/Widgets/custom_circle_button_pop.dart';
import 'package:brain_pulse/features/data_by_doctor/presentation/screens/display_data.dart';
import 'package:brain_pulse/features/data_by_doctor/presentation/screens/save_and_create_patient.dart';
import 'package:brain_pulse/features/home/presentation/controller/cubit/prediction_file_cubit.dart';
import 'package:brain_pulse/features/home/presentation/controller/cubit/prediction_file_state.dart';
import 'package:file_picker/file_picker.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:path/path.dart' as p;

class FilePredictionBody extends StatefulWidget {
  const FilePredictionBody({super.key});

  @override
  State<FilePredictionBody> createState() => _PredictionResultScreenState();
}

class _PredictionResultScreenState extends State<FilePredictionBody> {
  File? selectedFile;

  Future<File> compressCsvFile(String csvPath) async {
    final input = File(csvPath);
    final bytes = await input.readAsBytes();

    const encoder = GZipEncoder();
    final compressedData = encoder.encode(bytes);

    final outputPath = p.setExtension(csvPath, '.gz');
    final output = File(outputPath);

    return await output.writeAsBytes(Uint8List.fromList(compressedData));
  }

  void pickFile() async {
    final result = await FilePicker.platform.pickFiles(
      allowedExtensions: ['csv'],
      type: FileType.custom,
    );

    if (result != null && result.files.single.path != null) {
      setState(() {
        selectedFile = File(result.files.single.path!);
      });
    }
  }

  void uploadFile(BuildContext context) async {
    if (selectedFile != null) {
      final compressedFile = await compressCsvFile(selectedFile!.path);
      context.read<PredictionFileCubit>().uploadEegFile(compressedFile.path);
    } else {
      ScaffoldMessenger.of(context).showSnackBar(
        const SnackBar(content: Text('Please select a file first.')),
      );
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Padding(
        padding: const EdgeInsets.all(20.0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.stretch,
          children: [
            Padding(
              padding: EdgeInsets.only(top: 50.h),
              child: Row(
                children: [
                  const CustomCircleButtonPop(),
                  SizedBox(
                    width: 80.h,
                  ),
                  Text(
                    "EEG Analysis",
                    style: TextStyleApp.font18weight600colorBlack,
                  ),
                ],
              ),
            ),
            SizedBox(height: 20.h),
            ElevatedButton.icon(
              onPressed: pickFile,
              icon: const Icon(Icons.upload_file, size: 24),
              label: Text(
                "Select EEG file (.csv)",
                style: TextStyleApp.font18weight600colorBlack
                    .copyWith(color: Colors.white),
              ),
              style: ElevatedButton.styleFrom(
                padding: EdgeInsets.symmetric(vertical: 16.h),
                backgroundColor: ColorsApp.primary,
                foregroundColor: Colors.white,
                shape: RoundedRectangleBorder(
                  borderRadius: BorderRadius.circular(12),
                ),
              ),
            ),
            SizedBox(height: 16.h),
            if (selectedFile != null)
              Text(
                "📄 Selected file: ${selectedFile!.path.split('/').last}",
                style: const TextStyle(fontSize: 16),
                textAlign: TextAlign.center,
              ),
            SizedBox(height: 20.h),
            ElevatedButton(
              onPressed: () => uploadFile(context),
              style: ElevatedButton.styleFrom(
                padding: EdgeInsets.symmetric(vertical: 16.h),
                backgroundColor: Colors.deepOrange,
                foregroundColor: Colors.white,
                shape: RoundedRectangleBorder(
                  borderRadius: BorderRadius.circular(12.r),
                ),
              ),
              child: Text(
                "Upload file and start analysis",
                style: TextStyleApp.font18weight600colorBlack
                    .copyWith(color: Colors.white),
              ),
            ),
            SizedBox(height: 30.h),
            Expanded(
              child: BlocBuilder<PredictionFileCubit, PredictionFileState>(
                builder: (context, state) {
                  if (state is LoadingPredictionFileState) {
                    return const Center(
                      child: CircularProgressIndicator(
                        color: Colors.teal,
                      ),
                    );
                  } else if (state is LoadedPredictionFileState) {
                    return Center(
                      child: Card(
                        elevation: 8,
                        shape: RoundedRectangleBorder(
                          borderRadius: BorderRadius.circular(16),
                        ),
                        color: Colors.teal.shade50,
                        child: Padding(
                          padding: const EdgeInsets.all(24.0),
                          child: Column(
                            mainAxisSize: MainAxisSize.min,
                            children: [
                              Icon(Icons.check_circle,
                                  color: ColorsApp.primary, size: 48),
                              SizedBox(height: 12.h),
                              Text(
                                "Analysis completed successfully",
                                style: TextStyle(
                                  fontSize: 20,
                                  fontWeight: FontWeight.bold,
                                  color: ColorsApp.primary,
                                ),
                              ),
                              SizedBox(height: 10.h),
                              // Text(
                              //   "Analysis result: ${state.prediction}",
                              //   style: const TextStyle(
                              //     fontSize: 20,
                              //     fontWeight: FontWeight.w500,
                              //     color: Colors.black87,
                              //   ),
                              //   textAlign: TextAlign.center,
                              // ),
                              // SizedBox(
                              //   height: 20.h,
                              // ),
                              SizedBox(
                                width: 120,
                                child: ElevatedButton(
                                  onPressed: () async {
                                    final result = await Navigator.push(context,
                                        MaterialPageRoute(builder: (_) {
                                      return DisplayData(
                                          prediction: state.prediction);
                                    }));
                                    if (result == true && context.mounted) {
                                      context
                                          .read<PredictionFileCubit>()
                                          .reset();
                                    }
                                  },
                                  style: ElevatedButton.styleFrom(
                                    padding:
                                        EdgeInsets.symmetric(vertical: 16.h),
                                    backgroundColor: ColorsApp.primary,
                                    foregroundColor: Colors.white,
                                    shape: RoundedRectangleBorder(
                                      borderRadius: BorderRadius.circular(12),
                                    ),
                                  ),
                                  child: Text(
                                    "Show Result",
                                    style: TextStyleApp
                                        .font18weight600colorBlack
                                        .copyWith(color: Colors.white),
                                  ),
                                ),
                              ),
                            ],
                          ),
                        ),
                      ),
                    );
                  } else if (state is ErrorPredictionFileState) {
                    return Center(
                      child: Text(
                        "Analysis failure: ${state.errormsg}",
                        style: const TextStyle(
                          fontSize: 16,
                          color: Colors.red,
                          fontWeight: FontWeight.bold,
                        ),
                        textAlign: TextAlign.center,
                      ),
                    );
                  } else {
                    return Center(
                      child: Text(
                        "Please select a file to start analysis",
                        style: TextStyleApp.font16weight600colorBlack,
                      ),
                    );
                  }
                },
              ),
            ),
          ],
        ),
      ),
    );
  }
}

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
//           backgroundColor: Theme
//               .of(context)
//               .scaffoldBackgroundColor,
//           body: SingleChildScrollView(
//             child: Column(
//               children: [
//                 Padding(
//                   padding: EdgeInsets.only(top: 50.h, right: 300.w),
//                   child: const CustomCircleButtonPop(),
//                 ),
//                 Padding(
//                   padding:
//                   EdgeInsets.symmetric(vertical: 50.h, horizontal: 20.w),
//                   child: DottedBorder(
//                     borderType: BorderType.RRect,
//                     radius: Radius.circular(15.r),
//                     strokeWidth: 3,
//                     dashPattern: [5, 8],
//                     color: ColorsApp.primary,
//                     child: Container(
//                       width: double.infinity,
//                       height: 500.h,
//                       decoration: BoxDecoration(
//                         color: ColorsApp.grey500,
//                         borderRadius: BorderRadius.circular(15.r),),
//                       child: _image != null
//                           ? ClipRRect(borderRadius: BorderRadius.circular(15.r),
//                         child: Image.file(_image!,
//                           fit: BoxFit.cover,
//                           width: double.infinity,
//                           height: double.infinity,),)
//                           : Column(mainAxisAlignment: MainAxisAlignment.center,
//                         children: [Image.asset("assets/images/image.png",
//                           width: 100.w, height: 100.h,
//                         ),
//                           SizedBox(height: 30.h),
//                           Text("No image selected, Drop image here",
//                             style: TextStyleApp.styleText(
//                                 15, ColorsApp.black, FontWeight.bold),),
//                           SizedBox(height: 30.h),
//                           CustomButton(
//                             onTap: uploadgallery,
//                             text: "Gallery",
//                             width: 140.w,
//                             height: 50.h,
//                             color: ColorsApp.primary,),
//                           SizedBox(height: 15.h),
//                           Text("-------      or     -------",
//                             style: TextStyleApp.styleText(
//                                 15, ColorsApp.black, FontWeight.bold),),
//                           SizedBox(height: 15.h),
//                           CustomButton(
//                             onTap: uploadcamera,
//                             text: "Camera",
//                             width: 140.w,
//                             height: 50.h,
//                             color: ColorsApp.primary,),
//                         ],
//                       ),),),
//                 ),
//                 Padding(
//                   padding:
//                   EdgeInsets.symmetric(vertical: 15.h, horizontal: 40.w),
//                   child: isLoading
//                       ? CircularProgressIndicator(
//                     color: ColorsApp.primary,
//                   )
//                       : CustomButton(
//                     text: "Show Result",
//                     width: double.infinity,
//                     color: ColorsApp.primary,
//                     height: 60.h,
//                     onTap: () {
//                       if (_image != null) {
//                         context
//                             .read<PredictionImageCubit>()
//                             .uploadImage(_image!);
//                       } else {
//                         ScaffoldMessenger.of(context).showSnackBar(
//                           const SnackBar(
//                               content:
//                               Text("Please select an image first")),
//                         );
//                       }
//                     },
//                   ),
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
