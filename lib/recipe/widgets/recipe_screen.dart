import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import 'package:gibsonify/recipe/recipe.dart';

class RecipeScreen extends StatelessWidget {
  const RecipeScreen({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: const Text('Add a new recipe')),
      body: const RecipeForm(),
    );
  }
}

class RecipeForm extends StatefulWidget {
  const RecipeForm({Key? key}) : super(key: key);

  @override
  State<RecipeForm> createState() => _RecipeFormState();
}

class _RecipeFormState extends State<RecipeForm> {
  final _recipeNameFocusNode = FocusNode();
  final _recipeNumberFocusNode = FocusNode();
  final _recipeVolumeFocusNode = FocusNode();

  @override
  void initState() {
    super.initState();
    _recipeNameFocusNode.addListener(() {
      if (!_recipeNameFocusNode.hasFocus) {
        context.read<RecipeBloc>().add(RecipeNameUnfocused());
      }
    });
    _recipeNumberFocusNode.addListener(() {
      if (!_recipeNumberFocusNode.hasFocus) {
        context.read<RecipeBloc>().add(RecipeNumberUnfocused());
      }
    });
    _recipeVolumeFocusNode.addListener(() {
      if (!_recipeVolumeFocusNode.hasFocus) {
        context.read<RecipeBloc>().add(RecipeVolumeUnfocused());
      }
    });
  }

  @override
  void dispose() {
    _recipeNameFocusNode.dispose();
    _recipeNumberFocusNode.dispose();
    _recipeVolumeFocusNode.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.all(8.0),
      child: Column(
        children: <Widget>[
          RecipeNameInput(focusNode: _recipeNameFocusNode),
          RecipeNumberInput(focusNode: _recipeNumberFocusNode),
          RecipeVolumeInput(focusNode: _recipeVolumeFocusNode)
        ],
      ),
    );
  }
}

class RecipeNameInput extends StatelessWidget {
  const RecipeNameInput({Key? key, required this.focusNode}) : super(key: key);

  final FocusNode focusNode;

  @override
  Widget build(BuildContext context) {
    return BlocBuilder<RecipeBloc, RecipeState>(
      builder: (context, state) {
        return TextFormField(
          initialValue: state.recipeName.value,
          focusNode: focusNode,
          decoration: InputDecoration(
            icon: const Icon(Icons.assignment_rounded),
            labelText: 'Recipe Name',
            helperText: 'A valid recipe name, e.g. Aloo bandhgobhi',
            errorText: state.recipeName.invalid
                ? 'Enter a valid recipe name, e.g. Aloo bandhgobhi'
                : null,
          ),
          onChanged: (value) {
            context
                .read<RecipeBloc>()
                .add(RecipeNameChanged(recipeName: value));
          },
          textInputAction: TextInputAction.next,
        );
      },
    );
  }
}

class RecipeNumberInput extends StatelessWidget {
  const RecipeNumberInput({Key? key, required this.focusNode})
      : super(key: key);

  final FocusNode focusNode;

  @override
  Widget build(BuildContext context) {
    return BlocBuilder<RecipeBloc, RecipeState>(
      builder: (context, state) {
        return TextFormField(
          initialValue: state.recipeNumber.value,
          focusNode: focusNode,
          decoration: InputDecoration(
            icon: const Icon(Icons.format_list_numbered),
            labelText: 'Recipe Number',
            helperText: 'Number of recipe e.g. 9001',
            errorText:
                state.recipeNumber.invalid ? 'Enter recipe number' : null,
          ),
          onChanged: (value) {
            context
                .read<RecipeBloc>()
                .add(RecipeNumberChanged(recipeNumber: value));
          },
          textInputAction: TextInputAction.next,
          keyboardType: TextInputType.number,
        );
      },
    );
  }
}

class RecipeVolumeInput extends StatelessWidget {
  const RecipeVolumeInput({Key? key, required this.focusNode})
      : super(key: key);

  final FocusNode focusNode;

  @override
  Widget build(BuildContext context) {
    return BlocBuilder<RecipeBloc, RecipeState>(
      builder: (context, state) {
        return TextFormField(
          initialValue: state.recipeVolume.value,
          keyboardType: TextInputType.number,
          focusNode: focusNode,
          decoration: InputDecoration(
            icon: const Icon(Icons.play_for_work_rounded),
            labelText: 'Recipe Volume',
            helperText: 'Volume of recipe in ml e.g 250 ml',
            errorText: state.recipeVolume.invalid ? 'Enter valid volume' : null,
          ),
          onChanged: (value) {
            context
                .read<RecipeBloc>()
                .add(RecipeVolumeChanged(recipeVolume: value));
          },
          textInputAction: TextInputAction.next,
        );
      },
    );
  }
}
