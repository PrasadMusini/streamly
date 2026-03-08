import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:streamly_cresolinfoserv/features/videos/domain/usecases/get_videos.dart';
import 'package:streamly_cresolinfoserv/features/videos/data/models/video_model.dart';

part 'video_event.dart';
part 'video_state.dart';

class VideoBloc extends Bloc<VideoEvent, VideoState> {
  final GetVideos getVideos;

  VideoBloc(this.getVideos) : super(VideoInitial()) {
    on<FetchVideos>((event, emit) async {
      emit(VideoLoading());

      try {
        final videos = await getVideos();
        emit(VideoLoaded(videos));
      } catch (e) {
        emit(VideoError(e.toString()));
      }
    });
  }
}
