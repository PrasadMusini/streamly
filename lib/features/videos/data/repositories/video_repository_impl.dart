import 'package:streamly_cresolinfoserv/features/videos/data/datasource/video_remote_datasource.dart';
import 'package:streamly_cresolinfoserv/features/videos/data/models/video_model.dart';
import 'package:streamly_cresolinfoserv/features/videos/domain/repositories/video_repository.dart';

class VideoRepositoryImpl implements VideoRepository {
  final VideoRemoteDataSource remoteDataSource;

  VideoRepositoryImpl(this.remoteDataSource);

  @override
  Future<List<Video>> getVideos() async {
    return await remoteDataSource.getVideos();
  }
}
