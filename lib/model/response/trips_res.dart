// To parse this JSON data, do
//
//     final tripsgetResponse = tripsgetResponseFromJson(jsonString);

import 'dart:convert';

List<TripsgetResponse> tripsgetResponseFromJson(String str) => List<TripsgetResponse>.from(json.decode(str).map((x) => TripsgetResponse.fromJson(x)));

String tripsgetResponseToJson(List<TripsgetResponse> data) => json.encode(List<dynamic>.from(data.map((x) => x.toJson())));

class TripsgetResponse {
    int idx;
    String name;
    String country;
    String coverimage;
    String detail;
    int price;
    int duration;
    DestinationZone destinationZone;

    TripsgetResponse({
        required this.idx,
        required this.name,
        required this.country,
        required this.coverimage,
        required this.detail,
        required this.price,
        required this.duration,
        required this.destinationZone,
    });

    factory TripsgetResponse.fromJson(Map<String, dynamic> json) => TripsgetResponse(
        idx: json["idx"],
        name: json["name"],
        country: json["country"],
        coverimage: json["coverimage"],
        detail: json["detail"],
        price: json["price"],
        duration: json["duration"],
        destinationZone: destinationZoneValues.map[json["destination_zone"]]!,
    );

    Map<String, dynamic> toJson() => {
        "idx": idx,
        "name": name,
        "country": country,
        "coverimage": coverimage,
        "detail": detail,
        "price": price,
        "duration": duration,
        "destination_zone": destinationZoneValues.reverse[destinationZone],
    };
}

enum DestinationZone {
    DESTINATION_ZONE,
    EMPTY,
    FLUFFY,
    PURPLE
}

final destinationZoneValues = EnumValues({
    "เอเชียตะวันออกเฉียงใต้": DestinationZone.DESTINATION_ZONE,
    "ยุโรป": DestinationZone.EMPTY,
    "ประเทศไทย": DestinationZone.FLUFFY,
    "เอเชีย": DestinationZone.PURPLE
});

class EnumValues<T> {
    Map<String, T> map;
    late Map<T, String> reverseMap;

    EnumValues(this.map);

    Map<T, String> get reverse {
            reverseMap = map.map((k, v) => MapEntry(v, k));
            return reverseMap;
    }
}
