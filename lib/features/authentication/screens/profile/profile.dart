import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:nabeey/features/authentication/blocs/profile/profile_bloc.dart';
import 'package:nabeey/features/authentication/blocs/profile/profile_event.dart';
import 'package:nabeey/features/authentication/blocs/profile/profile_state.dart';
import 'package:nabeey/routes/routes.dart';

import '../../../../common/widgets/headers/profile_header.dart';
import 'widgets/profile_button.dart';

class ProfileScreen extends StatelessWidget {
  const ProfileScreen({super.key});

  @override
  Widget build(BuildContext context) {
    final profileBloc = BlocProvider.of<ProfileBloc>(context);
    profileBloc.add(LoadProfile());

    return Scaffold(
      appBar: AppBar(title: const Text('Profile')),
      body: BlocBuilder<ProfileBloc, ProfileState>(
        builder: (context, state) {
          if (state is ProfileLoading) {
            return const Center(child: CircularProgressIndicator());
          } else if (state is ProfileLoaded) {
            return SingleChildScrollView(
              child: Column(
                children: [
                  ProfileHeader(user: state.user),
                  Padding(
                    padding: const EdgeInsets.all(24),
                    child: Column(
                      children: [
                        ProfileButton(
                          icon: Icons.edit,
                          text: "Edit Profile",
                          onTap: () {
                            // Navigate to edit profile screen
                          },
                        ),
                        ProfileButton(
                          icon: Icons.delete,
                          text: "Delete Account",
                          onTap: () {
                            profileBloc
                                .add(DeleteProfile(state.user.id.toString()));
                          },
                        ),
                      ],
                    ),
                  ),
                ],
              ),
            );
          } else if (state is ProfileError || state is ProfileNull) {
            return Center(
              child: ElevatedButton(
                onPressed: () => Navigator.pushNamed(context, ADRoutes.signup),
                child: const Text("Hisobga kirish"),
              ),
            );
          }
          return const Center(child: Text('No profile data'));
        },
      ),
    );
  }
}
