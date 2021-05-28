// class WeatherResponse {
//   List<Result> result;
//
//   WeatherResponse({this.result});
//
//   WeatherResponse.fromJson(Map<String, dynamic> json) {
//     if (json['result'] != null) {
//       result = new List<Result>();
//       json['result'].forEach((v) {
//         result.add(new Result.fromJson(v));
//       });
//     }
//   }
//
//   Map<String, dynamic> toJson() {
//     final Map<String, dynamic> data = new Map<String, dynamic>();
//     if (this.result != null) {
//       data['result'] = this.result.map((v) => v.toJson()).toList();
//     }
//     return data;
//   }
// }
//
// class Result {
//   String date;
//   String day;
//   String icon;
//   String description;
//   String status;
//   String degree;
//   String min;
//   String max;
//   String night;
//   String humidity;
//
//   Result(
//       {required this.date,
//         required this.day,
//         required this.icon,
//         required this.description,
//         required this.status,
//         required this.degree,
//         required this.min,
//         required this.max,
//         required this.night,
//         required this.humidity});
//
//   Result.fromJson(Map<String, dynamic> json) {
//     date = json['date'];
//     day = json['day'];
//     icon = json['icon'];
//     description = json['description'];
//     status = json['status'];
//     degree = json['degree'];
//     min = json['min'];
//     max = json['max'];
//     night = json['night'];
//     humidity = json['humidity'];
//   }
//
//   Map<String, dynamic> toJson() {
//     final Map<String, dynamic> data = new Map<String, dynamic>();
//     data['date'] = this.date;
//     data['day'] = this.day;
//     data['icon'] = this.icon;
//     data['description'] = this.description;
//     data['status'] = this.status;
//     data['degree'] = this.degree;
//     data['min'] = this.min;
//     data['max'] = this.max;
//     data['night'] = this.night;
//     data['humidity'] = this.humidity;
//     return data;
//   }
// }