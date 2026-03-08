import 'package:streamly_cresolinfoserv/features/videos/data/models/video_model.dart';
import 'package:streamly_cresolinfoserv/features/videos/domain/repositories/video_repository.dart';

class GetVideos {
  final VideoRepository repository;

  GetVideos(this.repository);

  Future<List<Video>> call() async {
    return await repository.getVideos();
  }
}
