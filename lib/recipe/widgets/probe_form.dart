import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:gibsonify/recipe/recipe.dart';

class ProbeForm extends StatelessWidget {
  final int recipeIndex;
  final int probeIndex;
  const ProbeForm(this.recipeIndex, this.probeIndex, {Key? key})
      : super(key: key);

  @override
  Widget build(BuildContext context) {
    return BlocBuilder<RecipeBloc, RecipeState>(builder: (context, state) {
      return Padding(
          padding: const EdgeInsets.all(8.0),
          child: TextFormField(
            initialValue: state.recipes[recipeIndex].probes[probeIndex]
                ['probe'],
            decoration: InputDecoration(
              icon: const Icon(Icons.live_help),
              labelText: 'Probe ${probeIndex + 1}',
              helperText:
                  'Recipe probe - e.g. Which flour did you use to make roti?',
            ),
            onChanged: (value) {
              context.read<RecipeBloc>().add(ProbeChanged(
                  recipe: state.recipes[recipeIndex],
                  probeName: value,
                  probeIndex: probeIndex));
            },
            textInputAction: TextInputAction.next,
          ));
    });
  }
}
