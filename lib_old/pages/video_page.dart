import '../imports.dart';

class VideoPage extends StatefulWidget {
  const VideoPage({super.key});

  @override
  State<VideoPage> createState() => _VideoPageState();
}

class _VideoPageState extends State<VideoPage> {
  @override
  void initState() {
    super.initState();
    initializeAuthors();
  }

  List<VideoData> preVideos = [];
  Future<void> initializeAuthors() async {
    await fetchContent(
      type: "videos",
      id: categoryId,
    )!
        .then((value) => preVideos = value.data);

    authors = preVideos.map((video) => video.author).toSet().toList();

    if (mounted) {
      setState(() {});
    }
  }

  @override
  Widget build(BuildContext context) {
    return getScaffold(
      child: Expanded(
        child: ListView.builder(
          itemCount: authors.length,
          itemBuilder: (context, i) {
            return Column(
              children: [
                Container(
                  margin: const EdgeInsets.only(
                    left: 20,
                    right: 14,
                  ),
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      Text(
                        authors[i],
                        style: const TextStyle(
                          overflow: TextOverflow.ellipsis,
                          fontSize: 20,
                          fontWeight: FontWeight.w700,
                        ),
                      ),
                      GestureDetector(
                        onTap: () {
                          navigate(10);
                        },
                        child: const Text(
                          "Barchasi",
                          style: TextStyle(
                            overflow: TextOverflow.ellipsis,
                            decoration: TextDecoration.underline,
                            decorationColor: Color.fromRGBO(245, 156, 22, 1),
                            decorationThickness: 1.5,
                            decorationStyle: TextDecorationStyle.solid,
                            color: Color.fromRGBO(245, 156, 22, 1),
                            fontSize: 16,
                            fontWeight: FontWeight.w500,
                          ),
                        ),
                      )
                    ],
                  ),
                ),
                Container(
                  padding: const EdgeInsets.only(
                    left: 12,
                    top: 20,
                    bottom: 20,
                  ),
                  height: 200,
                  child: FutureBuilder(
                    future: fetchFuture(
                      i,
                      preVideos: preVideos,
                    ),
                    builder: (context, snapshot) {
                      if (snapshot.connectionState == ConnectionState.waiting) {
                        return const Center(
                          child: CircularProgressIndicator(),
                        );
                      } else if (snapshot.hasError) {
                        return Center(
                          child: Text(
                            snapshot.error.toString(),
                            style: const TextStyle(
                              fontWeight: FontWeight.bold,
                            ),
                          ),
                        );
                      } else if (!snapshot.hasData) {
                        return const Text('No data available.');
                      } else {
                        final List<dynamic> videos = snapshot.data![0];
                        final List<dynamic> ytVideos = snapshot.data![1];

                        return ListView.builder(
                          itemCount: videos.length,
                          itemBuilder: (context, j) {
                            return Column(
                              crossAxisAlignment: CrossAxisAlignment.center,
                              children: [
                                GestureDetector(
                                  onTap: () {
                                    setState(() {
                                      authorId = i;
                                    });
                                    navigate(10);
                                  },
                                  child: Container(
                                    margin: const EdgeInsets.symmetric(
                                      horizontal: 8,
                                    ),
                                    height: 120,
                                    width: 100,
                                    decoration: BoxDecoration(
                                      image: DecorationImage(
                                        image: NetworkImage(
                                          ytVideos[j].image!,
                                        ),
                                        fit: BoxFit.cover,
                                      ),
                                      borderRadius: BorderRadius.circular(15),
                                    ),
                                    child: const Center(
                                      child: Icon(
                                        FontAwesome.play_circle,
                                        color: Colors.white,
                                      ),
                                    ),
                                  ),
                                ),
                                const SizedBox(
                                  height: 6,
                                ),
                                SizedBox(
                                  width: 100,
                                  child: Text(
                                    videos[j].title,
                                    style: const TextStyle(
                                      overflow: TextOverflow.ellipsis,
                                      fontSize: 12,
                                      fontWeight: FontWeight.w400,
                                    ),
                                  ),
                                ),
                                SizedBox(
                                  width: 100,
                                  child: Text(
                                    videos[j].description,
                                    style: const TextStyle(
                                      overflow: TextOverflow.ellipsis,
                                      fontSize: 10,
                                      fontWeight: FontWeight.w400,
                                    ),
                                  ),
                                ),
                              ],
                            );
                          },
                          scrollDirection: Axis.horizontal,
                        );
                      }
                    },
                  ),
                ),
                authors.length != i + 1
                    ? Container(
                        margin: const EdgeInsets.only(
                          top: 20,
                          bottom: 24,
                          left: 20,
                          right: 20,
                        ),
                        height: 1,
                        color: const Color.fromRGBO(0, 0, 0, 0.2),
                      )
                    : const SizedBox()
              ],
            );
          },
        ),
      ),
    );
  }
}

Future<List<List<dynamic>>> fetchFuture(int authorIndex,
    {List<VideoData>? preVideos}) async {
  List<VideoData> videos = [];
  List<YTVideo> ytVideos = [];
  Map<String, List<List<dynamic>>> result = {};

  if (preVideos == null) {
    await fetchContent(
      type: "videos",
      id: categoryId,
    )!
        .then((value) => videos = value.data);
  } else {
    videos = preVideos;
  }

  for (int i = 0; i < videos.length; i++) {
    if (videos[i].author == authors[authorIndex]) {
      if (!result.containsKey(videos[i].author)) {
        result[videos[i].author] = [[], []];
      }

      await videoDetails(
        videos[i].videoLink,
      ).then((value) {
        ytVideos.add(value);
        result[videos[i].author]?[0].add(videos[i]);
        result[videos[i].author]?[1].add(value);
      });
    }
  }

  return [result[authors[authorIndex]]![0], result[authors[authorIndex]]![1]];
}

Future<YTVideo> videoDetails(String url) async {
  String apiKey = ""; //Youtube api key
  try {
    final videoId = YoutubePlayer.convertUrlToId(url);
    Uri uri = Uri.parse(
        'https://www.googleapis.com/youtube/v3/videos?part=snippet&id=$videoId&key=$apiKey');
    final response = await get(uri);

    final videoDetails = jsonDecode(response.body) as Map<String, dynamic>;
    final title = videoDetails['items'][0]['snippet']['title'];
    final description = videoDetails['items'][0]['snippet']['description'];
    final thumbnailUrl =
        videoDetails['items'][0]['snippet']['thumbnails']['high']['url'];
    final viewCount = views[0];
    final date = videoDetails['items'][0]['snippet']['publishedAt']
        .toString()
        .substring(0, 10);
    YTVideo ytVideo = YTVideo(
      title: title,
      description: description,
      image: thumbnailUrl,
      views: viewCount,
      date: date,
    );
    return ytVideo;
  } catch (e) {
    throw ("Error fetching video details: $e");
  }
}
