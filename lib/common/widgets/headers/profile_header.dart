import 'package:flutter/material.dart';
import 'package:nabeey/data/models/user_model.dart';

import '../../../utils/constants/colors.dart';
import '../images/rounded_image.dart';
import '../icons/circular_icon.dart';

class ProfileHeader extends StatelessWidget {
  const ProfileHeader({super.key, required this.user});

  final UserModel user;

  @override
  Widget build(BuildContext context) {
    return AspectRatio(
      aspectRatio: 1.5,
      child: RoundedImage(
        borderRadius: 20,
        fit: BoxFit.cover,
        isNetworkImage: user.asset != null ? true : false,
        applyImageRadius: true,
        width: double.infinity,
        height: double.infinity,
        imageUrl: user.asset != null
            ? user.asset!.filePath
            : "assets/images/placeholders/profile_placeholder.jpg",
        padding: const EdgeInsets.all(20),
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
        child: Row(
          crossAxisAlignment: CrossAxisAlignment.end,
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: [
            /// Texts
            Expanded(
              flex: 2,
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                mainAxisAlignment: MainAxisAlignment.end,
                children: [
                  Text(
                    "${user.firstName} ${user.lastName}",
                    style: Theme.of(context)
                        .textTheme
                        .headlineLarge!
                        .apply(color: ADColors.white),
                  ),
                  Text(
                    "Profil",
                    style: Theme.of(context)
                        .textTheme
                        .bodyMedium!
                        .apply(color: ADColors.white),
                  ),
                ],
              ),
            ),

            /// Photo upload button
            CircularIcon(
              icon: Icons.camera_alt_outlined,
              width: 46,
              height: 46,
              onPressed: () {},
              color: ADColors.black,
              backgroundColor: const Color(0xFFFFFFFF),
              size: 24, // Adjust the size as needed
            ),
          ],
        ),
      ),
    );
  }
}
