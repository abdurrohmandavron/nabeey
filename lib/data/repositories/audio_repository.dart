import '../../utils/constants/api_constants.dart';
import '../../features/explore/models/audio_model.dart';

import 'base_repository.dart';

class AudioRepository extends BaseRepository<AudioModel> {
  @override
  AudioModel fromJson(Map<String, dynamic> json) => AudioModel.fromJson(json);

  @override
  AudioModel empty() => AudioModel.empty();

  Future<List<AudioModel>> getAudios() => getAll(ADAPIs.audiosR);

  Future<AudioModel> getAudio(int audioId) => getById(ADAPIs.audioR, audioId);

  Future<AudioModel> createAudio(AudioModel audio) => create(ADAPIs.audioC, audio.toJson());

  Future<AudioModel> updateAudio(int audioId, AudioModel newAudio) => update(ADAPIs.audioU, audioId, newAudio.toJson());

  Future<void> deleteAudio(int audioId) => delete(ADAPIs.audioD, audioId);
}
