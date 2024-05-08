import 'package:flutter/material.dart';
import 'package:iconsax/iconsax.dart';
import 'package:nabeey/utils/constants/colors.dart';
import 'package:nabeey/utils/constants/text_strings.dart';
import 'package:nabeey/features/explore/models/category_model.dart';

class ADHeader extends StatelessWidget {
  const ADHeader({super.key, required this.category});

  final CategoryModel category;

  @override
  Widget build(BuildContext context) {
    return AspectRatio(
      aspectRatio: 1.5,
      child: Container(
        width: double.infinity,
        decoration: BoxDecoration(
          borderRadius: const BorderRadius.only(bottomLeft: Radius.circular(20), bottomRight: Radius.circular(20)),
          image: DecorationImage(image: NetworkImage(category.image.filePath), fit: BoxFit.cover),
        ),
        child: Container(
          padding: const EdgeInsets.all(20),
          decoration: const BoxDecoration(
            gradient: LinearGradient(begin: Alignment.bottomRight, colors: [Color.fromRGBO(0, 0, 0, 1), Color.fromRGBO(0, 0, 0, 0.9), Color.fromRGBO(0, 0, 0, 0.8), Color.fromRGBO(0, 0, 0, 0.1)]),
            borderRadius: BorderRadius.only(bottomLeft: Radius.circular(20), bottomRight: Radius.circular(20)),
          ),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              /// Back button
              Container(
                margin: const EdgeInsets.only(top: 16),
                child: IconButton(onPressed: () => Navigator.pop(context), icon: const Icon(Iconsax.arrow_left, color: ADColors.white)),
              ),

              /// Row
              Row(
                crossAxisAlignment: CrossAxisAlignment.end,
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  /// Texts
                  Expanded(
                    flex: 2,
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Text(category.name, style: Theme.of(context).textTheme.headlineMedium!.apply(color: ADColors.white)),
                        Text(category.description, style: Theme.of(context).textTheme.bodySmall!.apply(color: ADColors.white)),
                      ],
                    ),
                  ),

                  /// Check Knowledge Button
                  Expanded(
                    flex: 1,
                    child: ElevatedButton(
                      onPressed: () => Navigator.pushNamed(context, '/quiz'),
                      style: ElevatedButton.styleFrom(shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(50))),
                      child: Text(ADTexts.checkKnowledge, style: Theme.of(context).textTheme.bodyMedium!.apply(color: ADColors.white)),
                    ),
                  ),
                ],
              ),
            ],
          ),
        ),
      ),
    );
  }
}
