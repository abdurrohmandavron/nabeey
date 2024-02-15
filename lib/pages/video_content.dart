import 'package:nabeey/imports.dart';

class VideoContent extends StatefulWidget {
  const VideoContent({super.key});

  @override
  State<VideoContent> createState() => _VideoContentState();
}

class _VideoContentState extends State<VideoContent> {
  late YoutubePlayerController controller;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        leading: IconButton(
          onPressed: () {
            navigate('back');
          },
          icon: const Icon(
            Icons.arrow_back_ios,
          ),
        ),
        title: Text(
          "${authors[authorId]} videolari",
          style: const TextStyle(
            fontWeight: FontWeight.bold,
          ),
        ),
      ),
      body: FutureBuilder(
        future: fetchFuture(authorId),
        builder: (context, snapshot) {
          if (snapshot.connectionState == ConnectionState.waiting) {
            return const Center(
              child: CircularProgressIndicator(),
            );
          } else if (snapshot.hasError) {
            return Center(
              child: Text(
                snapshot.error.toString(),
                style: const TextStyle(fontWeight: FontWeight.bold),
              ),
            );
          } else if (!snapshot.hasData) {
            return const Text('No data available.');
          } else {
            final List<dynamic> videos = snapshot.data![0];
            final List<dynamic> ytVideos = snapshot.data![1];
            return ListView.builder(
              itemCount: videos.length,
              itemBuilder: (context, i) {
                return Container(
                  padding: const EdgeInsets.all(20),
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      ClipRRect(
                        borderRadius: BorderRadius.circular(20),
                        child: videoPlayer(url: videos[i].videoLink),
                      ),
                      Text(
                        "${ytVideos[i].date}     ${ytVideos[i].views} views",
                        style: const TextStyle(
                          fontSize: 12,
                          fontWeight: FontWeight.w400,
                          height: 3,
                        ),
                      ),
                      Text(
                        ytVideos[i].title ?? "",
                        style: const TextStyle(
                          fontSize: 18,
                          fontWeight: FontWeight.w600,
                        ),
                      ),
                    ],
                  ),
                );
              },
            );
          }
        },
      ),
    );
  }
}


Videos videosFromJson(String str) => Videos.fromJson(json.decode(str));

String videosToJson(Videos data) => json.encode(data.toJson());

class Videos {
  int statusCode;
  String message;
  List<VideoData> data;

  Videos({
    required this.statusCode,
    required this.message,
    required this.data,
  });

  factory Videos.fromJson(Map<String, dynamic> json) => Videos(
        statusCode: json["statusCode"],
        message: json["message"],
        data: List<VideoData>.from(
            json["data"].map((x) => VideoData.fromJson(x))),
      );

  Map<String, dynamic> toJson() => {
        "statusCode": statusCode,
        "message": message,
        "data": List<dynamic>.from(data.map((x) => x.toJson())),
      };
}
