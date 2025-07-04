import 'package:brain_pulse/core/api/auth_api_service.dart';
import 'package:brain_pulse/core/api/failure.dart';
import 'package:brain_pulse/features/home/data/model/file_predict_model.dart';
import 'package:brain_pulse/features/home/data/repo/predict_file_repo.dart';
import 'package:dartz/dartz.dart';
import 'package:dio/dio.dart';

class PredictFileRepoImple implements PredictFileRepo {
  final AuthApiService authApiService;
  PredictFileRepoImple({required this.authApiService});

  @override
  Future<Either<Failure, FilePredictModel>> uploadEegFile(
      String filePath) async {
    try {
      final response = await authApiService.postEEGFile(filePath: filePath);
      print('📦 response in repo: ${response.data}');
      return right(FilePredictModel.fromJson(response.data));
    } on DioException catch (e) {
      print('❌ caught DioException in repo: $e');

      final failure = ServerFailure.fromDioException(e);

      return left(failure);
    }
  }
}


  // Future<Either<String, ImagePredictionModel>> postimage({
  //   required File image,
  // }) async {
  //   try {
  //     final formData = FormData.fromMap({
  //       'imageFile': await MultipartFile.fromFile(image.path),
  //     });
  //     final result = await authApiService.postimage(
  //       endpoint: 'Inference/predictImage',
  //       data: formData,
  //     );
  //     // Check if the response is empty or invalid
  //     if (result == null || result.isEmpty) {
  //       return left("Empty or invalid response from API.");
  //     }
  //     // Attempt to parse the response into a JSON object
  //     try {
  //       // Assuming the response should be a JSON, if not, log the raw response
  //       print("Raw API Response: $result");
  //       return right(ImagePredictionModel.fromJson(result));
  //     } catch (e) {
  //       return left("Failed to parse response: ${e.toString()}");
  //     }
  //   } catch (e) { return left("Error occurred while uploading image: ${e.toString()}"); }
  // }}

