import 'package:flutter/material.dart';
import 'package:nabeey/common/widgets/images/rounded_image.dart';
import 'package:nabeey/features/explore/models/category_model.dart';
import 'package:nabeey/features/explore/screens/content/content.dart';

class CategoryItem extends StatelessWidget {
  const CategoryItem({super.key, required this.category});

  final CategoryModel category;

  @override
  Widget build(BuildContext context) {
    return AspectRatio(
      aspectRatio: 1.4,
      child: GestureDetector(
        onTap: () => Navigator.of(context).push(MaterialPageRoute(builder: (context) => ContentScreen(category: category))),
        child: RoundedImage(
          borderRadius: 20,
          fit: BoxFit.cover,
          width: double.infinity,
          height: double.infinity,
          isNetworkImage: true,
          imageUrl: category.image.filePath,
          margin: const EdgeInsets.only(bottom: 20),
          child: Container(
            padding: const EdgeInsets.all(16),

            /// Gradient
            decoration: BoxDecoration(
              borderRadius: BorderRadius.circular(20),
              gradient: const LinearGradient(
                begin: Alignment.bottomRight,
                colors: [Color.fromRGBO(0, 0, 0, 1), Color.fromRGBO(0, 0, 0, 0.8), Color.fromRGBO(0, 0, 0, 0.5), Color.fromRGBO(0, 0, 0, 0.0)],
              ),
            ),

            /// Title and Description
            child: Column(
              mainAxisAlignment: MainAxisAlignment.end,
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(category.name, style: const TextStyle(color: Colors.white, fontSize: 22, fontWeight: FontWeight.w700)),
                Text(category.description, style: const TextStyle(color: Colors.white, fontSize: 13, fontWeight: FontWeight.w400)),
              ],
            ),
          ),
        ),
      ),
    );
  }
}
