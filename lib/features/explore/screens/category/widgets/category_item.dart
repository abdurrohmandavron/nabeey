import 'package:flutter/material.dart';
import 'package:nabeey/common/widgets/images/rounded_image.dart';
import 'package:nabeey/data/models/category_model.dart';
import 'package:nabeey/features/explore/screens/content/content.dart';

class CategoryItem extends StatelessWidget {
  const CategoryItem({super.key, required this.category});

  final CategoryModel category;

  @override
  Widget build(BuildContext context) {
    return AspectRatio(
      aspectRatio: 1.5,
      child: GestureDetector(
        onTap: () => Navigator.of(context).push(MaterialPageRoute(builder: (context) => ContentScreen(category: category))),
        child: RoundedImage(
          borderRadius: 20,
          fit: BoxFit.cover,
          isNetworkImage: true,
          applyImageRadius: true,
          width: double.infinity,
          height: double.infinity,
          imageUrl: category.image.filePath,
          margin: const EdgeInsets.only(bottom: 20),
          gradient: const LinearGradient(
            begin: Alignment.bottomRight,
            colors: [
              Color.fromRGBO(0, 0, 0, 0.7),
              Color.fromRGBO(0, 0, 0, 0.5),
              Color.fromRGBO(0, 0, 0, 0.3),
              Color.fromRGBO(0, 0, 0, 0.1),
              Color.fromRGBO(0, 0, 0, 0.0),
            ],
          ),
          child: Padding(
            padding: const EdgeInsets.all(16),
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
