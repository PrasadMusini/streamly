import 'package:dio/dio.dart';
import 'package:streamly_cresolinfoserv/core/constants/api_constants.dart';
import 'package:streamly_cresolinfoserv/features/videos/data/models/video_model.dart';

class VideoRemoteDataSource {
  final Dio dio;

  VideoRemoteDataSource(this.dio);

  Future<List<Video>> getVideos() async {
    final response = await dio.get(ApiConstants.baseUrl);

    final List data = response.data['data'];

    return data.map((e) => Video.fromJson(e)).toList();
  }
}
