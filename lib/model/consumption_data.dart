class ConsumptionData {
  DateTime timeOfDay;
  String foodName;
  String foodDescription;
  String formWhenEaten;
  String measurementMethod;
  double measurement;
  String measurementUnits;

  ConsumptionData(
      {this.timeOfDay,
      this.foodName,
      this.foodDescription,
      this.formWhenEaten,
      this.measurementMethod,
      this.measurement,
      this.measurementUnits
      }
  );
}
