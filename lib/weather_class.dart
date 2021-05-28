class Weather {
  final String selectedCity;
  final String degree;
  final String description;
  final String day;
  final String date;
  Weather({required this.selectedCity, required this.degree,required this.day,required this.description,required this.date});

  Weather.fromJson(Map<String, dynamic> json)
      : selectedCity = json['selectedCity'],
        degree = json['degree'],
        day = json['day'],
        date = json['date'],
        description = json['description'];

  Map<String, dynamic> toJson() {
    return {
      'selectedCity': selectedCity,
      'degree': degree,
      'day':day,
      'date':date,
      'description':description
    };
  }
}