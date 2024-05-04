import '../imports.dart';

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
        future: fetchContent(type: "categories"),
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
                  CategoryItems();
                },
              ),
            );
          }
        },
      ),
    );
  }
}
