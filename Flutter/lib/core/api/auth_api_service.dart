import 'package:brain_pulse/core/api/dio_factory.dart';
import 'package:dio/dio.dart';

class AuthApiService {
  final String _baseUrl = "https://manoehab-001-site1.ltempurl.com/api/";

  Future<Map<String, dynamic>> post(
      {required String endpoint, required Map<String, dynamic> data}) async {
    final dio = await DioFactory.getDio();
    var response = await dio.post("$_baseUrl$endpoint",
        data: data,
        options: Options(headers: {
          ...dio.options.headers,
          'Content-Type': 'application/json',
        }));
    return response.data;
  }

  Future<Map<String, dynamic>> put(
      {required String endpoint, required Map<String, dynamic> data}) async {
    final dio = await DioFactory.getDio();
    try {
      var response = await dio.put("$_baseUrl$endpoint",
          data: data,
          options: Options(headers: {
            ...dio.options.headers,
            'Content-Type': 'application/json',
          }));
      return response.data;
    } on DioException catch (e) {
      print('Error status: ${e.response?.statusCode}');
      print('Error data: ${e.response?.data}');
      throw e;
    }
  }

  Future<Map<String, dynamic>> editdoctor(
      {required String endpoint, required Map<String, dynamic> data}) async {
    final dio = await DioFactory.getDio();
    try {
      var response =
          await dio.put("https://manoehab-001-site1.ltempurl.com/api/$endpoint",
              data: data,
              options: Options(headers: {
                ...dio.options.headers,
                'Content-Type': 'application/json',
              }));
      if (response.statusCode == 204) {
        return {'message': 'Updated successfully'};
      }

      if (response.data is Map<String, dynamic>) {
        return response.data as Map<String, dynamic>;
      } else {
        return {'message': response.data.toString()};
      }
    } on DioException catch (e) {
      print('Error status: ${e.response?.statusCode}');
      print('Redirect Location: ${e.response?.headers.value("location")}');
      print('Error data: ${e.response?.data}');
      throw e;
    }
  }

  Future<bool> delete({required String endpoint}) async {
    try {
      final dio = await DioFactory.getDio();

      final response = await dio.delete(
        "https://manoehab-001-site1.ltempurl.com/api/$endpoint",
        options: Options(
          followRedirects: false,
          validateStatus: (status) {
            return status != null && status < 400;
          },
        ),
      );

      if (response.statusCode == 204) {
        return true;
      } else {
        throw Exception('Unexpected status code: ${response.statusCode}');
      }
    } on DioException catch (dioError) {
      throw dioError;
    }
  }

  // Future<Map<String, dynamic>> postimage(
  //     {required String endpoint, required FormData data}) async {
  //   final dio = await DioFactory.getDio();
  //   try {
  //     var response = await dio.post("$_baseUrl$endpoint",
  //         data: data,
  //         options: Options(headers: {
  //           ...dio.options.headers,
  //           'Content-Type': 'multipart/form-data',
  //         }));

  //     if (response.data is String) {
  //       try {
  //         return {"response": response.data};
  //       } catch (e) {
  //         throw Exception("Invalid JSON response: ${e.toString()}");
  //       }
  //     }

  //     return response.data;
  //   } catch (e) {
  //     throw Exception("Error during image POST request: ${e.toString()}");
  //   }
  // }
  Future<Response> postEEGFile({
    required String filePath,
  }) async {
    final dio = await DioFactory.getDio();
    const String url =
        'https://manoehab-001-site1.ltempurl.com/api/EEGPrediction/predict-gzip?isRaw=true';

    FormData formData = FormData.fromMap({
      'fileUpload': await MultipartFile.fromFile(
        filePath,
        filename: 'eeg.csv.gz',
      ),
    });

    try {
      final response = await dio.post(
        url,
        data: formData,
        options: Options(
          contentType: 'multipart/form-data',
          followRedirects: true,
          maxRedirects: 5,
          validateStatus: (status) => status != null && status < 500,
          headers: {
            'Accept': 'application/json',
          },
        ),
      );

      print('✅ statusCode: ${response.statusCode}');
      print('✅ response.data: ${response.data}');
      return response;
    } catch (e) {
      print('❌ DioException: $e');
      rethrow;
    }
  }
}
