import 'package:flutter/material.dart';
import 'package:nabeey/utils/http/http_client.dart';
import 'package:nabeey/utils/constants/api_constants.dart';
import 'package:nabeey/features/explore/models/audio_model.dart';

abstract class AudioRepository {
  @protected
  Future<List<AudioModel>> getAudios();

  Future<AudioModel?> getAudio(int audioId);

  Future<void> createAudio(AudioModel audio);

  Future<void> updateAudio(AudioModel audio);

  Future<void> deleteAudio(int audioId);
}

class AudioRepositoryImpl implements AudioRepository {
  final HttpHelper _httpClient = HttpHelper();

  AudioRepositoryImpl();

  @override
  Future<List<AudioModel>> getAudios() async {
    final response = await _httpClient.get(ADAPIs.audiosR);
    final List<dynamic> audioListJson = response['data'];
    final List<AudioModel> audios = audioListJson.map((audioJson) => AudioModel.fromJson(audioJson)).toList();
    return audios;
  }

  @override
  Future<AudioModel?> getAudio(int audioId) async {
    final response = await _httpClient.get("${ADAPIs.audioR}$audioId");
    // Handle API response (error checking, data parsing)
    return response['data'] != null ? AudioModel.fromJson(response['data']) : null;
  }

  @override
  Future<void> createAudio(AudioModel audio) async {
    // Send create Audio request to API
    await _httpClient.post(ADAPIs.audioC, audio.toJson());
  }

  @override
  Future<void> updateAudio(AudioModel audio) async {
    // Send update Audio request to API
    await _httpClient.put(ADAPIs.audioU + audio.id.toString(), audio.toJson());
  }

  @override
  Future<void> deleteAudio(int audioId) async {
    // Send delete Audio request to API
    await _httpClient.delete(ADAPIs.audioD + audioId.toString());
  }
}
