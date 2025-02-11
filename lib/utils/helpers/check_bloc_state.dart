import 'package:flutter/material.dart';
import 'package:nabeey/features/explore/blocs/base/base_state.dart';
import 'package:nabeey/utils/constants/sizes.dart';

class CheckBlocState {
  static Widget? checkState(BuildContext context, BaseState state) {
    if (state is ItemsLoading) {
      return const Center(child: CircularProgressIndicator());
    } else if (state is ItemsLoaded) {
      return null;
    } else if (state is ItemsError || state is ItemsEmpty) {
      return Center(child: Padding(padding: const EdgeInsets.all(ADSizes.defaultSpace), child: Text(state.toString(), style: Theme.of(context).textTheme.bodyLarge)));
    } else {
      return Center(child: Padding(padding: const EdgeInsets.all(ADSizes.defaultSpace), child: Text("Noma'lum xatolik!", style: Theme.of(context).textTheme.bodyLarge)));
    }
  }
}
