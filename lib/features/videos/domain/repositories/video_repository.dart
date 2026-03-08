import 'package:streamly_cresolinfoserv/features/videos/data/models/video_model.dart';

abstract class VideoRepository {
  Future<List<Video>> getVideos();
}
