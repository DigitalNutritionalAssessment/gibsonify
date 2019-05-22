class Recipe{
  int id;
  String recipeDescr;
  RecipeType recipeType;
  int ingrCode;
  String ingrDescr;
  double ingrFraction;
  int ingrFractionType;
  String ingrFractionTypeDescr;


}

enum RecipeType{
  STANDARD,
  MODIFIED
}
