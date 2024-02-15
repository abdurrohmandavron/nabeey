import 'package:nabeey/imports.dart';

class CategoryPage extends StatefulWidget {
  const CategoryPage({super.key});
  static const String id = "home_page";

  @override
  State<CategoryPage> createState() => _CategoryPageState();
}

class _CategoryPageState extends State<CategoryPage> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text(
          'Nabeey',
          style: TextStyle(
            fontWeight: FontWeight.bold,
          ),
        ),
        elevation: 0,
      ),
      body: FutureBuilder(
        future: fetchContent(
          type: "categories",
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
                style: const TextStyle(fontWeight: FontWeight.bold),
              ),
            );
          } else if (!snapshot.hasData) {
            return const Text('No data available.');
          } else {
            final List<Category> categories = snapshot.data!.data;

            return Container(
              margin: const EdgeInsets.only(top: 20),
              padding: const EdgeInsets.symmetric(horizontal: 20),
              child: ListView.builder(
                itemCount: categories.length,
                itemBuilder: (context, i) {
                  final Category category = categories[i];
                  return AspectRatio(
                    aspectRatio: 1.4,
                    child: GestureDetector(
                      onTap: () {
                        setState(() {
                          categoryId = category.id;
                        });
                        navigate(4);
                      },
                      child: Container(
                        margin: const EdgeInsets.only(bottom: 20),
                        width: double.infinity,
                        height: double.infinity,
                        decoration: BoxDecoration(
                          borderRadius: BorderRadius.circular(20),
                          image: DecorationImage(
                            image: NetworkImage(category.image.filePath),
                            fit: BoxFit.cover,
                          ),
                        ),
                        child: Container(
                          padding: const EdgeInsets.all(16),
                          decoration: BoxDecoration(
                            borderRadius: BorderRadius.circular(20),
                            gradient: const LinearGradient(
                              begin: Alignment.bottomRight,
                              colors: [
                                Color.fromRGBO(0, 0, 0, 1),
                                Color.fromRGBO(0, 0, 0, 0.8),
                                Color.fromRGBO(0, 0, 0, 0.5),
                                Color.fromRGBO(0, 0, 0, 0.0),
                              ],
                            ),
                          ),
                          child: Column(
                            mainAxisAlignment: MainAxisAlignment.end,
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: [
                              Text(
                                category.name,
                                style: const TextStyle(
                                  color: Colors.white,
                                  fontSize: 22,
                                  fontWeight: FontWeight.w700,
                                ),
                              ),
                              Text(
                                category.description,
                                style: const TextStyle(
                                  color: Colors.white,
                                  fontSize: 13,
                                  fontWeight: FontWeight.w400,
                                ),
                              ),
                            ],
                          ),
                        ),
                      ),
                    ),
                  );
                },
              ),
            );
          }
        },
      ),
    );
  }
}

Categories categoriesFromJson(String str) =>
    Categories.fromJson(json.decode(str));

String categoriesToJson(Categories data) => json.encode(data.toJson());

class Categories {
  int statusCode;
  String message;
  List<Category> data;

  Categories({
    required this.statusCode,
    required this.message,
    required this.data,
  });

  factory Categories.fromJson(Map<String, dynamic> json) => Categories(
        statusCode: json["statusCode"],
        message: json["message"],
        data: List<Category>.from(
          json["data"].map(
            (x) => Category.fromJson(x),
          ),
        ),
      );

  Map<String, dynamic> toJson() => {
        "statusCode": statusCode,
        "message": message,
        "data": List<dynamic>.from(data.map((x) => x.toJson())),
      };
}
