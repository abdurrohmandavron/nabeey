import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:nabeey/utils/constants/sizes.dart';
import 'package:nabeey/common/widgets/headers/header.dart';
import 'package:expansion_tile_group/expansion_tile_group.dart';
import 'package:nabeey/features/explore/models/audio_model.dart';
import 'package:nabeey/features/explore/blocs/base/base_bloc.dart';
import 'package:nabeey/features/explore/blocs/base/base_state.dart';
import 'package:nabeey/data/models/category_model.dart';

import 'widgets/audio_item.dart';
import '../../blocs/audio/audio_bloc.dart';

class AudioScreen extends StatelessWidget {
  const AudioScreen({super.key, required this.category});

  final CategoryModel category;

  @override
  Widget build(BuildContext context) {
    final bloc = BlocProvider.of<BaseBloc<AudioModel>>(context);

    return PopScope(
      canPop: true,
      onPopInvokedWithResult: (value, _) => bloc.playingAudio = null,
      child: Scaffold(
        body: Column(
          children: [
            /// Category Description
            ADHeader(category: category),

            /// Audios
            Expanded(
              child: Padding(
                padding: const EdgeInsets.only(
                  top: ADSizes.defaultSpace,
                  left: ADSizes.defaultSpace,
                  right: ADSizes.defaultSpace,
                ),
                child: BlocBuilder<BaseBloc<AudioModel>, BaseState>(
                  builder: (context, state) {
                    if (state is ItemsLoading) {
                      return const Center(child: CircularProgressIndicator());
                    } else if (state is ItemsLoaded) {
                      final audios = state.items as List<AudioModel>;

                      return ExpansionTileGroup(
                        spaceBetweenItem: ADSizes.spaceBtwItems,
                        toggleType: ToggleType.expandOnlyCurrent,
                        children: audios
                            .map(
                              (audio) => ExpansionTileItem(
                                maintainState: true,
                                isHasTrailing: false,
                                isHasTopBorder: false,
                                isHasBottomBorder: false,
                                borderRadius: BorderRadius.circular(20),
                                border: Border.all(width: 1, color: Colors.grey, style: BorderStyle.solid),
                                title: Center(child: Text(audio.title, style: Theme.of(context).textTheme.titleLarge)),
                                children: [
                                  BlocProvider(
                                    create: (_) => AudioBloc(bloc),
                                    child: AudioItem(audio: audio),
                                  )
                                ],
                              ),
                            )
                            .toList(),
                      );
                    } else if (state is ItemsEmpty || state is ItemsError) {
                      return Center(child: Padding(padding: const EdgeInsets.all(ADSizes.defaultSpace), child: Text(state.toString(), style: Theme.of(context).textTheme.bodyLarge)));
                    } else {
                      return Center(child: Padding(padding: const EdgeInsets.all(ADSizes.defaultSpace), child: Text("Noma'lum xatolik.", style: Theme.of(context).textTheme.bodyLarge)));
                    }
                  },
                ),
              ),
            )
          ],
        ),
      ),
    );
  }
}
