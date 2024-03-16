import 'package:blue_tube/common/constants/api.dart';
import 'package:blue_tube/features/main/models/video_model.dart';
import 'package:dio/dio.dart';

class BlueTubeRepository {
  static Future<List<VideoModel>> getVideos() async {
    final response = await Dio().get(
      baseUrl,
      queryParameters: {
        'channelId': myChannel,
        'maxResults': 50,
        'key': apiKey,
        'part': 'snippet',
        'order': 'date',
      },
    );

    final dataList = response.data['items'].where(
      (item) =>
          item?['id']?['videoId'] != null && item?['snippet']?['title'] != null,
    );

    return dataList
        .map<VideoModel>(
          (item) => VideoModel(
            id: item['id']['videoId'],
            title: item['snippet']['title'],
          ),
        )
        .toList();
  }
}
